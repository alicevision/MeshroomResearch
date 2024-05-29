"""
Copy data that is not exposed from a node output folder.
Usefull for exposing intermediate data.
"""
__version__ = "3.0"

import os

from meshroom.core import desc
import shutil
from distutils.dir_util import copy_tree

class CopyData(desc.Node):
    category = 'Meshroom Research'

    documentation = ''' '''

    inputs = [

        desc.File(
            name='inputFolder',
            label='Input Folder',
            description='''Get the input folder from any node output.''',
            value='',
        ),

        desc.StringParam(
            name='inputFile',
            label='Input File',
            description='''Input file to copy.''',
            value='',
        ),

        desc.StringParam(
            name='outputName',
            label='outputName',
            description='''Output name.''',
            value='',
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
            name='outputFile',
            label='Output File',
            description='Path to the output file.',
            value=lambda attr: os.path.join(desc.Node.internalFolder, os.path.basename(attr.node.inputFile.value) if attr.node.outputName.value =="" else attr.node.outputName.value),
        ),

    ]


    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            input_dir = chunk.node.inputFolder.value
            if os.path.isfile(input_dir):
                input_dir = os.path.dirname(input_dir)
            file_to_copy = os.path.join(input_dir, chunk.node.inputFile.value)
            if os.path.isdir(file_to_copy):
                chunk.logger.info("Copying folder"+file_to_copy)
                copy_tree( file_to_copy, chunk.node.outputFile.value)
                chunk.logger.info('Copying folder ends')
            else:
                chunk.logger.info("Copying file"+file_to_copy)
                shutil.copyfile( file_to_copy, chunk.node.outputFile.value)
                chunk.logger.info('Copying file ends')
        finally:
            chunk.logManager.end()



