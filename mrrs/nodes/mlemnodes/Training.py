__version__ = "1.0"

from meshroom.core import desc


class Training(desc.CommandLineNode):
    commandLine = '/s/apps/packages/dev/pythonStandalone/3.7.9/platform-linux/build-release/bin/python3 /s/apps/users/multiview/mrrs/hogm/mrrs/mrrs/depth_map_refinement/learning_based_refinement/training.py'

    category = 'Meshroom Research'
    gpu = desc.Level.INTENSIVE

    inputs = [
        desc.StringParam(
            name='dummy',
            label='Dummy',
            description='''.''',
            value='',
            uid=[0],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = []
