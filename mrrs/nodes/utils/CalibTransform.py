__version__ = "3.0"

import os
import json

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.core.geometry import *

from mrrs.core.geometry import GG_CV_MAT33

def id(extrinsics, intrinsics, param):
    return extrinsics, intrinsics

def cg2cv(extrinsics, intrinsics, param):
    extrinsics=GG_CV_MAT33@extrinsics
    return extrinsics, intrinsics

def custom(extrinsics, intrinsics, param):
    extrinsics=param@extrinsics
    return extrinsics, intrinsics

def inv(extrinsics, intrinsics, param):
    extrinsics = [np.linalg.inv(np.concatenate( [e,[[0,0,0,1]]] )) for e in extrinsics]
    return extrinsics, intrinsics
    
def norm(extrinsics, intrinsics, param):
    raise NotImplementedError("Not implemented yet")
    return extrinsics, intrinsics

class CalibTransform(desc.Node):

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

        desc.ChoiceParam(
            name='transform',
            label='Tranform',
            description='Transformation to apply to the calib',
            values=['id', 'cg2cv', 'norm', 'custom', 'inv'],
            value='id',
            exclusive=True,
            uid=[0],
            joinChar=',',
        ),

    
    desc.StringParam(
            name='parameter',
            label='Parameter',
            description='',
            value='[[1,0,0], [0,1,0], [0,0,1]]',
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

    def processChunk(self, chunk):
        """
        Computes the different transforms
        """
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
        #get transform function
        transform_function = eval(chunk.node.transform.value)
        matrix = np.asarray(eval(chunk.node.parameter.value))
        #load .sfm data
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        extrinsics, intrinsics, views_id, poses_ids, intrinsics_ids, pixel_sizes_all_cams, images_size = matrices_from_sfm_data(sfm_data, True)
        sensor_width = pixel_sizes_all_cams*images_size[:,0]
        #apply transfrom
        extrinsics, intrinsics = transform_function(extrinsics, intrinsics, matrix)
        #intrinsics in piXels for export
        intrinsics/=np.expand_dims(pixel_sizes_all_cams, axis=[1,2])
        intrinsics[:,2,2]=1
        #write result
        sfm_data_out = sfm_data_from_matrices(extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size, 
                                              sfm_data = sfm_data, sensor_width = sensor_width[0])
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(sfm_data_out, f, indent=4)
        chunk.logManager.end()

