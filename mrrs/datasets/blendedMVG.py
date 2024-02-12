import os
from PIL import Image
import numpy as np

from mrrs.core.utils import listdir_fullpath
import trimesh

def open_txt_calibration_blendedMVG(calib_file):
    '''
    Opens a text file containing the calibration for a single camera, in the form :

    extrinsic
    E00 E01 E02 E03
    E10 E11 E12 E13
    E20 E21 E22 E23
    E30 E31 E32 E33

    intrinsic
    K00 K01 K02
    K10 K11 K12
    K20 K21 K22

    see https://github.com/YoYo000/MVSNet.
    '''
    intrinsics = np.zeros((3, 3))
    extrinsics = np.zeros((4, 4))
    with open(calib_file, "r") as calib_file:
        words = calib_file.read().split()
        # read extrinsic
        for i in range(0, 4):
            for j in range(0, 4):
                extrinsic_index = 4 * i + j + 1
                extrinsics[i][j] = words[extrinsic_index]
        # read intrinsic
        for i in range(0, 3):
            for j in range(0, 3):
                intrinsic_index = 3 * i + j + 18
                intrinsics[i][j] = words[intrinsic_index]

        # #extra info about depth range (unsused for now)
        # if len(words) == 29:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = max_d
        #     intrinsics[3][3] = intrinsics[3][0] + intrinsics[3][1] * intrinsics[3][2]
        # elif len(words) == 30:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = words[29]
        #     intrinsics[3][3] = intrinsics[3][0] + intrinsics[3][1] * intrinsics[3][2]
        # elif len(words) == 31:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = words[29]
        #     intrinsics[3][3] = words[30]
        # else:
        #     intrinsics[3][0] = 0
        #     intrinsics[3][1] = 0
        #     intrinsics[3][2] = 0
        #     intrinsics[3][3] = 0

    return extrinsics, intrinsics

def open_dataset(sfm_data):
    """
    Opens blededMVG dataset
    """
    depth_maps=[]
    extrinsics=[]
    intrinsics=[]
    image_names=[]
    images_sizes = []
    for view in sfm_data["views"]:
        image = view["path"]
        folder = os.path.dirname(image)
        basename = os.path.basename(image)[:-4]#FIXME: not great, use split
        calib = os.path.join(folder, "..", "cams", basename + "_cam.txt")
        depth_map = os.path.join(folder, "..", "rendered_depth_maps", basename + ".pfm")
        E, I = open_txt_calibration_blendedMVG(calib)
        depth_maps.append(depth_map)
        extrinsics.append(E)
        intrinsics.append(I)
        image_names.append(os.path.basename(image))
        images_sizes.append(Image.open(image).size)#note, open is lazy so we dont actually open
    # R-1 and R-1.-T, needed to reuse sfm_data_from_matrices
    extrinsics = [np.linalg.inv(e) if e is not None else None for e in extrinsics] 
    
    #try loading from mesh list if any
    mesh_list_path = os.path.join(folder, "..", "textured_mesh", 'mesh_list.txt') 
    all_meshes = [f for f in listdir_fullpath(os.path.join(folder, "..", "textured_mesh")) if f.endswith(".ply")]
    if os.path.exists(mesh_list_path):
        print("**Importing blendedMVG mesh data")
        mesh_list = [os.path.basename(p) for p in  open(mesh_list_path, 'r').read().splitlines()]
        mesh = None
        submeshes = []
        for i, mesh_path in enumerate(mesh_list):
            print("**%d/%d"%(i, len(mesh_list)))
            submesh_path = os.path.join(folder, "..", "textured_mesh", mesh_path)
            submesh = trimesh.load_mesh(submesh_path) 
            submeshes.append(submesh)
        mesh = trimesh.util.concatenate(submeshes)
    #else try loading the first mesh it finds
    elif len(all_meshes)>=1:
        print("**Importing blendedMVG mesh data")
        mesh = trimesh.load_mesh(all_meshes[0]) 
    else:
        print("**No mesh found")

    return {
        "image_names":  image_names,
        "depth_maps":   depth_maps,
        # "masks":        masks,  #for now we dont use masks
        "extrinsics" :  extrinsics,
        "intrinsics" :  intrinsics,
        "image_sizes":  images_sizes,
        "mesh":mesh
        }