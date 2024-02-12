__version__ = "3.0"

import copy
import os 
import json
from mrrs.core.utils import listdir_fullpath

import trimesh
import numpy as np
from PIL import Image

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *

from mrrs.datasets.eth3d import open_dataset as open_dataset_eth3d
from mrrs.datasets.baptiste import open_dataset as open_dataset_baptiste
from mrrs.datasets.blendedMVG import open_dataset as open_dataset_blended
from mrrs.datasets.dtu import open_dtu_calibration

class LoadDataset(desc.Node):
    category = 'Meshroom Research'

    documentation = '''Util node to open datasets with different data from the images in the .sfm'''

    size = desc.DynamicNodeSize('sfmData')

    inputs = [

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.ChoiceParam(
            name='datasetType',
            label='Dataset Type',
            description='''Dataset type''',
            value='blendedMVG',
            values=['blendedMVG', 'DTU', 'ETH3D', 'baptiste', 'vital'],
            exclusive=True,
            uid=[0],
        ),

        desc.FloatParam(
            name='initSfmLandmarks',
            label='Init Landmarks',
            description='''Will initalise sfmLandmarks with the vertices ground truth mesh (if any). \\
                           0 for deactivated, otherwise generate use n*nb_vertices landmarks.''',
            value=0.0,
            range=(0.0, 1.0, 0.1),
            uid=[0],
            advanced=True
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
            advanced=True
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfMData',
            label='SfM Data',
            description='Path to the output sfmdata file',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        ),

        desc.File(
            name='depthMapsFolder',
            label='Depth map folder',
            description='Output folder for loaded depth maps',
            value=os.path.join(desc.Node.internalFolder, 'depth_maps'),
            uid=[],
            # enabled=lambda attr: (attr.node.datasetType.value=='blendedMVG'), #FIXME: does not work!! doesnt actually hides in the node
        ),

        desc.File(
            name='mesh',
            label='Mesh',
            description='Loaded mesh.',
            semantic='mesh',
            value=os.path.join(desc.Node.internalFolder, 'mesh.ply'),
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
        ),

        desc.File(
            name='maskFolder',
            label='Mask Folder',
            description='Image mask folder. The mask describes the visibility of the object to be observed, on each view.',
            value=os.path.join(desc.Node.internalFolder,'masks'),
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            group='',
        ),

        #used for display
        desc.File(
            name='depthmaps',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'depth_maps', '<VIEW_ID>_depthMap.exr'),
            uid=[],
            group='',
            advanced=True
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.sfmData.value == '':
            chunk.logger.warning(
                'No input InputFolder or sfmData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """

        chunk.logManager.start(chunk.node.verboseLevel.value)
        if not self.check_inputs(chunk):
            return False

        chunk.logger.info("*LoadDataset Starting")

        chunk.logger.info("**Importing data")

        # Load SFM data from JSON file
        sfm_data = json.load(open(chunk.node.sfmData.value, "r"))
        
        # pose IDs, calibration IDs, and view IDs (one per view)
        poses_id = [v["poseId"] for v in sfm_data["views"]]
        instrinsics_id = [v["intrinsicId"] for v in sfm_data["views"]]
        views_id = [v["viewId"] for v in sfm_data["views"]]

        # Initialize lists to store scene images, calibrations, depths and masks
        images = [view["path"] for view in sfm_data["views"]]
        images_sizes = [Image.open(image).size for image in images] #FIXME: not working with exr
        depth_maps = []
        masks = []
        extrinsics = []
        intrinsics = []
        sensor_size = 35 #note, by default the sensor size is set to 35mm

        # Initialise geometry (one per scene)
        mesh = None

        # Load data
        if chunk.node.datasetType.value == "blendedMVG":#FIXME: sort as in dtu?
            chunk.logger.info("**Importing blendedMVG data")
            data = open_dataset_blended(sfm_data)
            image_names = data["depth_maps"]
            extrinsics = data["extrinsics"]
            intrinsics = data["intrinsics"] 
            depth_maps = data["depth_maps"] 
            image_sizes = data["image_sizes"]
            mesh=data["mesh"]
        elif chunk.node.datasetType.value == "DTU":
            chunk.logger.info("***Importing DTU data")
            #sort sfm data views by frame order (as in dtu)
            sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:int(v["frameId"])) 
            # reload pose IDs, calibration IDs, and view IDs (one per view), in order
            poses_id = [v["poseId"] for v in sfm_data["views"]]
            instrinsics_id = [v["intrinsicId"] for v in sfm_data["views"]]
            views_id = [v["viewId"] for v in sfm_data["views"]]

            image_folder = os.path.abspath(os.path.dirname(sfm_data["views"][0]["path"]))
            rescale=True
            extrinsics, intrinsics, gt_scale_mat = open_dtu_calibration( os.path.join(image_folder, "..", "cameras_sphere.npz"), rescale)
            #get the id of the scan from the filename
            scan_nb = int(image_folder.split('/')[-2].split('scan')[-1])
            mesh = os.path.join(image_folder,'..',f'stl{scan_nb:03}_total.ply')
            mesh = trimesh.load(mesh, force='mesh')
            if rescale:
                mesh.apply_transform(np.linalg.inv(gt_scale_mat))
            masks_folder = os.path.join(image_folder, "..", "mask")
            #FIXME: order?
            masks = [open_image(os.path.join(masks_folder, m)) for m in os.listdir(masks_folder) if (m.endswith(".png") and (not m.startswith(".")))]
        elif chunk.node.datasetType.value == "ETH3D":#FIXME: sort as in dtu?
            chunk.logger.info("**Importing ETH3D data")
            image_folder = os.path.dirname(sfm_data["views"][0]["path"])
            #load data from relative path
            data = open_dataset_eth3d(image_folder)
            # re-order the camera parameters using filename
            image_names = data["image_names"] 
            if len(image_names) != len(sfm_data["views"]):
                raise RuntimeError("Different number of images in the sfm and the GT")
            extrinsics=[]
            intrinsics=[]
            image_sizes=[]
            for v in sfm_data["views"]:
                for i, image_name in enumerate(image_names):
                    if image_name == os.path.basename(v["path"]):
                        # print(i, os.path.basename(v["path"])+" vs "+image_name)
                        extrinsics.append(data["extrinsics"][i])
                        intrinsics.append(data["intrinsics"][i])
                        image_sizes.append(data["image_sizes"][i])
                        break
                ##raise RuntimeError("Image "+v["path"]+" not found in ground truth")
            mesh = data["point_cloud"]
        elif chunk.node.datasetType.value == "baptiste":
            #sort sfm data views by filenames as in baptist's dataset 
            sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:os.path.basename(v["path"]))
            # reload pose IDs, calibration IDs, and view IDs (one per view), in order
            poses_id = [v["poseId"] for v in sfm_data["views"]]
            instrinsics_id = [v["intrinsicId"] for v in sfm_data["views"]]
            views_id = [v["viewId"] for v in sfm_data["views"]]
            #renders from https://github.com/bbrument/lambertianRendering_v1
            image_folder = os.path.dirname(sfm_data["views"][0]["path"])
            data = open_dataset_baptiste(image_folder)
            # data["image_names"]
            depth_maps = data["depth_maps"]
            masks = data["masks"]
            extrinsics = data["extrinsics"]
            intrinsics = data["intrinsics"]
            sensor_size = data["sensor_size"]
            image_sizes = data["image_sizes"]
            pixel_size = sensor_size/image_sizes[0][0]
            #turn focal and pp into pixels for export
            for i in range(len(intrinsics)):
                intrinsics[i]/=pixel_size 
                intrinsics[i][2,2]=1
        elif chunk.node.datasetType.value.startswith("vital"):#FIXME: open the same way as the rest
            image_folder = os.path.dirname(sfm_data["views"][0]["path"])
            sfm_folder=os.path.join(image_folder, "..", '..', 'sfm')
            sfm_data_vital_path = [os.path.join(sfm_folder, f) for f in os.listdir(sfm_folder) if f.endswith(".sfm")]
            if len(sfm_data_vital_path) == 0:
                raise RuntimeError("No sfm found in "+sfm_folder)
            sfm_data_vital_path=sfm_data_vital_path[0]
            with open(sfm_data_vital_path, "r") as json_file:
                sfm_data_vital = json.load(json_file)
            (extrinsics_vital, intrinsics_vital, _, _, _, _) = matrices_from_sfm_data(sfm_data_vital)
            sensor_size = float(sfm_data_vital["intrinsics"][0]["sensorWidth"])#FIXME: 
            print("Sensorwidth:", sensor_size)
            #match with sfm data using filename
            extrinsics=[]
            intrinsics=[]
            sfm_data_out = copy.deepcopy(sfm_data)
            sfm_data_out["poses"]=[]
            for i,vo in enumerate(sfm_data["views"]):
                for j,vv in enumerate(sfm_data_vital["views"]):
                    if os.path.basename(vo["path"])==os.path.basename(vv["path"]):
                        print(vo["path"]+" matched with "+vv["path"])
                        sfm_data_out["views"][i]["resectionId"]="0"#add resection id
                        pose=sfm_data_vital["poses"][i]
                        extrinsic_vital = extrinsics_vital[j]
                        rotation=extrinsic_vital[0:3, 0:3]
                        if not is_rotation_mat(rotation):
                            raise RuntimeError("Rotation matrix not valid for "+vo["viewId"])
                        translation=extrinsic_vital[:, 3]
                        pose["pose"]["transform"]["rotation"]=np.char.mod("%.20f", rotation.flatten()).tolist()
                        pose["pose"]["transform"]["center"]=np.char.mod("%.20f", translation).tolist()
                        pose["poseId"] = vo["viewId"] #FIXME: assumes matching id
                        sfm_data_out["poses"].append(pose)
                        break
            sfm_data_out["intrinsics"][0]=sfm_data_vital["intrinsics"][0]#copy gt and keep uid
            sfm_data_out["intrinsics"][0]["intrinsicId"]=sfm_data["intrinsics"][0]["intrinsicId"]
            #save FIXME: move that
            with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
                json.dump(sfm_data_out, f, indent=4)
            mesh_folder = os.path.join(image_folder, '..', '..', 'obj')
            if os.path.exists(mesh_folder):
                mesh_path = [os.path.join(mesh_folder, f)
                             for f in os.listdir(mesh_folder) if f.endswith(".obj")][0]
                print("Loading "+mesh_path)
                mesh = trimesh.load(mesh_path, force='mesh')
                mesh.export(chunk.node.mesh.value)
            else:
                print("GT mesh not found in "+mesh_folder)
            return #FIXME: unlike the other datasets we leave early here
        else:
            raise RuntimeError("Dataset type not supported")

        chunk.logger.info("**Exporting data")

        #Generate SFM data from matrices
        if not (len(extrinsics) == len(intrinsics) == len(images_sizes) ):
            raise RuntimeError("Mismatching number of parameters for the sfmData ")
        gt_sfm_data = sfm_data_from_matrices(extrinsics, intrinsics, poses_id, instrinsics_id, 
                                             images_sizes, sfm_data, sensor_width=sensor_size)

        #Add dummy resection id for display 
        for i, v in enumerate(gt_sfm_data["views"]):
            gt_sfm_data["views"][i]["resectionId"]=str(i)

        #Exports
        if chunk.node.initSfmLandmarks.value != 0:
            chunk.logger.info("**Exporting SfM landmarks")
            if mesh is None:
                raise RuntimeError("Cannot initialise landmarks with no mesh")
            mesh_data = trimesh.load(mesh, force='mesh')
            structure = []
            step = int( 1/chunk.node.initSfmLandmarks.value)
            chunk.logger.info("**Exporting %d SfM landmarks"%(int(mesh_data.vertices.shape[0]/step)))
            for vi, v in enumerate(mesh_data.vertices[::step]):#FIXME: slow
                landmark = {}
                landmark["landmarkId"] = str(vi)
                landmark["descType"] = "unknown" 
                landmark["color"] = ["255", "0", "0"]
                landmark["X"] = [str(x) for x in v]
                landmark["observations"] = []
                #create dummy obs in all views 
                #FIXME: suboptimal, ideally we would compute the viz  all all view by projection 
                for oi, i in enumerate(views_id):
                    obs =  {"observationId": str(i),
                            "featureId": str(oi),
                            "x": ["0","0"]}
                    landmark["observations"].append(obs)
                structure.append(landmark)
            gt_sfm_data["structure"] = structure

        # Save the generated SFM data to JSON file
        chunk.logger.info("**Writting sfm")
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(gt_sfm_data, f, indent=4)

        # Save depth maps if any
        if len(depth_maps)>0:
            chunk.logger.info("**Writting depth maps")
            os.makedirs(chunk.node.depthMapsFolder.value, exist_ok=True)
            for view_id, depth_map, gt_extrinsic, gt_intrinsic in zip(views_id, depth_maps, extrinsics, intrinsics):
                if os.path.exists(depth_map):
                    depth_map_gt = open_depth_map(depth_map)
                else:
                    continue
                #add flags to the depth map for display
                camera_center = gt_extrinsic[0:3, 3]
                inverse_intr_rot = np.linalg.inv(
                    gt_intrinsic @ np.linalg.inv(gt_extrinsic[0:3, 0:3]))
                #https://openimageio.readthedocs.io/en/v2.4.6.1/imageoutput.html
                depth_meta = {
                    "AliceVision:CArr": camera_center,
                    "AliceVision:iCamArr": inverse_intr_rot,
                    "AliceVision:downscale": 1
                }
                save_exr(depth_map_gt, os.path.join(chunk.node.depthMapsFolder.value, 
                        str(view_id) + "_depthMap.exr"), custom_header=depth_meta)
            
        #Save image masks if any
        if len(masks)>0:
            chunk.logger.info("**Writting masks")
            os.makedirs(chunk.node.maskFolder.value, exist_ok=True)
            for mask, view_id in zip(masks, views_id) :
                if isinstance(mask, str):
                    mask=open_image(mask)
                save_image(os.path.join(chunk.node.maskFolder.value, str(view_id) + ".png"), mask)

        #Save ground truth mesh as obj if any
        if mesh is not None:
            chunk.logger.info("**Writting mesh")
            mesh.export(chunk.node.mesh.value)
            
        chunk.logger.info("*LoadDataset ends")

