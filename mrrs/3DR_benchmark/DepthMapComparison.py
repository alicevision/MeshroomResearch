__version__ = "3.0"

import os
from meshroom.core import desc
from meshroom.core.plugin import CondaNode

class DepthMapComparison(CondaNode):

    category = 'MRRS - Benchmark'

    documentation = '''For each camera, compare its depth maps to a given ground truth.
The names of the original inputSfM file is used to retrieve the GT file, therefore must match.
The depth maps are assumed to be estimated with the same inputSfM poses.
Autorescale may be used otherwise but it is far from ideal.
'''

    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "depth_map_comparison.py")+'" {allParams}'
    
    envFile = os.path.join(os.path.dirname(__file__), "general_env.yaml")

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.File(
            name="depthMapsFolder",
            label="DepthMaps Folder",
            description="Input depth maps folder.",
            value="",
        ),

        desc.File(
            name="depthMapsFolderGT",
            label="GT DepthMaps Folder",
            description="Input ground truth depth maps folder.",
            value="",
        ),

        desc.ChoiceParam(
            name='metrics',
            label='Metrics',
            description='Metrics to be used in the comparison.',
            value=['RMSE', 'MAE', 'validity_ratio'],
            values=['RMSE', 'MAE', 'validity_ratio'],
            exclusive=False,
            joinChar=',',
        ),

        desc.BoolParam(
            name='autoRescale',
            label='Auto Rescale',
            description='''Will attempt to find a scale factor between GT depth maps and estimated depth maps. To be used when the depth maps have not been estimated from the same camera coordinate system.''',
            value=False,
        ),

        desc.StringParam(
            name='maskValue',
            label='Mask Value',
            description='''If this is not None, will mask the pixels with value bellow this (in gt and estimated).''',
            value='0',
        ),

        desc.StringParam(
            name='csv_name',
            label='CsvName',
            description='Name for the csv file to be used.',
            value="depth_map_comparison.csv",
            group="0"
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

    outputs = [
        desc.File(
            name='output',
            label='Output',
            description='Output folder for generated results.',
            value=desc.Node.internalFolder,
        ),
        
        desc.File(
            name='outputCsv',
            label='Output Csv',
            description='Output file to generated results.',
            value=lambda attr: os.path.join(desc.Node.internalFolder, attr.node.csv_name.value),
        )
    ]
