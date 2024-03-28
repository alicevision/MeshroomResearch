import json
import os
import numpy as np
import cv2

from meshroom.core import desc
from mrrs.core.ios import matrices_from_sfm_data, open_depth_map, save_exr
from mrrs.core.CondaNode import CondaNode
from mrrs.nerf import ENV_PATH


class NeRFStudioExport(CondaNode):

    category = 'Meshroom Research'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = "ns-export {methodValue} --load-config {configPathValue} {allParams}"

    #overides the env path
    # @property
    # def env_file(self):
    #     return ENV_FILE
    
    env_path = ENV_PATH

    inputs = [
            desc.File(
                name="input",
                label="Input",
                description="Input folder.",
                value="",
                uid=[0],
                group=""
            ),
            desc.ChoiceParam(
                name='method',
                label='Method',
                description='Method to export the NeRF model.',
                value='poisson',
                values=['pointcloud', 'tsdf', 'poisson', 'marching-cubes', 'cameras', 'gaussian-splat'],
                exclusive=True,
                uid=[0],
                group=""
            ),

            # PointCloud Options
            desc.IntParam(
                name='numPoints',
                label='Number of Points',
                description='Number of points to generate. May result in less if outlier removal is used.',
                value=1000000,
                range=(1000, 10000000, 1000),
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
            ),
            desc.BoolParam(
                name='removeOutliers',
                label='Remove Outliers',
                description='Remove outliers from the point cloud.',
                value=True,
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
            ),
            desc.BoolParam(
                name='reorientNormals',
                label='Reorient Normals',
                description='Reorient point cloud normals based on view direction.',
                value=True,
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
            ),
            desc.ChoiceParam(
                name='normalMethod',
                label='Normal Method',
                description='Method to estimate normals with.',
                value='model_output',
                values=['open3d', 'model_output'],
                exclusive=True,
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
            ),

            # TSDF Options
            desc.IntParam(
                name='downscaleFactor',
                label='Downscale Factor',
                description='Downscale the images starting from the resolution used for training.',
                value=1,
                range=(1, 8, 1),
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='tsdf'),
            ),
            desc.IntParam(
                name='resolution',
                label='Resolution',
                description='Resolution of the mesh.',
                value=256,
                range=(256, 2048, 256),
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='tsdf') or (attr.node.method.value=='marching-cubes'),
            ),

            # Marching Cubes Options
            desc.FloatParam(
                name='isosurface-threshold',
                label='Isosurface Threshold',
                description='The isosurface threshold for extraction. For SDF based methods the surface is the zero level set.',
                value=0.0,
                range=(-1.0, 1.0, 0.01),
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='marching-cubes'),
            ),
            desc.BoolParam(
                name='simplify-mesh',
                label='Simplify Mesh',
                description='Simplify the mesh after extraction.',
                value=False,
                uid=[0],
                enabled=lambda attr: (attr.node.method.value=='marching-cubes'),
            ),
            
            desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
                uid=[0],
                group="",
                )
            ]

    outputs = [
            desc.File(
                name='output-dir',
                label='Output',
                description='Output folder.',
                value=desc.Node.internalFolder,
                uid=[],
            ),
    ]

    def processChunk(self, chunk):
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.input.value == "":
            raise RuntimeError('Must input folder.')
        
        # Run the CL
        chunk.node._cmdVars["methodValue"] = chunk.node.method.value
        chunk.node._cmdVars["configPathValue"] = os.path.join(chunk.node.input.value, 'config.yml')
        cmd = self.buildCommandLine(chunk)
        super().processChunk(chunk)

        chunk.logManager.end()