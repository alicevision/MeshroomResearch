__version__ = "1.1"

from meshroom.core import desc

import os
import json

class ColmapFeatureExtraction(desc.CommandLineNode):
    commandLine = 'colmap.bat feature_extractor {allParams} ' #FIXME --ImageReader.single_camera 1

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='image_path',
            label='Image Directory',
            description='''Path to images.''',
            value='',
            uid=[0],
        ),

        desc.File(
            name='input_sfm',
            label='Input Sfm',
            description='''Extracts the image path from an input sfm''',
            value='',
            uid=[0],
            group=''
        ),

        # desc.ChoiceParam(
        #     name='ImageReader.camera_model',
        #     label='CameraModel',
        #     description='''Camera Model.''',
        #     value='PINHOLE',
        #     values=['PINHOLE', 'SIMPLE_PINHOLE', 'RADIAL', 'SIMPLE_RADIAL', 'OPENCV', 'FULL_OPENCV',
        #             'SIMPLE_RADIAL_FISHEYE', 'RADIAL_FISHEYE', 'OPENCV_FISHEYE', 'FOV', 'THIN_PRISM_FISHEYE'],
        #     exclusive=True,
        #     uid=[],
        # ),

        #FIXME: todo
        # desc.BoolParam(
        #     name='ImageReader-single_camera',#ImageReader.single_camera'
        #     label='SingleCamera',
        #     description='''If the scene has be shot with a single camera.''',
        #     value=False,
        #     uid=[],
        # ),
    ]

    outputs = [
        desc.File(
            name='database_path',
            label='Sensor Database',
            description='''Camera sensor width database path.''',
            value=os.path.join(desc.Node.internalFolder, "colmap_database.db"),
            uid=[],
        ),
    ]

    # def buildCommandLine(self, chunk):#FIXME: make a  for that
    #     new_cmdVars = {}
    #     for key, value in chunk.node._cmdVars.items():#replaces the - with .
    #         if "-" in key:
    #             value=value.replace("-", ".") #!!! args, alos why Value and stuff?
    #         new_cmdVars[key]=value
    #     old_cmdvars = chunk.node._cmdVars
    #     chunk.node._cmdVars = new_cmdVars
    #     comand_line = desc.CommandLineNode.buildCommandLine(self, chunk)
    #     chunk.node._cmdVars = old_cmdvars
    #     return comand_line

    def processChunk(self, chunk):
        if chunk.node.input_sfm.value != '':
            image_path = json.load(open(chunk.node.input_sfm.value))["views"][0]["path"]
            chunk.node.image_path.value = os.path.dirname(image_path)
        desc.CommandLineNode.processChunk(self, chunk)
