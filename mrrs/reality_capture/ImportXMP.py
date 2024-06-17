"""
This nodes make an sfm data from an xmp 
"""
__version__ = "3.0"

from meshroom.core import desc
from meshroom.core.plugin import CondaNode 

import os

class ImportXMP(CondaNode):

    category = 'Meshroom Research'

    documentation = '''Node to import a camera calibration from an XMP'''

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "reality_capture.py")+'" importxmp {sfmDataValue} {xmpDataValue} {outputSfMDataValue}'

    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")

    inputs = [

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData.",
            value="",
        ),

        desc.File(
            name="xmpData",
            label="xmpData",
            description="Input xmpData.",
            value="",
        ),

        desc.File(
            name="meshData",
            label="meshData",
            description="Input mesh.",
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
            name='outputSfMData',
            label='outputSfMData',
            description='Path to the outputSfMData.',
            value=os.path.join(desc.Node.internalFolder, "outputSfMData.sfm"),
        ),
    ]
