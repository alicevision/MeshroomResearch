
import json
import os
import trimesh 
# from PIL import Image

from mrrs.core.ios import matrices_from_sfm_data

def find_sfm(sfm_folder):
    sfm_data_alab_path = [os.path.join(sfm_folder, f) for f in os.listdir(sfm_folder) if f.endswith(".sfm")]
    if len(sfm_data_alab_path) == 0:
        return None
    return sfm_data_alab_path[0]

def open_dataset(sfm_data):
    image_folder = os.path.dirname(sfm_data["views"][0]["path"])
    #get gt .sfm first from current folder (alab), or from .. .. sfm (ptut)
    sfm_data_alab_path = find_sfm(image_folder)
    if sfm_data_alab_path is None:
        sfm_data_alab_path = find_sfm(os.path.abspath(os.path.join(image_folder, "..", '..', 'sfm')))
    if sfm_data_alab_path is None:
        raise FileNotFoundError("Could not find sfmData") 
    print("Sfm file found in "+sfm_data_alab_path)
    with open(sfm_data_alab_path, "r") as json_file:
        sfm_data_alab = json.load(json_file)
    #sort by filename to match the .sfm 
    sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:os.path.basename(v["path"]))
    sfm_data_alab["views"]=sorted(sfm_data_alab["views"], key=lambda v:os.path.basename(v["path"])) 
    if len(sfm_data["views"]) != len(sfm_data_alab["views"]) :
        raise BaseException("Mismatching number of views in the sfm %d vs %d"%(len(sfm_data["views"]),len(sfm_data_alab["views"])))
    image_names = [os.path.basename(v["path"]) for v in sfm_data["views"]]
    #load gt mats
    (extrinsics, intrinsics, views_id_alab, _, _, _, image_sizes) = matrices_from_sfm_data(sfm_data_alab, return_image_sizes=True )
    # image_sizes = [Image.open(v["path"]).size for v in sfm_data["views"] ]
    sensor_w = float(sfm_data_alab["intrinsics"][0]["sensorWidth"])
    sensor_h = float(sfm_data_alab["intrinsics"][0]["sensorHeight"])
    if(sensor_w/sensor_h != image_sizes[0][0]/image_sizes[0][1]):
        print("!!!Image size incoherent with sensor size, will modify sensor_height and reload")
        sfm_data_alab["intrinsics"][0]["sensorHeight"] =  sensor_w*image_sizes[0][1]/image_sizes[0][0]
        (extrinsics, intrinsics, _, _, _, _, image_sizes) = matrices_from_sfm_data(sfm_data_alab, return_image_sizes=True )

    sensor_size = sensor_w
    #turn focal and pp into pixels for export
    pixel_size = sensor_size/image_sizes[0][0]
    for i in range(len(intrinsics)):
        intrinsics[i]/=pixel_size 
        intrinsics[i][2,2]=1

    
    #TODO: depth maps and masks

 
    data = {
        "image_names":  image_names,
        "extrinsics" :  extrinsics,
        "intrinsics" :  intrinsics,
        "image_sizes":  image_sizes,
        "sensor_size":  sensor_size
        }

    #load mesh if any
    mesh_folder = os.path.join(image_folder, '..', '..', 'obj')
    if os.path.exists(mesh_folder):
        mesh_path = [os.path.join(mesh_folder, f)
                        for f in os.listdir(mesh_folder) if (f.endswith(".obj") or f.endswith(".ply")) ][0]
        print("Loading "+mesh_path)
        data["mesh"] = trimesh.load(mesh_path, force='mesh')
    else:
        print("GT mesh not found in "+mesh_folder)

    #landmarks if any
    if "structure" in sfm_data_alab.keys():
        sfm_data["structure"] = sfm_data_alab["structure"]

    return data