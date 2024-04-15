# $ colmap stereo_fusion \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --input_type geometric \
#     --output_mesh $DATASET_PATH/dense/fused.ply

__version__ = "2.0"

import os
from meshroom.core import desc

from . import COLMAP
import trimesh
from mrrs.core.geometry import CG_CV_MAT44 

class PoissonMesher(desc.CommandLineNode):
    commandLine = COLMAP+' poisson_mesher {input_path} --PoissonMeshing.trim {trimValue} --output_path {output_meshValue}'

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
            ),
    ]

    outputs = [
        desc.File(
            name='output_mesh',
            label='OutputMesh',
            description='Output mesh',
            value=os.path.join(desc.Node.internalFolder, "mesh_poisson.ply"),
            uid=[],
        ),

    ]

    def processChunk(self, chunk):
        desc.CommandLineNode.processChunk(self, chunk)
        #re-orient mesh
        mesh = trimesh.load(chunk.node.output_mesh.value)
        mesh.apply_transform(CG_CV_MAT44)
        mesh.export(chunk.node.output_mesh.value)

