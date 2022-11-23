"""
This node injects some fields from a source sfm data to a target sfm data.
"""
__version__ = "3.0"

import os
import json
from meshroom.core import desc
from mrrs.core.geometry import *
import trimesh

class MeshTransform(desc.Node):#FIXME: abstract this Dataset, scan folder etc...?

    category = 'Meshroom Research'#Machine Learning Effort for Meshroom #'Sparse Reconstruction'

    documentation = '''.'''

    inputs = [

        desc.File(
            name='inputMesh',
            label='Input mesh',
            description='Input mesh.',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='inputTransform',
            label='Input transform',
            description='Input transform.',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='outputMesh',
            label='Output mesh',
            description='Output Mesh.',
            value=desc.Node.internalFolder+'mesh.obj',
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputMesh.value:
            chunk.logger.warning('No input inputMesh in node MeshTransform, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Applies transform to a mesh.
        """
        chunk.logManager.start(chunk.node.verboseLevel.value)
        #check inputs
        if not self.check_inputs(chunk):
            return
        chunk.logger.info("Starts mesh transfrom")

        # Load transform
        with open(chunk.node.inputTransform.value, "r") as json_file:
            T_dict = json.load(json_file)
            T = np.asarray(T_dict['transform'], np.float32)

        # Load, apply transform and save mesh
        mesh = trimesh.load(chunk.node.inputMesh.value)
        mesh_upd = mesh_transform(mesh,T)
        mesh_upd.export(chunk.node.outputMesh.value)