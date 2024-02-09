__version__ = "1.0"
import os
import numpy as np
from meshroom.core import desc
# from mrrs.metrics.baptiste

class CleanMesh(desc.CommandLineNode):
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
            label='FAces Index Images',
            description='',
            value='',
            uid=[0],
            )
    ]

    outputs = [
        desc.File(
            name="output_mesh",
            label="Ouput Mesh",
            description="",
            value=os.path.join(desc.Node.internalFolder, "cleaned_mesh.obj"),
            uid=[],
            ),
    ]

