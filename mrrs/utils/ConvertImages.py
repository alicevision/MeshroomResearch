"""
This node converts images.
"""
__version__ = "3.0"

import os
import json

from meshroom.core import desc
from meshroom.core.plugin import PluginNode, EnvType

class ConvertImages(PluginNode):
    """
    Generic node to perform segmentation.
    """

    category = 'MRRS - Utils'
    documentation = ''''''

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "utils_env.yaml")

    inputs = [
        desc.File(
            name='input',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.ChoiceParam(
            name='outputFormat',
            label='Output Format',
            description='''Output format to be used.''',
            value='.png',
            values=['.png', '.jpg', '.exr'],
            exclusive=True,
        ),

        #TODO: mode auto
        desc.IntParam(
            name='resampleX',
            label='Resample X',
            description='Resample by a given factor along the x dim.',
            value=1,
            range=(0, 100, 1),
        ),

        desc.IntParam(
            name='maxWidth',
            label='Maximum Width',
            description='Will resize to the max width (keep the aspect ratio).',
            value=1000000000,
            range=(0, 4096, 1),
        ),

        desc.IntParam(
            name='forceWidth',
            label='Force Width',
            description='Will resize to the width by padding or cropping, if != 0.',
            value=0,
            range=(0, 4096, 1),
        ),

        desc.IntParam(
            name='forceHeight',
            label='Force Height',
            description='Will resize to the height by padding or cropping, if != 0.',
            value=0,
            range=(0, 4096, 1),
        ),



        desc.BoolParam(
            name='mergeInterinsics',
            label='mergeInterinsics',
            description='Will merge all intrinsics by taking the first one.',
            value=False,
        ),

        desc.BoolParam(
            name='autoRotate',
            label='autoRotate',
            description='Rotates the frames using the EXIF flag.',
            value=True,
        ),

        desc.BoolParam(
            name='convertSRGB',
            label='convertSRGB',
            description='Will convert to srgb.',
            value=True,
        ),

        desc.BoolParam(
            name='renameSequence',
            label='Rename Sequence',
            description='Renames the frames by order.',
            value=False,
        ),

        desc.BoolParam(
            name='autoPixelRatio',
            label='autoPixelRatio',
            description='Will automatically set pixel ratio (will overwrite resample).',
            value=True,
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        )
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output Folder',
            description='Output folder for converted images.',
            value=desc.Node.internalFolder,
        ),
        desc.File(
            name='outputSfMData',
            label='SfMData',
            description='Path to the output sfmdata file.',
            value=desc.Node.internalFolder + 'sfm.sfm',
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
        import cv2
        from mrrs.core.utils import cv2_resize_with_pad 
        import numpy as np
        from mrrs.core.ios import open_image, save_image
   
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
                #modify the corresponding intrinsic (! done multiple time becasue sevearl view share one intricic)
                intrinsicId = sfm_data["views"][index]["intrinsicId"]
                frameId  = int(sfm_data["views"][index]["frameId"])
                chunk.logger.info('\tOrientation %d'%orientation)
                resample_x=chunk.node.resampleX.value
                if chunk.node.autoPixelRatio.value:
                    resample_x = int(sfm_data["intrinsics"][0]["pixelRatio"])
                input_image = input_image[::resample_x,::]#resample
                new_filename = view_id+chunk.node.outputFormat.value
                if chunk.node.maxWidth.value<input_image.shape[1]:#max size
                    height = int(input_image.shape[0]*chunk.node.maxWidth.value/input_image.shape[1])
                    original_dtype = input_image.dtype
                    input_image = cv2.resize(input_image.astype(np.float32), (chunk.node.maxWidth.value, height))
                    input_image = input_image.astype(original_dtype)   
                    chunk.logger.info('\tResizing to %d %d'%(chunk.node.maxWidth.value, height))
                    
                #force resize with pad and crop
                if chunk.node.forceWidth.value  and chunk.node.forceHeight.value:
                    input_image, pads= cv2_resize_with_pad(input_image, [ chunk.node.forceWidth.value  , chunk.node.forceHeight.value], interpolation=cv2.INTER_LINEAR)
                if chunk.node.renameSequence.value:
                    new_filename = "frame_%05d"%frameId+chunk.node.outputFormat.value
                    chunk.logger.info("\tRenaming to to "+new_filename)

                output_file = os.path.join(chunk.node.outputFolder.value, new_filename)
                if chunk.node.autoRotate.value:
                    orientation=0
    
                save_image(output_file, input_image, orientation=orientation)
                sfm_data["views"][index]["path"]     = output_file

                #modify the view size
                sfm_data["views"][index]["width"] = input_image.shape[1]
                sfm_data["views"][index]["height"] = input_image.shape[0]
                index_intrinsic = [i for i,intrinsic in enumerate(sfm_data["intrinsics"]) if intrinsic["intrinsicId"]==intrinsicId][0]
                sfm_data["intrinsics"][index_intrinsic]["width"] = input_image.shape[1]
                sfm_data["intrinsics"][index_intrinsic]["height"] = input_image.shape[0]
                
                #if has been rotated, swap sensor size (should be done only once per intrisics)
                largets_dim_image=np.argmax([input_image.shape[0],input_image.shape[1]])
                largets_dim_sfm=np.argmax([ sfm_data["intrinsics"][index_intrinsic]["sensorHeight"],
                                            sfm_data["intrinsics"][index_intrinsic]["sensorWidth"]
                                            ])
                if  largets_dim_image !=  largets_dim_sfm :
                    chunk.logger.info("rotation detected for intrinsic %d"%index_intrinsic)
                    w=sfm_data["intrinsics"][index_intrinsic]["sensorWidth"]
                    sfm_data["intrinsics"][index_intrinsic]["sensorWidth"] = sfm_data["intrinsics"][index_intrinsic]["sensorHeight"]
                    sfm_data["intrinsics"][index_intrinsic]["sensorHeight"] = w
                    
            #update intrisic pixel ratio
            for intrisic in sfm_data["intrinsics"] :
                old_pixel_ratio = float(intrisic["pixelRatio"])
                intrisic["pixelRatio"] = str(old_pixel_ratio/resample_x)
                if chunk.node.maxWidth.value<int(intrisic["width"]):#update image size
                    intrisic["height"] = int(int(intrisic["height"])*chunk.node.maxWidth.value/int(intrisic["width"]))
                    intrisic["width"] = chunk.node.maxWidth.value
                else:
                    intrisic["height"] = int(float(intrisic["height"])/resample_x)
     
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
