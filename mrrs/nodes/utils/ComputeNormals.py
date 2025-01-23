__version__ = "3.0"

import json
import os

import numpy as np

from meshroom.core import desc

from mrrs.core.ios import matrices_from_sfm_data, open_exr, open_image, save_exr
from mrrs.core.geometry import compute_normals, make_homogeneous

class ComputeNormals(desc.Node):
    """
    Class that compute normal maps from a depth map folder
    """
    # gpu = desc.Level.HIGH

    category = 'Meshroom Research'#'Dense Reconstruction'
    documentation = '''Compute normal maps from a depth map folder'''

    inputs = [
        desc.File(
            name='inputSfmData',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),
        desc.File(
            name="depthMapsFolder",
            label="DepthMaps Folder",
            description="Input depth maps folder.",
            value="",
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='outputNormalFolder',
            label='Output normal Folder',
            description='Output folder for refined depth maps.',
            value='{nodeCacheFolder}',
        ),
        desc.File(
            name='normals',
            label='Normal maps',
            description='Generated depth maps.',
            semantic='image',
            value='{nodeCacheFolder}/<VIEW_ID>.exr',
            group='', # do not export on the command line
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputSfmData.value:
            chunk.logger.warning("No input inputSfmData in node DeepDepthMapRefinement, skipping")
            return False
        if not chunk.node.depthMapsFolder.value:
            chunk.logger.warning("No input depthMapsFolder in node DeepDepthMapRefinement, skipping")
            return False
        return True


    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            # check inputs
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Starts computing normals")
            #open sfm
            with open(chunk.node.inputSfmData.value, "r") as json_file:
                sfm_data = json.load(json_file)

            # extrinsics_all_cams, intrinsics_all_cams, views_id, poses_id, intrinsics_id, pixel_sizes_all_cams = matrices_from_sfm_data(sfm_data)

            #run normlal conv
            for view in sfm_data["views"]:
                view_id = view["viewId"]
                # extrinsics = extrinsics_all_cams[np.where(poses_id==view["poseId"])[0][0]]
                depth_map_path = os.path.join(chunk.node.depthMapsFolder.value,view_id+"_depthMap.exr" )#FIXME: hardcoded
                depth_map, depth_map_header = open_exr(depth_map_path)
                normals = compute_normals(depth_map)
                # normals_world_cs = (extrinsics[0:3,0:3]@normals.reshape(-1,3).T).T
                # normals_world_cs=normals_world_cs.reshape(normals.shape)
                # write noramls
                normals_path = os.path.join(chunk.node.outputNormalFolder.value,view_id + ".exr" )#FIXME: hardcoded
                save_exr(normals, normals_path, data_type="RGB")

            chunk.logger.info("Done computing normals")
        finally:
            chunk.logManager.end()

