import os
from mrrs.core.geometry import transform_cg_cv
from mrrs.core.ios import open_image
import numpy as np
import cv2
import trimesh
from PIL import Image

def open_dtu_calibration(scene_calib_path, rescale = False):
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
        if rescale:
            P = world_mat @ scale_mat
        else:
            P = world_mat
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

def open_dataset(sfm_data):
    """
    Import dtu data, ! assumes the sfm_data is sorted!
    """

    print("***Importing DTU data")
    image_names = [os.path.basename(v["path"]) for v in sfm_data["views"]]
    image_sizes = [Image.open(v["path"]).size for v in sfm_data["views"]]
    image_folder = os.path.abspath(os.path.dirname(sfm_data["views"][0]["path"]))
    rescale=True
    extrinsics, intrinsics, gt_scale_mat = open_dtu_calibration( os.path.join(image_folder, "..", "cameras_sphere.npz"), rescale)
    #get the id of the scan from the filename
    scan_nb = int(image_folder.split('/')[-2].split('scan')[-1])
    mesh = os.path.join(image_folder,'..',f'stl{scan_nb:03}_total.ply')
    mesh = trimesh.load(mesh, force='mesh')
    if rescale:
        mesh.apply_transform(np.linalg.inv(gt_scale_mat))
    #cg to cv for meshroom
    mesh.vertices=transform_cg_cv(mesh.vertices)
    masks_folder = os.path.join(image_folder, "..", "mask")
    #FIXME: check order?
    masks = [open_image(os.path.join(masks_folder, m)) for m in os.listdir(masks_folder) if (m.endswith(".png") and (not m.startswith(".")))]


    return {
            "image_names":  image_names,
            "masks":        masks,  
            "extrinsics" :  extrinsics,
            "intrinsics" :  intrinsics,
            "image_sizes":  image_sizes,
            "mesh":mesh
            }