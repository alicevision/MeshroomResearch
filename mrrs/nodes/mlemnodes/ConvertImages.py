"""
This node converts images.
"""
__version__ = "3.0"

import os

from mrrs.core.ios import open_image, save_image
from meshroom.core import desc

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
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output Folder',
            description='Output folder for converted images.',
            value=desc.Node.internalFolder,
            uid=[],
        )]

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
            for index, (views_id, views_original_file) in enumerate(zip(views_ids, views_original_files)):
                #calling segmentation
                chunk.logger.info('Doing convertion for image %d/%d images'%(index, len(views_ids)))
                input_image = open_image(views_original_file)
                new_filename = views_ids+chunk.node.outputFormat.value
                output_file = os.path.join(chunk.node.outputFolder.value, new_filename)
                save_image(input_image, output_file)

            chunk.logger.info('Convertion ends')
        finally:
            chunk.logManager.end()
