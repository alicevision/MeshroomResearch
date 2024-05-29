# $ colmap image_undistorter \
#     --image_path $DATASET_PATH/images \
#     --input_path $DATASET_PATH/sparse/0 \
#     --output_path $DATASET_PATH/dense \
#     --output_type COLMAP \
#     --max_image_size 2000

__version__ = "1.1"

import os
from sys import platform


from meshroom.core import desc
from . import COLMAP

class ColmapImageUndistorder(desc.CommandLineNode):
    commandLine = COLMAP+' image_undistorter {allParams}'

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='image_path',
            label='Image Directory',
            description='''Path to images.''',
            value='',
        ),

        desc.File(
            name='input_path',
            label='Input Directory',
            description='''Path to input directory (from matcher).''',
            value='',
        ),

        #FIXME: this does not update the files!
        # desc.File(
        #     name='max_image_size',
        #     label='Max Image Size',
        #     description='''Used to downsample images''',
        #     value='2000',
        # ),

    ]

    outputs = [
        desc.File(
            name='output_path',
            label='Ouptut Path',
            description='''Output path path.''',
            value=os.path.join(desc.Node.internalFolder),
        ),
    ]


