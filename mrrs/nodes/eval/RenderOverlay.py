__version__ = "1.0"

from meshroom.core import desc


class RenderOverlay(desc.CommandLineNode):
    commandLine = 'blender -b -P {scriptValue} -- \
                    {markersValue} {sfmDataValue} {outputFolderValue}'
    category = 'Evaluation'
    documentation = 'This nodes creates 3D objects in a Blender scene and render them on top of the corresponding views'
    inputs = [
        desc.File(
            name='script',
            label='Script',
            description='Python script to render markers',
            value='MeshroomResearch/mrrs/blender/render_overlay_markers.py',
            uid=[0]
        ),
        desc.File(
            name='markers',
            label='Markers',
            description='3D markers to render',
            value='',
            uid=[0]
        ),
        desc.File(
            name='sfmData',
            label='SfM Data',
            description='Views, intrinsincs and estimated poses',
            value='',
            uid=[0]
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
    ]
