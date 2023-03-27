__version__ = "1.0"

from meshroom.core import desc

import os


class SyntheticDatasetNodeSize(desc.DynamicNodeSize):

    def computeSize(self, node):
        frameStart = node.attribute('frameStart').value
        frameEnd = node.attribute('frameEnd').value
        frameStep = node.attribute('frameStep').value
        return (frameEnd + 1 - frameStart) / frameStep


class SyntheticDataset(desc.InitNode, desc.CommandLineNode):
    commandLine = 'blender -b {blenderFileValue} -P {scriptValue} -- \
                {imagesFolderValue} {sceneNameValue} {cameraNameValue} \
                {frameStartValue} {frameEndValue} {frameStepValue} \
                {outputFolderValue}'

    size = SyntheticDatasetNodeSize('')

    category = 'Evaluation'
    documentation = 'Utility node to load an evaluation dataset from a given folder.'

    inputs = [
        desc.File(
            name='blenderFile',
            label='Blender File',
            description='Blender file containing the synthetic scene and camera',
            value='',
            uid=[0]
        ),
        desc.File(
            name='script',
            label='Script',
            description='Python script to extract ground truth data',
            value='MeshroomResearch/mrrs/blender/extract_ground_truth.py',
            uid=[0]
        ),
        desc.File(
            name='imagesFolder',
            label='Images Folder',
            description='Folder containing the images rendered from the Blender file',
            value='',
            uid=[0]
        ),
        desc.StringParam(
            name='sceneName',
            label='Scene Name',
            description='Name of the 3D scene in Blender',
            value='Scene',
            uid=[0]
        ),
        desc.StringParam(
            name='cameraName',
            label='Camera Name',
            description='Name of the camera in Blender',
            value='Camera',
            uid=[0]
        ),
        desc.IntParam(
            name='frameStart',
            label='Frame Start',
            description='First frame',
            value=0,
            range=(0,1000,1),
            uid=[0]
        ),
        desc.IntParam(
            name='frameEnd',
            label='Frame End',
            description='Last Frame (excluded)',
            value=100,
            range=(0,1000,1),
            uid=[0]
        ),
        desc.IntParam(
            name='frameStep',
            label='Frame Step',
            description='Step for downsampling the dataset',
            value=1,
            range=(1,100,1),
            uid=[0]
        ),
    ]
    outputs = [
        desc.File(
            name='outputFolder',
            label='Folder',
            description='Output folder for generated ground truth files',
            value=desc.Node.internalFolder,
            uid=[]
        ),
        desc.File(
            name='fakeCameraInit',
            label='Fake Camera Init',
            description='Sfm file containing the ground truth views and intrinsics (without poses)',
            value=desc.Node.internalFolder+'/gt_no_pose.sfm',
            uid=[]
        ),
        desc.File(
            name='groundTruth',
            label='Ground truth',
            description='Sfm file containing the ground truth views, intrinsics and poses',
            value=desc.Node.internalFolder+'/gt.sfm',
            uid=[]
        ),
    ]

    def initialize(self, node, inputs, recursiveInputs):
        if len(inputs) == 2:
            self.setAttributes(node, {'blenderFile': inputs[0], 'imagesFolder': inputs[1]})
