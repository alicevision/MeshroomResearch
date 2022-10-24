import os, sys

import cv2
from mrrs.core.ios import save_exr, save_image
import numpy as np
from mrrs.core.utils import cv2_resize_with_pad

import os
os.environ['KMP_DUPLICATE_LIB_OK']='True'

#%%
class RobustMVDWrapper():
    """
    Wraper class around RobustMVD
    """

    DO_RESIZE = False
    IMAGE_SIZE=[576, 384]
    # IMAGE_SIZE=[1152, 768] #original size, cannot run on local

    def __init__(self):
        super().__init__()
        #load file
        # this_file_path = os.path.dirname(os.path.realpath(__file__))
        # path_to_model = os.path.join(this_file_path, "model.onnx")
        # self.model = cv2.dnn.readNetFromONNX(path_to_model)
        # self._raw_output = None#unprocessed output
        # self._output_probabilities = []

        #from api #FIXME: export and test
        # requires install of rmvd pip install -e . (also added a __init__ in blocks )
        import rmvd
        self.model = rmvd.create_model("robust_mvd")

    def __call__(self, input_images, input_poses, input_intrinsics, pixel_sizes):
        """
        input_images: list of images,
        input_poses: list of 4x4 poses
        input_intrinsics: list of 3x3 instricics
        first view in the list is assumed to be the reference view
        """
        #prepare images for input_adapter
        input_images     = np.stack([cv2_resize_with_pad(input_image, self.IMAGE_SIZE, interpolation=cv2.INTER_LINEAR)[0]
                                     for input_image in input_images] ).astype(np.float32)
        input_images     = np.expand_dims(np.transpose(input_images, [0,3,1,2]), axis=1)
        input_poses      = np.expand_dims(np.stack(input_poses).astype(np.float32), axis=1)
        input_intrinsics = np.expand_dims(np.stack(input_intrinsics).astype(np.float32), axis=1)
        #intrinsics, turn into pixels
        input_intrinsics = input_intrinsics/(10*pixel_sizes[0])#FIXME: frames, also dont get the 10*
        input_intrinsics[:, :, 2, 2] = 1
        #poses, they take the reference camera as world cs
        input_poses = [np.linalg.inv(np.linalg.inv(input_poses[0])@input_pose) for input_pose in input_poses]#scale of pose?

        #pass into input prepared
        inputs_prepared = self.model.input_adapter(input_images, 0, poses=input_poses, intrinsics=input_intrinsics)

        #run forward
        pred = self.model(**inputs_prepared)
        depth_map = pred[0]["depth"][0][0].cpu().detach().numpy()
        depth_uncertainty = pred[0]["depth_uncertainty"][0][0].cpu().detach().numpy()

        #resize to input
        if self.DO_RESIZE:
            depth_map, _ = cv2_resize_with_pad(depth_map,  self.IMAGE_SIZE)

        # # #FIXME: no metadata and depth size?!
        # from mrrs.core.ios import open_exr, save_exr
        # import cv2
        # import numpy as np
        # mr_depth, _ = open_exr("c:\Dev\MRRS\mrrs\deep_mvs\\robust_mvd\\robustmvd\MeshroomCache\DepthMapTransform\\05403a7a07c7e111c41bc70994fb65a0f2c6cba0\\1971036266_depthMap.exr")
        # rmvd_depth, _ = open_exr("c:\Dev\MRRS\mrrs\deep_mvs\\robust_mvd\\robustmvd\MeshroomCache\DeepMVS\\34fbb55b45bea504229d9b62f717b044c2005edf\\1971036266_depthMap.exr")
        # mr_depth_rs = cv2.resize(mr_depth[:,:,0], [rmvd_depth.shape[1], rmvd_depth.shape[0]])

        # valid  = mr_depth_rs>0
        # valid &= np.abs(rmvd_depth[:,:,0]-mr_depth_rs)<0.1

        # ratios = (rmvd_depth[:,:,0]/mr_depth_rs)
        # ratio = np.median(ratios[valid])

        # X = rmvd_depth[valid].flatten()
        # Y = mr_depth_rs[valid].flatten()
        # a, b = np.linalg.lstsq(np.vstack([X,np.ones(len(X))]).T, Y, rcond=None)[0]

        # import matplotlib.pyplot as plt
        # plt.plot(X, Y, 'o', markersize=1)
        # plt.plot(X, a*X + b, 'r')
        # plt.plot(X, ratio*X, 'g')
        # plt.show()

        # save_exr(mr_depth_rs, 'c:\Dev\MRRS\\mr_depth.exr', data_type="depth")
        # save_exr(rmvd_depth, 'c:\Dev\MRRS\\rmvd_depth.exr', data_type="depth")
        # save_exr(np.abs(rmvd_depth[:,:,0]-mr_depth_rs), 'c:\Dev\MRRS\\diff.exr', data_type="depth")


        return depth_map, depth_uncertainty

    @staticmethod
    def export_model():
        """
        Will export the model to onnx, requires to install the robsut multiview depth repo and onnx.
        """
        import rmvd
        import torch
        model = rmvd.create_model("robust_mvd")
        dummy_images = np.zeros([11, 1, 3, 384, 576])
        dummy_poses = np.zeros([11, 4, 4])
        dummy_intrinsics = np.zeros([11, 3,3])
        dummy_keyview_idx = 0
        #forward once
        pred, aux = model.run((dummy_images, dummy_poses, dummy_intrinsics, dummy_keyview_idx))
        # Export the model
        torch.onnx.export(model, (dummy_images, dummy_poses, dummy_intrinsics, dummy_keyview_idx), "model.onnx")#FIXME: not working

if __name__ == "__main__":
    RobustMVDWrapper.export_model()
# %%
