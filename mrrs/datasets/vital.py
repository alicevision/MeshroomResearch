
import json
import os
import trimesh 

from mrrs.core.ios import matrices_from_sfm_data

def open_dataset(sfm_data):
    image_folder = os.path.dirname(sfm_data["views"][0]["path"])
    sfm_folder= os.path.abspath(os.path.join(image_folder, "..", '..', 'sfm'))
    #get gt .sfm
    sfm_data_vital_path = [os.path.join(sfm_folder, f) for f in os.listdir(sfm_folder) if f.endswith(".sfm")]
    if len(sfm_data_vital_path) == 0:
        raise RuntimeError("No sfm found in "+sfm_folder)
    sfm_data_vital_path=sfm_data_vital_path[0]
    with open(sfm_data_vital_path, "r") as json_file:
        sfm_data_vital = json.load(json_file)
    #sort by filename to match the .sfm 
    sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:os.path.basename(v["path"]))
    sfm_data_vital["views"]=sorted(sfm_data_vital["views"], key=lambda v:os.path.basename(v["path"])) 
    assert(len(sfm_data["views"]) == len(sfm_data_vital["views"]) )
    image_names = [os.path.basename(v["path"]) for v in sfm_data["views"]]
    #load gt mats
    (extrinsics, intrinsics, _, _, _, _, image_sizes) = matrices_from_sfm_data(sfm_data_vital,return_image_sizes=True )
    sensor_size = float(sfm_data_vital["intrinsics"][0]["sensorWidth"])

    #turn focal and pp into pixels for export
    pixel_size = sensor_size/image_sizes[0][0]
    for i in range(len(intrinsics)):
        intrinsics[i]/=pixel_size 
        intrinsics[i][2,2]=1

    
    #TODO: depth maps and masks

    #load mesh if any
    mesh_folder = os.path.join(image_folder, '..', '..', 'obj')
    if os.path.exists(mesh_folder):
        mesh_path = [os.path.join(mesh_folder, f)
                        for f in os.listdir(mesh_folder) if f.endswith(".obj")][0]
        print("Loading "+mesh_path)
        mesh = trimesh.load(mesh_path, force='mesh')
    else:
        print("GT mesh not found in "+mesh_folder)
    
    return {
        "image_names":  image_names,
        "mesh":         mesh,
        "extrinsics" :  extrinsics,
        "intrinsics" :  intrinsics,
        "image_sizes":  image_sizes,
        "sensor_size": sensor_size
        }