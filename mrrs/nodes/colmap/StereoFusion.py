# $ colmap stereo_fusion \
#     --workspace_path $DATASET_PATH/dense \
#     --workspace_format COLMAP \
#     --input_type geometric \
#     --output_path $DATASET_PATH/dense/fused.ply

__version__ = "2.0"

import shutil
import os

from meshroom.core import desc
from . import COLMAP

class StereoFusion(desc.CommandLineNode):
    commandLine = COLMAP+' stereo_fusion {allParams}'

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_folder',
            label='Input Folder',
            description='Input Workspace Folder (output of patch match)',
            value='',
            uid=[0],
            group=""
        ),

    ]

    outputs = [
        desc.File(
            name='output_path',
            label='OutputPath',
            description='Output point cloud path',
            value=os.path.join(desc.Node.internalFolder,  "workspace", "fused.ply"),
            uid=[],
        ),


        desc.File(
            name='workspace_path',
            label='Output Workspace Folder',
            description='Output workspace path',
            value=os.path.join(desc.Node.internalFolder, "workspace"),
            uid=[],
        ),

    ]

    def processChunk(self, chunk):
        shutil.copytree(chunk.node.input_folder.value, chunk.node.workspace_path.value, dirs_exist_ok=True)
        desc.CommandLineNode.processChunk(self, chunk)
