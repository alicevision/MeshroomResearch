__version__ = "3.0"

import os
import json

import cv2

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.core.geometry import *

def meshroom2normal(pixels, depth_map, extrinsic, intrinsic, pixel_size):
    """
    Convert meshroom depth maps to conventional depth maps.
    """
    #deproject using meshoom deprojection
    scene_points = camera_deprojection_meshroom(pixels, depth_map, extrinsic, intrinsic, pixel_size)
    #reprojection used to get depth map
    _, points_distances_from_camera = camera_projection(scene_points, extrinsic, intrinsic, pixel_size)
    depth_map_converted = np.reshape(points_distances_from_camera, depth_map.shape)
    return  depth_map_converted

def normal2meshroom(pixels, depth_map, extrinsic, intrinsic, pixel_size):
    """
    Convert conventional depth maps to meshroom depth maps.
    """
    #deproject using regular equation
    scene_points = camera_deprojection(pixels, depth_map, extrinsic, intrinsic, pixel_size)
    #Z is distance from camera center
    points_distances_from_camera = np.sqrt(np.sum((scene_points-extrinsic[0:3,3])**2, axis=-1))
    depth_map_converted = np.reshape(points_distances_from_camera, depth_map.shape)
    depth_map_converted[depth_map<0]=0
    return  depth_map_converted

def do_transform(depth_maps_path, sfm_data, transform, output_folder):
    """
    Runs the transform on a set of depth maps.
    """
    extrinsics, intrinsics, _, _, _, pixel_sizes = matrices_from_sfm_data(sfm_data)
    output_depth_map_paths = []
    pixels = None
    for index, view in enumerate(sfm_data["views"]):
        logging.info("Converting view %d/%d"%(index, len(pixel_sizes)))
        view_id = view["viewId"]
        if not os.path.exists(depth_maps_path[index]):
            logging.warning(depth_maps_path[index]+" cannot be found, skipping")
            continue
        depth_map, depth_map_header = open_exr(depth_maps_path[index])
        scale = 1
        depth_map_size = np.asarray(depth_map.shape[0:2])
        if "AliceVision:downscale" in depth_map_header:#FIXME: resizing is not ideal
            scale = float(depth_map_header["AliceVision:downscale"])
            depth_map = cv2.resize(depth_map, (scale*depth_map_size[::-1]).astype(np.int32))
            logging.info("Rescaling depth map with %f"%scale)

        # if pixels is None: #depth map size can
        ys, xs = np.meshgrid(range(0, depth_map.shape[0]), \
                            range(0, depth_map.shape[1]), \
                            indexing="ij")
        pixels = [xs, ys]
        depth_map_transformed = transform(pixels, depth_map, extrinsics[index], intrinsics[index], pixel_sizes[index])
        output_depth_map_path = os.path.join(output_folder, view_id+"_depthMap.exr")
        depth_map_transformed[depth_map<0] = 0#put 0 in places where its invalid
        if "AliceVision:downscale" in depth_map_header:
            depth_map_transformed = cv2.resize(depth_map_transformed, depth_map_size[::-1])
        save_exr(depth_map_transformed, output_depth_map_path, data_type="depth", custom_header=depth_map_header)
        output_depth_map_paths.append(output_depth_map_path)
    return output_depth_map_paths

class DepthMapTransform(desc.Node):

    category = 'Meshroom Research'
    documentation = '''Will process depth maps (groud truth and/or from folder, according to the selected transformation)
'''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
            uid=[0],
        ),

        desc.File(
            name="depthMapsFolder",
            label="DepthMaps Folder",
            description="Input depth maps folder",
            value="",
            uid=[0],
        ),

        desc.ChoiceParam(
            name='transform',
            label='Tranform',
            description='Transformation to apply to the depth maps',
            values=['meshroom2normal', 'normal2meshroom'],#TODO: project?
            value='meshroom2normal',
            exclusive=True,
            uid=[0],
            joinChar=',',
        ),

        desc.ChoiceParam(
            name='processDepthMap',
            label='Depth map to process',
            description='''Choose the depth maps to process''',
            value=['folder'],
            values=['sfm_data', 'folder'],
            exclusive=False,
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
            name='output',
            label='Output',
            description='Output folder for generated results.',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='depth',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>_depthMap.exr',
            uid=[],
            group='',
        ),
    ]

    def processChunk(self, chunk):
        """
        Computes the different transforms on the depth maps.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if chunk.node.inputSfM.value == '':
                raise RuntimeError("No inputSfM specified")

            sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
            transform_function = eval(chunk.node.transform.value)

            if "sfm_data" in chunk.node.processDepthMap.value:
                if "groudtruthDepth" not in sfm_data["views"][0].keys():
                    raise RuntimeError("No groudtruthDepth found in .sfm ")
                depth_files = [view["groudtruthDepth"] for view in sfm_data["views"]]
                chunk.logger.info('Transforming %d depths maps from sfm'%len(depth_files))
                output_gt_folder = os.path.join(chunk.node.output.value, "ground_truth_depth_maps")
                os.makedirs(output_gt_folder)
                depth_map_path = do_transform(depth_files, sfm_data, transform_function, output_gt_folder)
                #TODO: change .sfm with depth_map_path
                raise BaseException("Not supported yet")

            if "folder" in chunk.node.processDepthMap.value :
                if chunk.node.depthMapsFolder.value == '':
                    raise RuntimeError("No depthMapsFolder specified")
                depth_folder = chunk.node.depthMapsFolder.value
                depth_files = [os.path.join(depth_folder, str(views["viewId"])+"_depthMap.exr") for views in sfm_data["views"]]#FIXME: hardcoded filename
                do_transform(depth_files, sfm_data, transform_function, chunk.node.output.value)

            chunk.logger.info('Depth map transform end')
        finally:
            chunk.logManager.end()

