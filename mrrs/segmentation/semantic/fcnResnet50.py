import os
import cv2
from mrrs.segmentation.segmentation_model import SegmentationModel
import numpy as np

from mrrs.core.utils import cv2_resize_crop, cv2_resize_with_pad
from mrrs.core.utils import get_label_colors

class SemanticSegmentationFcnResnet50(SegmentationModel):

    IMAGE_SIZE = [1280, 720]
    CLASSES_NAMES = [ '__background__', 'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
                'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse', 'motorbike',
                'person', 'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor']

    def __init__(self):
        super().__init__()
        this_file_path = os.path.dirname(os.path.realpath(__file__))
        path_to_model = os.path.join(this_file_path, "fcn_resnet50.onnx")
        self.model = cv2.dnn.readNetFromONNX(path_to_model)
        self.norm_mean=[0.485, 0.456, 0.406]
        self.norm_std=[0.229, 0.224, 0.225] #CONSTANT CLASS ,
        self._raw_output = None#unprocessed output
        self._output_probabilities = []

    def __call__(self, input_image):
        #resize/pad image to the network size
        input_image_prepared, pads = cv2_resize_with_pad(input_image, self.IMAGE_SIZE, cv2.INTER_NEAREST)
        #make sure the image is float
        input_image_prepared = input_image_prepared.astype(np.float32)
        #center and normalise for network (https://pytorch.org/hub/pytorch_vision_fcn_resnet101/)
        for channel in range(input_image_prepared.shape[-1]):
            input_image_prepared[:,:,channel] = ( input_image_prepared[:,:,channel]/255.0 - self.norm_mean[channel])\
                            / self.norm_std[channel]
        #batch and remap channels
        input_image_prepared = np.expand_dims(np.transpose(input_image_prepared, [2,0,1]), axis=0)
        self.model.setInput(input_image_prepared)
        #forward pass, save raw predictions in temp buffer
        output_probabilities = self.model.forward(["output"])[0][0]
        #resize to match original size (NN interpolation)
        self._output_probabilities = []
        for output_probability in output_probabilities:
            self._output_probabilities.append(cv2_resize_crop(output_probability,
                                                            (input_image.shape[1], input_image.shape[0]),
                                                            pads,
                                                            interpolation=cv2.INTER_NEAREST))
        #prepare output with a mask of the maximum value
        output_segmentation_index = np.argmax(self._output_probabilities, axis=0)
        output_classes = []
        output_segmentation = []
        for class_index in np.unique(output_segmentation_index):
            output_classes.append(self.CLASSES_NAMES[class_index])
            output_segmentation.append((255*(output_segmentation_index==class_index)).astype(np.uint8))#FIXME255?
        return output_segmentation, output_classes

    @staticmethod
    def export_model():#fixed_image_size = [1920, 1080]
        """
        Will load and export the model using pytorch model zoo.
        http://pytorch.org/vision/master/models/generated/torchvision.models.segmentation.fcn_resnet50.html
        You need to have pytorch installed.
        """
        #Lazy imports
        import torch
        from torchvision.models.segmentation import fcn_resnet50
        import torch.onnx
        #setup model and load in eval mode
        torch_model = fcn_resnet50(pretrained=True, progress=True, num_classes=21)
        torch_model.eval()
        # print(segmentor.CLASSES_NAMES)
        #setup input
        dummy_inputs = torch.randn(1, 3, SemanticSegmentationFcnResnet50.IMAGE_SIZE[1], SemanticSegmentationFcnResnet50.IMAGE_SIZE[0], requires_grad=True)
        with torch.no_grad():
            torch_out = torch_model(dummy_inputs)
        _ = torch_out['out'][0].detach().cpu().numpy()
        #export the model
        this_file_path = os.path.dirname(os.path.realpath(__file__))
        path_to_model = os.path.join(this_file_path, "fcn_resnet50.onnx")
        torch.onnx.export(torch_model, dummy_inputs, path_to_model,
                            export_params=True, opset_version=12,
                            do_constant_folding=True,
                            input_names = ['input'], output_names = ['output'],
                            dynamic_axes={'input' : {0 : 'batch_size'},  #opencv does not support variable length width and weigth
                                        'output' : {0 : 'batch_size'  }})

#Exports and tests
if __name__ == "__main__":
    SemanticSegmentationFcnResnet50.export_model()#create weigts

    # from mrrs.core.ios import *
    # from PIL import Image
    # segmentor = SemanticSegmentationFcnResnet50()
    # test_image = "C:\\Users\\hogm\\Downloads\\Family\\00001.jpg"
    # img = np.asarray(Image.open(test_image))
    # segmentor = SemanticSegmentationFcnResnet50()#TODO: test result with pytorch implementation
    # output_segmentation, output_classes = segmentor(img)
    # output_segmentation_index = np.argmax(segmentor._output_probabilities, axis=0) #to get seg index
    # Image.fromarray((15*output_segmentation_index).astype(np.uint8)).save("out_model_onnx.png")
    # save_image("input_img.png", img)
    # for s, c in zip(output_segmentation, output_classes):
    #     save_image("segments"+c+".png", s.astype(np.uint8) )
    # print("Done")



