__version__ = "3.0"

import os
import json

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.core.geometry import *

from mrrs.core.geometry import GG_CV_MAT33

class Transforms():
    """
    class used as namespace to automatically include in gui
    """
    def id(extrinsics, intrinsics, param):
        """
        Identity transform, does nothing
        """
        return extrinsics, intrinsics

    def cg2cv(extrinsics, intrinsics, param):
        """
        Swap from CG to CV coordinate system
        """
        extrinsics=GG_CV_MAT33@extrinsics
        return extrinsics, intrinsics

    def custom(extrinsics, intrinsics, param):
        """
        Will use the passed matrix to transform the poses
        """
        extrinsics=param@extrinsics
        return extrinsics, intrinsics

    def inv(extrinsics, intrinsics, param):
        """
        Inv of the poses
        """
        extrinsics = [np.linalg.inv(np.concatenate( [e,[[0,0,0,1]]] )) for e in extrinsics]
        return extrinsics, intrinsics
    
    def scale(extrinsics, intrinsics, param):
        """
        """
        extrinsics=np.asarray(extrinsics)
        center = np.mean(extrinsics[:,0:3,3], axis=0 )
        for i in range(len(extrinsics)):
            extrinsics[i][0:3,3] -= center
            extrinsics[i][0:3,3] *= param
            extrinsics[i][0:3,3] += center
        return extrinsics, intrinsics
    
    def center(extrinsics, intrinsics, param):
        """
        Will normalise the calib such that the camera centers are between -1 and 1
        """
        extrinsics=np.asarray(extrinsics)
        center = np.mean(extrinsics[:,0:3,3], axis=0 )
        for i in range(len(extrinsics)):
            extrinsics[i][0:3,3] -= center
        return extrinsics, intrinsics

transforms_names = [f for f in Transforms.__dict__.keys() if not f.startswith("__")]

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
            values=transforms_names,
            value=transforms_names[0],
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
        transform_function = eval("Transforms."+chunk.node.transform.value)
        matrix = np.asarray(eval(chunk.node.parameter.value), dtype=np.float32)
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

