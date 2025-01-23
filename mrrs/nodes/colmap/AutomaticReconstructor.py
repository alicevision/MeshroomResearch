__version__ = "4.0"

import os
from sys import platform

from meshroom.core import desc
from . import COLMAP

class ColmapAutomaticReconstructor(desc.CommandLineNode):
    commandLine = COLMAP+' automatic_reconstructor  {allParams}'

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='image_path',
            label='Image Directory',
            description='''Path to images.''',
            value='',
        ),

    ]

    outputs = [

        desc.File(
            name='workspace_path',
            label='Output Folder',
            description='''Output Folder.''',
            value='{nodeCacheFolder}',
        ),
        desc.File(
            name='output_pc',
            label='Output point cloud',
            description='''Output point cloud.''',
            value=os.path.join('{nodeCacheFolder}', 'dense\\0\\fused.ply'),
            group='',
        ),
    ]

    def buildCommandLine(self, chunk):
        cmd = desc.buildCommandLine(self, chunk)
        return cmd.replace(">", ".")