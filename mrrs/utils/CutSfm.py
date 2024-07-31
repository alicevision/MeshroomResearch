__version__ = "3.0"

import os
import json

from meshroom.core import desc
from meshroom.core.plugin import PluginNode, EnvType

class CutSfm(PluginNode):

    category = 'MRRS - Utils'
    documentation = ''''''

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "utils_env.yaml")

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

    
    desc.StringParam(
            name='parameter',
            label='Parameter',
            description='',
            value='',
        ),

    desc.BoolParam(
            name='removeImagePath',
            label='removeImagePath',
            description='Will remove the fullpath to images.',
            value=True,
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
            label='Output',
            description='Output SfM data.',
            value=os.path.join(desc.Node.internalFolder, "sfm.sfm"),
        )
    ]

    def processChunk(self, chunk):
        """
        Computes the different transforms
        """
        import numpy as np

        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
        
        #load .sfm data in fram order
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        sfm_data["views"], sfm_data["poses"]  = zip(*sorted(zip(sfm_data["views"], sfm_data["poses"]), key=lambda v:int(v[0]["frameId"])) )
        #extract views
        param = np.asarray(eval(chunk.node.parameter.value), dtype=np.float32)
        param=param.astype(np.int32)
        sfm_data["views"] = [sfm_data["views"][p] for p in param]
        sfm_data["poses"] = [sfm_data["poses"][p] for p in param]

        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(sfm_data, f, indent=4)
        chunk.logManager.end()

