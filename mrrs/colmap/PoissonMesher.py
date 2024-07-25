__version__ = "2.0"

import os
from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

from . import COLMAP

class ColmapPoissonMesher(PluginCommandLineNode):
    commandLine = COLMAP+' poisson_mesher {input_path} --PoissonMeshing.trim {trimValue} --output_path {output_meshValue}'

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")


    category = 'MRRS - Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_path',
            label='Input Point Cloud',
            description='Input Point Cloud.',
            value='',
        ),
        desc.FloatParam(
            name='trim',
            label='trim',
            description='Poisson Meshing Triming parameters.',
            value=0.0,
            range=(0.0, 100.0, 1.0),
            ),
    ]

    outputs = [
        desc.File(
            name='output_mesh',
            label='OutputMesh',
            description='Output mesh.',
            value=os.path.join(desc.Node.internalFolder, "mesh_poisson.ply"),
        ),

    ]

    def processChunk(self, chunk):
        desc.CommandLineNode.processChunk(self, chunk)
        import trimesh
        from mrrs.core.geometry import CG_CV_MAT44 
        #! env
        #re-orient mesh
        mesh = trimesh.load(chunk.node.output_mesh.value)
        mesh.apply_transform(CG_CV_MAT44)
        mesh.export(chunk.node.output_mesh.value)

