#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  6 15:14:59 2023

@author: hardy216
"""
import os

__version__ = "1.0"

from meshroom.core import desc

class  Uni_MS_PS(desc.CommandLineNode):
    file_script = os.path.join(os.path.dirname(os.path.realpath(__file__)), 
                               "launch.py")
    commandLine = 'python '+ file_script +' {allParams} {outputPathValue}'
    category = 'Meshroom Research'
    documentation = '''
Reconstruction using Photometric Stereo. A normal map is evaluated from several photographs taken from the same point of view, but under different lighting conditions.
'''

    inputs = [
        desc.File(
            name="inputPath",
            label="SfMData",
            description="Input SfMData file.",
            value="",
        )
    ]

    outputs = [
        desc.File(
            name="outputPath",
            label="Output Folder",
            description="Path to the output folder.",
            value="{nodeCacheFolder}",
        )
    ]
