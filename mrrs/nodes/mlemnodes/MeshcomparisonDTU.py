__version__ = "1.0"

import os
from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.metrics.dtu import ENV_FILE

class MeshcomparisonDTU(CondaNode):
    @property
    def env_file(self):
        return ENV_FILE

    commandLine = ''
    gpu = desc.Level.NONE

    category = 'Meshroom Research'
    documentation = '''Calls the dtu bechmark metrics between two meshes'''

    inputs = [
        desc.File(
            name='data',
            label='InputPly',
            description=''' ''',
            value='',
            uid=[0],
            ),
         desc.File(
            name='dataset_dir',
            label='DataseDir',
            description='''Input dataset for dtu''',#FIXE
            value='',
            uid=[0],
            ),
        desc.IntParam(
            name='scan',
            label='Scan',
            description='''Index of the scanned mesh in dtu''',#FIXE
            value=1,
            range=(0, 5000, 1),
            uid=[0],
            ),
        desc.ChoiceParam(
            name='mode',
            label='Mode',
            description='''Chose mesh or poin cloud''',
            value='info',
            values=['mesh', 'pcd'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='eval_dir',
            label='NumericalEval',
            description='''''',
            value=desc.Node.internalFolder,
            uid=[],
            ),

        desc.File(
            name='vis_out_dir',
            label='MeshDifference',
            description='''''',
            value=desc.Node.internalFolder,
            uid=[],
            ),
    ]
