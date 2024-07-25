__version__ = "2.0"

import shutil
import os

from meshroom.core import desc
from . import COLMAP

class ColmapStereoFusion(desc.CommandLineNode):
    commandLine = COLMAP+' stereo_fusion {allParams}'

    category = 'MRRS - Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_folder',
            label='Input Folder',
            description='Input Workspace Folder (output of patch match).',
            value='',
            group=""
        ),

    ]

    outputs = [
        desc.File(
            name='output_path',
            label='OutputPath',
            description='Output point cloud path.',
            value=os.path.join(desc.Node.internalFolder,  "workspace", "fused.ply"),
        ),


        desc.File(
            name='workspace_path',
            label='Output Workspace Folder',
            description='Output workspace path.',
            value=os.path.join(desc.Node.internalFolder, "workspace"),
        ),
    ]

    def processChunk(self, chunk):
        shutil.copytree(chunk.node.input_folder.value, chunk.node.workspace_path.value)#, dirs_exist_ok=True)
        desc.CommandLineNode.processChunk(self, chunk)
