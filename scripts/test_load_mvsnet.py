import numpy as np
from mrrs.core.ios import *
from mrrs.core.geometry import *
import os

def scan_scene(scene_folder):
    scenes_image = [os.path.join(scene_folder,"blended_images", file_name) for file_name in os.listdir(os.path.join(scene_folder,"blended_images")) if not file_name.endswith("_masked.jpg")]
    scenes_depth = [os.path.join(scene_folder,"cams", file_name) for file_name in os.listdir(os.path.join(scene_folder,"cams")) if file_name.endswith("_cam.txt") ]
    scenes_calib = [os.path.join(scene_folder,"rendered_depth_maps", file_name) for file_name in os.listdir(os.path.join(scene_folder,"rendered_depth_maps")) if file_name.endswith(".pfm")]
    #TODO: sanity check
    return scenes_image, scenes_depth, scenes_calib

def save_obj(file, scene_points, colors):
    with open(file, 'w') as objfile:
        for p,c in zip(scene_points, colors):
            objfile.write("v "+' '.join(map(str, p))+" "+' '.join(map(str, c))+"\n") #meshlab format support adding colors right after the vertex

if __name__=="__main__":
    test_dataset_path = "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1"
    scenes_images, scenes_calibs, scenes_depths = scan_scene(test_dataset_path)

    for f in range(len(scenes_images)):
        print(scenes_images[f])

        #open view #middle of image is 384 and 288 IRL...
        gt_extrinsic, gt_intrinsic = open_txt_calibration(scenes_calibs[f])
        if f==8:
            print(gt_intrinsic)
            print(gt_extrinsic)
        depth_map_gt = open_depth_map(scenes_depths[f])
        colors = open_image(scenes_images[f]).reshape([-1,3])/255
        #get projections
        ys, xs = np.meshgrid(   range(0, depth_map_gt.shape[0]), \
                                range(0, depth_map_gt.shape[1]), \
                                indexing="ij")#meshgrid
        xs=xs.reshape([-1])
        ys=ys.reshape([-1])
        pixels = np.stack([xs, ys], axis=-1)
        Zs = depth_map_gt.flatten()#vectorise depth map
        pixel_homo = make_homogeneous(pixels)
        ray_camera_cs = np.transpose(np.matmul(np.linalg.inv(gt_intrinsic[0:3,0:3]), np.transpose(pixel_homo)))#the deprojection in camera cs
        XYZ_cam=ray_camera_cs*np.expand_dims(Zs, -1)#project to z plane
        gt_extrinsic=np.linalg.inv(gt_extrinsic)
        XYZ_world = np.transpose(np.matmul(gt_extrinsic,np.transpose(make_homogeneous(XYZ_cam))))#pass into world cs (supposed to be invere extrinsic?)
        scene_points=unmake_homogeneous(XYZ_world)
        #save as obj
        save_obj("camera_projection_%d.obj"%f, scene_points, colors)

        print("%d done"%f)