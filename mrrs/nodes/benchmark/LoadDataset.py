__version__ = "3.0"

import copy
import os 
import json
from re import S

import trimesh
import numpy as np
from PIL import Image

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *

from mrrs.datasets.blendedMVG import open_txt_calibration_blendedMVG
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
            values=['blendedMVG', 'DTU', 'vital', 'vital_flipped'],
            exclusive=True,
            uid=[0],
        ),

        desc.FloatParam(
            name='initSfmLandmarks',
            label='Init Landmarks',
            description='''Will initalise sfmLandmarks with the vertices ground truth mesh (if any). 0 for deactivated, otherwise generate use n*nb_vertices landmarks.''',
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
            enabled=lambda attr: (attr.node.datasetType.value=='blendedMVG'), #FIXME: does not work!!
        ),

        desc.File(
            name='mesh',
            label='Mesh',
            description='Loaded mesh.',
            semantic='mesh',
            value=os.path.join(desc.Node.internalFolder, 'mesh.obj'),
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
        ),

        desc.File(
            name='maskFolder',
            label='Mask Folder',
            description='Image mask folder',
            value=os.path.join(desc.Node.internalFolder,'masks'),
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
        ),

        desc.File(
            name='observationMask',
            label='Observation Mask',
            description='Occupancy map',
            value=os.path.join(desc.Node.internalFolder,
                               'observation_mask.npy'),
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
        ),

        desc.File(
            name='groundPlane',
            label='Ground Plane',
            description='Ground plane',
            value=os.path.join(desc.Node.internalFolder,
                               'ground_plane.npy'),
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
        ),

        desc.File(#for display
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
        sensor_size = 1 #note, by default the sensor size is set to a virtual sensor size of 1

        # Initialise geometry (one per scene)
        mesh = None
        observation_mask = None
        ground_plane = None

        # Load data
        if chunk.node.datasetType.value == "blendedMVG":
            chunk.logger.info("**Importing blendedMVG data")
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
            extrinsics = [np.linalg.inv(e) if e is not None else None for e in extrinsics] # R-1 and R-1.-T, needed to reuse sfm_data_from_matrices
            mesh_list_path = os.path.join(folder, "..", "textured_mesh", 'mesh_list.txt') 
            if os.path.exists(mesh_list_path):
                chunk.logger.info("**Importing blendedMVG mesh data")
                mesh_list = [os.path.basename(p) for p in  open(mesh_list_path, 'r').read().splitlines()]
                mesh = None
                submeshes = []
                for i, mesh_path in enumerate(mesh_list):
                    chunk.logger.info("**%d/%d"%(i, len(mesh_list)))
                    submesh_path = os.path.join(folder, "..", "textured_mesh", mesh_path)
                    submesh = trimesh.load_mesh(submesh_path) 
                    submeshes.append(submesh)
                mesh = trimesh.util.concatenate(submeshes)
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
            try:
                from scipy.io import loadmat
            except:
                chunk.logger.warning("Scipy not installed, will not load observation masks or ground plane")
            observation_mask = loadmat(os.path.join(image_folder, "..", f"ObsMask{scan_nb}_10.mat") )
            ground_plane = loadmat(os.path.join(image_folder, "..", f"Plane{scan_nb}.mat"))     
        elif chunk.node.datasetType.value.startswith("vital"):
            image_folder = os.path.dirname(sfm_data["views"][0]["path"])
            sfm_data_vital_path = [os.path.join(image_folder, f) for f in os.listdir(image_folder) if f.endswith(".sfm")][0]
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
                        if chunk.node.datasetType.value == "vital_flipped":
                            transform_mat = np.asarray([[1,0,0],[0,-1,0],[0,0,-1]])
                            extrinsic_vital = transform_mat@extrinsics_vital[j]
                        else:
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
            #save
            with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
                json.dump(sfm_data_out, f, indent=4)
            mesh_folder = os.path.join(image_folder, '..', 'mesh')
            if os.path.exists(mesh_folder):
                mesh_path = [os.path.join(mesh_folder, f)
                             for f in os.listdir(mesh_folder) if f.endswith(".obj")][0]
                print("Loading "+mesh_path)
                mesh = trimesh.load(mesh_path, force='mesh')
                mesh.export(chunk.node.mesh.value)
            return #unlike the other datasets we leave early here
        elif chunk.node.datasetType.value == "ETH3D":
            RuntimeError("ETH3D support TBA") 
        else:
            raise RuntimeError("Dataset type not supported")

        chunk.logger.info("**Exporting data")
        # generate SFM data from matrices
        gt_sfm_data = sfm_data_from_matrices(extrinsics, intrinsics, poses_id, instrinsics_id, 
                                             images_sizes, sfm_data, sensor_width=sensor_size)

        # Exports
        if chunk.node.initSfmLandmarks.value != 0:
            chunk.logger.info("**Exporting SfM landmarks")
            if mesh is None:
                raise RuntimeError("Cannot initialise landmarks with no mesh")
            mesh_data = trimesh.load(mesh, force='mesh')
            structure = []
            step = int( 1/chunk.node.initSfmLandmarks.value)
            for vi, v in enumerate(mesh_data.vertices[::step]):
                chunk.logger.info("**Exporting SfM landmarks %d/%d"%(vi, mesh_data.vertices.shape[0]))
                landmark = {}
                landmark["landmarkId"] = str(vi)
                landmark["descType"] = "unknown" 
                landmark["color"] = ["255", "0", "0"]
                landmark["X"] = [str(x) for x in v]
                landmark["observations"] = []
                #create dummy obs in all views FIXME: suboptimal, ideally we would compute the viz  all all view by projection 
                for oi, i in enumerate(views_id):
                    obs =  {"observationId": str(i),
                            "featureId": str(oi),
                            "x": ["0","0"]}
                    landmark["observations"].append(obs)
                structure.append(landmark)
            gt_sfm_data["structure"] = structure


        # Save the generated SFM data to JSON file
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(gt_sfm_data, f, indent=4)

        #save depth maps if any
        if len(depth_maps)>0:
            os.makedirs(chunk.node.depthMapsFolder.value, exist_ok=True)
            for view_id, depth_map, gt_extrinsic, gt_intrinsic in zip(views_id, depth_maps, extrinsics, intrinsics):
                if os.path.exists(depth_map):
                    depth_map_gt = open_depth_map(depth_map)
                else:
                    continue

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
            os.makedirs(chunk.node.maskFolder.value, exist_ok=True)
            for mask, view_id in zip(masks, views_id) :
                save_image(os.path.join(chunk.node.maskFolder.value, str(view_id) + ".png"), mask)

        #Save ground truth mesh as obj if any
        if mesh is not None:
            mesh.export(chunk.node.mesh.value)

        #Save observation grid if any
        if observation_mask is not None:
            np.savez_compressed(chunk.node.observationMask.value)

        #Save plane if any 
        if ground_plane is not None:
            np.savez_compressed(chunk.node.groundPlane.value)
            
        chunk.logger.info("*LoadDataset ends")

