import json
import math
import os
import re
from PIL import Image
from mrrs.core.geometry import is_rotation_mat, transform_cg_cv
import numpy as np

from mrrs.core.utils import listdir_fullpath
import trimesh


def read_json_data(calib_file, image_width):
    """
    Read nerf json data
    """
    with open(calib_file, 'r') as fp:
        meta = json.load(fp)

    fnames = []
    poses = []
    for frame in meta['frames']:
        fname = frame['file_path']+'.png'
        fnames.append(fname)
        poses.append(np.array(frame['transform_matrix']))
    
    poses = np.array(poses).astype(np.float32)
    poses = np.transpose(poses, (1,2,0))
    poses = np.concatenate([poses[:, 0:1, :], -poses[:, 1:2, :], -poses[:, 2:3, :], poses[:, 3:4, :]], 1)
    
    poses = np.transpose(poses, (2,0,1))


    camera_angle_x = float(meta['camera_angle_x'])
    focalx = 0.5*image_width/math.tan(camera_angle_x/2) # angle_x = math.atan(w / (fl * 2)) * 2
    cx=image_width/2.0
    cy=image_width/2.0#square image in the dataset

    intrinsics = [ np.asarray([[focalx, 0, cx], [0, focalx, cy], [0,0,1]]) for _ in fnames]
    
    return poses, intrinsics, fnames

def open_dataset(sfm_data):
    """
    Opens nerf dataset. assumes images in the train folder
    """
    #sort sfm by filename to match the order in the json
    sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:int(re.findall(r"\d+" , os.path.basename(v["path"]))[0]))
    #open image sizes
    image_sizes = [Image.open(v["path"]).size for v in sfm_data["views"]]
    image_names = [os.path.basename(v["path"]) for v in sfm_data["views"]] #"useful for sanity check"

    base_dir = os.path.abspath(os.path.join(os.path.dirname(sfm_data["views"][0]["path"]), ".."))
    set_name = os.path.basename(base_dir)
    
    #opening calib
    gt_calib_file = os.path.join(base_dir, "transforms_train.json")
    extrinsics,intrinsics, image_names_json = read_json_data(gt_calib_file, image_sizes[0][0])

    #open mesh
    gt_mesh_file =  os.path.join(base_dir, set_name+".ply")
    mesh=trimesh.load_mesh(gt_mesh_file) 

    #flip cg=>cv
    if mesh is not None:
        mesh.vertices = transform_cg_cv(mesh.vertices)


    return {
        "extrinsics" :  extrinsics,
        "intrinsics" :  intrinsics,
        "image_sizes":  image_sizes,
        "mesh":mesh
        }