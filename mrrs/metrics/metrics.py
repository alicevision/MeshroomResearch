import logging
from mrrs.core.geometry import EPSILON, nearest_neighbors, rescale_depth
import numpy as np
import cv2

##http://ylatif.github.io/papers/IROS2016_ccadena.pdf
#log scale rsme
#accuracy under threshold
#coverage
#ssim psnr?

#FIXME: class metric with __call__ and description or enum
#FIXME: move into a metric package and split into depth, calib and mesh metrics
#TODO: add ssim and psnr

#%% Depth metrics
def RMSE(depth_map, gt_depth_map, mask):
    """
    Residual mean square error between two depth maps.
    """
    squared_diff = (depth_map-gt_depth_map)**2
    if mask is not None:
        squared_diff *= (1-mask)
    return np.sqrt(np.mean(squared_diff)), squared_diff

def MAE(depth_map, gt_depth_map, mask):
    """
    Mean aveerage error between two depth maps.
    """
    absolute_diff = np.abs(depth_map - gt_depth_map)
    if mask is not None:
        absolute_diff *= (1-mask)
    return np.mean(absolute_diff), absolute_diff

def validity_ratio(depth_map, gt_depth_map, mask):
    """
    Compute the ammount of valid depth pixel on the gt and predicted.
    """
    print(np.count_nonzero(1-mask))
    print(depth_map.shape)
    percentage_valid =100*np.count_nonzero(1-mask)/np.prod(depth_map.shape)
    return percentage_valid, None

# def PSRM(depth_map, gt_depth_map, mask):
#     # img1 and img2 have range [0, 255]
#     img1 = img1.astype(np.float64)
#     img2 = img2.astype(np.float64)
#     mse = np.mean((img1 - img2)**2)
#     if mse == 0:
#         return float('inf')
#     return 20 * math.log10(255.0 / math.sqrt(mse))

#https://cvnote.ddlee.cc/2019/09/12/psnr-ssim-python
# def SSIM():
#     pass

def compute_depth_metric(depth_map, gt_depth_map, metric,
                         auto_resize=False, auto_rescale=False,
                         mask_value=None):
    """
    Computes the differences bewteen two depth maps using the passed metric.
    If auto_resize is true, will resize the gt depth map to the size of the depth map.
    If auto_rescale, will look for a depth factor bewteen the two depth map and rescale gt depth map.
    If mask_value is != None, will consider pixels with corresponding values as invalid.
    The output depth maps are the ground truth ones.
    """
    try:
        metric_function = eval(metric)
    except:
        raise BaseException("Issue with metric "+metric+": not a defined metric")
    if len(gt_depth_map.shape)>2:
        gt_depth_map = gt_depth_map[:,:,0]
    if len(depth_map.shape)>2:
        depth_map =  depth_map[:,:,0]
    if auto_resize:
        #depth_map = cv2.resize(depth_map, dsize=[gt_depth_map.shape[1], gt_depth_map.shape[0]], interpolation=cv2.INTER_NEAREST)
        gt_depth_map = cv2.resize(gt_depth_map, dsize=[depth_map.shape[1], depth_map.shape[0]], interpolation=cv2.INTER_NEAREST)
    mask = None
    if mask_value is not None:#mask out all invalid values in depth gt and depth TODO: make list, separate to two?
        mask_depth_gt = gt_depth_map<=mask_value
        mask_gt = depth_map<=mask_value
        mask = mask_depth_gt|mask_gt
    if auto_rescale:
        #depth_map = rescale_depth(depth_map, gt_depth_map)
        gt_depth_map, scale = rescale_depth(gt_depth_map, depth_map, mask)
        logging.info("Rescaling gt with "+str(scale))
    metric_value, metric_per_pixel = metric_function(depth_map, gt_depth_map, mask)
    return metric_value, metric_per_pixel, gt_depth_map

#%% Calib metrics
def MSECameraCenter(extrinsic, intrinsic, gt_extrinsic, gt_intrinsic):
    """
    Mean square error between camera centers.
    """
    return np.mean(np.sqrt(np.sum((extrinsic[:,3]-gt_extrinsic[:,3])**2)))

def AngleBetweenRotations(extrinsic, intrinsic, gt_extrinsic, gt_intrinsic):
    """
    Returns the angle between two rotation matrices in deg.
    """
    rotation_matrix = extrinsic[0:3,0:3].transpose()@gt_extrinsic[0:3,0:3]
    rotation_trace = np.trace(rotation_matrix)
    theta = np.clip((rotation_trace-1)/2, -1,1)#clip because of numerical imprecision
    axis_angle = np.rad2deg(np.arccos(theta))
    return axis_angle

def MSEFocal(extrinsic, intrinsic, gt_extrinsic, gt_intrinsic):
    """
    Mean square error between camera focals.
    """
    return np.mean(np.sqrt(np.sum( [(intrinsic[0,0]-gt_intrinsic[0,0])**2,(intrinsic[1,1]-gt_intrinsic[1,1])**2] )))

def MSEPrincipalPoint(extrinsic, intrinsic, gt_extrinsic, gt_intrinsic):
    """
    Mean square error between principal points.
    """
    return np.mean(np.sqrt(np.sum((intrinsic[0:2,2]-gt_intrinsic[0:2,2])**2)))

def validCams(extrinsic, intrinsic, gt_extrinsic, gt_intrinsic):
    """
    Return if the camera is valid or not
    """
    return 1 if extrinsic is not None else 0

def compute_calib_metric(metric, extrinsic, intrinsic, gt_extrinsic, gt_intrinsic):
    """
    Computes the differences bewteen two calibrations using the passed metric.
    """
    try:
        metric_function = eval(metric)
    except:
        raise RuntimeError("Issue with metric "+metric+": not a defined metric")
    result = metric_function(extrinsic, intrinsic, gt_extrinsic, gt_intrinsic)
    if np.isnan(result):
        raise RuntimeError("Compute metric returned nan")
    return result

#%%Mesh metrics

def chamfer_distance(point_set_0, point_set_1, bidirectional = True):
    """Chamfer distance between two point clouds
    point_set_0 an array NxD the first point cloud
    point_set_1: an array MxD the second point cloud
    Return the Chamfer from point_set_0 to point_set_1 distance:
    sum_{x_i \in point_set_0}{\min_{y_j \in point_set_1}{||x_i-y_j||**2}}
    if bidirectional is true, returns the bidirectional champfer distance:
    sum_{x_i \in point_set_0}{\min_{y_j \in point_set_1}{||x_i-y_j||**2}} + sum_{y_j \in point_set_1}{\min_{x_i \in point_set_0}{||x_i-y_j||**2}}
    """
    _,  min_dist_point_set_0_to_1 = nearest_neighbors(point_set_0, point_set_1, nb_neighbors=1)
    chamfer_dist = np.mean(min_dist_point_set_0_to_1)
    if bidirectional:
        _,  min_dist_point_set_1_to_0 = nearest_neighbors(point_set_1, point_set_0, nb_neighbors=1)
        chamfer_dist += np.mean(min_dist_point_set_1_to_0)
    return chamfer_dist