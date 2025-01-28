__version__ = "2.0"

import os
import shutil

from meshroom.core import desc
from . import COLMAP

class ColmapFeatureMatching(desc.CommandLineNode):
    commandLine = COLMAP+' exhaustive_matcher {allParams}'

    category = 'MRRS - Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_database_path',
            label='InputDatabase',
            description='Input database path.',
            value='',
            group='',
        ),
        desc.BoolParam(
            name="use_gpu",
            label = "Use GPU",
            description='''Will use GPU for feature extraction.''',
            value=False,
            group='',
        )
    ]

    outputs = [
        desc.File(
            name='database_path',
            label='OutputDatabasePath',
            description='Output database path.',
            value=os.path.join(desc.Node.internalFolder, 'colmap_database_matches.db'),
        ),
    ]

    def buildCommandLine(self, chunk):
        command_line = desc.CommandLineNode.buildCommandLine(self, chunk)#as default
        #add the extra params
        if not chunk.node.use_gpu.value:
            command_line+=" --SiftMatching.use_gpu 0" 
        return command_line

    def processChunk(self, chunk):
        shutil.copy2(chunk.node.input_database_path.value, chunk.node.database_path.value)
        desc.CommandLineNode.processChunk(self, chunk)
