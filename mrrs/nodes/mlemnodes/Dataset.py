"""
This nodes opens data from various dataset.
It will overwrite calibration values in sfm data and add extra values.

It uses the camera init node and relative path to find the corresponding data.
It will create its own .sfm and create a ground truth depth map folder and mesh is applicable.

Specific documentation for OpenMVGDataset:
TODO

Specific documentation for XMP from reality capture:
TODO NOTE: sould be in a node?

Specific documentation for DTU dataset
This following workspace folder structure is needed:
+---DTU_sphere #https://drive.google.com/drive/folders/1qiG2aaNRxlfJ7GscI4LRFJR6icvEY3Jm
|   +---scan24
|       +---images
|       +---mask
|       +---cameras_sphere.npz
|   +---scan...
|       +---images
|       +---mask
|       +---cameras_sphere.npz
+---SampleSet #https://roboimagedata.compute.dtu.dk/?page_id=36
|   +---Matlab evaluation code
|   +---MVS Data
|       +---ObsMask
|           +---ObsMask1_10.mat
|           +---ObsMask..._10.mat
|           +---ObsMask122_10.mat
|           +---Plane1.mat
|           +---Plane....mat
|           +---Plane122.mat
|       +---Points
|           +---stl
|               +---stl001_total.ply
|               +---stl..._total.ply
|               +---stl122_total.ply

"""
__version__ = "3.0"

import os
import json
import re
import cv2
import trimesh

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *

# FIXME: this is becoming a mess, maybe an abstract class Dataset is needed, move to a module also

# FIXME: move this into a reality capture folder
def parse_xmp(xmp_file):
    """
    Parses the xmp from reality capture.
    """
    with open(xmp_file) as f:
        xmp_lines = " ".join(f.readlines())
        camera_center = re.search(
            "<xcr:Position>(.*)</xcr:Position>", xmp_lines)
        rotation_matrix = re.search(
            "<xcr:Rotation>(.*)</xcr:Rotation>", xmp_lines)
        principal_point_u = re.search(
            "PrincipalPointU=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        principal_point_v = re.search(
            "PrincipalPointV=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        focalLength_35mm = re.search(
            "xcr:FocalLength35mm=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        if camera_center is None or rotation_matrix is None or principal_point_u is None or principal_point_v is None or focalLength_35mm is None:
            return None, None
        # DistortionCoeficients InMeshing
        camera_center = np.asarray(
            camera_center.group(1).split(" "), dtype=np.float32)
        rotation_matrix = np.asarray(rotation_matrix.group(
            1).split(" "), dtype=np.float32).reshape([3, 3])
        principal_point_u = np.asarray(
            principal_point_u.group(1).split(" "), dtype=np.float32)
        principal_point_v = np.asarray(
            principal_point_v.group(1).split(" "), dtype=np.float32)
        focalLength_35mm = np.asarray(
            focalLength_35mm.group(1).split(" "), dtype=np.float32)
        # TODO if needed, xcr:DistortionModel="brown3" xcr:Skew="0" xcr:AspectRatio="1"
        intrinsics = np.zeros([3, 3])
        extrinsics = np.zeros([4, 4])
        intrinsics[0, 0] = focalLength_35mm
        intrinsics[1, 1] = focalLength_35mm
        intrinsics[1, 2] = principal_point_u
        intrinsics[0, 2] = principal_point_v
        intrinsics[2, 2] = 1
        extrinsics[0:3, 0:3] = rotation_matrix
        extrinsics[0:3, 3] = camera_center
        extrinsics[3, 3] = 1
        return extrinsics, intrinsics


def open_calibration(scenes_calibs, dataset_type):
    # opening corresponding ground truth calibration matrix form
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
            else:  # some views may have been skipped
                gt_extrinsics.append(None)
                gt_intrinsics.append(None)
    return gt_extrinsics, gt_intrinsics


def open_dtu_calibration(scene_calib_path, frame_ids):
    """Opens camera_sphere.npz file where the ground truth is stored."""
    camera_dict = np.load(scene_calib_path)
    scale_mats = [camera_dict['scale_mat_%d' %
                              idx].astype(np.float32) for idx in frame_ids]
    world_mats = [camera_dict['world_mat_%d' %
                              idx].astype(np.float32) for idx in frame_ids]

    gt_scale_mat = camera_dict['scale_mat_0']

    gt_extrinsics, gt_intrinsics = [], []
    n_images = len(frame_ids)
    for i in range(n_images):
        world_mat = world_mats[i]
        scale_mat = scale_mats[i]
        P = world_mat @ scale_mat
        # P = world_mat
        P = P[:3, :4]
        intrinsics, pose = load_K_Rt_from_P(None, P)

        gt_intrinsics.append(intrinsics)
        gt_extrinsics.append(pose)

    return gt_extrinsics, gt_intrinsics, gt_scale_mat


def load_K_Rt_from_P(filename, P=None):
    if P is None:
        lines = open(filename).read().splitlines()
        if len(lines) == 4:
            lines = lines[1:]
        lines = [[x[0], x[1], x[2], x[3]]
                 for x in (x.split(" ") for x in lines)]
        P = np.asarray(lines).astype(np.float32).squeeze()

    out = cv2.decomposeProjectionMatrix(P)
    K = out[0]
    R = out[1]
    t = out[2]

    K = K/K[2, 2]
    intrinsics = np.eye(4)
    intrinsics[:3, :3] = K

    pose = np.eye(4, dtype=np.float32)
    pose[:3, :3] = R.transpose()
    pose[:3, 3] = (t[:3] / t[3])[:, 0]

    return intrinsics, pose


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
            values=['blendedMVG', 'realityCapture', 'DTU'],
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

        # all of these are used to debug
        desc.StringParam(
            name='permutationMatrix',
            label='Permutation Matrix',
            description='''Permutation matrix used on the camera intrinsic''',
            value='[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]',
            uid=[0],
        ),

        desc.FloatParam(
            name='focalOverwrite',
            label='Focal overwrite',
            description='''Overwrite the focal (needs to be in unit of the sfm)''',
            value=-1.0,
            range=(-1.0, 100.0, 1.0),
            uid=[0],
        ),

        # desc.StringParam(
        #     name='principalPointOverwrite',
        #     label='Principal Point Overwrite',
        #     description='''Overwrite the principal point (need to be a python code). Delta from the center of the image, in pixels.''',
        #     value='',
        #     uid=[0],
        # ),

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
        ),

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
            value=os.path.join(desc.Node.internalFolder, 'depth_maps'),
            uid=[],
        ),

        desc.File(
            name='groundTruthMesh',
            label='Ground Truth Mesh',
            description='Generated mesh.',
            semantic='mesh',
            value=os.path.join(desc.Node.internalFolder,
                               'ground_truth_mesh.obj'),
            uid=[],
            group='',
        ),
        
        desc.File(
            name='transformationMatrix',
            label='Transformation matrix',
            description='Scale matrix from unit sphere to GT.',
            semantic='mesh',
            value=os.path.join(desc.Node.internalFolder,
                               'transformationMatrix.json'),
            uid=[],
            group='',
        ), #FIXME: has to disappear from Dataset, look at NormalizeCameras

        desc.File(#for display
            name='depthmaps',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'depth_maps') + '<VIEW_ID>_depthMap.exr',
            uid=[],
            group='',
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.sfmData.value == '':
            chunk.logger.warning(
                'No input InputFolder or sfmData in node blendMVGDataset, skipping')
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

            chunk.logger.info("Starts to load data from sfmdata")
            # Load SFM data from JSON file
            sfm_data = json.load(open(chunk.node.sfmData.value, "r"))

            # Initialize lists to store scene images, calibrations, depths, pose IDs, calibration IDs, and view IDs
            scenes_images = []
            scenes_calibs = []
            scenes_depths = []
            poses_id = []
            calibs_id = []
            views_id = []

            # Determine the paths to calibration and depth maps based on the dataset type
            for view in sfm_data["views"]:
                view_id = view["viewId"]
                frame_id = view["frameId"]
                scene_image = view["path"]
                pose_id = view["poseId"]
                calib_id = view["intrinsicId"]
                folder = os.path.dirname(scene_image)
                basename = os.path.basename(scene_image)[:-4]#FIXME: not great, use split

                if chunk.node.datasetType.value == "blendedMVG":
                    scenes_calib = os.path.join(
                        folder, "..", "cams", basename + "_cam.txt")
                    scenes_depth = os.path.join(
                        folder, "..", "rendered_depth_maps", basename + ".pfm")
                elif chunk.node.datasetType.value == "realityCapture":
                    scenes_calib = os.path.join(
                        folder, "..", "calib", basename + ".xmp")#FIXME: actually has several intrisinc
                    scenes_depth = os.path.join(
                        folder, "..", "depths", basename + ".jpg.depth.exr")#FIXME: no gt
                elif chunk.node.datasetType.value == "DTU":
                    scenes_calib = int(frame_id)#for dtu, simple index is enough
                    scenes_depth = None

                # Append the data to the respective lists
                scenes_images.append(scene_image)
                scenes_calibs.append(scenes_calib)
                scenes_depths.append(scenes_depth)
                poses_id.append(pose_id)
                calibs_id.append(calib_id)
                views_id.append(view_id)

            # Get sizes of images
            images_sizes = [Image.open(image).size for image in scenes_images]#FIXME: not working with exr

            chunk.logManager.start("Exporting calibration")
            # Open calibrations based on the dataset type
            if chunk.node.datasetType.value == "blendedMVG" or chunk.node.datasetType.value == "realityCapture":
                gt_extrinsics, gt_intrinsics = open_calibration(scenes_calibs, chunk.node.datasetType.value)
            elif chunk.node.datasetType.value == "DTU":
                gt_extrinsics, gt_intrinsics, gt_scale_mat = open_dtu_calibration(
                    os.path.join(folder, "..", "cameras_sphere.npz"), scenes_calibs)
                # Add DTU information to the generated SFM data
                gtPath = os.path.join(folder, "..", "..", "..", "SampleSet","MVS Data")
                scan = int(folder.split('/')[-2].split('scan')[-1])
                sfm_data["groundTruthDTU"] = {"gtPath":gtPath,
                                      "scan":scan,
                                      "stl":os.path.join(gtPath,'Points','stl',f'stl{scan:03}_total.ply'),
                                    #   "obsMask":os.path.join(gtPath,'ObsMask',f'ObsMask{scan}_10.mat'),
                                    #   "groundPlane":os.path.join(gtPath,'ObsMask',f'Plane{scan}.mat'),
                                      "obsMaskFolder":os.path.join(folder,'..','mask'),
                                      "scaleMat":gt_scale_mat.tolist()}
                
                # Save the scale matrix
                with open(os.path.join(chunk.node.transformationMatrix.value), 'w') as f:
                    json.dump({'transform':sfm_data["groundTruthDTU"]["scaleMat"]}, f, indent=4)

            # Adjust values based on the dataset type
            sensor_size = 1
            if chunk.node.datasetType.value == "blendedMVG":
                pixel_size = sensor_size / images_sizes[0][0]
                gt_extrinsics = [np.linalg.inv(
                    e) if e is not None else None for e in gt_extrinsics] # R-1 and R-1.-T, needed to reuse sfm_data_from_matrices
            elif chunk.node.datasetType.value == "realityCapture":
                nb_invalid = 0
                for e in gt_extrinsics:
                    if e is not None:
                        e[0:3, 0:3] = np.linalg.inv(e[0:3, 0:3])
                    else:
                        nb_invalid += 1
                chunk.logger.info("%d invalid calibs" % nb_invalid)
                sensor_size = 35
                for i, image_size in zip(gt_intrinsics, images_sizes):
                    if i is not None:
                        pixel_size = sensor_size / image_size[0]
                        i[0, 0] /= pixel_size
                        i[1, 1] /= pixel_size
                        i[0, 2] = image_size[0] / 2 + i[0, 2] * 1000000 * 1 / image_size[0]
                        i[1, 2] = image_size[1] / 2 + i[1, 2] * 1000000 * 1 / image_size[0]
                        # convert principal point in pixels
                        # https://support.capturingreality.com/hc/en-us/community/posts/115002199052-Unit-and-convention-of-PrincipalPointU-and-PrincipalPointV
                        # dimentionless because already /35 => we pass it into pixels
            elif chunk.node.datasetType.value == "DTU":
                sensor_size = 36

            # Generate SFM data from matrices
            gt_sfm_data = sfm_data_from_matrices(gt_extrinsics, gt_intrinsics, poses_id, calibs_id, images_sizes, sfm_data, sensor_size)

            if chunk.node.focalOverwrite.value != -1:
                pixel_size = sensor_size / images_sizes[0][0]
                for intrinsics in gt_intrinsics:
                    intrinsics[0, 0] = chunk.node.focalOverwrite.value * pixel_size
                    intrinsics[1, 2] = chunk.node.focalOverwrite.value * pixel_size
                    # if chunk.node.principalPointOverwrite.value != "":
                    #     principal_point_overwrite = eval(chunk.node.principalPointOverwrite.value)
                    #     i[0,2] = image_size[0]/2+i[0,2]
                    #     i[1,2] = image_size[1]/2+i[1,2]

            # Add ground truth depth map information
            if chunk.node.datasetType.value == "blendedMVG" or chunk.node.datasetType.value == "realityCapture":
                for view, depth in zip(gt_sfm_data["views"], scenes_depths):
                    view["groundTruthDepth"] = depth

            # Load GT mesh depending on the dataset
            gt_mesh = None
            if chunk.node.datasetType.value == "DTU":
                #get stl from last load
                gt_mesh = os.path.abspath(os.path.join(gtPath,'Points','stl',f'stl{scan:03}_total.ply'))

            # Add ground truth mesh if any
            if gt_mesh is not None:
                mesh = trimesh.load(gt_mesh, force='mesh')
                mesh.export(chunk.node.groundTruthMesh.value)

            # Save the generated SFM data to JSON file
            with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
                json.dump(gt_sfm_data, f, indent=4)

            # Update the generated SFM data removing known extrinsics and intrinsics
            if chunk.node.initIntrinsics.value:
                gt_sfm_data = sfm_data_from_matrices(
                    gt_extrinsics, gt_intrinsics, poses_id, calibs_id, images_sizes, sfm_data)
            else:
                gt_sfm_data = sfm_data_from_matrices(gt_extrinsics, [None] * len(gt_intrinsics), poses_id, calibs_id,
                                                    images_sizes, sfm_data)
                gt_sfm_data["intrinsics"] = sfm_data["intrinsics"]
            del gt_sfm_data["poses"]

            # Save the new generated SFM data to JSON file
            with open(os.path.join(chunk.node.outputSfMDataCameraInit.value), 'w') as f:
                json.dump(gt_sfm_data, f, indent=4)

            # Export depth maps for blendedMVG and realityCapture datasets
            if chunk.node.datasetType.value == "blendedMVG" or chunk.node.datasetType.value == "realityCapture":
                chunk.logManager.start("Exporting depth")
                os.makedirs(
                    chunk.node.outputGroundTruthdepthMapsFolder.value, exist_ok=True)

                for view_id, gt_depth, gt_extrinsic, gt_intrinsic in zip(views_id, scenes_depths, gt_extrinsics, gt_intrinsics):
                    if os.path.exists(gt_depth):
                        depth_map_gt = open_depth_map(gt_depth)
                    else:
                        continue

                    camera_center = gt_extrinsic[0:3, 3]
                    inverse_intr_rot = np.linalg.inv(
                        gt_intrinsic @ np.linalg.inv(gt_extrinsic[0:3, 0:3]))
                    #https://openimageio.readthedocs.io/en/v2.4.6.1/imageoutput.html
                    depth_meta = {
                        "AliceVision:CArr": camera_center,
                        "AliceVision:iCamArr": inverse_intr_rot,
                        "AliceVision:downscale": 1
                    }

                    save_exr(depth_map_gt, os.path.join(chunk.node.outputGroundTruthdepthMapsFolder.value,
                                                        str(view_id) + "_depthMap.exr"), data_type="depth",
                            custom_header=depth_meta)

            chunk.logger.info('Dataset loading ends')
        finally:
            chunk.logManager.end()
