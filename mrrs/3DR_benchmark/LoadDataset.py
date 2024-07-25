__version__ = "3.0"

import os 

from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

class LoadDataset(PluginCommandLineNode):
    category = 'MRRS - Benchmark'

    documentation = '''Util node to open datasets with different data from the images in the .sfm'''

    envFile = os.path.join(os.path.dirname(__file__), "general_env.yaml")
    envType = EnvType.CONDA

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "load_dataset.py")+'" {allParams}'
    
    inputs = [

        desc.File(
            name="inputSfM",
            label="inputSfM",
            description="Input sfmData",
            value="",
        ),

        desc.ChoiceParam(
            name='datasetType',
            label='Dataset Type',
            description='''Dataset type.''',
            value='blendedMVG',
            values=['blendedMVG', 'DTU', 'ETH3D', 'baptiste', 'alab', 'NERF'],
            exclusive=True,
        ),

        desc.IntParam(
            name='initSfmLandmarksVertices',
            label='Init Landmarks Vertices',
            description='''Will initalise sfmLandmarks by sampling points on mesh. 0 to deactivate.''',
            value=1,
            range=(0, 1000000000, 1),
            advanced=True
        ),
        

        desc.BoolParam(
            name='initMasks',
            label='Init Masks',
            description='''If no masks in dataset, will initialise the masks using the values from the depth map (<=0) or the images (alpha<=0).''',
            value=True,
            advanced=True
        ),

        desc.BoolParam(
            name='landMarksProj',
            label='Landmarks Projections',
            description='''Will display point cloud or landmarks projection.''',
            value=False,
            advanced=True
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            advanced=True
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfMData',
            label='SfM Data',
            description='Path to the output sfmdata file.',
            value=desc.Node.internalFolder + 'sfm.sfm',
        ),

        desc.File(
            name='depthMapsFolder',
            label='Depth map folder',
            description='Output folder for loaded depth maps.',
            value=os.path.join(desc.Node.internalFolder, 'depth_maps'),
            # enabled=lambda attr: (attr.node.datasetType.value=='blendedMVG'), #FIXME: does not work!! doesnt actually hides in the node
        ),

        desc.File(
            name='mesh',
            label='Mesh',
            description='Loaded mesh.',
            value=os.path.join(desc.Node.internalFolder, 'mesh.ply'),
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
        ),

        desc.File(
            name='maskFolder',
            label='Mask Folder',
            description='Image mask folder. The mask describes the visibility of the object to be observed, on each view.',
            value=os.path.join(desc.Node.internalFolder,'masks'),
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
        ),

        #used for display
        desc.File(
            name='depthmapsDisplay',
            label='DepthMapsDisplay',
            description='Generated depth maps.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'depth_maps', '<VIEW_ID>_depthMap.exr'),
            advanced=True,
            visible=False,
            group=""
        ),

        desc.File(
            name='masksDisplay',
            label='MasksDisplay',
            description='Generated masks.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'masks', '<VIEW_ID>.png'),
            advanced=True,
            visible=False,
            group=""
        ),

        desc.File(
            name='landMarksProjDisplay',
            label='landMarksProjDisplay',
            description='Generated images for landmarl projection.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'lm_projs', '<VIEW_ID>.png'),
            advanced=True,
            enabled=lambda attr: attr.node.landMarksProj.value,
            visible=False,
        ),

        desc.File(
            name='meshDisplay',
            label='MeshDisplay',
            description='MeshDisplay',
            semantic='3D',
            value=os.path.join(desc.Node.internalFolder,
                               'mesh_display.ply'),
            advanced=True,
            visible=False
        ),
    ]

   
