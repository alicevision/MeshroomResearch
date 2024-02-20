import json
import math
import os
from PIL import Image
from mrrs.core.geometry import transform_cg_cv
import numpy as np

from mrrs.core.utils import listdir_fullpath
import trimesh

#https://github.com/graphdeco-inria/gaussian-splatting/blob/main/scene/dataset_readers.py
def parse_calib(transformsfile, image_width):
    with open(transformsfile) as json_file:
        contents = json.load(json_file)
        frames = contents["frames"]

        fovx = contents["camera_angle_x"]
        focal = fov2focal(fovx, image_width)
        intrinsics = [ np.asarray([[focal, 0, 0], [0, focal, 0], [0,0,1]]) for _ in frames]

        extrinsics = []
        for idx, frame in enumerate(frames):
            # NeRF 'transform_matrix' is a camera-to-world transform
            c2w = np.array(frame["transform_matrix"])
            # change from OpenGL/Blender camera axes (Y up, Z back) to COLMAP (Y down, Z forward)
            c2w[:3, 1:3] *= -1
            # get the world-to-camera transform and set R, T
            w2c = np.linalg.inv(c2w)
            R = np.transpose(w2c[:3,:3])  # R is stored transposed due to 'glm' in CUDA code
            T = w2c[:3, 3]
            extrinsic = np.identity(4)
            extrinsic[0:3,0:3]=R
            extrinsic[3,0:3]=T
            extrinsics.append(extrinsic)

    return intrinsics, extrinsics

def fov2focal(fov, pixels):
    return pixels / (2 * math.tan(fov / 2))

def getWorld2View2(R, t, translate=np.array([.0, .0, .0]), scale=1.0):
    Rt = np.zeros((4, 4))
    Rt[:3, :3] = R.transpose()
    Rt[:3, 3] = t
    Rt[3, 3] = 1.0

    C2W = np.linalg.inv(Rt)
    cam_center = C2W[:3, 3]
    cam_center = (cam_center + translate) * scale
    C2W[:3, 3] = cam_center
    Rt = np.linalg.inv(C2W)
    return np.float32(Rt)
    
def getNerfppNorm(cam_info):
    def get_center_and_diag(cam_centers):
        cam_centers = np.hstack(cam_centers)
        avg_cam_center = np.mean(cam_centers, axis=1, keepdims=True)
        center = avg_cam_center
        dist = np.linalg.norm(cam_centers - center, axis=0, keepdims=True)
        diagonal = np.max(dist)
        return center.flatten(), diagonal

    cam_centers = []

    for cam in cam_info:
        W2C = getWorld2View2(cam.R, cam.T)
        C2W = np.linalg.inv(W2C)
        cam_centers.append(C2W[:3, 3:4])

    center, diagonal = get_center_and_diag(cam_centers)
    radius = diagonal * 1.1

    translate = -center

    return {"translate": translate, "radius": radius}


def open_dataset(sfm_data):
    """
    Opens nerf dataset. assumes images in the train folder
    """
    #sort sfm by filename to match the order in the json
    sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:os.path.basename(v["path"]))
    #open image sizes
    image_sizes = [Image.open(v["path"]).size for v in sfm_data["views"]]
    # image_names = [os.path.basename(v["path"]) for v in sfm_data["views"]]

    
    base_dir = os.path.abspath(os.path.join(os.path.dirname(sfm_data["views"][0]["path"]), ".."))
    set_name = os.path.basename(base_dir)
    
    #opening calib
    gt_calib_file = os.path.join(base_dir, "transforms_train.json")
    intrinsics, extrinsics = parse_calib(gt_calib_file, image_sizes[0][0])

    #open mesh
    gt_mesh_file =  os.path.join(base_dir, set_name+".ply")
    mesh=trimesh.load_mesh(gt_mesh_file) 

    # #flip cg=>cv
    # if mesh is not None:
    #     mesh.vertices = transform_cg_cv(mesh.vertices)
    scale = 1/0.267
    rescale = scale*np.identity(3)
    extrinsics = [ rescale@e[0,0:2] for e in extrinsics]

    # mesh.vertices = np.transpose(rescale@np.transpose(mesh.vertices))

    return {
        "extrinsics" :  extrinsics,
        "intrinsics" :  intrinsics,
        "image_sizes":  image_sizes,
        "mesh":mesh
        }