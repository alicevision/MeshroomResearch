
__version__ = "3.0"

import os

from meshroom.core import desc

class PrepareFolderForGS(desc.Node):

    category = 'Inpainting 3D'
    documentation = ''''''

    inputs = [
        desc.File(
            name='colmapFolder',
            label='colmapFolder',
            description='',
            value='',
        ),

        desc.File(
            name="maskFolder",
            label="Mask Folder",
            description="maskFolder",
            value="",
        ),

        desc.ChoiceParam(
            name='scale',
            label='scale',
            description=''' ''',
            value=['1', '2', '4', '8'],
            values=['1', '2', '4', '8', '16', '32', '64', '128', '256'],
            exclusive=False,
        ),

        desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
            ),

    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='outputFolder',
            description='outputFolder',
            value=desc.Node.internalFolder,
            group='',
        ),
        desc.File(
            name='outputImageFolder',
            label='outputImageFolder',
            description='outputImageFolder',
            value=os.path.join(desc.Node.internalFolder, "images"),
            group='',
        )
    ]

    def processChunk(self, chunk):
        """
        image_<scale>
        mask_<scale>
        in output folder
        """

        import json
        import numpy as np
        from shutil import copytree
        import cv2
        from mrrs.core.ios import open_image, save_image
      
        chunk.logManager.start(chunk.node.verboseLevel.value)
       
        #copy colmap folder
        copytree(chunk.node.colmapFolder.value, chunk.node.outputFolder.value, dirs_exist_ok=True)

        #resize images and images
        def save_downsampled(inputfolder, name):
            chunk.logger.info("Loading...")
            image_files = [f 
                    for f in os.listdir(inputfolder) if f.endswith(".exr") or f.endswith(".jpg")]
            images = []
            for image_file in image_files:
                image_file=os.path.join(inputfolder,image_file)
                if not os.path.exists(image_file):
                    chunk.logger.info("Issue with "+image_file+", skipping")
                images.append(open_image(image_file)/255.0)
            #for each scale, save in mask_<scale>
            for scale in chunk.node.scale.value:
                chunk.logger.info("Resizing at "+scale)
                images_resized = [cv2.resize(m, (0,0), fx=1/float(scale), fy=1/float(scale)) for m in images]
                chunk.logger.info("Saving images")
                dirname = name+"_"+scale if int(scale)!=1 else name
                os.makedirs(os.path.join(chunk.node.outputFolder.value, dirname), exist_ok=True)
                for image_file, image in zip(image_files, images_resized):
                    save_image(os.path.join(chunk.node.outputFolder.value, dirname, image_file[:-4]+".jpg"),(255*image).astype(np.uint8))
        
        save_downsampled(chunk.node.maskFolder.value, "masks")
        save_downsampled(os.path.join(chunk.node.colmapFolder.value, "images"), "images")
        chunk.logManager.end()

