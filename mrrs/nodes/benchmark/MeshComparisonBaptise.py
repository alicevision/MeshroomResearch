__version__ = "1.0"
import os
from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.metrics.baptiste import ENV_FILE

class MeshcomparisonBaptiste(CondaNode):

    #overides the env path
    @property
    def env_file(self):
        return ENV_FILE
    
    commandLine = 'python "'+os.path.join(os.path.dirname(__file__),"..", "..", "metrics", "baptiste", "eval_pcd.py")+'" {allParams}'
    gpu = desc.Level.NONE

    category = 'Meshroom Research'
    documentation = '''Calls the dtu benchmark metrics between two meshes'''

    inputs = [
        desc.File(
            name='input_path',
            label='Input Mesh',
            description='''''',
            value='',
            uid=[0],
            ),

        desc.File(
            name='gt_path',
            label='GroundTruthMesh',
            description='''''',
            value='',
            uid=[0],
            ),

        desc.ChoiceParam(
            name='mode',
            label='Mode',
            description='''Chose mesh or point cloud''',
            value='mesh',
            values=['mesh', 'pcd'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='output_dir',
            label='Output Directory',
            description='''''',
            value=desc.Node.internalFolder,
            uid=[],
            ),

            desc.File(
            name='vizMeshtoGT',
            label='Distance Mesh to GT',
            description='''''',
            value=os.path.join(desc.Node.internalFolder, "vis_data2gt.ply"),
            uid=[],
            semantic="3D",
            group='',
            ),

            desc.File(
            name='vizGTtoMesh',
            label='Distance GT to Mesg',
            description='''''',
            value=os.path.join(desc.Node.internalFolder, "vis_gt2data.ply"),
            uid=[],
            semantic="3D",
            group='',
            ),
    ]
