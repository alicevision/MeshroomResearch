"""
This nodes opens data from OpenMVGDataset.
It either bypasses the CameraInit node or takes an sfm data to add the depth and poses.
It will create its own .sfm and create a ground truth depth map folder.
"""
__version__ = "3.0"

import os
import json
import re

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *

#FIXME: move this into a reality capture folder
def parse_xmp(xmp_file):
    """
    Parses the xmp from reality capture.
    """
    with open(xmp_file) as f:
        xmp_lines = " ".join(f.readlines())
        camera_center = re.search("<xcr:Position>(.*)</xcr:Position>", xmp_lines)
        rotation_matrix = re.search("<xcr:Rotation>(.*)</xcr:Rotation>", xmp_lines)
        principal_point_u = re.search("PrincipalPointU=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        principal_point_v = re.search("PrincipalPointV=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        focalLength_35mm = re.search("xcr:FocalLength35mm=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        if camera_center is None or rotation_matrix is None or principal_point_u is None or principal_point_v is None or focalLength_35mm is None:
            return None, None
        # DistortionCoeficients InMeshing
        camera_center = np.asarray(camera_center.group(1).split(" "), dtype=np.float32)
        rotation_matrix = np.asarray(rotation_matrix.group(1).split(" "), dtype=np.float32).reshape([3,3])
        principal_point_u = np.asarray(principal_point_u.group(1).split(" "), dtype=np.float32)
        principal_point_v =np.asarray(principal_point_v.group(1).split(" "), dtype=np.float32)
        focalLength_35mm = np.asarray(focalLength_35mm.group(1).split(" "), dtype=np.float32)
        #TODO if needed, xcr:DistortionModel="brown3" xcr:Skew="0" xcr:AspectRatio="1"
        intrinsics=np.zeros([3,3])
        extrinsics=np.zeros([4,4])
        intrinsics[0,0]=focalLength_35mm
        intrinsics[1,1]=focalLength_35mm
        intrinsics[1,2]=principal_point_u
        intrinsics[0,2]=principal_point_v
        intrinsics[2,2]=1
        extrinsics[0:3,0:3]=rotation_matrix
        extrinsics[0:3,3]=camera_center
        extrinsics[3,3]=1

        return extrinsics, intrinsics

def open_calibration(scenes_calibs, dataset_type):
    #opening corresponding ground truth calibration matrix form
    gt_extrinsics = []
    gt_intrinsics = []
    for calib_gt_file in scenes_calibs:
        if dataset_type == "blendedMVG":
            gt_extrinsic, gt_intrinsic = open_txt_calibration(calib_gt_file)
            gt_extrinsics.append(gt_extrinsic)
            gt_intrinsics.append(gt_intrinsic)
        elif dataset_type == "realityCapture":
            if os.path.exists(calib_gt_file):
                extrinsics, intrinsics = parse_xmp(calib_gt_file)
                if extrinsics is None:
                    print("Invalid XMP "+calib_gt_file)
                gt_extrinsics.append(extrinsics)
                gt_intrinsics.append(intrinsics)
            else:#some views may have been skipped
                gt_extrinsics.append(None)
                gt_intrinsics.append(None)
    return gt_extrinsics, gt_intrinsics

class Dataset(desc.Node):
    category = 'Meshroom Research'

    documentation = '''Util node to open datasets from the images in the .sfm, assumes a file structure depending on the dataset.'''

    size = desc.DynamicNodeSize('sfmData')

    inputs = [

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.ChoiceParam(
            name='datasetType',
            label='Dataset Type',
            description='''Dataset type''',
            value='blendedMVG',
            values=['blendedMVG', 'realityCapture'],
            exclusive=True,
            uid=[0],
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
            value=os.path.join(desc.Node.internalFolder,'depth_maps'),
            uid=[],
        ),

        desc.File(
            name='depthmaps',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,'depth_maps') + '<VIEW_ID>.exr',
            uid=[],
            group='', # do not export on the command line
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.sfmData.value=='':
            chunk.logger.warning('No input InputFolder or sfmData in node blendMVGDataset, skipping')
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
            #TODO: make fc
            chunk.logger.info("Starts to load data from sfmdata")
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
                basename = os.path.basename(scene_image)[:-4]#FIXME: not great, use split
                if chunk.node.datasetType.value == "blendedMVG":
                    scenes_calib = os.path.join(folder,"..","cams", basename+"_cam.txt")
                    scenes_depth  =  os.path.join(folder,"..","rendered_depth_maps",basename+".pfm")
                elif chunk.node.datasetType.value == "realityCapture":
                    scenes_calib = os.path.join(folder,"..","calib",basename+".xmp")
                    scenes_depth = os.path.join(folder,"..","depths",basename+".jpg.depth.exr")#FIXME: no gt

                scenes_images.append(scene_image)
                scenes_calibs.append(scenes_calib)
                scenes_depths.append(scenes_depth)
                poses_id.append(pose_id)
                calibs_id.append(calib_id)
                views_id.append(view_id)
            images_sizes = [Image.open(image).size for image in scenes_images]

            chunk.logManager.start("Exporting calibration")
            gt_extrinsics, gt_intrinsics= open_calibration(scenes_calibs, chunk.node.datasetType.value)

            #camera representation convertion
            #TODO: make fc
            sensor_size = 1
            if chunk.node.datasetType.value == "blendedMVG":
                #only change with meshroom is the pose world to cam vs cam to world
                gt_extrinsics = [None if e is None else np.linalg.inv(e) for e in gt_extrinsics]
            elif chunk.node.datasetType.value == "realityCapture":
                nb_invalid = 0
                sensor_size = 35
                for e in gt_extrinsics:
                    if e is not None:
                        #R-1 and R-1.-T, needed to reuse sfm_data_from_matrices
                        e[0:3,0:3] = np.linalg.inv(e[0:3,0:3])
                        #camera centers are not in the same unit as the focal =>/10
                        #transform the camera center to match the 36mm to unit focal transform
                        # e[0:3, 3]/=3.5
                        # 3.41752
                    else:
                        nb_invalid+=1
                chunk.logger.info("%d invalid calibs"%nb_invalid)
                #sensor with is equivalent 35mm in RC

                for i, image_size in zip(gt_intrinsics, images_sizes):
                    if i is not None:
                        #pass into focal from sensor with unit width, as in meshroom with not init
                        # RC assumes the 24×36 mm film format, we use unit sensor width
                        # i[0,0]/=35
                        # i[1,1]/=35
                        # print(i[0,0])
                        # #pixel size assuming unit sensor
                        # pixel_size = 1/image_size[0]
                        # #pass into focal in pixel units to be like blended mvsnet (even thougt we remove it later)
                        # i[0,0]/=pixel_size
                        # i[1,1]/=pixel_size

                        #convert focal in pixels
                        pixel_size = sensor_size/image_size[0]
                        i[0,0]*=pixel_size
                        i[1,1]*=pixel_size

                        #convert principal point in pixels https://support.capturingreality.com/hc/en-us/community/posts/115002199052-Unit-and-convention-of-PrincipalPointU-and-PrincipalPointV
                        #dimentionless because already /35
                        i[0,2] = image_size[0]/2#image_size[0]/2-i[0,2]/pixel_size
                        i[1,2] = image_size[1]/2#image_size[1]/2-i[1,2]/pixel_size




            gt_sfm_data = sfm_data_from_matrices(gt_extrinsics, gt_intrinsics, poses_id,
                                                 calibs_id, images_sizes, sfm_data, sensor_size)
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
            os.makedirs(chunk.node.outputGroundTruthdepthMapsFolder.value, exist_ok=True)
            for view_id, gt_depth, gt_extrinsic, gt_intrinsic in zip(views_id, scenes_depths, gt_extrinsics, gt_intrinsics):
                if os.path.exists(gt_depth):
                    depth_map_gt = open_depth_map(gt_depth)
                else:
                    continue
                #compute projection matrices for meshroom
                camera_center = gt_extrinsic[0:3,3]
                inverse_intr_rot = np.linalg.inv(gt_intrinsic@np.linalg.inv(gt_extrinsic[0:3,0:3]))
                #https://openimageio.readthedocs.io/en/v2.4.6.1/imageoutput.html
                depth_meta = {"AliceVision:CArr":camera_center,
                              "AliceVision:iCamArr":inverse_intr_rot, "AliceVision:downscale":1} #TOTEST
                depth_meta={}

                #save exr
                save_exr(depth_map_gt, os.path.join(chunk.node.outputGroundTruthdepthMapsFolder.value, str(view_id)+"_depthMap.exr"),#FIXME: harcoded names
                        data_type="depth", custom_header=depth_meta)

            chunk.logger.info('Dataset loading ends')
        finally:
            chunk.logManager.end()



