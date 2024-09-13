__version__ = "1.0"
import os
from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.metrics.chamfer_distance import ENV_FILE

class MeshcomparisonBaptiste(CondaNode):

    #overides the env path
    @property
    def env_file(self):
        return ENV_FILE
    
    commandLine = 'python "'+os.path.join(os.path.dirname(__file__),"..", "..", "metrics", "chamfer_distance", "eval_pcd.py")+'" {allParams}'
    gpu = desc.Level.NONE

    category = 'Meshroom Research'
    documentation = '''Calls the dtu benchmark metrics between two meshes'''

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
