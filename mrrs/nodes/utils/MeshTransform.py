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
        ),
        desc.File(
            name='inputTransform',
            label='Input transform',
            description='Input transform.',
            value='',
        ),
        desc.BoolParam(
            name='flipCG_CV',
            label='flipCG_CV',
            description='Flip from a CG to a CV cs or vice versa.',
            value=False,
        ),
        desc.FloatParam(
            name='addGaussianNoise',
            label='Add Gaussian Noise',
            description='Add Gaussian Noise to the mesh vertices.',
            value=-1.0,
            range=(-1.0, 100.0, 1.0),
        ),

        # desc.ChoiceParam(
        #     name='extention',
        #     label='Extention',
        #     description='''File format for the ouptut mesh.''',
        #     value='.ply',
        #     values=['.ply', '.obj'],
        #     exclusive=True,
        # ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='outputMesh',
            label='Output mesh',
            description='Output Mesh.',
            value=desc.Node.internalFolder + 'mesh.ply',#pb: not extention!!! variable output
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
        mesh_file = chunk.node.inputMesh.value

        if mesh_file.endswith(".abc"):
            #make sure blender is in path
            #FIXME: todo
            #export with blender
            script_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../blender/alembic_convert.py"))
            command_line = "blender -b -P "+script_path+" -- "+mesh_file+" "+\
                            chunk.node.outputMesh.value[:-4]+".obj"
            print(command_line)
            # os.popen(command_line).read()
            os.system(command_line)
            mesh_file = chunk.node.outputMesh.value[:-4]+".obj"


        mesh = trimesh.load(mesh_file)
        if chunk.node.inputTransform.value != '':
            #check inputs
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Starts mesh transfrom")

            # Load transform
            with open(chunk.node.inputTransform.value, "r") as json_file:
                T_dict = json.load(json_file)
                T = np.asarray(T_dict['transform'], np.float32)

            # Load, apply transform and save mesh
            mesh = mesh_transform(mesh,T)

        if chunk.node.flipCG_CV.value:
            mesh.vertices = transform_cg_cv(mesh.vertices)

        #apply noise if any
        if chunk.node.addGaussianNoise.value > 0:
            mesh.vertices += chunk.node.addGaussianNoise.value*np.random.random(size=mesh.vertices.shape)

        #save
        mesh.export(chunk.node.outputMesh.value)