"""
This node injects some fields from a source sfm data to a target sfm data.
"""
__version__ = "3.0"


import json
import os 

from meshroom.core import desc
from meshroom.core.plugin import PluginNode

class InjectSfmData(PluginNode):

    category = 'Meshroom Research'#Machine Learning Effort for Meshroom #'Sparse Reconstruction'

    documentation = '''This node injects some fields from a source sfm data to a target sfm data.'''

    size = desc.DynamicNodeSize('sourceSfmData')

    envFile = os.path.join(os.path.dirname(__file__), "utils_env.yaml")

    inputs = [

        desc.File(
            name='sourceSfmData',
            label='Source SfmData',
            description='Input sfm file containing the fields to be injected in target SfMData.',
            value=desc.Node.internalFolder,
        ),

        desc.File(
            name='targetSfmData',
            label='Target SfmData',
            description='Input SfM file containing the SfM data to be injected with data from the source SfMData.',
            value=desc.Node.internalFolder,
        ),

        desc.ChoiceParam(
            name='exportedFields',
            label='Exported Fields',
            description='''Fields of the .sfm to export.''',
            value=['structure'],
            values=['poses', 'views' ,'intrinsics', 'structure', 'version', 'featuresFolders', 'matchesFolders'],
            exclusive=False,
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
            name='outputSfMData',
            label='SfMData',
            description='Path to the output SfMData file.',
            value=desc.Node.internalFolder + 'sfm.sfm',
        ),
    ]

    def pythonProcessChunk(self, args):
        """
        Opens the dataset data.
        """
        print("Starts to inject sfm data")
        with open(args.sourceSfmData.value,"r") as json_file:
            source_sfm_data= json.load(json_file)
        with open(args.targetSfmData.value,"r") as json_file:
            target_sfm_data= json.load(json_file)
   
        for field in args.exportedFields.value:
            print("Injecting "+field)
            if field not in source_sfm_data.keys():
                print("Field "+field+" not found in "+args.sourceSfmData.value+", skipping")
                continue
            if field =="structure":#filter out
                print('Removing structure with no matching views')
                #make sure the viewid in obeservation is in the lisy of views, otherwise remove
                view_id = [view["viewId"] for view in target_sfm_data['views'] ]
                for landmark in source_sfm_data[field]:
                    valid_observations =[]
                    for observation in landmark["observations"]:
                        if observation["observationId"]  in view_id:
                            valid_observations.append(observation)
                        # else:
                        #     print('Removing obervation')
                    landmark["observations"]=valid_observations

            target_sfm_data[field]=source_sfm_data[field]

        with open(args.outputSfMData.value,"w") as json_file:
            json_file.write(json.dumps(target_sfm_data, indent=2))
   
