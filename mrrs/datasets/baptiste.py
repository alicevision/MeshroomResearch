
import json
import os
import xml.etree.ElementTree as ET
from PIL import Image
from mrrs.core.geometry import is_rotation_mat
from mrrs.core.ios import matrices_from_sfm_data

def open_dataset(image_path):
    """
    Opens "minimal" dataset from IRIT (matlab)
    """
    #get the root of the dataset
    dataset_root_path = os.path.abspath(os.path.join(image_path, ".."))

    #images
    image_names = [f for f in os.listdir(image_path) if f.endswith(".png") ]
    images_sizes = [Image.open(os.path.join(image_path, image)).size for image in image_names]

    #GT calib from the .sfm
    sfm_folder=os.path.join(image_path, "..", 'sfm.json')
    with open(sfm_folder, "r") as json_file:
        sfm_data = json.load(json_file)
    (extrinsics, intrinsics, _, _, _, _) = matrices_from_sfm_data(sfm_data)
    sensor_size = float(sfm_data["intrinsics"][0]["sensorWidth"])

    #match with sfm data using filename #FIXME: really necessary? the sfm seems to be in order
    ordered_extrinsics=[]
    ordered_intrinsics=[]
    for i,vo in enumerate(image_names):
        for j,vv in enumerate(sfm_data["views"]):
            if vo == os.path.basename(vv["path"]):
                e = extrinsics[j]
                i = intrinsics[j]
                #check rotation matrix just in case
                rotation=e[0:3, 0:3]
                if not is_rotation_mat(rotation):
                    raise RuntimeError("Rotation matrix not valid for "+vo["viewId"])
                ordered_extrinsics.append(e)
                ordered_intrinsics.append(i)
                break

    #load depth (filename corresponding)
    depth_map_path = os.path.abspath(os.path.join(dataset_root_path, "depth"))
    depth_maps = [os.path.join(depth_map_path, f) for f in os.listdir(depth_map_path) if f.endswith(".exr") ]

    #load mask
    mask_map_path = os.path.abspath(os.path.join(dataset_root_path, "mask"))
    masks = [os.path.join(mask_map_path, f) for f in os.listdir(mask_map_path) if f.endswith(".png") ]

    return {
            "image_names":  image_names,
            "depth_maps":   depth_maps,
            "masks":        masks,
            "extrinsics" :  ordered_extrinsics,
            "intrinsics" :  ordered_intrinsics,
            "image_sizes":  images_sizes,
            "sensor_size": sensor_size
           }
