__version__ = "3.0"

import os
import json

import numpy as np
from meshroom.core import desc

from mrrs.core.ios import *
from .kornia_wrappers.utils import open_descriptor_file, write_descriptor_file

class MaskFeatures(desc.Node):

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

        desc.File(
            name="featureFolder",
            label="Feature Folder",
            description="Featurefolder",
            value="",
            uid=[0],
        ),

        desc.File(
            name="maskFolder",
            label="Mask Folder",
            description="maskFolder",
            value="",
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
            name='outputFolder',
            label='outputFolder',
            description='outputFolder',
            value=desc.Node.internalFolder,
            uid=[],
            group='',
        )
    ]

    def processChunk(self, chunk):
        """
        """
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
        if chunk.node.maskFolder.value == '':
            raise RuntimeError("No maskFolder specified")
        
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        feature_files = os.listdir(chunk.node.featureFolder.value)
        print("%d feature files detected"%len(feature_files))
  
        print("Masking features")
        for view in sfm_data["views"]:
            image_uid = view["viewId"]
            keypoint_file = [os.path.join(chunk.node.featureFolder.value, ff) for ff
                             in feature_files if ((image_uid in ff) and ff.endswith(".feat"))][0]
            desc_file = [os.path.join(chunk.node.featureFolder.value, ff) for ff
                             in feature_files if ((image_uid in ff) and ff.endswith(".desc"))][0]
            mask_file = os.path.join(chunk.node.maskFolder.value, image_uid+".exr")
            
            keypoints = np.loadtxt(keypoint_file)
            mask = open_image(mask_file).astype(np.bool)
            keypoints_nn = np.round(keypoints).astype(np.int32)
            valid_mask=mask[keypoints_nn[:,1],keypoints_nn[:,0],0]
            valid_keypoints = keypoints[valid_mask,:]
            print("Saving %d keypoints"%valid_keypoints.shape[0])
            with open(os.path.join(chunk.node.outputFolder.value, os.path.basename(keypoint_file)), "w") as kpf:
                for kp_x, kp_y in valid_keypoints[:,0:2]:
                    kpf.write("%f %f 0 0\n"%(kp_x, kp_y))
            #FIXME: need to remove coresp descriptor
            descriptors=open_descriptor_file(desc_file)
            valid_descriptors = descriptors[valid_mask,:]
            write_descriptor_file(valid_descriptors, os.path.join(chunk.node.outputFolder.value, os.path.basename(desc_file)))
      
        chunk.logManager.end()

