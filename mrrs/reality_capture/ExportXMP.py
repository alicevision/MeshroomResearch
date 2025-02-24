"""
This nodes make an xmp from the sfm data.
"""
__version__ = "3.0"

import os 

from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

class ExportXMP(PluginCommandLineNode):

    category = 'MRRS - Reality Capture'

    documentation = '''Node to create an XMP file from camera calibration.'''

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "reality_capture.py")+'" exportxmp {sfmDataValue} {outputFolderValue} {exportImageValue} {useUIDValue}'

    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")
    envType = EnvType.CONDA

    inputs = [

        desc.ChoiceParam(
            name='targetXMP',
            label='target XMP',
            description='''Target XMP format to be used.''',
            value='export_reality_capture',
            values=['export_reality_capture'],
            exclusive=True,
        ),

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData.",
            value="",
        ),

        desc.BoolParam(
            name='exportImage',
            label='Export Image',
            description='''''',
            value=False,
        ),

        desc.BoolParam(
            name='useUID',
            label='Use UID',
            description='''''',
            value=False,
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            group=""
        ),
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output folder',
            description='Path to the XMP folder',
            value=desc.Node.internalFolder,
        ),
    ]

