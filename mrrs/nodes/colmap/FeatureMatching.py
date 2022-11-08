__version__ = "2.0"

from meshroom.core import desc

import os
import shutil
from sys import platform

class ColmapFeatureMatching(desc.CommandLineNode):

    if platform.startswith('win32'):
        # Windows-specific code here...
        commandLine = 'colmap.bat exhaustive_matcher {allParams}'
    elif platform.startswith('linux'):
        # Linux-specific code here...
        commandLine = 'colmap exhaustive_matcher {allParams}'
    

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
        desc.CommandLineNode.processChunk(self, chunk)
