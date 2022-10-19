__version__ = "1.1"

from meshroom.core import desc

import os

class ColmapFeatureExtraction(desc.CommandLineNode):
    commandLine = 'colmap feature_extractor {allParams}'
    #size = desc.DynamicNodeSize('input')
    #parallelization = desc.Parallelization(blockSize=40)
    #commandLineRange = '--rangeStart {rangeStart} --rangeSize {rangeBlockSize}'

    category = 'Colmap/Sparse Reconstruction'
    documentation = '''
'''

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
            name='database_path',
            label='DB',
            description='Scene DB',
            value=os.path.join(desc.Node.internalFolder, 'scene.db'),
            uid=[],
        ),
    ]
