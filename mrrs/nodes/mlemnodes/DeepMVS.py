__version__ = "3.0"

import json
import logging
import numpy as np
import os

from meshroom.core import desc

from mrrs.core.ios import matrices_from_sfm_data, open_image, save_exr
from mrrs.deep_mvs.robust_mvd.robust_mvd_wrapper import  RobustMVDWrapper

#TODO: add abstraction for != approches

class DeepMVS(desc.Node):
    """
    Class that wraps depth mvs algorithms and models.
    It take images + calibration as input and ouptuts depth maps.
    Needs to be run with an environnent that supports RMVD for now.
    """
    gpu = desc.Level.INTENSIVE
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
            label='DepthMaps Folder',
            description='Output folder for depth maps.',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='depth',
            label='Depth Maps',
            description='Generated depth maps.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>_depthMap.exr',
            uid=[],
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
        return True


    def processChunk(self, chunk):
        """
        Runs the MVS
        """
        # try:
        chunk.logManager.start(chunk.node.verboseLevel.value)
        # check inputs
        if not self.check_inputs(chunk):
            return
        chunk.logger.info("Starts deep MVS")
        #open sfm
        with open(chunk.node.inputSfmData.value, "r") as json_file:
            sfm_data = json.load(json_file)

        extrinsics_all_cams, intrinsics_all_cams, view_ids, _, _, pixel_sizes_all_cams = matrices_from_sfm_data(sfm_data)

        view_sorted =  sorted(sfm_data["views"], key=lambda x: int(x['frameId']))#sort by temporal index frameId, breaks stuff?
        #run mvs for all views
        mvd = RobustMVDWrapper()
        nb_cams = 5#FIXME: should be a view selection, but keep slding window for now
        for index in range(len(view_sorted)):
            chunk.logger.info("View %d/%d"%(index,len(view_sorted)))
            chunk.logger.info("Reference : "+view_sorted[index]["path"])
            # selects n consequtive views
            logging.getLogger('PIL').setLevel(logging.WARNING)
            #FIXME: use the view selection from meshroom
            selected_views_indices = index+np.arange(-nb_cams, nb_cams+1)
            selected_views_indices=selected_views_indices[selected_views_indices!=index]#remove current frame
            selected_views_indices[selected_views_indices<0] += 2*nb_cams+1#eg for index 0, -5 =>6 ; -4  => 7 ...
            selected_views_indices[selected_views_indices>=len(view_sorted)] -= 2*nb_cams-1#eg for index 37,
            selected_views_indices = np.insert(selected_views_indices, 0, index)#add ref view in first position
            chunk.logger.info("Views (1rst is reference): ")
            [chunk.logger.info(view_sorted[v]["path"]) for v in  selected_views_indices]
            images_path = [view_sorted[view_index]["path"] for view_index in selected_views_indices]
            images = [open_image(image_path) for image_path in images_path]
            #get correspondng indices
            view_indices =  [np.where(np.asarray(view_ids)==view_sorted[view_index]["viewId"])[0][0] for view_index in selected_views_indices]
            #get corresponding instrinsics and extrinsics
            extrinsics = [np.concatenate([extrinsics_all_cams[v], [[0,0,0,1]]]) for v in view_indices]
            intrinsics = [intrinsics_all_cams[v] for v in view_indices]
            #run
            chunk.logger.info("Running model")
            depth_map, _ = mvd(images, extrinsics, intrinsics, pixel_sizes_all_cams)
            #save result
            save_exr(depth_map, os.path.join(chunk.node.outputDepthMapsFolder.value,
                        view_ids[view_indices[0]]+"_depthMap.exr"), data_type="depth")#FIXME: need downsample header, and resize to input size
            #, custom_header={"AliceVision:downscale"}
            print("Saving "+view_ids[view_indices[0]])
        chunk.logger.info("Done deep MVS")
        # finally:
        #     chunk.logManager.end()

