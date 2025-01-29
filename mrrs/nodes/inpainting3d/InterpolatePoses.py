__version__ = "3.0"

import os
import json

from meshroom.core import desc

class InterpolatePoses(desc.Node):

    category = 'Inpainting 3D'
    documentation = ''''''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
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
        import cv2
        from mrrs.core.ios import sfm_data_from_matrices, matrices_from_sfm_data

        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
     
        #load .sfm data 
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        #sort by frameId
        sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:int(v["frameId"])) 
        #load poses into matrices
        extrinsics, intrinsics, views_id, poses_ids, intrinsics_ids, pixel_sizes_all_cams, images_size = matrices_from_sfm_data(sfm_data, True)
        sensor_width = pixel_sizes_all_cams[0]*images_size[0,0]

        #
        print("Saving")
        #intrinsics in pixels for export
        for i in range(len(intrinsics)):
            if intrinsics[i] is not None:
                intrinsics[i]/= pixel_sizes_all_cams[i]
                intrinsics[i][2,2]=1
        sfm_data_out = sfm_data_from_matrices(extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size, 
                                              sfm_data = sfm_data, sensor_width = sensor_width)
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(sfm_data_out, f, indent=4)
       

        # #tmp 
        # extrinsics[4]=None

        # # trasnsform into so3
        # print("transforming")
        # rot_so3=[]
        # missing=0
        # for e in extrinsics:
        #     rotVec = None 
        #     if e is not None:
        #         rotVec,_=cv2.Rodrigues(e[0:3,0:3])
        #     else:
        #         missing+=1
        #     rot_so3.append(rotVec)
        
        # print("%d poses missing"%missing)

        # #interpolation
        # print("Intepolation")
        # extrinsics_intrp = extrinsics.copy()
        # prev_valid = -1
        # for i,e in enumerate(extrinsics):
        #     if e is None and prev_valid!=-1:
        #         next_valid = [j for j in range(i, len(extrinsics)) if extrinsics[j] is not None][0]
        #         print("interpolatin view %d from %d and %d"%(i,prev_valid,next_valid))
        #         print(sfm_data["views"][i])
        #         print(sfm_data["views"][prev_valid])
        #         print(sfm_data["views"][next_valid])
        #         w = (i-prev_valid)/(next_valid-prev_valid)
        #         r_interp, _ = cv2.Rodrigues((1-w)*rot_so3[prev_valid]+w*rot_so3[next_valid])
        #         t_interp = (1-w)*extrinsics[prev_valid][:,3]+w*extrinsics[next_valid][:,3]
        #         e_interp=np.concatenate([r_interp, np.expand_dims(t_interp, axis=1) ], axis=1)
        #         extrinsics_intrp[i] = e_interp
        #     else:
        #         prev_valid = i

        
        # #write result
        # print("Saving")
        # #intrinsics in pixels for export
        # for i in range(len(intrinsics)):
        #     if intrinsics[i] is not None:
        #         intrinsics[i]/= pixel_sizes_all_cams[i]
        #         intrinsics[i][2,2]=1
        # sfm_data_out = sfm_data_from_matrices(extrinsics_intrp, intrinsics, poses_ids, intrinsics_ids, images_size, 
        #                                       sfm_data = sfm_data, sensor_width = sensor_width)
        # with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
        #     json.dump(sfm_data_out, f, indent=4)
        chunk.logManager.end()

