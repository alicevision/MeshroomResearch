__version__ = "2.0"

import os
import shutil

from meshroom.core import desc
from . import COLMAP

class ColmapMapper(desc.CommandLineNode):
    commandLine = COLMAP+' mapper {allParams}'#  --output_type TXT

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
        desc.File(
            name='image_path',
            label='Image Directory',
            description='''Path to images.''',
            value='',
        ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='BaseOutputPath',
            description='Base Output path.',
            value=desc.Node.internalFolder,
        ),
        desc.File(
            name='output_path0',
            label='OutputPath0',
            description='Output path 0.',
            value=os.path.join(desc.Node.internalFolder, "0"),
            group=""
        ),
        # desc.File(
        #     name='cameras',
        #     label='Cameras',
        #     description='Ouptut camera file',
        #     value=os.path.join(desc.Node.internalFolder, "0", "cameras.bin"),
        #     group=""
        # ),
        desc.File(
            name='database_path',
            label='OutputDatabasePath',
            description='Output database path',
            value=os.path.join(desc.Node.internalFolder, 'colmap_database_mapper.db'),
        ),

    ]

    def processChunk(self, chunk):
        shutil.copy2(chunk.node.input_database_path.value, chunk.node.database_path.value)
        desc.CommandLineNode.processChunk(self, chunk)
