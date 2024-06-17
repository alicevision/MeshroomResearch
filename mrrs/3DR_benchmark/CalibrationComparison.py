"""
This node runs comparison between two input calibration.
"""
__version__ = "3.0"


import os

from meshroom.core import desc
from meshroom.core.plugin import CondaNode

class CalibrationComparison(CondaNode):
    category = 'MRRS - Benchmark'

    documentation = '''For each camera, compare its estimated parameters with a given groud truth.'''
    
    commandLine = 'python "'+os.path.join(os.path.dirname(__file__), "calibration_comparison.py")+'" {allParams}'
    
    envFile = os.path.join(os.path.dirname(__file__), "general_env.yaml")

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.File(
            name='inputSfMGT',
            label='GtSfMData',
            description='Ground Truth SfMData file.',
            value='',
        ),

        desc.ChoiceParam(
            name='metrics',
            label='Metrics',
            description='Metrics to be used in the comparison.',
            value=['MSECameraCenter'],
            values=['MSECameraCenter','AngleBetweenRotations','MSEFocal', 'MSEPrincipalPoint', 'validCams'],
            exclusive=False,
            joinChar=',',
        ),

         desc.StringParam(
            name='csvName',
            label='CsvName',
            description='Name for the csv file to be used.',
            value="calibration_comparison.csv",
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output Folder',
            description='Output folder for generated results.',
            group="",
            value=desc.Node.internalFolder,
        ),
        desc.File(
            name='outputCsv',
            label='Output Csv',
            description='Output file to generated results.',
<<<<<<< HEAD
            value=lambda attr: os.path.join(desc.Node.internalFolder, attr.node.csv_name.value),
=======
            value=lambda attr: os.path.join(desc.Node.internalFolder, attr.node.csvName.value),
            uid=[],
>>>>>>> calibration comparison cli
        )
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputSfM.value:
            chunk.logger.warning('No inputSfM in node, skipping')
            return False
        if not chunk.node.inputSfMGT.value:
            chunk.logger.warning('No inputSfMGT in node, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Computes the different metrics on the input and groud truth depth maps.
        """
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if not self.check_inputs(chunk):
            raise RuntimeError("Missing arguments")
        super().processChunk(chunk)
        chunk.logger.info('Calib comparison ends')
        chunk.logManager.end()
