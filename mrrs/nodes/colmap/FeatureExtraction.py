__version__ = "1.1"


import os
import json

from meshroom.core import desc
from . import COLMAP



class ColmapFeatureExtraction(desc.CommandLineNode):
    commandLine = COLMAP+' feature_extractor {allParams}' #FIXME --ImageReader.single_camera 1

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='image_path',
            label='Images Directory',
            description='''Path to images directory.''',
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

        desc.BoolParam(
            name="use_gpu",
            label = "Use GPU",
            description='''Will use GPU for feature extraction''',
            value=False,
            uid=[0],
            group='',
        ),

        #Issue . is used to denote a group, TODO: replace with special symbol and replace in all keys
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
        desc.File(
            name='image_list_path',
            label='Used Images',
            description='''Used images (if from .sfm)''',
            value=os.path.join(desc.Node.internalFolder, "used_images.txt"),
            uid=[],
        ),
    ]

    # def buildCommandLine(self, chunk):#FIXME: make a  for that
        # new_cmdVars = {}
        # for key, value in chunk.node._cmdVars.items():#replaces the - with .
        #     if "-" in key:
        #         value=value.replace("-", ".") #!!! args, alos why Value and stuff?
        #     new_cmdVars[key]=value
        # old_cmdvars = chunk.node._cmdVars
        # chunk.node._cmdVars = new_cmdVars
        # comand_line = desc.CommandLineNode.buildCommandLine(self, chunk)#FIXME: no, all is stored in allParams
        # chunk.node._cmdVars = old_cmdvars
        # return comand_line

    def processChunk(self, chunk):
        images_basename = []
        #By default list everything in folder
        if chunk.node.image_path.value != "":
            images_basename = os.listdir(chunk.node.image_path.value)
        #Will automaticcaly fill up images_path with values from sfm if it is set
        if chunk.node.input_sfm.value != '':
            #creates image list from sfm
            images_path = [v["path"] for v in json.load(open(chunk.node.input_sfm.value))["views"]]
            images_base_folder = set([os.path.dirname(p) for p in images_path ])
            images_basename = [os.path.basename(p) for p in images_path ]
            if len(images_base_folder) > 1:
                raise RuntimeError("Images from different folders not supported yet")
            chunk.node.image_path.value=list(images_base_folder)[0]#set to base folder
        if chunk.node.image_path.value == '':
            raise RuntimeError("Need to specify input directory")
        #write image to use file
        os.makedirs(os.path.dirname(chunk.node.image_list_path.value), exist_ok=True)
        with open(chunk.node.image_list_path.value, "w") as images_to_use_file:
            for image_basename in images_basename:
                images_to_use_file.write(image_basename+"\n")

        if not chunk.node.use_gpu.value:
            chunk.node._cmdVars["allParams"]+=" --SiftExtraction.use_gpu 0"

        desc.CommandLineNode.processChunk(self, chunk)
