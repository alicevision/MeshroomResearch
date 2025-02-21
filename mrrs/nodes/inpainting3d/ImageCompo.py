__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL


import OpenImageIO as oiio
import os


class ImageCompo(desc.Node):
    #size = desc.DynamicNodeSize('inputFiles')

    category = 'Inpainting 3D'
    documentation = '''
This node allows to perform basic alpha compositing.
'''

    inputs = [
        desc.File(
            name="folderA",
            label="Folder A",
            description="Foreground images folder.",
            value="",
        ),
        desc.File(
            name="folderB",
            label="Folder B",
            description="Background images folder.",
            value="",
        ),
        desc.File(
            name="folderMask",
            label="Alpha masks folder",
            description="The alpha masks used to combine the images.",
            value="",
        ),
    ]

    outputs = [
        desc.File(
            name="combinedImageFolder",
            label="Combined images folder",
            description="The output images are mixes between input images.",
            value=desc.Node.internalFolder,
        ),
    ]

    def processChunk(self, chunk):
        try:

            im1_names = [e for e in os.listdir(chunk.node.folderA.value) if len(e)>=5 and e[-4:]==".jpg"]
            im2_names = [e for e in os.listdir(chunk.node.folderB.value) if len(e)>=5 and e[-4:]==".jpg"]
            masks_names = [e for e in os.listdir(chunk.node.folderMask.value) if len(e)>=5 and e[-4:]==".jpg"]

            assert len(im1_names)==len(im2_names), f"Number of images is different in two folders: {len(im1_names)} VS {len(im2_names)}"
            assert len(im1_names)==len(masks_names), f"Number of images is different from number of masks: {len(im1_names)} VS {len(masks_names)}"
            
            for a,b in zip(im1_names, im2_names):
                im1 = oiio.ImageBuf(os.path.join(chunk.node.folderA.value, a)).get_pixels()
                im2 = oiio.ImageBuf(os.path.join(chunk.node.folderB.value, b)).get_pixels()
                c = [e for e in masks_names if a in e or e in a]
                #print(masks_names)
                #print(a)
                #print(c)
                assert len(c)==1, f"error, len(c)={len(c)}"
                c = c[0]
                mask = oiio.ImageBuf(os.path.join(chunk.node.folderMask.value, c)).get_pixels()

                res = im2*(1-mask) + im1*mask

                out = oiio.ImageOutput.create(os.path.join(chunk.node.combinedImageFolder.value, a))
                spec = oiio.ImageSpec(res.shape[1], res.shape[0], res.shape[2], oiio.UINT8)
                out.open(os.path.join(chunk.node.combinedImageFolder.value, a), spec)
                out.write_image(res)
                out.close()

        finally:
            chunk.logManager.end()
