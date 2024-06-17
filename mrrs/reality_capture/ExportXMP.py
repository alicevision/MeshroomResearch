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

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output folder',
            description='Path to the XMP folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]

