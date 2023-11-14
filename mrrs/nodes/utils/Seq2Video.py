__version__ = "1.0"

import os
from meshroom.core import desc

class Seq2Video(desc.CommandLineNode):
    #FIXme : rez env
    commandLine = 'rez env ffmpeg -- ffmpeg -y -framerate {framerateValue} -pattern_type glob -i {imagesFolderValue}/{patternValue} {outputVideoValue}'
    gpu = desc.Level.NONE

    category = 'Meshroom Research'
    documentation = ''' '''

    inputs = [
        desc.File(
            name='imagesFolder',
            label='imagesFolder',
            description=''' ''',
            value='',
            uid=[0],
            ),
        desc.File(
            name='pattern',
            label='pattern',
            description=''' ''',
            value='*.png',
            uid=[0],
            ),
        desc.FloatParam(
            name='framerate',
            label='Framerate',
            description=''' ''',
            value=25.0,
            range=(1.0, 120.0, 1.0),
            uid=[0],
            )
    ]

    outputs = [
        desc.File(
            name='outputVideo',
            label='Output Video',
            description='''  ''',
            value=os.path.join(desc.Node.internalFolder, 'video.mp4'),
            uid=[],
            ),
    ]
