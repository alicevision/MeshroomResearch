
import os

from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode
from mrrs.nerf import ENV_FILE

class NeRFStudioExport(CondaNode):

    category = 'Meshroom Research'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = "ns-export {methodValue} --load-config {configPathValue} {allParams}"
    
    env_file = ENV_FILE

    inputs = [
        desc.File(
            name="input",
            label="Input",
            description="Input folder.",
            value="",
            group=""
        ),
        desc.ChoiceParam(
            name='method',
            label='Method',
            description='Method to export the NeRF model.',
            value='poisson',
            values=['pointcloud', 'tsdf', 'poisson', 'marching-cubes', 'cameras', 'gaussian-splat'],
            exclusive=True,
            group=""
        ),

        # PointCloud Options
        desc.IntParam(
            name='numPoints',
            label='Number of Points',
            description='Number of points to generate. May result in less if outlier removal is used.',
            value=1000000,
            range=(1000, 10000000, 1000),
            enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
        ),
        desc.BoolParam(
            name='removeOutliers',
            label='Remove Outliers',
            description='Remove outliers from the point cloud.',
            value=True,
            enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
        ),
        desc.BoolParam(
            name='reorientNormals',
            label='Reorient Normals',
            description='Reorient point cloud normals based on view direction.',
            value=True,
            enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
        ),
        desc.ChoiceParam(
            name='normalMethod',
            label='Normal Method',
            description='Method to estimate normals with.',
            value='model_output',
            values=['open3d', 'model_output'],
            exclusive=True,
            enabled=lambda attr: (attr.node.method.value=='pointcloud') or (attr.node.method.value=='poisson'),
        ),

        # TSDF Options
        desc.IntParam(
            name='downscaleFactor',
            label='Downscale Factor',
            description='Downscale the images starting from the resolution used for training.',
            value=1,
            range=(1, 8, 1),
            enabled=lambda attr: (attr.node.method.value=='tsdf'),
        ),
        desc.IntParam(
            name='resolution',
            label='Resolution',
            description='Resolution of the mesh.',
            value=256,
            range=(256, 2048, 256),
            enabled=lambda attr: (attr.node.method.value=='tsdf') or (attr.node.method.value=='marching-cubes'),
        ),

        # Marching Cubes Options
        desc.FloatParam(
            name='isosurface-threshold',
            label='Isosurface Threshold',
            description='The isosurface threshold for extraction. For SDF based methods the surface is the zero level set.',
            value=0.0,
            range=(-1.0, 1.0, 0.01),
            enabled=lambda attr: (attr.node.method.value=='marching-cubes'),
        ),
        desc.BoolParam(
            name='simplify-mesh',
            label='Simplify Mesh',
            description='Simplify the mesh after extraction.',
            value=False,
            enabled=lambda attr: (attr.node.method.value=='marching-cubes'),
        ),
        
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            group="",
        )
    ]

    outputs = [
        desc.File(
            name='output-dir',
            label='Output',
            description='Output folder.',
            value=desc.Node.internalFolder,
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