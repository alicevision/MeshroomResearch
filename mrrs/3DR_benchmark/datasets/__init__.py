
from mrrs.core.geometry import is_rotation_mat
from mrrs.datasets.eth3d import open_dataset as open_dataset_eth3d
from mrrs.datasets.baptiste import open_dataset as open_dataset_baptiste
from mrrs.datasets.blendedMVG import open_dataset as open_dataset_blended
from mrrs.datasets.dtu import open_dataset as open_dataset_dtu
from mrrs.datasets.alab import open_dataset as open_dataset_alab
from mrrs.datasets.nerf import open_dataset as open_dataset_nerf

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
    if dataset_type == "blendedMVG":
        print("**Importing blendedMVG data")
        data = open_dataset_blended(sfm_data)
    elif dataset_type == "DTU":
        print("**Importing DTU data")
        data = open_dataset_dtu(sfm_data)
    elif dataset_type == "ETH3D":
        print("**Importing ETH3D data")
        data = open_dataset_eth3d(sfm_data)
    elif dataset_type == "baptiste":
        print("**Importing Baptiste data")
        data = open_dataset_baptiste(sfm_data)
    elif dataset_type == "alab":
        print("**Importing alab data")
        data = open_dataset_alab(sfm_data)
    elif dataset_type == "NERF":
        print("**Importing NERF data")
        data = open_dataset_nerf(sfm_data)
    else:
        raise RuntimeError("Dataset type not supported")
    
    #sanity check rotation matrix, as its a common error
    for e in data["extrinsics"]:
        if not is_rotation_mat(e[0:3,0:3]):
            raise ValueError("Issue with rotation matrix")

    #if sensor size, not specified, assumes 35mm
    if "sensor_size" not in data :
        data["sensor_size"] = 35
        print("Sensor size set to default (35mm)")

    return data, sfm_data
