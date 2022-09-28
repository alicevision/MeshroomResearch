
import glob
import logging
import os
import random
import json

import cv2
import numpy as np
import tensorflow as tf

from mrrs.core.ios import open_depth_map, open_image
from mrrs.core.utils import listdir_fullpath
from mrrs.core.geometry import EPSILON

#%% Data generator
def scan_meshroom_dataset(input_folder):
    """
    Generator funciton returning <depth>, <depth_gt>, <image> file paths from a directory of computed meshrom projects.
    The directory must be
    <meshroom_dir>
        <meshroom_project>
            <MeshroomCache>
                <DepthMapComparison>
                    <.*>
                 <PrepareDenseScene>
                    <.*>
    /!\ If PrepareDenseScene contains multiple runs, all will be selected and the order not garanteed.
    So better have only one. However if DepthMapComparison contains multiple folder, only the first will be selected.
    """
    scenes = [directory for directory in listdir_fullpath(input_folder) if os.path.isdir(directory)]
    logging.info("%d scenes found"%len(scenes))
    for scene in scenes:
        logging.info(scene+":")
        images =        glob.glob(os.path.join(scene,'MeshroomCache', 'PrepareDenseScene', '*', '*.exr'))
        logging.info("%d images found"%len(images))
        view_ids = [os.path.basename(x)[:-4] for x in images]
        if not os.path.exists(os.path.join(scene,'MeshroomCache', 'DepthMap')):
            logging.warn("Issue with scene "+scene+". No DepthMap folder. SKipping.")
            continue
        if not os.path.exists(os.path.join(scene,'MeshroomCache', 'BlendedMVGDataset')):
            logging.warn("Issue with scene "+scene+". No BlendedMVGDataset folder. SKipping.")
            continue

        #get folder of depth maps corresponding to depth maps from gt poses
        depth_maps_subfolders = listdir_fullpath(os.path.join(scene,'MeshroomCache', 'DepthMap'))#should return 2
        if len(depth_maps_subfolders)!=2:
            print("!! Invalid nb Depthmap nodes found (should be 2")
        depth_maps_subfolder = None
        for depth_maps_subfolder in depth_maps_subfolders:
            json_status = json.load(open(os.path.join(depth_maps_subfolder, "0.status"), "r"))#FIXME: hardcoded
            if json_status["nodeName"] == "DepthMap_5":#FIXME: hardcoded
                break
        # print("Estimatied depth map folder "+depth_maps_subfolder)
        depth_maps =    [os.path.join(depth_maps_subfolder, view_id+'_depthMap_refinedFused.exr') for view_id in view_ids]

        depth_maps_gt_subfolders = listdir_fullpath(os.path.join(scene,'MeshroomCache', 'BlendedMVGDataset'))#should only be one
        if len(depth_maps_gt_subfolders)>1:
            print("!! severeal Blendedmvg nodes found")
        depth_maps_gt_subfolder = depth_maps_gt_subfolders[0]
        depth_maps_gt = [os.path.join(depth_maps_gt_subfolder, view_id+'_depthMap.exr') for view_id in view_ids]
        if len(depth_maps) != len(depth_maps_gt):
            print("Mismatching number of depth maps for "+scene+", skipping")
            continue
        if len(depth_maps)==0:
            print("Empty sequence for "+scene+", skipping")
            continue

        for depth_map, depth_map_gt, image in zip(depth_maps, depth_maps_gt, images):
            if not os.path.exists(depth_map):
                logging.warn("Issue with view "+image+": no depth map found "+depth_map+" Skipping.")
                continue
            if not os.path.exists(depth_map_gt):
                logging.warn("Issue with view "+image+": no gt depth map found "+depth_map_gt+" Skipping.")
                continue
            yield depth_map, depth_map_gt, image

def open_meshroom_training_sample(depth_map_path, depth_map_gt_path, image_path, resize_gt):
    """
    Will open the 3 files.
    """
    depth = open_depth_map(depth_map_path)
    depth_gt = open_depth_map(depth_map_gt_path)
    image = open_image(image_path)
    image = np.flip(cv2.resize(image, [depth.shape[1], depth.shape[0]]), axis=-1)#FIXME: flip because opencv check normal
    if resize_gt:
        depth_gt = np.expand_dims(cv2.resize(depth_gt, [depth.shape[1], depth.shape[0]]), axis=-1)
    return (depth, image[:,:,0:3]), depth_gt

def training_generator(input_folder):
    """
    Generator function that opens directy the meshroom depth and imge files.
    Creates and opens outputs from scan_meshroom_dataset.
    """
    scanned_files = list(scan_meshroom_dataset(input_folder))#preloads that as it is not too memory expensive
    for depth_map_path, depth_map_gt_path, image_path in scanned_files: #scan_meshroom_dataset(input_folder):
        yield open_meshroom_training_sample(depth_map_path, depth_map_gt_path, image_path)

class TrainingGenerator:
    """
    Generator function that opens directy the meshroom depth and imge files.
    Class that is both a callable to be used in tf dataset or in keras.fit
    """
    def __init__(self, input_folder, shuffle_scenes=True, resize_gt = False):#add shufle here?
        self.scanned_files = list(scan_meshroom_dataset(input_folder))#preloads that as it is not too memory expensive
        if shuffle_scenes:
            random.seed(10)#FIXME; hardcoded seed
            random.shuffle(self.scanned_files)#shuffles inplace along all scenes
        self.dataset_length = len(self.scanned_files)
        self.resize_gt  = resize_gt

    def __len__(self):#usefull to know the total length
        return self.dataset_length

    def __call__(self):#for usage in tensroflwo dataset from generator
        return self.__iter__()

    def __iter__(self):#for usage in python generator
        for depth_map_path, depth_map_gt_path, image_path in self.scanned_files:
            yield open_meshroom_training_sample(depth_map_path, depth_map_gt_path, image_path, self.resize_gt)

    def __getitem__(self, idx):#usefull for debug
        depth_map_path, depth_map_gt_path, image_path = self.scanned_files[idx]
        return open_meshroom_training_sample(depth_map_path, depth_map_gt_path, image_path, self.resize_gt)

#%% Funcitons to be used with map
def assert_all_finite(depth_image, depth_gt):
    """
    Make sure the items from the dataset are ok.
    """
    (depth, image)=depth_image
    tf.debugging.assert_all_finite(depth, "invalid number in depth")
    tf.debugging.assert_all_finite(image, "invalid number in image")
    tf.debugging.assert_all_finite(depth_gt, "invalid number in depth_gt")
    return (depth, image), depth_gt


# def normalise_depth(depth, gt_depth, image):
#     """
#     normalise depth data between 0 and 1, using the valid parts of the ground truth
#     """
#     valid_depth = gt_depth>0
#     min=tf.reduce_min(depth[valid_depth])
#     max=tf.reduce_max(depth[valid_depth])
#     tf.debugging.assert_all_finite(min, "invalid number in min")
#     tf.debugging.assert_all_finite(max, "invalid number in max")#FIXME: nan wuuut
#     tf.debugging.assert_none_equal(min, max)#sanity check
#     valid_depth = tf.cast(valid_depth, dtype=tf.float32)
#     tf.debugging.assert_all_finite(valid_depth, "invalid number in valid_depth")
#     #add epsilon to avoid /0, also keep 0 as invalid value
#     depth=(valid_depth*(depth-min+EPSILON))/(max-min+EPSILON)
#     gt_depth=(valid_depth*(gt_depth-min+EPSILON))/(max-min+EPSILON)
#     # tf.debugging.assert_all_finite(depth, "invalid number in depth")
#     # tf.debugging.assert_all_finite(gt_depth, "invalid number in gt_depth")
#     return depth, gt_depth, image

def invert_depth(depth_image, gt_depth, ):
    """
    Invert the depth and the gt depth to reason in 1/d
    """
    depth = depth_image[0]
    valid_depth = depth>0
    valid_gt_depth = gt_depth>0
    depth[valid_depth]=1/depth[valid_depth]#FIXME: not working?
    gt_depth[valid_gt_depth]=1/gt_depth[valid_gt_depth]
    return (depth, depth_image[1]), gt_depth
