"""
This node launches instant-ngp.
"""
__version__ = "1.0"

import os

from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.implicit_mesh.instant_ngp import ENV_FILE

os.environ['KMP_DUPLICATE_LIB_OK']='True'

CONDA_ENV_PATH = "/home/bbrument/anaconda3/envs/instant-ngp/bin"
# NGP_COMMAND = f"{CONDA_ENV_PATH}/python "+ os.path.join(os.path.dirname(__file__), "../../implicit_mesh/instant_ngp/instant-ngp/scripts/run.py")#FIXME: hardcoded
NGP_COMMAND = "python "+ os.path.join(os.path.dirname(__file__), "../../implicit_mesh/instant_ngp/instant-ngp/scripts/run.py")#FIXME: hardcoded
MODEL = "instant-ngp/configs/nerf/base.json"
# MODEL_PATH = os.path.join(os.path.dirname(__file__),"../../implicit_mesh/instant_ngp",MODEL)#FIXME: hardcoded


class InstantNGP(CondaNode):
    """
    This node launches InstantNGP.
    """
    category = 'Meshroom Research'
    gpu = desc.Level.INTENSIVE
    documentation = '''Util node to launch instant-ngp.'''

     #overides the env path
    @property
    def env_file(self):
        return ENV_FILE

    commandLine = NGP_COMMAND + ' {allParams}'

    inputs = [

        desc.File(
            name="training_data",
            label="Input NeRF Data",
            description="Input NeRF Data",
            value="",
            uid=[0],
        ),

        desc.IntParam(
            name='marching_cubes_res',
            label='Marching Cubes Resolution',
            description='Marching Cubes Resolution',
            value=256,
            range=(256, 1280, 256),
            uid=[0],
        ),

        desc.IntParam(
            name='n_steps',
            label='Number of steps',
            description='Number of iterations for the training.',
            value=30000,
            range=(10000, 300000, 10000),
            uid=[0],
        ),

        desc.StringParam(
            name='mode',
            label='Mode',
            description='Mode.',
            value='nerf',
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='save_mesh',
            label='Output mesh',
            description='Output mesh.',
            value=desc.Node.internalFolder + 'mesh.obj',
            uid=[],
        ),
    ]


    # def processChunk(self, chunk):
    #     """
    #     Launches InstantNGP.
    #     """
    #     try:
    #         chunk.logManager.start(chunk.node.verboseLevel.value)
    #         if not self.check_inputs(chunk):
    #             return

    #         # Launch instant-ngp
    #         cmd = NGP_COMMAND + (f" --mode nerf"
    #                             +f" --training_data {chunk.node.inputNerfData.value}"
    #                             +f" --marching_cubes_res {chunk.node.marchingCubesRes.value}"
    #                             +f" --save_mesh {chunk.node.outputMesh.value}"
    #                             +f" --network {MODEL_PATH}"
    #                             +f" --n_steps {chunk.node.nSteps.value}")
    #         print(cmd)
    #         do_system(cmd)

    #         chunk.logger.info('InstantNGP done.')
    #     finally:
    #         chunk.logManager.end()

