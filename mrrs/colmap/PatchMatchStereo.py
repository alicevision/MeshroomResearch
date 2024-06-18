__version__ = "2.0"

import shutil
import os

from meshroom.core import desc
from . import COLMAP

class PatchMatchStereo(desc.CommandLineNode):
    commandLine = COLMAP+' patch_match_stereo {allParams}'
    gpu = desc.Level.INTENSIVE
    category = 'MRRS - Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_folder',
            label='Input Folder',
            description='Input Folder (output of undisto).',
            value='',
            group=""
        ),
    ]

    outputs = [
        desc.File(
            name='workspace_path',
            label='OutputPath',
            description='Output path.',
            value=os.path.join(desc.Node.internalFolder, "workspace"),
        ),

    ]

    def processChunk(self, chunk):
        shutil.copytree(chunk.node.input_folder.value, chunk.node.workspace_path.value)#, dirs_exist_ok=True)
        desc.CommandLineNode.processChunk(self, chunk)
