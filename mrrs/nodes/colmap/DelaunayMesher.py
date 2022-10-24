# $ colmap stereo_fusion \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --input_type geometric \
#     --output_path $DATASET_PATH/dense/fused.ply

__version__ = "2.0"

from meshroom.core import desc

import os

class DelaunayMesher(desc.CommandLineNode):
    commandLine = 'colmap.bat delaunay_mesher {allParams} --input_type dense'

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_path',
            label='Input path',
            description='Path to either the dense workspace folder',
            value='',
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='OutputPath',
            description='Output path',
            value=os.path.join(desc.Node.internalFolder, "mesh_delaunay.ply"),
            uid=[],
        ),

    ]

    def processChunk(self, chunk):
        desc.CommandLineNode.processChunk(self, chunk)
