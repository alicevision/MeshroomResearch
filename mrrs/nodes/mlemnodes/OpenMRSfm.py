"""
This nodes opens an sfm from the image path.
"""
__version__ = "3.0"

import os
import json

from meshroom.core import desc
import shutil

class OpenMRSfM(desc.Node):
    category = 'Meshroom Research'

    documentation = ''' '''

    size = desc.DynamicNodeSize('sfmData')

    inputs = [

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.StringParam(
            name='relativePath',
            label='Relative path',
            description='''Path to find the sfm from where the images are''',
            value='../sfmdata.sfm',
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
            name='outputSfMData',
            label='SfMData',
            description='Path to the output sfmdata file',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        ),

    ]


    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            chunk.logger.info("Loading SfMData:")

            with open(chunk.node.sfmData.value,"r") as json_file:
                sfm_data= json.load(json_file)
            image_folder = os.path.dirname(sfm_data["views"][0]["path"])
            sfm_path = os.path.join(image_folder, chunk.node.relativePath.value)
            chunk.logger.info(sfm_path)
            shutil.copyfile(sfm_path, chunk.node.outputSfMData.value)
            chunk.logger.info('Loading SfMData ends')
        finally:
            chunk.logManager.end()



