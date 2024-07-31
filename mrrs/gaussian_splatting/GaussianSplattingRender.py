
import os
from distutils.dir_util import copy_tree
from shutil import move

from meshroom.core import desc
from meshroom.core.plugin import PluginNode, EnvType

class GaussianSplattingRender(PluginNode):

    category = 'GaussianSplatting'
    documentation = '''Node to render frames from a .sfm and the optimised gaussian splats.'''
    gpu = desc.Level.INTENSIVE

    commandLine = "python gaussian-splatting/render.py -s /node_folder/input_scene -m /node_folder/input_model"

    envFile = os.path.join(os.path.dirname(__file__), 'Dockerfile')
    envType = EnvType.DOCKER

    inputs = [
            desc.File(
                name="inputModelFolder",
                label="inputModelFolder",
                description="inputModelFolder",
                value="",
                uid=[0],
                group=""
                ),
            desc.File(
                name="inputColmapFolder",
                label="inputColmapFolder",
                description="inputColmapFolder",
                value="",
                uid=[0],
                group=""
                ),
            desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
                uid=[0],
                )
            ]

    outputs = [
            desc.File(
                name='outputFolder',
                label='OutputFolder',
                description='Output folder.',
                value=os.path.join(desc.Node.internalFolder, "output"),
                uid=[],
                group="",
            ),
    ]

    def processChunk(self, chunk):
        #copy input data to node's folder (we mount only this folder)
        input_folder = os.path.join(chunk.node.internalFolder, 'input_scene')
        input_folder_model = os.path.join(chunk.node.internalFolder, 'input_model')
        output_folder = os.path.join(chunk.node.internalFolder, 'output')
        os.makedirs(input_folder)
        os.makedirs(input_folder_model)
        os.makedirs(output_folder)
        
        #copy colmap scene and pretrained model
        copy_tree(os.path.join(chunk.node.inputColmapFolder.value,'sparse'), os.path.join(input_folder, 'sparse', '0'))
        copy_tree(os.path.join(chunk.node.inputColmapFolder.value,'images'), os.path.join(input_folder, 'images'))
        copy_tree(chunk.node.inputModelFolder.value, input_folder_model)
  
        super().processChunk(chunk)