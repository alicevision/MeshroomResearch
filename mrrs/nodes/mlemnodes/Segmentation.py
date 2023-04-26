"""
This node perform segmentation of any kind on input images.
"""
__version__ = "3.0"

import os
import json
from PIL.Image import linear_gradient

import numpy as np
from meshroom.core import desc

from mrrs.core.ios import open_image, save_exr, save_image
#FIXME: would be better with azy import?
from mrrs.segmentation.instance_segmentation.mask_rcnn import InstanceSegmentationMaskRCNN
from mrrs.segmentation.semantic.fcnResnet50 import SemanticSegmentationFcnResnet50

from mrrs.segmentation.facial_segmentation.bisnet import BisnetSegmentation

class Segmentation(desc.Node):
    """
    Generic node to perform segmentation.
    """
    size = desc.DynamicNodeSize('input')
    category = 'Meshroom Research'
    documentation = '''Node to compute the segmentation of input images. Different kind of segmentation can be used.'''

    # size = desc.DynamicNodeSize('SfMData')

    inputs = [
        desc.File(
            name='input',
            label='SfMData',
            description='SfMData file.',
            value='',
            uid=[0],
        ),

        desc.ChoiceParam(
            name='segmentationMethod',
            label='Segmetation Method',
            description='''Segmentation method to be used''',
            value='InstanceSegmentationMaskRCNN',
            values=['InstanceSegmentationMaskRCNN', 'SemanticSegmentationFcnResnet50', 'BisnetSegmentation'],
            exclusive=True,
            uid=[0],
        ),

        desc.ListAttribute(
            elementDesc=desc.StringParam(#FIXME: should be a choiceparam with dynamically set classes names from the seg
                        name='className',
                        label='Class Name',
                        description='Class name to be added to the mask',
                        value='classname',
                        uid=[0]),
            name="createMask",
            label="Create Masks",
            description="Create a mask with the input labels names(s)"
        ),

        desc.BoolParam(
            name='inverseClassmask',
            label='Inverse Class Mask',
            description='''Will inverse the class mask''',
            value=True,
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
        ),
    ]

    outputs = [
        desc.File(
            name='output',
            label='Output Segmentation',
            description='Output folder for generated results.',
            value=desc.Node.internalFolder,
            uid=[],
        ),

        desc.File(
            name='outputMask',
            label='Output Mask',
            description='Output folder to generate the masks.',
            value=desc.Node.internalFolder,
            uid=[],
        )
    ]

    def check_inputs(self, chunk):
        """
        Verify the inputs are properly set
        """
        if not chunk.node.input:
            chunk.logger.warning('No input in node Segmentation, skipping')
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
            #instantiate segmentor
            segmentor = eval(chunk.node.segmentationMethod.value+"()")
            #main loop TODO: batch option?
            chunk.logger.info('Computing segmentation for %d images'%len(views_ids))
            for index, (views_id, views_original_file) in enumerate(zip(views_ids, views_original_files)):
                #calling segmentation
                chunk.logger.info('Computing segmentation for image %d/%d images'%(index, len(views_ids)))
                input_image = open_image(views_original_file)
                if np.amin(input_image)<0 or np.amax(input_image)>255:
                    chunk.logger.warn("Segmentation assumes uint8 0-255 rgb values. Will attempt to convert")
                    # def lin2srgb(image):
                    #     mask = image> 0.0031308
                    #     image[mask] = 1.055 * (np.power(image[mask], (1.0 / 2.4))) - 0.055
                    #     image[~mask] = 12.92 * image[~mask]
                    # input_image = lin2srgb(input_image)
                    # input_image = 255*(input_image-np.amin(input_image))/(np.amax(input_image)-np.amin(input_image))
                    # save_image("./test.png", input_image)
                    converted_path = os.path.join(chunk.node.output.value,views_id+"_converted.png")
                    os.system("iconvert "+views_original_file+" "+converted_path)
                    input_image, meta_image = open_image(converted_path, return_meta=True)
                    #rm file

                # save_image(os.path.join(chunk.node.output.value, views_id+"_image.png"), input_image)#FIXME: to remove (used in debug)
                output_masks, output_classes = segmentor(input_image)#segmentor retrurns 1-hot vectors+corresponding class name
                chunk.logger.info('%d objects found'%(len(output_masks)))
                #dumps class names
                np.savetxt(os.path.join(chunk.node.output.value, views_id+"_classes.txt" ) , output_classes, fmt="%s")

                #if a class mask is passed will create it for each channel
                if len(chunk.node.createMask.value)>0:
                    if len(output_masks)>0:
                        mask = np.zeros(output_masks[0].shape[0:2], dtype=np.uint8)
                        selected_masks = [m._value for m in chunk.node.createMask.value]
                        #creating mask by | the masks of the selected classes
                        for output_mask, output_class in zip(output_masks, output_classes):
                            print(output_class)
                            output_class_radical = output_class.split("_")[0]
                            if output_class_radical in selected_masks:
                                mask |= output_mask
                        if chunk.node.inverseClassmask.value:
                            mask = 255-mask
                        save_image(os.path.join(chunk.node.output.value, views_id+".png"), mask[:,:])#FIXME: need resize to size of the input image?

                    else:
                        chunk.logger.warn("No objects detected for "+views_id)
                #save final images: an exr with a one hot per channel, the channel name is the class name
                if len(output_masks) > 0:
                    output_masks = np.stack(output_masks, axis=-1)
                else:
                    output_masks = np.zeros(input_image.shape[0:2])#empty image if no objects found
                    output_classes = "unlabeled"
                save_exr(output_masks, os.path.join(chunk.node.output.value, views_id+"_segmentation.exr"),
                         data_type="segmentation", channel_names=output_classes)

            chunk.logger.info('Computing segmentation end')
        finally:
            chunk.logManager.end()
