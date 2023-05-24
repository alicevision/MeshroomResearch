"""
Binset wrapper from https://github.com/zllrunning/face-parsing.PyTorch.
Meant to be used with faceCapture
"""
import os
import cv2
import numpy as np

import torch
import torchvision.transforms as transforms#FIXME: to remove

from mrrs.core.utils import cv2_resize_with_pad, cv2_resize_crop
from mrrs.segmentation.segmentation_model import SegmentationModel

class BisnetSegmentation(SegmentationModel):

    IMAGE_SIZE = [512, 512]
    CLASSES_NAMES = ['background', 'skin', 'l_brow', 'r_brow', 'l_eye', 'r_eye', 'eye_g', 'l_ear', 'r_ear', 'ear_r',
            'nose', 'mouth', 'u_lip', 'l_lip', 'neck', 'neck_l', 'cloth', 'hair', 'hat']
            
    def __init__(self):
        super().__init__()
        this_file_path = os.path.dirname(os.path.realpath(__file__))
        path_to_model = os.path.join(this_file_path, "79999_iter.pth")
        # self.model = cv2.dnn.readNetFromTorch(path_to_model)
        # self.norm_mean=[0.485, 0.456, 0.406]
        # self.norm_std=[0.229, 0.224, 0.225] #CONSTANT CLASS ,
        # self._raw_output = None#unprocessed output
        # self._output_probabilities = []

        import sys
        sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), "face-parsing.PyTorch"))
        from model import BiSeNet
        self.n_classes = 19
        net = BiSeNet(n_classes=self.n_classes)
        net.cuda()
        net.load_state_dict(torch.load(path_to_model))
        net.eval()
        self.model=net
        print("Loading done")

    def __call__(self, input_image):
        #resize/pad image to the network size
        input_image_prepared, pads = cv2_resize_with_pad(input_image, self.IMAGE_SIZE, cv2.INTER_NEAREST)
        # #make sure the image is float
        # input_image_prepared = input_image_prepared.astype(np.float32)
        input_image_prepared=input_image_prepared.astype(np.uint8) #FIXME: ToTensor expextcs uint8
        # input_image_prepared=np.rot90(input_image_prepared).copy()#FIXME: test
        to_tensor = transforms.Compose([
                        transforms.ToTensor(),
                        transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225)),
                    ])
        with torch.no_grad():
            img = to_tensor(input_image_prepared)
            img = torch.unsqueeze(img, 0)
            img = img.cuda()
            out = self.model(img)[0]
            seg_labels = out.squeeze(0).cpu().numpy().argmax(0)
            # print(parsing)

        #resize/pad image to the image size
        seg_labels_resized = cv2_resize_crop(seg_labels, (input_image.shape[1],input_image.shape[0]),
                                                 pads, cv2.INTER_NEAREST)

        class_names = [self.CLASSES_NAMES[n] for n in np.unique(seg_labels) ]
        masks = [(255*(seg_labels_resized==i)).astype(np.uint8)for i in np.unique(seg_labels)]

        return masks, class_names

    @staticmethod
    def export_model():#fixed_image_size = [1920, 1080]
        """
        """
        pass