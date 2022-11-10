# $ colmap stereo_fusion \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --input_type geometric \
#     --output_path $DATASET_PATH/dense/fused.ply

__version__ = "2.0"

import os

from meshroom.core import desc
from . import COLMAP

class PoissonMesher(desc.CommandLineNode):
    commandLine = COLMAP+' poisson_mesher {allParams} --PoissonMeshing.trim 0'

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_path',
            label='Input Point Cloud',
            description='Input Point Cloud',
            value='',
            uid=[0],
        ),


        # desc.StringParam(
        #     name=r'PoissonMeshing.trim',
        #     label='PoissonMeshingTrim',
        #     description='Poisson Meshing Triming parameters',
        #     uid=[0],
        #     value='0'
        # ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='OutputPath',
            description='Output path',
            value=os.path.join(desc.Node.internalFolder, "mesh_poisson.ply"),
            uid=[],
        ),

    ]

    def processChunk(self, chunk):
        desc.CommandLineNode.processChunk(self, chunk)
