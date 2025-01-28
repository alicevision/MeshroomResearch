__version__ = "1.0"
import os
from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

from .metrics.chamfer_distance import ENV_FILE

class MeshComparison(PluginCommandLineNode):

    gpu = desc.Level.NONE

    category = 'MRRS - Benchmark'
    documentation = '''Computes the champfer distance between two meshes'''

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "metrics", "chamfer_distance", "eval_pcd.py")+'" {allParams}'

    envFile=ENV_FILE
    envType = EnvType.CONDA

    inputs = [
        desc.File(
            name='input_path',
            label='Input Mesh',
            description='''''',
            value='',
            ),

        desc.File(
            name='gt_path',
            label='GroundTruthMesh',
            description='''''',
            value='',
            ),

        desc.ChoiceParam(
            name='mode',
            label='Mode',
            description='''Choose mesh or point cloud.''',
            value='mesh',
            values=['mesh', 'pcd'],
            exclusive=True,
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            group=""
        ),
    ]

    outputs = [
        desc.File(
            name='output_dir',
            label='Output Directory',
            description='''''',
            value=desc.Node.internalFolder,
            ),

            desc.File(
            name='vizMeshtoGT',
            label='Distance Mesh to GT',
            description='''''',
            value=os.path.join(desc.Node.internalFolder, "vis_data2gt.pc.ply"),
            semantic="3D",
            group='',
            ),

            desc.File(
            name='vizGTtoMesh',
            label='Distance GT to Mesg',
            description='''''',
            value=os.path.join(desc.Node.internalFolder, "vis_gt2data.pc.ply"),
            semantic="3D",
            group='',
            ),
    ]
