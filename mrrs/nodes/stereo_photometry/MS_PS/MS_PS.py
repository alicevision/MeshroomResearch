#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  6 15:14:59 2023

@author: hardy216
"""
import os

__version__ = "1.0"

from meshroom.core import desc

class MS_PS(desc.CommandLineNode):
    file_script = os.path.join(os.path.dirname(os.path.realpath(__file__)), 
                               "launch.py")
    commandLine = 'python '+ file_script +' {allParams} {outputPathValue}'
    category = 'Meshroom Research'
    documentation = '''
Reconstruction using Photometric Stereo. A normal map is evaluated from several photographs taken from the same point of view, but under different lighting conditions.
The lighting conditions are assumed to be known.
'''

    inputs = [
        desc.File(
            name="inputPath",
            label="SfMData",
            description="Input SfMData file.",
            value="",
            uid=[0]
        ),
        desc.File(
            name="pathToJSONLightFile",
            label="Light File",
            description="Path to a JSON file containing the lighting information.\n"
                        "If empty, .txt files are expected in the image folder.",
            value="defaultJSON.txt",
            uid=[0]
        )
    ]

    outputs = [
        desc.File(
            name="outputPath",
            label="Output Folder",
            description="Path to the output folder.",
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]
