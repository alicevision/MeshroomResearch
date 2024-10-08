__version__ = "1.1"

from meshroom.core import desc
import os

DEFAULT_RENDER_SCRIPT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../blender/render_overlay_markers.py'))

class RenderOverlay(desc.CommandLineNode):
    commandLine = 'blender -b -P {scriptValue} -- \
                    {markersValue} {sizeFactorValue} {sfmDataValue} {outputFolderValue}'
    category = 'Evaluation'
    documentation = 'This nodes creates 3D objects in a Blender scene and render them on top of the corresponding views'
    inputs = [
        desc.File(
            name='script',
            label='Script',
            description='Python script to render markers.',
            value=DEFAULT_RENDER_SCRIPT,
        ),
        desc.File(
            name='markers',
            label='Markers',
            description='3D markers to render.',
            value='',
        ),
        desc.FloatParam(
            name='sizeFactor',
            label='Size Factor',
            description='Marker size factor.',
            value=1.0,
            range=(0.0, 10.0, 0.1),
        ),
        desc.File(
            name='sfmData',
            label='SfM Data',
            description='Views, intrinsincs and estimated poses.',
            value='',
        ),
    ]
    outputs = [
        desc.File(
            name='outputFolder',
            label='Folder',
            description='Output folder for generated images.',
            value=desc.Node.internalFolder,
        ),

        desc.File(
            name='overlay',
            label='Overlay',
            description='Rendered views with markers overlay.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>.jpg',
        ),
    ]
