import multiprocessing as mp
import numpy as np
import json

import trimesh

def sample_single_tri(input_):
    n1, n2, v1, v2, tri_vert = input_
    c = np.mgrid[:n1+1, :n2+1]
    c += 0.5
    c[0] /= max(n1, 1e-7)
    c[1] /= max(n2, 1e-7)
    c = np.transpose(c, (1,2,0))
    k = c[c.sum(axis=-1) < 1]  # m2
    q = v1 * k[:,:1] + v2 * k[:,1:] + tri_vert
    return q

def upsampling_mesh(tri_vert, thresh):
    v1 = tri_vert[:,1] - tri_vert[:,0]
    v2 = tri_vert[:,2] - tri_vert[:,0]
    l1 = np.linalg.norm(v1, axis=-1, keepdims=True)
    l2 = np.linalg.norm(v2, axis=-1, keepdims=True)
    area2 = np.linalg.norm(np.cross(v1, v2), axis=-1, keepdims=True)
    non_zero_area = (area2 > 0)[:,0]
    l1, l2, area2, v1, v2, tri_vert = [
        arr[non_zero_area] for arr in [l1, l2, area2, v1, v2, tri_vert]
    ]
    thr = thresh * np.sqrt(l1 * l2 / area2)
    n1 = np.floor(l1 / thr)
    n2 = np.floor(l2 / thr)

    with mp.Pool() as mp_pool:
        new_pts = mp_pool.map(sample_single_tri, ((n1[i,0], n2[i,0], v1[i:i+1], v2[i:i+1], tri_vert[i:i+1,0]) for i in range(len(n1))), chunksize=1024)

    new_pts = np.concatenate(new_pts, axis=0)
    return new_pts

def write_vis_pcd(file, points, colors):
    mesh = trimesh.Trimesh(vertices=points, vertex_colors=colors)
    mesh.export(file)

def get_ray(pixel, K, R_c2w, center):
    pixel = pixel.reshape(-1, 1)
    pixel = np.concatenate((pixel, np.ones((1, 1))), axis=0)
    K_inv = np.linalg.inv(K)
    pixel_c2w = K_inv @ pixel
    pixel_w2c = R_c2w @ pixel_c2w + center
    ray = np.concatenate((center.T, pixel_w2c.T), axis=0)
    return ray


def get_intrinsics(data_intrinsic):

    id_intr = int(data_intrinsic['intrinsicId'])
    width = float(data_intrinsic['width'])
    height = float(data_intrinsic['height'])
    sensor_width = float(data_intrinsic['sensorWidth'])
    sensor_height = float(data_intrinsic['sensorHeight'])
    fl_mm = float(data_intrinsic['focalLength'])
    cx = float(data_intrinsic['principalPoint'][0])
    cy = float(data_intrinsic['principalPoint'][1])

    fl_x = fl_mm*max(width,height)/sensor_width
    fl_y = fl_x
    px = width/2 + cx
    py = height/2 + cy

    K = np.eye(3)
    K[0,0] = fl_x
    K[1,1] = fl_y
    K[0,2] = px
    K[1,2] = py
    
    return K

def get_extrinsics(data_pose):
    R = np.array(data_pose['pose']['transform']['rotation'],dtype=np.float32).reshape([3,3]) # orientation
    t = np.expand_dims(np.array(data_pose['pose']['transform']['center'],dtype=np.float32), axis=1) # center
    c2w = np.concatenate([R, t], axis=1)
    c2w[1:2,:] = -c2w[1:2,:] # graphics -> vision coordinates
    return c2w

def read_sfm(file):

    with open(file) as json_file:
        data = json.load(json_file)

    views = []
    poses = []
    intrinsics = []
    for ind_view, view in enumerate(data['views']):

        # get view data
        id_view = str(view['viewId'])
        id_pose = str(view['poseId'])
        id_frame = str(view['frameId'])
        id_intr = str(view['intrinsicId'])
        path = view['path']
        width = int(view['width'])
        height = int(view['height'])

        # get intrinsic data
        for intr in data['intrinsics']:
            if id_intr == str(intr['intrinsicId']):
                K = get_intrinsics(intr)
                continue

        # Extrinsic
        pose_id = int(view['poseId'])
        for pose in data['poses']:
            if pose_id == int(pose['poseId']):
                c2w = get_extrinsics(pose)
                continue

        # save data
        views.append({"path": path, "width": width, "height": height})
        poses.append(c2w)
        intrinsics.append(K)

    return views, poses, intrinsics


