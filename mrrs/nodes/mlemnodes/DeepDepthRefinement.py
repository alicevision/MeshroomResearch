__version__ = "3.0"

import json
import os

from meshroom.core import desc

from mrrs.core.ios import open_exr, open_image, save_exr
from mrrs.depth_map_refinement.learning_based_refinement.forward_wrapper import LearningBasedDepthRefinement

class DeepDepthMapRefinement(desc.Node):
    """
    Class that wraps depth refinement algorithms and models.
    """
    # gpu = desc.Level.HIGH

    category = 'Meshroom Research'#'Dense Reconstruction'
    documentation = '''Runs the deep depth refinement step to improve the quality of the depth maps'''

    inputs = [
        desc.File(
            name='inputSfmData',
            label='SfMData',
            description='SfMData file.',
            value='',
            uid=[0],
        ),
        desc.File(
            name="depthMapsFolder",
            label="DepthMaps Folder",
            description="Input depth maps folder",
            value="",
            uid=[0],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[],
        ),
    ]

    outputs = [
        desc.File(
            name='outputDepthMapsFolder',
            label='Refined DepthMaps Folder',
            description='Output folder for refined depth maps.',
            value=desc.Node.internalFolder,
            uid=[],
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
            chunk.logger.info("Starts refining depth maps")
            #open sfm
            with open(chunk.node.inputSfmData.value, "r") as json_file:
                sfm_data = json.load(json_file)

            #run refinement
            refiner = LearningBasedDepthRefinement()
            for view in sfm_data["views"]:
                view_id = view["viewId"]
                image_path = view["path"]
                depth_map_path = os.path.join(chunk.node.depthMapsFolder.value,view_id+"_depthMap.exr" )#FIXME: hardcoded
                depth_map, depth_map_header = open_exr(depth_map_path)
                image = open_image(image_path)/255.0 #FIXME; during treaining we load from exr !
                depth_map_refined = refiner(depth_map,image)
                # write new depths
                depth_map_refine_path = os.path.join(chunk.node.outputDepthMapsFolder.value,view_id + "_depthMap.exr" )#FIXME: hardcoded
                save_exr(depth_map_refined, depth_map_refine_path, data_type="depth", custom_header=depth_map_header)
                save_exr(depth_map, depth_map_refine_path+"_orig.exr", data_type="depth")

            chunk.logger.info("Done refining depth maps")
        finally:
            chunk.logManager.end()

