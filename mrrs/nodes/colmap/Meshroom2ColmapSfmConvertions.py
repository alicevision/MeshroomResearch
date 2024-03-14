__version__ = "2.0"
import os 
import json
import shutil
from meshroom.core import desc
from . import COLMAP

class Meshroom2ColmapSfmConvertions(desc.CommandLineNode):
    commandLine = 'aliceVision_exportColmap {allParams}'
    size = desc.DynamicNodeSize('input')

    category = 'Colmap'
    documentation = ''' '''

    inputs = [
        desc.File(
            name='input',
            label='Input',
            description='SfMData file.',
            value='',
            uid=[0],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='verbosity level (fatal, error, warning, info, debug, trace).',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='output',
            label='Output Folder',
            description='Path to the output SfM Data file.',
            value=desc.Node.internalFolder,
            uid=[],
            ),
        desc.File(
            name='imageDirectory',
            label='Image Directory',
            description='',
            value=os.path.join(desc.Node.internalFolder, "images"),
            uid=[],
            group=""
            ),
        desc.File(
            name='sparseDirectory',
            label='Sparse Directory',
            description='',
            value=os.path.join(desc.Node.internalFolder, "sparse"),
            uid=[],
            group=""
            ),
    ]


    def processChunk(self, chunk):
        desc.CommandLineNode.processChunk(self, chunk)
        #moves from sparse/0 to sparse
        shutil.copytree(os.path.join(chunk.node.output.value, 'sparse', '0'), 
                        os.path.join(chunk.node.output.value, 'sparse2'))
        shutil.rmtree(os.path.join(chunk.node.output.value, 'sparse', '0'))
        os.rename(os.path.join(chunk.node.output.value, 'sparse2'), os.path.join(chunk.node.output.value, 'sparse'))
        #os.rmdir(os.path.join(chunk.node.output.value,'dense'))
        #create image folder from sfm
        images_path = [v["path"] for v in json.load(open(chunk.node.input.value))["views"]]
        images_base_folder = set([os.path.dirname(p) for p in images_path ])
        images_basename = [os.path.basename(p) for p in images_path ]
        images_output_folder = os.path.join(chunk.node.output.value, "images")
        os.makedirs(images_output_folder, exist_ok=True)
        for img, basename in zip(images_path, images_basename):
            # shutil.copyfile(img, os.path.join( images_output_folder, basename))
            os.symlink(img, os.path.join( images_output_folder, basename))
        if len(images_base_folder) > 1:
            raise RuntimeError("Images from different folders not supported yet")
        
        #create stereo match

        
