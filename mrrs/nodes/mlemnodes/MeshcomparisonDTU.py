__version__ = "1.0"
import os
from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.metrics.dtu import ENV_FILE

class MeshcomparisonDTU(CondaNode):

    #overides the env path
    @property
    def env_file(self):
        return ENV_FILE

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__),"..", "..", "metrics", "dtu", "dtu_eval.py")+'" {allParams}'
    gpu = desc.Level.NONE

    category = 'Meshroom Research'
    documentation = '''Calls the dtu benchmark metrics between two meshes'''

    inputs = [
        desc.File(
            name='data',
            label='Input Mesh',
            description='''Ply?''',
            value='',
            uid=[0],
            ),

        desc.File(
            name='gt_sfm',
            label='GroundTruthSfMData',
            description='''''',
            value='',
            uid=[0],
            ),

        # desc.File(
        #     name='dataset_dir',
        #     label='DataseDir',
        #     description='''Input dataset for dtu''',#FIXE: remove read from data
        #     value='',
        #     uid=[0],
        #     ),

        # desc.IntParam(
        #     name='scan',
        #     label='Scan',
        #     description='''Index of the scanned mesh in dtu''',#FIXE: remove read from data
        #     value=1,
        #     range=(0, 5000, 1),
        #     uid=[0],
        #     ),

        desc.ChoiceParam(
            name='mode',
            label='Mode',
            description='''Chose mesh or point cloud''',
            value='mesh',
            values=['mesh', 'pcd'],
            exclusive=True,
            uid=[0],
        ),

        desc.StringParam(
            name='suffix',
            label='saveSuffix',
            description='''Suffix for the eval output''',
            value='eval',
            uid=[0],
            ),

        desc.FloatParam(
            name='downsample_density',
            label='downsampleDensity',
            description='''Dowsampling of the input mesh''',
            value=0.2,
            range=(0.0, 1.0, 0.01),
            uid=[0],
            ),

        desc.FloatParam(
            name='patch_size',
            label='pathSize',
            description='''''',
            value=60.0,
            range=(0.0, 100.0, 1.0),
            uid=[0],
            ),

        desc.FloatParam(
            name='max_dist',
            label='maxDist',
            description='''''',
            value=20.0,
            range=(0.0, 100.0, 1.0),
            uid=[0],
            ),

        desc.FloatParam(
            name='visualize_threshold',
            label='maxDist',
            description='''''',
            value=20.0,
            range=(0.0, 100.0, 1.0),
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

        # desc.File(
        #     name='vis_out_dir',
        #     label='MeshDifference',
        #     description='''''',
        #     value=desc.Node.internalFolder,
        #     uid=[],
        #     ),
    ]


    # def processChunk(self, chunk):
    #     try:
    #         chunk.logger.info('Running dtu benchmark')

    #         super().processChunk(self, chunk)
    #         chunk.logger.info('Running dtu benchmark')
    #     finally:
    #         chunk.logManager.end()

