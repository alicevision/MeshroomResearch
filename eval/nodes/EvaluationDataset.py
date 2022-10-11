__version__ = "1.0"

import os
from meshroom.core import desc


class EvaluationDataset(desc.InitNode, desc.Node):
    category = 'Meshroom Research'
    documentation = 'Utility node to load an evaluation dataset from a given folder.'
    inputs = [
        desc.File(
            name='datasetFolder',
            label='Dataset Folder',
            description='Folder containing the generated gt.sfm and gt_no_pose.sfm files',
            value='',
            uid=[0]
        ),
    ]
    outputs = [
        desc.File(
            name='fakeCamInit',
            label='Fake Camera Init',
            description='Sfm file containing the ground truth views and intrinsics (without poses)',
            value=lambda attr: attr.node.datasetFolder.value + '/gt_no_pose.sfm',
            uid=[]
        ),
        desc.File(
            name='groundTruth',
            label='Ground truth',
            description='Sfm file containing the ground truth views, intrinsics and poses',
            value=lambda attr: attr.node.datasetFolder.value + '/gt.sfm',
            uid=[]
        ),
    ]

    def stopProcess(self, chunk):
        pass

    def processChunk(self, chunk):
        pass

    def initialize(self, node, inputs, recursiveInputs):
        if len(inputs) == 1 and os.path.isdir(inputs[0]):
            self.setAttributes(node, {'datasetFolder': inputs[0]})
