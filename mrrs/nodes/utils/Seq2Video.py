__version__ = "1.0"

import os
from meshroom.core import desc

class Seq2Video(desc.CommandLineNode):
    #FIXme : rez env
    commandLine = 'rez env ffmpeg -- ffmpeg -framerate {framerateValue} -y -pattern_type glob -i {imagesFolderValue}/{patternValue} {outputVideoValue}{videoFormatValue}'
    gpu = desc.Level.NONE

    category = 'Meshroom Research'
    documentation = ''' '''

    inputs = [
        desc.File(
            name='imagesFolder',
            label='imagesFolder',
            description=''' ''',
            value='',
            ),
        desc.StringParam(
            name='pattern',
            label='pattern',
            description=''' ''',
            value='*.png',
            ),
        desc.FloatParam(
            name='framerate',
            label='Framerate',
            description=''' ''',
            value=25.0,
            range=(1.0, 3000.0, 1.0),
            ),
        desc.StringParam(
            name='videoFormat',
            label='videoFormat',
            description=''' ''',
            value='.mp4',
            ),
    ]

    outputs = [
        desc.File(
            name='outputVideo',
            label='Output Video',
            description='''  ''',
            value=os.path.join(desc.Node.internalFolder, 'video'),
            ),
    ]
