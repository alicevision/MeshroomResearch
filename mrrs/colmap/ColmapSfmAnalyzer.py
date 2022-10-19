__version__ = "2.0"

from meshroom.core import desc


class ColmapSfmAnalyzer(desc.CommandLineNode):
    commandLine = 'colmap model_analyzer {allParams}'

    category = 'Colmap/Sparse Reconstruction'
    documentation = '''
'''

    inputs = [
        desc.File(
            name='input',
            label='SfM DB',
            description='SfM DB',
            value='',
            uid=[0],
            group='',
        ),
        desc.File(
            name='path',
            label='Internal SfM DB',
            description='SfM DB',
            value=lambda node: os.path.join(node.input, '0'),
            uid=[0],
            advanced=True,
        ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='Output Folder',
            description='Output Folder',
            value=desc.Node.internalFolder,
            uid=[],
            group='',
        ),
    ]

