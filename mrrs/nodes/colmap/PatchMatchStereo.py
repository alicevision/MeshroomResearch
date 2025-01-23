# $ colmap patch_match_stereo \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --PatchMatchStereo.geom_consistency true

__version__ = "2.0"

import shutil
import os
from sys import platform

from meshroom.core import desc
from . import COLMAP

class PatchMatchStereo(desc.CommandLineNode):
    commandLine = COLMAP+' patch_match_stereo {allParams}'
    gpu = desc.Level.INTENSIVE
    category = 'Colmap'
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
            value=os.path.join("{nodeCacheFolder}", "workspace"),
        ),

    ]

    def processChunk(self, chunk):
        shutil.copytree(chunk.node.input_folder.value, chunk.node.workspace_path.value)#, dirs_exist_ok=True)
        desc.CommandLineNode.processChunk(self, chunk)
