__version__ = "2.0"

import os
import shutil
from sys import platform

from meshroom.core import desc
from . import COLMAP

class ColmapFeatureMatching(desc.CommandLineNode):
    commandLine = COLMAP+' exhaustive_matcher {allParams}'

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_database_path',
            label='InputDatabase',
            description='Input database path',
            value='',
            uid=[0],
            group='',
        ),
        desc.BoolParam(
            name="use_gpu",
            label = "Use GPU",
            description='''Will use GPU for feature extraction''',
            value=False,
            uid=[0],
            group='',
        )
    ]

    outputs = [
        desc.File(
            name='database_path',
            label='OutputDatabasePath',
            description='Output database path',
            value=os.path.join(desc.Node.internalFolder, 'colmap_database_matches.db'),
            uid=[],

        ),
    ]

    def processChunk(self, chunk):
        shutil.copy2(chunk.node.input_database_path.value, chunk.node.database_path.value)
        if not chunk.node.use_gpu.value:
            chunk.node._cmdVars["allParams"]+=" --SiftMatching.use_gpu 0"
        desc.CommandLineNode.processChunk(self, chunk)
