
import os
from meshroom.core import desc
from mrrs.core.DockerNode import DockerNode
from distutils.dir_util import copy_tree
from shutil import move


# --model_path / -m
# Path to the trained model directory you want to create renderings for.
# --skip_train
# Flag to skip rendering the training set.
# --skip_test
# Flag to skip rendering the test set.

#renders are going to be onthe rendering dfolder?

class GaussianSplattingRender(DockerNode):

    category = 'Meshroom Research'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = "python gaussian-splatting/render.py -s /node_folder/input_scene -m /node_folder/input_model"

    docker_file = os.path.abspath(os.path.join(__file__,"..","..","..","gaussian_splat"))

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