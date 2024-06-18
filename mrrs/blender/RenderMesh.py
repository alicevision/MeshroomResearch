__version__ = "1.1"

from meshroom.core import desc
import os

RENDER_SCRIPT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), './scripts/render_mesh.py'))

class RenderMesh(desc.CommandLineNode):
    commandLine = 'blender -b -P {scriptValue} -- \
                    {cameras} {model} {renderMode} {output}'
    category = 'Evaluation'
    gpu = desc.Level.INTENSIVE
    documentation = 'This nodes creates 3D objects in a Blender scene and render them on top of the corresponding views'
    inputs = [
        desc.File(
            name='script',
            label='Script',
            description='Python script to render markers.',
            value=RENDER_SCRIPT,
        ),
        desc.File(
            name='model',
            label='Model',
            description='Model to render.',
            value='',
        ),
        desc.File(
            name='cameras',
            label='SfM Data',
            description='Views, intrinsincs and estimated poses.',
            value='',
        ),
        desc.ChoiceParam(
            name='renderMode',
            label='Render Mode',
            description='Rendering mode.',
            values=["MESH", "FACES", "DEPTH"],
            value='MESH',
            exclusive=True,
        ),
    ]
    outputs = [
        desc.File(
            name='output',
            label='OutputFolder',
            description='Output folder for generated images.',
            value=desc.Node.internalFolder,
        ),

        desc.File(
            name='overlay',
            label='Overlay',
            description='Rendered views.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>.exr',
        ),
    ]
