"""
This nodes opens data from various dataset.
It will overwrite values in an input sfm data.

It uses the camera init node and relative path to find the corresponding data, depending on the dataset.
It will create its own .sfm and create a ground truth depth map folder and mesh etc. is applicable.

Specific documentation for BlendedMVSDataset:
TODO

Specific documentation for XMP from reality capture:
TODO NOTE: sould be in a node?

Specific documentation for DTU dataset
This following workspace folder structure is needed:
+---DTU_sphere #https://drive.google.com/drive/folders/1qiG2aaNRxlfJ7GscI4LRFJR6icvEY3Jm
|   +---scan24
|       +---images
|       +---mask
|       +---cameras_sphere.npz
|   +---scan...
|       +---images
|       +---mask
|       +---cameras_sphere.npz
+---SampleSet #https://roboimagedata.compute.dtu.dk/?page_id=36
|   +---Matlab evaluation code
|   +---MVS Data
|       +---ObsMask
|           +---ObsMask1_10.mat
|           +---ObsMask..._10.mat
|           +---ObsMask122_10.mat
|           +---Plane1.mat
|           +---Plane....mat
|           +---Plane122.mat
|       +---Points
|           +---stl
|               +---stl001_total.ply
|               +---stl..._total.ply
|               +---stl122_total.ply

"""
__version__ = "3.0"


import os 
import json

import trimesh
import numpy as np

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
            values=['blendedMVG', 'DTU'],
            exclusive=True,
            uid=[0],
        ),

        desc.FloatParam(
            name='initSfmLandmarks',
            label='initSfmLandmarks',
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
            label='SfMData',
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
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
        ),

        desc.File(
            name='maskFolder',
            label='maskFolder',
            description='Image mask folder',
            value=os.path.join(desc.Node.internalFolder,'masks'),
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
        ),

        desc.File(
            name='observationMask',
            label='observationMask',
            description='Occupancy map',
            value=os.path.join(desc.Node.internalFolder,
                               'mesh.obj'),
            enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
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
        images = []
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
                # pixel_size = sensor_size / images_sizes[0][0]
                images.append(image)
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
                #FIXME: need to rotate in CG CS?

        elif chunk.node.datasetType.value == "DTU":
            chunk.logger.info("***Importing DTU data")
            #FIXME: check order!!! with frame id
            image_folder = os.path.abspath(os.dirname(sfm_data["views"][0][["path"]]))
            extrinsics, intrinsics, gt_scale_mat = open_dtu_calibration( os.path.join(image_folder, "..", "cameras_sphere.npz"))
            scan_nb = int(image_folder.split('/')[-2].split('scan')[-1])
            mesh = os.path.join(image_folder,'Points','stl',f'stl{scan_nb:03}_total.ply'),
            #TODO
            observation_mask = None#f'{args.dataset_dir}/ObsMask/ObsMask{args.scan}_10.mat'
            masks = None
            ground_plane = None
        elif chunk.node.datasetType.value == "ETH3D":
            RuntimeError("ETH3D support TBA") 
        else:
            raise RuntimeError("Dataset type not supported")

        chunk.logger.info("**Exporting data")
        
        # generate SFM data from matrices
        images_sizes = [Image.open(image).size for image in images] #FIXME: not working with exr
        gt_sfm_data = sfm_data_from_matrices(extrinsics, intrinsics, poses_id, instrinsics_id, 
                                             images_sizes, sfm_data, sensor_size)

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
        for mask, view_id in zip(masks, views_id) :
            save_image(os.path.join(chunk.node.maskFolder.value, str(view_id) + ".png"), mask)

        #Save ground truth mesh as obj if any
        if mesh is not None:
            mesh_data = trimesh.load(mesh, force='mesh')
            mesh_data.export(chunk.node.mesh.value)

        #Save observation grid if any
        if observation_mask is not None:
            raise BaseException("obervationmask not suported yet") #f'{args.dataset_dir}/ObsMask/ObsMask{args.scan}_10.mat'

        #Save plane if any 
        if ground_plane is not None:
            raise BaseException("obervationmask not suported yet")
            # ground_plane = loadmat(f'{args.dataset_dir}/ObsMask/Plane{args.scan}.mat')['P']
            # data_hom = np.concatenate([data_in_obs, np.ones_like(data_in_obs[:,:1])], -1)
        chunk.logger.info("*LoadDataset ends")

