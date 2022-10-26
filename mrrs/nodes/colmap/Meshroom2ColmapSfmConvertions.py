__version__ = "2.0"

from meshroom.core import desc

class Meshroom2ColmapSfmConvertions(desc.CommandLineNode):
    commandLine = 'aliceVision_exportColmap {allParams}'
    size = desc.DynamicNodeSize('input')

    category = 'Utils'
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
            name='output0',
            label='Output Folder 0',
            description='Path to the output SfM Data file.',
            value=desc.Node.internalFolder+"/sparse/0",
            uid=[],
            group=''
            ),
    ]

