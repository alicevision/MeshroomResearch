import numpy as np
import cv2

def open_dtu_calibration(scene_calib_path):
    """Opens camera_sphere.npz file where the ground truth is stored."""
    camera_dict = np.load(scene_calib_path)
    frame_ids = range(int(len(camera_dict.keys())/6))#the dict contains 6 matrices
    scale_mats = [camera_dict['scale_mat_%d' %
                              idx].astype(np.float32) for idx in frame_ids]
    world_mats = [camera_dict['world_mat_%d' %
                              idx].astype(np.float32) for idx in frame_ids]

    gt_scale_mat = camera_dict['scale_mat_0']

    gt_extrinsics, gt_intrinsics = [], []
    n_images = len(world_mats)
    for i in range(n_images):
        world_mat = world_mats[i]
        scale_mat = scale_mats[i]
        P = world_mat @ scale_mat
        # P = world_mat
        P = P[:3, :4]
        intrinsics, pose = load_K_Rt_from_P(None, P)

        gt_intrinsics.append(intrinsics)
        gt_extrinsics.append(pose)

    return gt_extrinsics, gt_intrinsics, gt_scale_mat

def load_K_Rt_from_P(filename, P=None):
    if P is None:
        lines = open(filename).read().splitlines()
        if len(lines) == 4:
            lines = lines[1:]
        lines = [[x[0], x[1], x[2], x[3]]
                 for x in (x.split(" ") for x in lines)]
        P = np.asarray(lines).astype(np.float32).squeeze()

    out = cv2.decomposeProjectionMatrix(P)
    K = out[0]
    R = out[1]
    t = out[2]

    K = K/K[2, 2]
    intrinsics = np.eye(4)
    intrinsics[:3, :3] = K

    pose = np.eye(4, dtype=np.float32)
    pose[:3, :3] = R.transpose()
    pose[:3, 3] = (t[:3] / t[3])[:, 0]

    return intrinsics, pose
