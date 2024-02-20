__version__ = "3.0"

import os 
import json
import numpy as np

from meshroom.core import desc

from mrrs.core.geometry import *
from mrrs.core.ios import *
from mrrs.datasets import load_dataset

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
            values=['blendedMVG', 'DTU', 'ETH3D', 'baptiste', 'vital', 'NERF'],
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
            semantic='3D',
            value=os.path.join(desc.Node.internalFolder, 'mesh.ply'),
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
            group='',
        ),

        desc.File(
            name='maskFolder',
            label='Mask Folder',
            description='Image mask folder. The mask describes the visibility of the object to be observed, on each view.',
            semantic='image',
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

        print("*LoadDataset Starting")

        print("**Importing data")
        # Load SFM data from JSON file (may update sfm_data!)
        sfm_data = json.load(open(chunk.node.sfmData.value, "r"))
        gt_data, sfm_data = load_dataset(sfm_data, chunk.node.datasetType.value)
        # Load meshroom ids
        extrinsics_id = [v["poseId"] for v in sfm_data["views"]]
        instrinsics_id = [v["intrinsicId"] for v in sfm_data["views"]]
        views_id = [v["viewId"] for v in sfm_data["views"]]

        print("**Exporting data")
        #Generate SFM data from matrices
        if not (len(gt_data["intrinsics"]) == len(gt_data["extrinsics"]) ==  len(gt_data["image_sizes"])):
            raise RuntimeError("Mismatching number of parameters for the sfmData ")
        gt_sfm_data = sfm_data_from_matrices(gt_data["extrinsics"], gt_data["intrinsics"], extrinsics_id, instrinsics_id, 
                                              gt_data["image_sizes"], sfm_data, sensor_width=gt_data["sensor_size"])

        #Add dummy resection id (for display)
        for i, v in enumerate(gt_sfm_data["views"]):
            gt_sfm_data["views"][i]["resectionId"]=str(i)

        #Exports
        if chunk.node.initSfmLandmarks.value != 0: 
            print("**Exporting SfM landmarks")
            if gt_data["mesh"] is None:
                raise RuntimeError("Cannot initialise landmarks with no mesh")

            #FIXME: move to common 
            structure = []
            step = int( 1/chunk.node.initSfmLandmarks.value)
            #meshes in meshroom ar in the CG cs, landmarks are CV
            vertices = transform_cg_cv(gt_data["mesh"].vertices)
            print("**Exporting %d SfM landmarks"%(int(vertices.shape[0]/step)))
            for vi, v in enumerate(vertices[::step]):#FIXME: slow
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
        print("**Writting sfm")
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(gt_sfm_data, f, indent=4)

        # Save depth maps if any
        if "depth_maps" in gt_data:
            print("**Writting depth maps")
            os.makedirs(chunk.node.depthMapsFolder.value, exist_ok=True)
            for view_id, depth_map, gt_extrinsic, gt_intrinsic in \
                zip(views_id, gt_data["depth_maps"], gt_data["extrinsics"], gt_data["intrinsics"]):
                if os.path.exists(depth_map):
                    depth_map_gt = open_depth_map(depth_map)
                else:
                    continue
                #FIXME: move to IO?
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
        if "masks" in gt_data:
            print("**Writting masks")
            os.makedirs(chunk.node.maskFolder.value, exist_ok=True)
            for mask, view_id in zip(gt_data["masks"], views_id) :
                if isinstance(mask, str):
                    mask=open_image(mask)
                save_image(os.path.join(chunk.node.maskFolder.value, str(view_id) + ".png"), mask)

        #Save ground truth mesh as obj if any
        if "mesh" in gt_data :
            print("**Writting mesh")
            gt_data["mesh"].export(chunk.node.mesh.value)
            
        print("*LoadDataset ends")

