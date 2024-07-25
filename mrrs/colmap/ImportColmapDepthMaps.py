__version__ = "1.0"

import os

from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

class ImportColmapDepthMaps(PluginCommandLineNode):
    category = 'MRRS - Colmap'

    documentation = ''' '''

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "import_colmap_depth_maps.py")+'" {allParams}'
    
    inputs = [

        desc.File(
            name="inputFolder",
            label="Input",
            description="COLMAP Dense folder in workspace.",
            value="",
        ),

        desc.File(
            name="inputSfm",
            label="InputSfm",
            description="Input SfM data, used to match the views.",
            value="",
        ),


        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='depthMapFolder',
            label='Depth maps folder',
            description='Generated depth maps folder.',
            value=desc.Node.internalFolder,
        ),
        #for viz
        desc.File(
            name='depth',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>_depthMap.exr',
<<<<<<< HEAD
=======
            uid=[],
            group=""
>>>>>>> port colmap
        ),

    ]
