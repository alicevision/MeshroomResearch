"""
Copy data that is not exposed from a node output folder.
Usefull for exposing intermediate data.
"""
__version__ = "3.0"

import os
import json

from meshroom.core import desc
import shutil

class CopyData(desc.Node):
    category = 'Meshroom Research'

    documentation = ''' '''

    inputs = [

        desc.File(
            name='inputFolder',
            label='Input Folder',
            description='''Get the input folder from any node output''',
            value='',
            uid=[0],
        ),

        desc.StringParam(
            name='inputFile',
            label='Input File',
            description='''Input file to copy''',
            value='',
            uid=[0],
        ),

        desc.StringParam(
            name='outputName',
            label='outputName',
            description='''Output name''',
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
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='outputFile',
            label='Output File',
            description='Path to the output file',
            value=lambda attr: os.path.join(desc.Node.internalFolder, os.path.basename(attr.node.inputFile.value) if attr.node.outputName.value =="" else attr.node.outputName.value),
            uid=[],
        ),

    ]


    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            file_to_copy = os.path.join(os.path.dirname(chunk.node.inputFolder.value), chunk.node.inputFile.value)
            chunk.logger.info("Copying File"+file_to_copy)
            shutil.copyfile( file_to_copy, chunk.node.outputFile.value)
            chunk.logger.info('Copying File ends')
        finally:
            chunk.logManager.end()



