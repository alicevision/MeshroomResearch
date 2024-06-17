"""
This nodes make an xmp from the sfm data.
"""
__version__ = "3.0"

import os 

from meshroom.core import desc
from meshroom.core.plugin import CondaNode 

class ExportXMP(CondaNode):

    category = 'Meshroom Research'

    documentation = '''Node to create an XMP file from camera calibration.'''

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "reality_capture.py")+'" exportxmp {sfmDataValue} {outputFolderValue} '

    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")

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
            name='outputFolder',
            label='Output folder',
            description='Path to the XMP folder',
            value=desc.Node.internalFolder,
        ),
    ]

