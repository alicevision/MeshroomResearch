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
    commandLine = COLMAP+' poisson_mesher {allParams}'

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
        desc.FloatParam(
            name='trim',
            label='trim',
            description='Poisson Meshing Triming parameters',
            value=0.0,
            range=(0.0, 100.0, 1.0),
            uid=[0],
            group='',
            ),
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
        append_param= " --PoissonMeshing.trim "+str(chunk.node.trim.value)
        chunk.node._cmdVars["allParams"]+=append_param#FIXME: need to be done onoy once!! also messes up the save
        desc.CommandLineNode.processChunk(self, chunk)
        chunk.node._cmdVars["allParams"]=chunk.node._cmdVars["allParams"][:-len(append_param)]

