

__version__ = "1.1"

from meshroom.core import desc
import os
import trimesh 
import numpy as np

DEFAULT_RENDER_SCRIPT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../blender/render360.py'))

class Render360(desc.CommandLineNode):
    commandLine = 'blender -b -P {scriptValue} -- {objectFileValue}  {outputFolderValue} {renderStepsValue}'
    category = 'Evaluation'
    documentation = 'This nodes renders an object as in a turntable'
    gpu = desc.Level.INTENSIVE
    inputs = [
        desc.File(
            name='script',
            label='Script',
            description='Python script to render markers',
            value=DEFAULT_RENDER_SCRIPT,
            uid=[0]
        ),
        desc.File(
            name='objectFile',
            label='objectFile',
            description='Object File',
            value='',
            uid=[0],
        ),

        desc.IntParam(
            name='renderSteps',
            label='renderSteps',
            description='Render steps.',
            value=64,
            range=(0, 1000000, 1),
            uid=[0],
        ),
    ]
    outputs = [
        desc.File(
            name='outputFolder',
            label='Folder',
            description='Output folder for generated images',
            value=desc.Node.internalFolder,
            uid=[]
        ),

        desc.File(
            name='outputImages',
            label='outputImages',
            description='Output  generated images',
            value=os.path.join(desc.Node.internalFolder, "*.png"),
            uid=[]
        ),
    ]
