import logging
import os
import cv2
import numpy as np

from mrrs.core.utils import cv2_resize_crop, cv2_resize_with_pad

class LearningBasedDepthRefinementCv2():
    #FIXME: not workiung
    # IMAGE_SIZE = [1280, 720]

    def __init__(self):
        this_file_path = os.path.dirname(os.path.realpath(__file__))
        path_to_model = os.path.join(this_file_path, "model.onnx")
        self.model = cv2.dnn.readNetFromONNX(path_to_model)

    def __call__(self, depth_map, rgb_image):
        depth_map_prepared = depth_map
        rgb_image_prepared = rgb_image
        #resize/pad image to the network size
        # depth_map_prepared, pads = cv2_resize_with_pad(depth_map_prepared, self.IMAGE_SIZE, cv2.INTER_NEAREST)
        # rgb_image_prepared, pads = cv2_resize_with_pad(rgb_image_prepared, self.IMAGE_SIZE, cv2.INTER_NEAREST)
        #make sure the depth is float
        depth_map_prepared = depth_map_prepared.astype(np.float32)
        rgb_image_prepared = rgb_image_prepared.astype(np.float32)
        #batch FIXME: actually batch
        depth_map_prepared = np.expand_dims(depth_map_prepared, axis=0)#, axis=0)
        rgb_image_prepared = np.expand_dims(rgb_image_prepared, axis=0)
        # self.model.setInputsNames(["input_0", "input_1"])
        self.model.setInput(depth_map_prepared, name="input_1")
        self.model.setInput(rgb_image_prepared, name="input_2")
        #forward pass, save raw predictions in temp buffer
        output_depth_map, _ = self.model.forward(["output_1"])[0][0]
        #resize to match original size (NN interpolation)
        # output_depth_map = cv2_resize_crop(output_depth_map,
        #                 (depth_map.shape[1], depth_map.shape[0]),
        #                 pads,
        #                 interpolation=cv2.INTER_NEAREST)
        return output_depth_map

import onnxruntime
class LearningBasedDepthRefinementOnnxRT():

    #FIXME: fixed see if we cnt ready it from model
    IMAGE_SIZE = [384, 288]

    def __init__(self, path_to_model=None):
        if path_to_model is None:
            this_file_path = os.path.dirname(os.path.realpath(__file__))
            path_to_model = os.path.join(this_file_path, "model.onnx")
        logging.info("Loading model "+path_to_model)
        print(path_to_model)#FIXME; debug
        print(onnxruntime.__version__)
        logging.info("Onnx runtime v"+onnxruntime.__version__)
        self.ort_session = onnxruntime.InferenceSession(path_to_model, providers=['CUDAExecutionProvider',
                                                                                  'CPUExecutionProvider'])


    def __call__(self, depth_map, rgb_image):
        depth_map_prepared = depth_map
        rgb_image_prepared = rgb_image
        #resize/pad image to the network size
        depth_map_prepared, pads = cv2_resize_with_pad(depth_map_prepared, self.IMAGE_SIZE, cv2.INTER_NEAREST)
        rgb_image_prepared, pads = cv2_resize_with_pad(rgb_image_prepared, self.IMAGE_SIZE, cv2.INTER_NEAREST)
        #make sure the depth is float
        depth_map_prepared = depth_map_prepared.astype(np.float32)
        rgb_image_prepared = rgb_image_prepared.astype(np.float32)
        #batch FIXME: actually batch
        depth_map_prepared = np.expand_dims(depth_map_prepared, axis=0)
        if len(depth_map.shape)<4:
            depth_map_prepared = np.expand_dims(depth_map_prepared, axis=-1)
        rgb_image_prepared = np.expand_dims(rgb_image_prepared, axis=0)
        #set input and call onnx runtime
        ort_inputs = {self.ort_session.get_inputs()[0].name: depth_map_prepared,
                      self.ort_session.get_inputs()[1].name: rgb_image_prepared}
        ort_outs = self.ort_session.run(None, ort_inputs)
        output_depth_map = ort_outs[0][0]
        #resize to match original size (NN interpolation)
        output_depth_map = cv2_resize_crop(output_depth_map,
                        (depth_map.shape[1], depth_map.shape[0]),
                        pads,
                        interpolation=cv2.INTER_NEAREST)
        return output_depth_map

LearningBasedDepthRefinement = LearningBasedDepthRefinementOnnxRT

# if __name__ == "__main__":
#     W = 384
#     H = 288
#     CD = 1
#     CC = 3
#     dummy_depth = np.zeros([H,W, CD], dtype=np.float32)
#     dummy_rgb = np.zeros([H,W, CC], dtype=np.float32)

# #     # dr = LearningBasedDepthRefinement()
# #     # dr(dummy_depth, dummy_rgb)

# #     dr = LearningBasedDepthRefinementOnnxRT()
# #     dr(dummy_depth, dummy_rgb)


#     import onnxruntime
#     import numpy as np
#     this_file_path = os.path.dirname(os.path.realpath(__file__))
#     path_to_model = os.path.join(this_file_path, "model.onnx")
#     ort_session = onnxruntime.InferenceSession(path_to_model, providers=['CUDAExecutionProvider', 'CPUExecutionProvider'])

#     # src_out = ... # output of your source framework, if this is a PyTorch tensor convert it to a numpy array using to_numpy
#     ort_inputs = {ort_session.get_inputs()[0].name: np.expand_dims(dummy_depth, axis=0),
#                   ort_session.get_inputs()[1].name: np.expand_dims(dummy_rgb, axis=0)}
#     ort_outs = ort_session.run(None, ort_inputs)
#     print("Done")


