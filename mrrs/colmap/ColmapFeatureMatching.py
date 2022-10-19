__version__ = "2.0"

from meshroom.core import desc

import os
import shutil


class ColmapFeatureMatching(desc.CommandLineNode):
    commandLine = 'colmap exhaustive_matcher {allParams}'
    # size = desc.DynamicNodeSize('input')
    # parallelization = desc.Parallelization(blockSize=20)
    # commandLineRange = '--rangeStart {rangeStart} --rangeSize {rangeBlockSize}'

    category = 'Colmap/Sparse Reconstruction'
    documentation = '''
'''

    inputs = [
        desc.File(
            name='input_file',
            label='Input DB',
            description='Input DB',
            value='',
            uid=[0],
            group='',
        ),
    ]

    outputs = [
        desc.File(
            name='database_path',
            label='Matches DB',
            description='Matches DB',
            value=os.path.join(desc.Node.internalFolder, 'scene.db'),
            uid=[],
        ),
    ]

    def processChunk(self, chunk):
        shutil.copy2(chunk.node.input_file.value, chunk.node.database_path.value)
        desc.CommandLineNode.processChunk(self, chunk)
