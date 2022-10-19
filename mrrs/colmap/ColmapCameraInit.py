__version__ = "4.0"

import os
import json
import psutil
import shutil
import tempfile
import logging

from meshroom.core import desc


class ColmapCameraInit(desc.CommandLineNode):
    commandLine = 'colmap feature_extractor {allParams}'
    # size = desc.StaticNodeSize(1)

    category = 'Colmap/Sparse Reconstruction'
    documentation = '''
'''

    inputs = [
        desc.File(
            name='imageDirectory',
            label='Image Directory',
            description='''Path to images.''',
            value='',
            uid=[0],
        ),
        desc.File(
            name='sensorWidthDatabase',
            label='Sensor Database',
            description='''Camera sensor width database path.''',
            value=os.environ.get('OPENMVG_SENSOR_DB', ''),
            uid=[],
        ),
        desc.FloatParam(
            name='focal',
            label='Default Focal',
            description='',
            value=-1.0,
            range=(-1.0, 50000.0, 1.0),
            uid=[0],
            advanced=True,
        ),
    ]

    outputs = [
        desc.File(
            name='output',
            label='SfMData',
            description='''Output SfMData.''',
            value=desc.Node.internalFolder + 'sfm_data.json',
            uid=[],
            group='',
        ),
        desc.File(
            name='outputDirectory',
            label='Output Folder',
            description='''Output SfMData.''',
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]
