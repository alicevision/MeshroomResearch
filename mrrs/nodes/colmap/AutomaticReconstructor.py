__version__ = "4.0"

import os

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
            uid=[0],
        ),

    ]

    outputs = [

        desc.File(
            name='workspace_path',
            label='Output Folder',
            description='''Output Folder.''',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='output_pc',
            label='Output point cloud',
            description='''Output point cloud''',
            value=os.path.join(desc.Node.internalFolder, 'dense\\0\\fused.ply'),
            uid=[],
            group='',
        ),
    ]
