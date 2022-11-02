"""
This nodes opens data from OpenMVGDataset.
It either bypasses the CameraInit node or takes an sfm data to add the depth and poses.
It will create its own .sfm and create a ground truth depth map folder.
"""
__version__ = "3.0"

import os
import json

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *

def scan_scenes(input_folder):
    """
    Scans all folders in a given folder (ie a scene).
    Returns the scenes names and full path
    """
    scenes_names = os.listdir(input_folder)
    scenes_path = [os.path.join(input_folder, scene_name) for scene_name in scenes_names]
    return scenes_names, scenes_path

def scan_blendedMVG_scene(scene_folder):
    """
    Will returns the paths for images, calibration and depth maps for the openmvg dataset.
    """
    scenes_image = [os.path.join(scene_folder,"blended_images", file_name)
                    for file_name in os.listdir(os.path.join(scene_folder,"blended_images"))
                    if not file_name.endswith("_masked.jpg")]
    scenes_depth = [os.path.join(scene_folder,"cams", file_name)
                    for file_name in os.listdir(os.path.join(scene_folder,"cams"))
                    if file_name.endswith("_cam.txt") ]
    scenes_calib = [os.path.join(scene_folder,"rendered_depth_maps", file_name)
                    for file_name in os.listdir(os.path.join(scene_folder,"rendered_depth_maps"))
                    if file_name.endswith(".pfm")]
    if not (len(scenes_image) == len(scenes_depth) == len(scenes_calib)):
        raise RuntimeError("Mismatch in number of images for scene "+scene_folder)
    return scenes_image, scenes_depth, scenes_calib

class BlendedMVGDataset(desc.Node):#FIXME: abstract this Dataset, scan folder etc...?

    category = 'Meshroom Research'

    documentation = '''Util node to open blendedMVG data https://github.com/YoYo000/BlendedMVS'''

    inputs = [
        desc.File(
            name="blendedMVGFolder",
            label="blendedMVG Folder",
            description="Input root folder for blendedMVG",
            value="",
            uid=[0],
        ),

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData for blendedMVG images",
            value="",
            uid=[0],
        ),

        #FIXME: find a solution for this
        desc.IntParam(
            name='sceneId',
            label='Scene Number',
            description='Scene index to run on',
            value=0,
            range=(0, 100000),
            uid=[0],
            advanced=True,
            enabled= lambda node: node.byPass.enabled and not node.byPass.value,
        ),

        desc.BoolParam(
            name='initIntrinsics',
            label='Initalize intrinsics',
            description='''Will initialise the focal and sensor size with groud truth''',
            value=False,
            uid=[0],
        ),

        desc.StringParam(
            name='permutationMatrix',
            label='Permutation Matrix',
            description='''Permutation matrix used on the camera intrinsic''',
            value='[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]',
            uid=[0],
        ),

        desc.BoolParam(
            name='inverse',
            label='inverse',
            description='''Will inverse extrinsic''',
            value=False,
            uid=[0],
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfMDataCameraInit',
            label='SfMData CameraInit',
            description='Path to the output sfmdata file, with no calibration informations',
            value=desc.Node.internalFolder + 'sfm_camerainit.sfm',
            uid=[],
        ),#FIXME: do we really need this?

        desc.File(
            name='outputSfMData',
            label='SfMData',
            description='Path to the output sfmdata file',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        ),

        desc.File(
            name='outputGroundTruthdepthMapsFolder',
            label='Output groud truth depth map',
            description='Output folder for generated results.',
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if (chunk.node.blendedMVGFolder.value=='') and (chunk.node.sfmData.value==''):
            chunk.logger.warning('No input blendedMVGFolder or sfmData in node blendMVGDataset, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return
            if chunk.node.blendedMVGFolder.value != '':
                chunk.logger.info("Starts to load blendedMVG from folder")
                scenes_names, scenes_path = scan_scenes(chunk.node.blendedMVGFolder.value)
                # chunk.node.sceneId.values = scenes_names
                # chunk.node.sceneId.updateInternals()
                # chunk.node.sceneId.value = scenes_names[0]#FIXME need refresh? also how to update display
                chunk.logger.info("%d scenes found"%len(scenes_names))
                (scenes_images, scenes_calibs,
                scenes_depths) = scan_blendedMVG_scene(scenes_path[(int(chunk.node.sceneId.value))])
                chunk.logger.info("Running on "+scenes_path[(int(chunk.node.sceneId.value))])
                #creating views in sfm
                images_sizes = [Image.open(image).size for image in scenes_images]
                sfm_data = {}
                sfm_data["version"]=["1","2","2"]#FIXME: hardcoded
                sfm_data["views"]=[]
                for image_index, (image, depth, images_size) in enumerate(zip(scenes_images, scenes_depths, images_sizes)) :
                    view = {"viewId":str(image_index),
                            "poseId": str(image_index),  "frameId": str(image_index),
                            "intrinsicId": str(image_index), "path":  image,
                            "width": str(images_size[0]), "height": str(images_size[1]),
                            #"groudtruthDepth":depth
                            }
                    sfm_data["views"].append(view)
                views_id = range(len(scenes_images))
                poses_id = range(len(scenes_images))
                calibs_id = range(len(scenes_images))
            elif chunk.node.sfmData.value:
                chunk.logger.info("Starts to load blendedMVG from sfmdata")
                sfm_data = json.load(open(chunk.node.sfmData.value, "r"))
                scenes_images = []
                scenes_calibs = []
                scenes_depths= []
                poses_id = []
                calibs_id = []
                views_id =  []
                for view in sfm_data["views"]:
                    view_id = view["viewId"]
                    scene_image = view["path"]
                    pose_id = view["poseId"]
                    calib_id = view["intrinsicId"]
                    folder = os.path.dirname(scene_image)
                    basename = os.path.basename(scene_image)[:-4]
                    # if basename.endswith("_masked"):#FIXME: we removed this, also misses the extnetion
                    #     basename=basename[:-7]
                    scenes_calib = os.path.join(folder,"..","cams",basename+"_cam.txt")
                    scenes_depth  =  os.path.join(folder,"..","rendered_depth_maps",basename+".pfm")
                    scenes_images.append(scene_image)
                    scenes_calibs.append(scenes_calib)
                    scenes_depths.append(scenes_depth)
                    poses_id.append(pose_id)
                    calibs_id.append(calib_id)
                    views_id.append(view_id)
                images_sizes = [Image.open(image).size for image in scenes_images]

            chunk.logManager.start("Exporting calibration")
            #opening corresponding ground truth calibration matrix form
            gt_extrinsics = []
            gt_intrinsics = []
            for calib_gt_file in scenes_calibs:
                gt_extrinsic, gt_intrinsic = open_txt_calibration(calib_gt_file)
                gt_extrinsics.append(gt_extrinsic)
                gt_intrinsics.append(gt_intrinsic)
            #stack to np arrays for convenience
            gt_extrinsics = np.stack(gt_extrinsics, axis=0)
            gt_intrinsics = np.stack(gt_intrinsics, axis=0)
            #exporting GT calib to sfm format
            #Note, mvsnet and meshroom store in camera to world and world to cam respectively
            gt_extrinsics = np.linalg.inv(gt_extrinsics)
            gt_sfm_data = sfm_data_from_matrices(gt_extrinsics, gt_intrinsics, poses_id,
                                                 calibs_id, images_sizes, sfm_data)
            #adding gt depth
            for view, depth in zip(gt_sfm_data["views"], scenes_depths):
                view["groudtruthDepth"]=depth
            #write new gt sfm file
            chunk.logger.info('Writting sfm')
            with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
                json.dump(gt_sfm_data, f, indent=4)
            #write without pose and with default intrinsic
            with open(os.path.join(chunk.node.outputSfMDataCameraInit.value), 'w') as f:
                if chunk.node.initIntrinsics.value :
                    gt_sfm_data = sfm_data_from_matrices(gt_extrinsics, gt_intrinsics, poses_id,
                                                         calibs_id, images_sizes, sfm_data)
                else:
                    gt_sfm_data = sfm_data_from_matrices(gt_extrinsics, [None for _ in gt_intrinsics], poses_id,
                                                        calibs_id, images_sizes, sfm_data)
                del gt_sfm_data["poses"]
                json.dump(gt_sfm_data, f, indent=4)
            chunk.logManager.start("Exporting depth")
            for view_id, gt_depth, gt_extrinsic, gt_intrinsic in zip(views_id, scenes_depths, gt_extrinsics, gt_intrinsics):
                depth_map_gt = open_depth_map(gt_depth)
                #compute projection matrices for meshroom
                camera_center = gt_extrinsic[0:3,3]
                inverse_intr_rot = np.linalg.inv(gt_intrinsic@np.linalg.inv(gt_extrinsic[0:3,0:3]))
                # depth_meta = {"AliceVision:CArr":[float(f) for f in (camera_center)],
                #              "AliceVision:iCamArr":inverse_intr_rot, "AliceVision:downscale":1} #crashes
                depth_meta = {}
                #save exr
                save_exr(depth_map_gt, os.path.join(chunk.node.outputGroundTruthdepthMapsFolder.value, str(view_id)+"_depthMap.exr"),#FIXME: harcoded names
                        data_type="depth", custom_header=depth_meta)

            chunk.logger.info('Dataset loading ends')
        finally:
            chunk.logManager.end()



