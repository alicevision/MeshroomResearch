__version__ = "3.0"

import os
import json

from meshroom.core import desc
from meshroom.core.plugin import PluginNode, EnvType

transforms_names = ["id", "cg2cv", "custom", "inv", 
                    "scale", "center", "set_focal"]#[f for f in Transforms.__dict__.keys() if not f.startswith("__")]

class CalibTransform(PluginNode):

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

        desc.ChoiceParam(
            name='transform',
            label='Tranform',
            description='Transformation to apply to the calib.',
            values=transforms_names,
            value=transforms_names[0],
            exclusive=True,
            joinChar=',',
        ),

    
    desc.StringParam(
            name='parameter',
            label='Parameter',
            description='',
            value='[[1,0,0], [0,1,0], [0,0,1]]',
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
        from mrrs.core.geometry import sfm_data_from_matrices, matrices_from_sfm_data
        from mrrs.core.geometry import CG_CV_MAT33

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
                extrinsics=CG_CV_MAT33@extrinsics
                return extrinsics, intrinsics

            def custom(extrinsics, intrinsics, param):
                """
                Will use the passed param_array to transform the poses
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

            def set_focal(extrinsics, intrinsics, param):
                """
                Set focal 
                """
                intrinsics=np.asarray(intrinsics)
                intrinsics[:,0,0] = param
                intrinsics[:,1,1] = param
                return extrinsics, intrinsics

        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
        #get transform function
        transform_function = eval("Transforms."+chunk.node.transform.value)
        param_array = np.asarray(eval(chunk.node.parameter.value), dtype=np.float32)
        #load .sfm data 
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        #sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:int(v["frameId"])) 

        extrinsics, intrinsics, views_id, poses_ids, intrinsics_ids, pixel_sizes_all_cams, images_size = matrices_from_sfm_data(sfm_data, True)
        sensor_width = pixel_sizes_all_cams[0]*images_size[0,0]
        #apply transfrom
        extrinsics, intrinsics = transform_function(extrinsics, intrinsics, param_array)
        #intrinsics in piXels for export
        # intrinsics/=np.expand_dims(pixel_sizes_all_cams, axis=[1,2])
        # intrinsics[:,2,2]=1
        #intrinsics in pixels for export
        for i in range(len(intrinsics)):
            if intrinsics[i] is not None:
                intrinsics[i]/= pixel_sizes_all_cams[i]
                intrinsics[i][2,2]=1
        #write result
        sfm_data_out = sfm_data_from_matrices(extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size, 
                                              sfm_data = sfm_data, sensor_width = sensor_width)
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(sfm_data_out, f, indent=4)
        chunk.logManager.end()

