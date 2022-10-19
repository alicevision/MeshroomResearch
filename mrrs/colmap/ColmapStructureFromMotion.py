__version__ = "2.0"

from meshroom.core import desc


class ColmapStructureFromMotion(desc.CommandLineNode):
    commandLine = 'colmap mapper {mapperValue} {allParams}'
    # size = desc.StaticNodeSize(1)

    category = 'Colmap/Sparse Reconstruction'
    documentation = '''
'''

    inputs = [
        desc.File(
            name='database_path',
            label='Feat/Matches DB',
            description='Feat/Matches DB',
            value='',
            uid=[0],
        ),
        desc.File(
            name='image_path',
            label='Image Directory',
            description='''Path to images.''',
            value='',
            uid=[0],
        ),
        desc.ChoiceParam(
            name='mapper',
            label='Mapper Method',
            description='Structure from Motion algorithm',
            value='mapper',
            values=['mapper', 'hierarchical_mapper'],
            exclusive=True,
            uid=[0],
            group='',
        ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='Output Folder',
            description='Output Folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]

