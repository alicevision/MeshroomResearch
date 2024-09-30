__version__ = "2.0"

import os
from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

class Colmap2MeshroomSfmConvertion(PluginCommandLineNode):
    """
    Converts colmap's sfm infos into meshroom format
    """

    category = 'MRRS - Colmap'
    documentation = '''Converts colmap's sfm infos into meshroom format'''

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "colmap_2_meshroom_sfm_convertion.py")+'" {allParams}'

    inputs = [
        desc.File(
            name='inputFolder',
            label='Input',
            description='Input sparse folder.',
            value='',
        ),
        desc.File(
            name='inputSfm',
            label='InputSfm',
            description='Input sfm from cameraInit.',
            value='',
        ),
        desc.File(
            name='imageFolder',
            label='ImageFolder',
            description='Input image folder (needed if you dont use a SfM).',
            value='',
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='Verbosity level (fatal, error, warning, info, debug, trace).',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfm',
            label='Output Sfm',
            description='Path to the output SfM file.',
            value=os.path.join(desc.Node.internalFolder, "sfmdata.sfm"),
            ),
    ]
