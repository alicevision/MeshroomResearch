__version__ = "3.0"

import json
import logging
import numpy as np
import os

from meshroom.core import desc

class InstantNGP(desc.CommandLineNode):
    """
    instant-ngp : https://github.com/NVlabs/instant-ngp
    """
    commandLine = '/home/bbrument/anaconda3/envs/instant-ngp/bin/python /home/bbrument/dev/instant-ngp/scripts/run.py {allParams}'
    category = 'Meshroom Research'#Machine Learning Effort for Meshroom #'Sparse Reconstruction'

    documentation = '''This node launchs a 3D reconstruction.'''

    inputs = [

        desc.File(
            name='training_data',
            label='Training Data',
            description="The scene to load. Can be the scene's name or a full path to the training data.",
            value="",
            uid=[0],
        ),

        
        desc.ChoiceParam(
            name='mode',
            label='mode',
            description="The scene to load. Can be the scene's name or a full path to the training data.",
            value='nerf',
            values=["nerf", "sdf", "image", "volume"],
            exclusive=True,
            uid=[0],
        ),

        desc.IntParam(
            name='marching_cubes_res',
            label='Marching Cubes Resolution',
            description="Sets the resolution for the marching cubes grid.",
            value=256,
            range=(32,1024,8),
            uid=[0],
        ),

        # desc.ChoiceParam(
        #     name='verboseLevel',
        #     label='Verbose Level',
        #     description='''verbosity level (fatal, error, warning, info, debug, trace).''',
        #     value='info',
        #     values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
        #     exclusive=True,
        #     uid=[0],
        # ),
    ]

    outputs = [

        desc.File(
            name="save_mesh",
            label="Mesh",
            description="Output mesh",
            value=desc.Node.internalFolder + 'mesh.obj',
            uid=[],
        ),
    ]

    # def check_inputs(self, chunk):
    #     """
    #     Checks that all inputs are properly set.
    #     """
    #     if not chunk.node.sourceSfmData.value:
    #         chunk.logger.warning('No input SfmData in node InstantNGP, skipping')
    #         return False
    #     return True

    # def processChunk(self, chunk):
    #     """
    #     Launchs instant-ngp.
    #     """
    #     try:
    #         chunk.logManager.start(chunk.node.verboseLevel.value)
    #         #check inputs
    #         if not self.check_inputs(chunk):
    #             return
    #         chunk.logger.info("Starts instant-ngp")
    #         chunk.logger.info("Loading input sfmData")
    #         with open(chunk.node.inputSfmData.value,"r") as json_file:
    #             input_sfm_data= json.load(json_file)

            
            
    #         chunk.logger.info('')
    #     finally:
    #         chunk.logManager.end()



