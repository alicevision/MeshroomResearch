# $ colmap stereo_fusion \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --input_type geometric \
#     --output_path $DATASET_PATH/dense/fused.ply

__version__ = "2.0"

import os
from meshroom.core import desc
from . import COLMAP

class DelaunayMesher(desc.CommandLineNode):
    commandLine = COLMAP+' delaunay_mesher {allParams} --input_type dense'

    category = 'MRRS - Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_path',
            label='Input path',
            description='Path to either the dense workspace folder.',
            value='',
        ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='OutputPath',
            description='Output path.',
            value=os.path.join(desc.Node.internalFolder, "mesh_delaunay.ply"),
        ),

    ]

    def processChunk(self, chunk):
        desc.CommandLineNode.processChunk(self, chunk)
