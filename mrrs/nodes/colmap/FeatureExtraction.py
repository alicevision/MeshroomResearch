__version__ = "1.1"


import os
import json
import shutil

from meshroom.core import desc
from . import COLMAP

class ColmapFeatureExtraction(desc.CommandLineNode):
    commandLine = COLMAP+' feature_extractor {allParams}' #FIXME --ImageReader.single_camera 1

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        # desc.File(
        #     name='image_path',
        #     label='Images Directory',
        #     description='''Path to images directory.''',
        #     value="",
        # ), #FIXME: issue there, cannot be updated by node for next nodes, if uid !=0 then it changes the uid without notifuying next nodes
        #dirty fix: copy images to this folder in outputss

        desc.File(
            name='input_sfm',
            label='Input Sfm',
            description='''Extracts the image path from an input SfM.''',
            value='',
            group=''
        ),

        desc.BoolParam(
            name="use_gpu",
            label = "Use GPU",
            description='''Will use GPU for feature extraction.''',
            value=False,
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
        # ),

        desc.BoolParam(
            name='singleCam',
            label='SingleCamera',
            description='''If the scene has be shot with a single camera.''',
            value=False,
            group=''
        ),
    ]

    outputs = [
        desc.File(
            name='database_path',
            label='Sensor Database',
            description='''Camera sensor width database path.''',
            value=os.path.join("{nodeCacheFolder}", "colmap_database.db"),
        ),
        desc.File(
            name='image_list_path',
            label='Used Images',
            description='''Used images (if from .sfm)''',
            value=os.path.join("{nodeCacheFolder}", "used_images.txt"),
        ),
        desc.File(
            name='image_path',
            label='Images Directory',
            description='''Path to images directory.''',
            value=os.path.join("{nodeCacheFolder}", "images"),
        ),
    ]

    def buildCommandLine(self, chunk):
        command_line = desc.CommandLineNode.buildCommandLine(self, chunk)#as default
        #add the extra params
        if not chunk.node.use_gpu.value:
            command_line+=" --SiftExtraction.use_gpu 0" 
        if chunk.node.singleCam.value:
            command_line+=" --ImageReader.single_camera 1"
        return command_line

    def processChunk(self, chunk):
        images_basename = []
        # #By default list everything in folder
        # if chunk.node.image_path.value != "":
        #     images_basename = os.listdir(chunk.node.image_path.value)
        #Will automaticaly fill up images_path with values from sfm if it is set
        if chunk.node.input_sfm.value != '':
            #creates image list from sfm
            images_path = [v["path"] for v in json.load(open(chunk.node.input_sfm.value))["views"]]
            images_base_folder = set([os.path.dirname(p) for p in images_path ])
            images_basename = [os.path.basename(p) for p in images_path ]
            #FIXME: copy
            os.makedirs(chunk.node.image_path.value, exist_ok=True)
            for img, basename in zip(images_path, images_basename):
                shutil.copyfile(img, os.path.join( chunk.node.image_path.value , basename))
            if len(images_base_folder) > 1:
                raise RuntimeError("Images from different folders not supported yet")
            # chunk.node.image_path.value=list(images_base_folder)[0]#set to base folder FIXME: does not update other nodes!!
        if chunk.node.image_path.value == '':
            raise RuntimeError("Need to specify input directory")
        #write image to use file
        os.makedirs(os.path.dirname(chunk.node.image_list_path.value), exist_ok=True)
        with open(chunk.node.image_list_path.value, "w") as images_to_use_file:
            for image_basename in images_basename:
                images_to_use_file.write(image_basename+"\n")

        #FIXME: change the uid when saving...
        # if not chunk.node.use_gpu.value:
        #     chunk.node._cmdVars["allParams"]+=" --SiftExtraction.use_gpu 0" #FIXME: can only happen once
        # if chunk.node.singleCam.value:
        #     chunk.node._cmdVars["allParams"]+=" --ImageReader.single_camera 1"#FIXME: can only happen once

        desc.CommandLineNode.processChunk(self, chunk)
