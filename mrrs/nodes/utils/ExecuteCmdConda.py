__version__ = "1.0"

from meshroom.core import desc
from mrrs.core.CondaNode import CondaNode

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
            uid=[0],
            ),

        desc.StringParam(
            name='condaEnv',
            label='condaEnv',
            description='''''',
            value='',
            uid=[0],
            group=''
            )
    ]

    def processChunk(self, chunk):
        self.env_path = chunk.node.condaEnv.value
        if chunk.node.condaEnv.value == '': #if no env, just call the normal cl
            desc.CommandLineNode.processChunk(chunk)
        else:
            super().processChunk(chunk)

    outputs = [
    ]
