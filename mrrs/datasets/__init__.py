
from mrrs.datasets.eth3d import open_dataset as open_dataset_eth3d
from mrrs.datasets.baptiste import open_dataset as open_dataset_baptiste
from mrrs.datasets.blendedMVG import open_dataset as open_dataset_blended
from mrrs.datasets.dtu import open_dataset as open_dataset_dtu

def load_dataset(sfm_data, dataset_type):
    """
    Loads the gt data corresponding to input images in sfm_data.
    """
    #sort by view name (handy for several of the dataset)
    sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:int(v["frameId"])) 

    # data =  {
    #         # Initialize lists to store scene images, calibrations, depths and masks (one per view)
    #         "images_sizes":[],
    #         "depth_maps":[],
    #         "masks":[],
    #         "extrinsics":[],
    #         "intrinsics":[],
    #         "sensor_size":35, #note, by default the sensor size is set to 35mm
    #         # Initialise geometry (one per scene)
    #         "mesh":None,
    #         }

    # Load data
    if dataset_type == "blendedMVG":#FIXME: sort as in dtu?
        print("**Importing blendedMVG data")
        data = open_dataset_blended(sfm_data)
    elif dataset_type == "DTU":
        print("***Importing DTU data")
        data = open_dataset_dtu(sfm_data)
    elif dataset_type == "ETH3D":
        print("**Importing ETH3D data")
        data = open_dataset_eth3d(sfm_data)
    elif dataset_type == "baptiste":
        print("**Importing Baptiste data")
        data = open_dataset_baptiste(sfm_data)

    # elif dataset_type.startswith("vital"):#FIXME: open the same way as the rest
    #     image_folder = os.path.dirname(sfm_data["views"][0]["path"])
    #     sfm_folder=os.path.join(image_folder, "..", '..', 'sfm')
    #     sfm_data_vital_path = [os.path.join(sfm_folder, f) for f in os.listdir(sfm_folder) if f.endswith(".sfm")]
    #     if len(sfm_data_vital_path) == 0:
    #         raise RuntimeError("No sfm found in "+sfm_folder)
    #     sfm_data_vital_path=sfm_data_vital_path[0]
    #     with open(sfm_data_vital_path, "r") as json_file:
    #         sfm_data_vital = json.load(json_file)
    #     (extrinsics_vital, intrinsics_vital, _, _, _, _) = matrices_from_sfm_data(sfm_data_vital)
    #     sensor_size = float(sfm_data_vital["intrinsics"][0]["sensorWidth"])#FIXME: 
    #     print("Sensorwidth:", sensor_size)
    #     #match with sfm data using filename
    #     extrinsics=[]
    #     intrinsics=[]
    #     sfm_data_out = copy.deepcopy(sfm_data)
    #     sfm_data_out["poses"]=[]
    #     for i,vo in enumerate(sfm_data["views"]):
    #         for j,vv in enumerate(sfm_data_vital["views"]):
    #             if os.path.basename(vo["path"])==os.path.basename(vv["path"]):
    #                 print(vo["path"]+" matched with "+vv["path"])
    #                 sfm_data_out["views"][i]["resectionId"]="0"#add resection id
    #                 pose=sfm_data_vital["poses"][i]
    #                 extrinsic_vital = extrinsics_vital[j]
    #                 rotation=extrinsic_vital[0:3, 0:3]
    #                 if not is_rotation_mat(rotation):
    #                     raise RuntimeError("Rotation matrix not valid for "+vo["viewId"])
    #                 translation=extrinsic_vital[:, 3]
    #                 pose["pose"]["transform"]["rotation"]=np.char.mod("%.20f", rotation.flatten()).tolist()
    #                 pose["pose"]["transform"]["center"]=np.char.mod("%.20f", translation).tolist()
    #                 pose["poseId"] = vo["viewId"] #FIXME: assumes matching id
    #                 sfm_data_out["poses"].append(pose)
    #                 break
    #     sfm_data_out["intrinsics"][0]=sfm_data_vital["intrinsics"][0]#copy gt and keep uid
    #     sfm_data_out["intrinsics"][0]["intrinsicId"]=sfm_data["intrinsics"][0]["intrinsicId"]
    #     #save FIXME: move that
    #     with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
    #         json.dump(sfm_data_out, f, indent=4)
    #     mesh_folder = os.path.join(image_folder, '..', '..', 'obj')
    #     if os.path.exists(mesh_folder):
    #         mesh_path = [os.path.join(mesh_folder, f)
    #                      for f in os.listdir(mesh_folder) if f.endswith(".obj")][0]
    #         print("Loading "+mesh_path)
    #         mesh = trimesh.load(mesh_path, force='mesh')
    #         mesh.export(chunk.node.mesh.value)
    #     else:
    #         print("GT mesh not found in "+mesh_folder)
    #     return #FIXME: unlike the other datasets we leave early here
    else:
        raise RuntimeError("Dataset type not supported")
    
    #if sensor size, not specified, assumes 35mm
    if "sensor_size" not in data :
        data["sensor_size"] = 35
        print("Sensor size set to default (35mm)")

    return data, sfm_data
