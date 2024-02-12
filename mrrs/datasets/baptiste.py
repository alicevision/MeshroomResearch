
import json
import os
from PIL import Image
import numpy as np

from mrrs.core.ios import matrices_from_sfm_data

def open_dataset(sfm_data):
    """
    Opens "minimal" dataset from IRIT (matlab)
    #renders from https://github.com/bbrument/lambertianRendering_v1
    """
    #get the root of the dataset
    image_path = os.path.dirname(sfm_data["views"][0]["path"])
    dataset_root_path = os.path.abspath(os.path.join(image_path, ".."))

    #GT calib from the .sfm
    sfm_folder=os.path.join(image_path, "..", 'sfm.json')
    with open(sfm_folder, "r") as json_file:
        sfm_data = json.load(json_file)
    sfm_names_image_names =[os.path.basename(v["path"]) for v in sfm_data["views"]]
    (extrinsics, intrinsics, _, _, _, _) = matrices_from_sfm_data(sfm_data)
    sensor_size = float(sfm_data["intrinsics"][0]["sensorWidth"])

    #images (sorted as in gt sfm)
    image_names = [f for f in sorted(os.listdir(image_path)) if f.endswith(".png") ]
    images_sizes = [Image.open(os.path.join(image_path, image)).size for image in image_names]

    #transforms in mr format
    extrinsics = [np.linalg.inv(np.concatenate( [e,[[0,0,0,1]]] )) for e in extrinsics]
    pixel_size = sensor_size/images_sizes[0][0]

    #turn focal and pp into pixels for export
    for i in range(len(intrinsics)):
        intrinsics[i]/=pixel_size 
        intrinsics[i][2,2]=1

    #load depth names  (sorted as in gt sfm)
    depth_map_path = os.path.abspath(os.path.join(dataset_root_path, "depth"))
    depth_maps = sorted([os.path.join(depth_map_path, f) for f in os.listdir(depth_map_path) if f.endswith(".exr") ])

    #load mask names (sorted as in gt sfm)
    mask_map_path = os.path.abspath(os.path.join(dataset_root_path, "mask"))
    masks = sorted([os.path.join(mask_map_path, f) for f in os.listdir(mask_map_path) if f.endswith(".png") ])

    #sfm_names_image_names
    return {
            "image_names":  image_names,
            "depth_maps":   depth_maps,
            "masks":        masks,
            "extrinsics" :  extrinsics,
            "intrinsics" :  intrinsics,
            "image_sizes":  images_sizes,
            "sensor_size": sensor_size
           }
