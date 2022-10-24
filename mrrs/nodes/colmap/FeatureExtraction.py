
__version__ = "1.1"

from meshroom.core import desc

import os
import json

class ColmapFeatureExtraction(desc.CommandLineNode):
    commandLine = 'colmap.bat feature_extractor {allParams}'

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

        desc.File(
            name='input_sfm',
            label='Input Sfm',
            description='''Extracts the image path from an input sfm''',
            value='',
            uid=[0],
            group=''
        ),

    ]

    outputs = [
        desc.File(
            name='database_path',
            label='Sensor Database',
            description='''Camera sensor width database path.''',
            value=os.path.join(desc.Node.internalFolder, "colmap_database.db"),
            uid=[],
        ),
    ]

    def processChunk(self, chunk):
        if chunk.node.input_sfm.value != '':
            image_path = json.load(open(chunk.node.input_sfm.value))["views"][0]["path"]
            chunk.node.image_path.value = os.path.dirname(image_path)
        desc.CommandLineNode.processChunk(self, chunk)
