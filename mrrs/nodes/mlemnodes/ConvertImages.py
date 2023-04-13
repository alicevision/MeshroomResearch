"""
This node converts images.
"""
__version__ = "3.0"

import os

from mrrs.core.ios import open_image, save_image
import cv2 
from meshroom.core import desc
import numpy as np
import json

class ConvertImages(desc.Node):
    """
    Generic node to perform segmentation.
    """
    size = desc.DynamicNodeSize('input')
    category = 'Meshroom Research'
    documentation = '''Node to convert images into a specific file format'''

    size = desc.DynamicNodeSize('input')

    inputs = [
        desc.File(
            name='input',
            label='SfMData',
            description='SfMData file.',
            value='',
            uid=[0],
        ),

        desc.ChoiceParam(
            name='outputFormat',
            label='Output Format',
            description='''Output format to be used''',
            value='.png',
            values=['.png', '.jpg', '.exr'],
            exclusive=True,
            uid=[0],
        ),

        #TODO: mode auto
        desc.IntParam(
            name='resampleX',
            label='Resample X',
            description='Resample by a given factor along the x dim.',
            value=1,
            range=(0, 100, 1),
            uid=[0],
        ),

        desc.IntParam(
            name='maxWidth',
            label='Maximum Width',
            description='Will resize to the max width (keep the aspect ratio)',
            value=2024,
            range=(0, 4096, 1),
            uid=[0],
        ),

        desc.BoolParam(
            name='rotateLeft',
            label='Rotate left',
            description='Rotates the frames on the left',
            value=False,
            uid=[0],
        ),

        desc.BoolParam(
            name='renameSequence',
            label='Rename Sequence',
            description='Renames the frames by order',
            value=False,
            uid=[0],
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        )
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output Folder',
            description='Output folder for converted images.',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='outputSfMData',
            label='SfMData',
            description='Path to the output sfmdata file',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        )
        ]

    def check_inputs(self, chunk):
        """
        Verify the inputs are properly set
        """
        if not chunk.node.input:
            chunk.logger.warning('No input in node ConvertImage, skipping')
            return False
        return True

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return
            #get views ids and path
            sfm_data=json.load(open(chunk.node.input.value,"r"))
            views_ids = [view["viewId"] for view in sfm_data["views"]]
            views_original_files = [view["path"] for view in sfm_data["views"]]
            chunk.logger.info('Doing convertion for %d images'%len(views_ids))
            for index, (view_id, views_original_file) in enumerate(zip(views_ids, views_original_files)):
                chunk.logger.info('Doing convertion for image %d/%d images'%(index, len(views_ids)))
                input_image = open_image(views_original_file)
                input_image = input_image[::chunk.node.resampleX.value,::]#resample
                new_filename = view_id+chunk.node.outputFormat.value
                if chunk.node.maxWidth.value<input_image.shape[1]:#max sie
                    height = int(input_image.shape[0]*chunk.node.maxWidth.value/input_image.shape[1])
                    input_image = cv2.resize(input_image, (chunk.node.maxWidth.value, height))
                if chunk.node.renameSequence.value:
                    new_filename = "frame_%05d"%index+chunk.node.outputFormat.value
                if chunk.node.rotateLeft.value:#rename
                    input_image = np.rot90(input_image)
                output_file = os.path.join(chunk.node.outputFolder.value, new_filename)
                save_image(output_file, input_image)
                sfm_data["views"][index]["path"]     = output_file
                #not used in sfm?
                sfm_data["views"][index]["width"] = input_image.shape[1]
                sfm_data["views"][index]["height"] = input_image.shape[0]

            #update intrisic pixel ratio
            for intrisic in sfm_data["intrinsics"] :
                old_pixel_ratio = float(intrisic["pixelRatio"])
                intrisic["pixelRatio"] = str(old_pixel_ratio/chunk.node.resampleX.value)
                if chunk.node.maxWidth.value<int(intrisic["width"]):#update image size
                    intrisic["height"] = int(int(intrisic["height"])*chunk.node.maxWidth.value/int(intrisic["width"]))
                    intrisic["width"] = chunk.node.maxWidth.value
                else:
                    intrisic["height"] = int(float(intrisic["height"])/chunk.node.resampleX.value)
                if chunk.node.rotateLeft.value:
                    h=intrisic["height"]
                    intrisic["height"] = intrisic["width"]
                    intrisic["width"] = h
            with open(chunk.node.outputSfMData.value, "w") as json_file:
                json.dump(sfm_data, json_file, indent=2)

            chunk.logger.info('Convertion ends')
        finally:
            chunk.logManager.end()
