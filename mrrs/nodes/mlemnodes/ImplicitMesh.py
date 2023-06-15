__version__ = "3.0"

import json
import logging
import numpy as np
import os

from meshroom.core import desc

from mrrs.core.ios import matrices_from_sfm_data
from mrrs.implicit_mesh.instant_ngp.InstantNGP_wrapper import  InstantNGPWrapper

class ImplicitMesh(desc.Node):
    """
    Class that wraps implicit mesh algorithms.
    It take images + poses + calibration as input and ouptuts meshes.
    """
    gpu = desc.Level.INTENSIVE
    category = 'Meshroom Research'#'Dense Reconstruction'
    documentation = '''Runs implicit mesh algorithms.'''

    inputs = [
        desc.File(
            name='inputSfmData',
            label='Input sfmdata',
            description='Input sfmdata file.',
            value='',
            uid=[0],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[],
        ),
    ]

    outputs = [
        desc.File(
            name='outputMesh',
            label='Output mesh',
            description='Output mesh.',
            value=desc.Node.internalFolder + 'mesh.ply',
            uid=[],
        ),
        desc.File(
            name='nerfFile',
            label='NeRF file',
            description='NeRF file.',
            value=desc.Node.internalFolder + 'transforms.json',
            uid=[],
        ),
        desc.File(
            name='poseTransform',
            label='Pose transform file',
            description='Pose transform file.',
            value=desc.Node.internalFolder + 'poseTransform.json',
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputSfmData.value:
            chunk.logger.warning("No input inputSfmData in node ImplicitMesh, skipping")
            return False
        return True


    def processChunk(self, chunk):
        """
        Runs instant-ngp.
        """
        chunk.logManager.start(chunk.node.verboseLevel.value)
        # check inputs
        if not self.check_inputs(chunk):
            return
        chunk.logger.info("Starts ImplicitMesh")
        with open(chunk.node.inputSfmData.value, "r") as json_file:
            sfm_data = json.load(json_file)

        # Get data
        extrinsics_all_cams, intrinsics_all_cams, view_ids, _, _, pixel_sizes_all_cams = matrices_from_sfm_data(sfm_data)
        images_path = [view['path'] for view in sfm_data['views']]

        # Run instant-ngp
        mesh_path = chunk.node.outputMesh.value
        nerf_path = chunk.node.nerfFile.value
        posetransform_path = chunk.node.poseTransform.value
        instantngp = InstantNGPWrapper(mesh_path,nerf_path,posetransform_path)
        instantngp(images_path, extrinsics_all_cams, intrinsics_all_cams, pixel_sizes_all_cams)

