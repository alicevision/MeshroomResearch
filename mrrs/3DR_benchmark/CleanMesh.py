__version__ = "1.0"
import os
from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.metrics.chamfer_distance import ENV_FILE

class CleanMesh(CondaNode):

    #overides the env path
    env_file = ENV_FILE

    category = 'Meshroom Research'
    commandLine = 'python "'+os.path.join(os.path.dirname(__file__),"..", "..", "metrics", "baptiste", "remove_invisible_faces.py")+'" {allParams}'
    gpu = desc.Level.NONE
    documentation = ''' '''

    inputs = [
        desc.File(
            name="input_mesh",
            label='Input Mesh',
            description='',
            value='',
            uid=[0],
            ),
        desc.File(
            name="face_index_images_folder",
            label='Faces Index Images',
            description='',
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
            uid=[0],
            group=""
        ),
    ]

    outputs = [
        desc.File(
            name="output_mesh",
            label="Ouput Mesh",
            description="",
            value=os.path.join(desc.Node.internalFolder, "cleaned_mesh.ply"),
            uid=[],
            ),
    ]

