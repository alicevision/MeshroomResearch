
import cv2
import os
from mrrs.segmentation.segmentation_model import SegmentationModel
import numpy as np

class InstanceSegmentationMaskRCNN(SegmentationModel):
    """
    Wrapper around the semantic segmentaion of matter port.
    Code and model here https://github.com/matterport/Mask_RCNN
    https://machinelearningknowledge.ai/instance-segmentation-using-roi-rcnn-in-opencv-python/#i_Install_Libraries
    """
    CLASSES_NAMES = ["person","bicycle","car","motorcycle","airplane","bus","train","truck","boat","traffic light",
                    "fire hydrant","street sign","stop sign","parking meter","bench","bird","cat","dog","horse","sheep",
                    "cow","elephant","bear","zebra","giraffe","hat","backpack","umbrella","shoe","eye glasses","handbag",
                    "tie","suitcase","frisbee","skis","snowboard","sports ball","kite","baseball bat","baseball glove",
                    "skateboard","surfboard","tennis racket","bottle","plate","wine glass","cup","fork","knife","spoon",
                    "bowl","banana","apple","sandwich","orange","broccoli","carrot","hot dog","pizza","donut","cake","chair",
                    "couch","potted plant","bed","mirror","dining table","window","desk","toilet","door","tv","laptop","mouse",
                    "remote","keyboard","cell phone","microwave","oven","toaster","sink","refrigerator","blender","book","clock",
                    "vase","scissors","teddy bear","hair drier","toothbrush"]

    def __init__(self, confidence_threshold = 0.9):
        super().__init__()
        this_file_path = os.path.dirname(os.path.realpath(__file__))
        path_to_model=os.path.join(this_file_path, "frozen_inference_graph_coco.pb")
        path_to_config=os.path.join(this_file_path, "mask_rcnn_inception_v2_coco_2018_01_28.pbtxt")
        self.model = cv2.dnn.readNetFromTensorflow(path_to_model,path_to_config)
        self.confidence_threshold = confidence_threshold

    def __call__(self, input_image):

        height, width, _ = input_image.shape
        blob = cv2.dnn.blobFromImage(input_image, swapRB=True)#size=[640,480] #FIXME: resize to 640×480?
        self.model.setInput(blob)
        boxes, mask_rois = self.model.forward(["detection_out_final", "detection_masks"])
        no_of_objects = boxes.shape[2]
        output_mask_rois = []
        output_classes = []
        for i in range(no_of_objects):
            box = boxes[0, 0, i]
            class_id = int(box[1])
            score = box[2]
            if score < self.confidence_threshold:
                continue

            x = int(box[3] * width)
            y = int(box[4] * height)
            x2 = int(box[5] * width)
            y2 = int(box[6] * height)
            if y2-y == 0 or x2-x==0:#empty box
                continue
            roi_height, roi_width = [y2-y, x2-x]
            mask_roi = mask_rois[i, int(class_id)]
            mask_roi = cv2.resize(mask_roi, (roi_width, roi_height))
            _, mask_roi = cv2.threshold(mask_roi, 0.5, 255, cv2.THRESH_BINARY)#fixme switch to 0 1 mask?
            mask = np.zeros(input_image.shape[0:2], dtype=np.uint8)
            mask[y:y2, x:x2]=mask_roi.astype(np.uint8)
            if(class_id>len(self.CLASSES_NAMES)):
                #raise RuntimeError("Invalid class id")
                class_label="class_%d"%class_id#FIXME: ungly also a problem... probaly not the right list
            else:
                class_label=self.CLASSES_NAMES[class_id]+"_%i"%class_id
            output_classes.append(class_label)
            output_mask_rois.append(mask)
        return output_mask_rois, output_classes

    @staticmethod
    def export_model():
        raise RuntimeError("Export not supported.")

