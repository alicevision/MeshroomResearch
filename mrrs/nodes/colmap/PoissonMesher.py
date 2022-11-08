# $ colmap stereo_fusion \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --input_type geometric \
#     --output_path $DATASET_PATH/dense/fused.ply

__version__ = "2.0"

from meshroom.core import desc

import os
from sys import platform

class PoissonMesher(desc.CommandLineNode):

    if platform.startswith('win32'):
        # Windows-specific code here...
        commandLine = 'colmap.bat poisson_mesher {allParams} --PoissonMeshing.trim 0'
    elif platform.startswith('linux'):
        # Linux-specific code here...
        commandLine = 'colmap poisson_mesher {allParams} --PoissonMeshing.trim 0'
    

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
