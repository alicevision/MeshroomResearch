"""
This node converts images.
"""
__version__ = "3.0"

import os
import json

import cv2 
import numpy as np

from mrrs.core.ios import open_image, save_image
from meshroom.core import desc


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
            value=1000000000,
            range=(0, 4096, 1),
            uid=[0],
        ),

        desc.BoolParam(
            name='mergeInterinsics',
            label='mergeInterinsics',
            description='Will merge all intrinsics by taking the first one',
            value=False,
            uid=[0],
        ),

        desc.BoolParam(
            name='autoRotate',
            label='autoRotate',
            description='Rotates the frames using the exif flag',
            value=False,
            uid=[0],
        ),

        desc.BoolParam(
            name='convertSRGB',
            label='convertSRGB',
            description='Will convert to srgb',
            value=True,
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
                input_image, orientation = open_image(views_original_file, return_orientation=True, 
                                                      auto_rotate=chunk.node.autoRotate.value, 
                                                      to_srgb=chunk.node.convertSRGB.value)
                print(input_image)
                chunk.logger.info('\tOrientation %d'%orientation)
                input_image = input_image[::chunk.node.resampleX.value,::]#resample
                new_filename = view_id+chunk.node.outputFormat.value
                if chunk.node.maxWidth.value<input_image.shape[1]:#max sie
                    height = int(input_image.shape[0]*chunk.node.maxWidth.value/input_image.shape[1])
                    original_dtype = input_image.dtype
                    input_image = cv2.resize(input_image.astype(np.float32), (chunk.node.maxWidth.value, height))
                    input_image = input_image.astype(original_dtype)   
                    chunk.logger.info('\tResizing to %d %d'%(chunk.node.maxWidth.value, height))
                if chunk.node.renameSequence.value:
                    new_filename = "frame_%05d"%index+chunk.node.outputFormat.value
                    chunk.logger.info("\tRenaming to to "+new_filename)
                output_file = os.path.join(chunk.node.outputFolder.value, new_filename)
                if chunk.node.autoRotate.value:
                    orientation=0
                save_image(output_file, input_image, orientation=orientation)
                sfm_data["views"][index]["path"]     = output_file
                #modify the view size
                sfm_data["views"][index]["width"] = input_image.shape[1]
                sfm_data["views"][index]["height"] = input_image.shape[0]
                #modify the corresponding intrinsic
                intrinsicId = sfm_data["views"][index]["intrinsicId"]
                index_intrinsic = [i for i,intrinsic in enumerate(sfm_data["intrinsics"]) if intrinsic["intrinsicId"]==intrinsicId][0]
                sfm_data["intrinsics"][index_intrinsic]["width"] = input_image.shape[1]
                sfm_data["intrinsics"][index_intrinsic]["height"] = input_image.shape[0]
            #update intrisic pixel ratio
            for intrisic in sfm_data["intrinsics"] :
                old_pixel_ratio = float(intrisic["pixelRatio"])
                intrisic["pixelRatio"] = str(old_pixel_ratio/chunk.node.resampleX.value)
                if chunk.node.maxWidth.value<int(intrisic["width"]):#update image size
                    intrisic["height"] = int(int(intrisic["height"])*chunk.node.maxWidth.value/int(intrisic["width"]))
                    intrisic["width"] = chunk.node.maxWidth.value
                else:
                    intrisic["height"] = int(float(intrisic["height"])/chunk.node.resampleX.value)
     
            if chunk.node.mergeInterinsics.value:
                intrinsic_id = sfm_data["intrinsics"][0]["intrinsicId"]
                sfm_data["intrinsics"] = [sfm_data["intrinsics"][0]]
                for view in sfm_data["views"]:
                    view["intrinsicId"]=intrinsic_id

            with open(chunk.node.outputSfMData.value, "w") as json_file:
                json.dump(sfm_data, json_file, indent=2)

            chunk.logger.info('Convertion ends')
        finally:
            chunk.logManager.end()
