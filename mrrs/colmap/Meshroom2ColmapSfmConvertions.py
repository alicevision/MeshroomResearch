__version__ = "2.0"
import os 
import json
import shutil

from meshroom.core import desc
from meshroom.core.plugin import PluginCommandLineNode, EnvType

class Meshroom2ColmapSfmConvertions(PluginCommandLineNode):
    commandLine = 'aliceVision_exportColmap -i {preparedSfmValue} -o {outputValue}'

    category = 'MRRS - Colmap'
    documentation = ''' '''

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")

    inputs = [
        desc.File(
            name='inputSfm',
            label='Input',
            description='SfMData file.',
            value='',
            group=""
        ),

        desc.IntParam(
            name='maxImageSize',
            label='Max Image Width',
            description='''Used to downsample images.''',
            value=0,
            range=(0, 1000000000, 1),
            group=""
            ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='Verbosity level (fatal, error, warning, info, debug, trace).',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='preparedSfm',#ugly hack to have an input that can change
            label='preparedSfm',
            description='SfMData file prepared for colmap.',
            value=os.path.join(desc.Node.internalFolder, "prepared_sfm.json"),
            advanced=True,
        ),
        desc.File(
            name='output',
            label='Output Folder',
            description='Path to the output SfM Data file.',
            value=desc.Node.internalFolder,
            ),
        desc.File(
            name='imageDirectory',
            label='Image Directory',
            description='',
            value=os.path.join(desc.Node.internalFolder, "images"),
            group=""
            ),
        desc.File(
            name='sparseDirectory',
            label='Sparse Directory',
            description='',
            value=os.path.join(desc.Node.internalFolder, "sparse"),
            group=""
            ),
    ]


    def processChunk(self, chunk):
        from mrrs.core.ios import open_image, save_image
        from mrrs.core.utils import cv2_resize_with_pad

        # get image info
        sfm_data = json.load(open(chunk.node.inputSfm.value))
        views = sfm_data["views"]
        images_path = [v["path"] for v in views]
        image_sizes = [[int(v["width"]), int(v["height"])] for v in views]
        images_base_folder = set([os.path.dirname(p) for p in images_path ])
        if len(images_base_folder) > 1:
            raise RuntimeError("Images from different folders not supported yet")
        images_basename = [os.path.basename(p) for p in images_path ]
        images_output_folder = os.path.join(chunk.node.output.value, "images")
        new_images_path = [os.path.join( images_output_folder, basename) for basename in images_basename]
        
        #get if we must resize
        do_resize = (chunk.node.maxImageSize.value == 0) and (image_sizes[0][0]>chunk.node.maxImageSize.value)

        #modify .sfm with new sizes and filepath
        if do_resize:
            #set input sfm to new file
            print("Editting .sfm")
            new_sizes = [ [chunk.node.maxImageSize.value, int(sz[1]*chunk.node.maxImageSize.value/sz[0])] for sz in image_sizes]
            for (v,sz, p) in zip(views, new_sizes, new_images_path):
                v["width"] = sz[0]
                v["heigt"] = sz[1]
                v["path"] = p

            sfm_data["views"] = views
            #FIXME: assumes one width
            for intrinsic in sfm_data["intrinsics"]:
                intrinsic["width"] = new_sizes[0][0]
                intrinsic["height"] = new_sizes[0][1]
            with open(os.path.join(chunk.node.preparedSfm.value), 'w') as f:
                json.dump(sfm_data, f, indent=4)
        else: #or ceate symlink stright to the sfm
            os.symlink(chunk.node.inputSfm.value, chunk.node.preparedSfm.value)

        #run the cl
        desc.CommandLineNode.processChunk(self, chunk)
        
        #create image folder from sfm (need to be done after the cl, otherwise bugs...)
        os.makedirs(images_output_folder, exist_ok=True)
        #FIXME: slow io bound
        print("Exporting images")
        for i, (img_path, new_img_path) in enumerate(zip(images_path, new_images_path)):
            if do_resize:
                image = open_image(img_path, to_srgb=True)
                if do_resize:
                    image, _ = cv2_resize_with_pad(image, new_sizes[i])
                save_image(new_img_path, image)#SLOW
            else:
                os.symlink(img_path, new_img_path)

        #moves from sparse/0 to sparse
        shutil.copytree(os.path.join(chunk.node.output.value, 'sparse', '0'), 
                        os.path.join(chunk.node.output.value, 'sparse2'))
        shutil.rmtree(os.path.join(chunk.node.output.value, 'sparse', '0'))
        os.rename(os.path.join(chunk.node.output.value, 'sparse2'), os.path.join(chunk.node.output.value, 'sparse'))
        #os.rmdir(os.path.join(chunk.node.output.value,'dense'))

 