__version__ = "3.0"

import os
import json

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.core.geometry import *

from mrrs.core.geometry import CG_CV_MAT33

class CutSfm(desc.Node):

    category = 'Meshroom Research'
    documentation = ''''''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
            uid=[0],
        ),

    
    desc.StringParam(
            name='parameter',
            label='Parameter',
            description='',
            value='',
            uid=[0],
        ),

    desc.BoolParam(
            name='removeImagePath',
            label='removeImagePath',
            description='Will remove the fullpath to images',
            value=True,
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
            label='Output',
            description='Output sfm data',
            value=os.path.join(desc.Node.internalFolder, "sfm.sfm"),
            uid=[]
        )
    ]

    def extract_frames(extrinsics, intrinsics, param):
        """
        Extract a set of frames from the .sfm
        """
        param=param.astype(np.int32)
        extrinsics = np.asarray(extrinsics)[param]
        return extrinsics, intrinsics


    def processChunk(self, chunk):
        """
        Computes the different transforms
        """
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

