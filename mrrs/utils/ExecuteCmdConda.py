__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.plugin import CondaNode

class ExecuteCmdConda(CondaNode):
    commandLine = '{commandLineValue}'
    # gpu = desc.Level.HIGH

    category = 'Meshroom Research'
    documentation = ''' '''

    inputs = [
        desc.StringParam(
            name='commandLine',
            label='commandLine',
            description=''' ''',
            value='echo "Hello"',
            ),

        desc.StringParam(
            name='condaEnv',
            label='condaEnv',
            description='''''',
            value='',
            group=''
            ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [    ]

    def processChunk(self, chunk):
        self.env_path = chunk.node.condaEnv.value
        if chunk.node.condaEnv.value == '': #if no env, just call the normal cl
            desc.CommandLineNode.processChunk(chunk)
        else:
            super().processChunk(chunk)

    
