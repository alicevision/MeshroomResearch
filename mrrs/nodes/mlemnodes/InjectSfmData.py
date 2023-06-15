"""
This node injects some fields from a source sfm data to a target sfm data.
"""
__version__ = "3.0"

import os
import json
from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *

class InjectSfmData(desc.Node):

    category = 'Meshroom Research'#Machine Learning Effort for Meshroom #'Sparse Reconstruction'

    documentation = '''This node injects some fields from a source sfm data to a target sfm data.'''

    size = desc.DynamicNodeSize('sourceSfmData')

    inputs = [

        desc.File(
            name='sourceSfmData',
            label='Source SfmData',
            description='Input sfm file containing the fields to be injected in target sfmdata.',
            value=desc.Node.internalFolder,
            uid=[0],
        ),

        desc.File(
            name='targetSfmData',
            label='Target SfmData',
            description='Input sfm file containing the sfm data to be injected with fata from the source sfm data.',
            value=desc.Node.internalFolder,
            uid=[0],
        ),

        desc.ChoiceParam(
            name='exportedFields',
            label='Exported Fields',
            description='''Fields of the .sfm to export''',
            value=['structure'],
            values=['poses', 'views' ,'intrinsics', 'structure', 'version', 'featuresFolders', 'matchesFolders'],
            exclusive=False,
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

    outputs = [
        desc.File(
            name='outputSfMData',
            label='SfMData',
            description='Path to the output sfmdata file',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.sourceSfmData.value:
            chunk.logger.warning('No input sourceSfmData in node InjectSfmData, skipping')
            return False
        if not chunk.node.targetSfmData.value:
            chunk.logger.warning('No input targetSfmData in node InjectSfmData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            #check inputs
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Starts to inject sfm data")
            with open(chunk.node.sourceSfmData.value,"r") as json_file:
                source_sfm_data= json.load(json_file)
            with open(chunk.node.targetSfmData.value,"r") as json_file:
                target_sfm_data= json.load(json_file)
            # output_sfm = target_sfm_data.copy()

            for field in chunk.node.exportedFields.value:
                chunk.logger.info("Injecting "+field)
                if field not in source_sfm_data.keys():
                    chunk.logger.info("Field "+field+" not found in "+chunk.node.sourceSfmData.value+", skipping")
                    continue
                if field =="structure":#filter out
                    chunk.logger.info('Removing structure with no matching views')
                    #take advantage of the fact that a view that is not reconstructed doesnt have pose (pose and view have same id)
                    view_id = [view["poseId"] for view in target_sfm_data['poses'] ]
                    for landmark in source_sfm_data[field]:
                        valid_observations =[]
                        for observation in landmark["observations"]:
                            if observation["observationId"]  in view_id:
                                valid_observations.append(observation)
                            # else:
                            #     chunk.logger.info('Removing obervation')
                        landmark["observations"]=valid_observations

                target_sfm_data[field]=source_sfm_data[field]

            with open(chunk.node.outputSfMData.value,"w") as json_file:
                json_file.write(json.dumps(target_sfm_data, indent=2))
            chunk.logger.info('')
        finally:
            chunk.logManager.end()



