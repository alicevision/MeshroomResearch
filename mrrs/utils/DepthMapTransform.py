__version__ = "3.0"

import logging
import os
import json

from meshroom.core import desc
from meshroom.core.plugin import PluginNode, EnvType

class DepthMapTransform(PluginNode):

    category = 'MRRS - Utils'
    documentation = '''Will process depth maps (groud truth and/or from folder, according to the selected transformation)'''

    envType = EnvType.CONDA
    envFile = os.path.join(os.path.dirname(__file__), "utils_env.yaml")

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.File(
            name="depthMapsFolder",
            label="DepthMaps Folder",
            description="Input depth maps folder.",
            value="",
        ),

        desc.ChoiceParam(
            name='transform',
            label='Tranform',
            description='Transformation to apply to the depth maps.',
            values=['meshroom2normal', 'normal2meshroom', 'id'],#TODO: project?
            value='meshroom2normal',
            exclusive=True,
            joinChar=',',
        ),

        desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
            ),

    ]

    outputs = [
        desc.File(
            name='output',
            label='Output',
            description='Output folder for generated results.',
            value=desc.Node.internalFolder,
        ),
        desc.File(
            name='depth',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>_depthMap.exr',
            group='',
        ),
    ]

    def processChunk(self, chunk):
        """
        Computes the different transforms on the depth maps.
        """
        import numpy as np
        import cv2

        from mrrs.core.utils import listdir_fullpath
        from mrrs.core.geometry import camera_deprojection, camera_deprojection_meshroom, camera_projection
        from mrrs.core.ios import matrices_from_sfm_data, open_depth_map, open_exr, save_exr

        def meshroom2normal(pixels, depth_map, extrinsic, intrinsic, pixel_size):
            """
            Convert meshroom depth maps to conventional depth maps.
            """
            if extrinsic is None:
                raise ValueError("Must pass an sfm for this transform")
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
            if extrinsic is None:
                raise ValueError("Must pass an sfm for this transform")
            #deproject using regular equation
            scene_points = camera_deprojection(pixels, depth_map, extrinsic, intrinsic, pixel_size)
            #Z is distance from camera center
            points_distances_from_camera = np.sqrt(np.sum((scene_points-extrinsic[0:3,3])**2, axis=-1))
            depth_map_converted = np.reshape(points_distances_from_camera, depth_map.shape)
            depth_map_converted[depth_map<0]=0
            return  depth_map_converted

        def id(pixels, depth_map, extrinsic, intrinsic, pixel_size):
            return depth_map

        def do_transform(depth_maps_path, sfm_data, transform, output_folder):
            """
            Runs the transform on a set of depth maps.
            """
            output_depth_map_paths = []
            if sfm_data is not None:
                extrinsics, intrinsics, _, _, _, pixel_sizes = matrices_from_sfm_data(sfm_data)
                pixels = None
                for index, view in enumerate(sfm_data["views"]):
                    logging.info("Converting view %d/%d"%(index, len(pixel_sizes)))
                    view_id = view["viewId"]
                    if not os.path.exists(depth_maps_path[index]):
                        logging.warning(depth_maps_path[index]+" cannot be found, skipping")
                        continue
                    depth_map, depth_map_header = open_exr(depth_maps_path[index])
                    depth_map=depth_map.astype(np.float32)
                
                    depth_map_size = np.asarray(depth_map.shape[0:2])
                    #add downscale if not present
                    if "AliceVision:downscale" not in depth_map_header:
                        depth_map_header["AliceVision:downscale"]=float(view["width"])/float(depth_map_size[1])
                    
                    #FIXME: resizing is not ideal, but convenient to use our calib directly
                    scale = float(depth_map_header["AliceVision:downscale"])
                    depth_map = cv2.resize(depth_map, (scale*depth_map_size[::-1]).astype(np.int32))
                    logging.info("Rescaling depth map with %f"%scale)

                    ys, xs = np.meshgrid(range(0, depth_map.shape[0]), \
                                        range(0, depth_map.shape[1]), \
                                        indexing="ij")
                    pixels = [xs, ys]
                    depth_map_transformed = transform(pixels, depth_map, extrinsics[index], intrinsics[index], pixel_sizes[index])
                    output_depth_map_path = os.path.join(output_folder, view_id+"_depthMap.exr")
                    depth_map_transformed[depth_map<0] = 0#put 0 in places where its invalid
                    
                    #resie to orginnal size
                    depth_map_transformed = cv2.resize(depth_map_transformed, depth_map_size[::-1])
                        
                    # add header for vizualisation
                    if "AliceVision:CArr" not in depth_map_header: 
                        # edit intrinsics pp with scale
                        intrinsics_dm = intrinsics[index]
                        # ?
                        # intrinsics_dm[0,2]/=depth_map_header["AliceVision:downscale"]
                        # intrinsics_dm[1,2]/=depth_map_header["AliceVision:downscale"]
                        camera_center = extrinsics[index][0:3, 3].tolist()
                        inverse_intr_rot = np.linalg.inv(intrinsics_dm @ np.linalg.inv(extrinsics[index][0:3, 0:3]))

                        depth_map_header["AliceVision:CArr"] = camera_center
                        depth_map_header["AliceVision:iCamArr"]= inverse_intr_rot
                        
                    save_exr(depth_map_transformed, output_depth_map_path, custom_header=depth_map_header)
                    output_depth_map_paths.append(output_depth_map_path)
            else:
                for depth_map_file in depth_maps_path:
                    depth_map = open_depth_map(depth_map_file)
                    depth_map_transformed = transform(None, depth_map, None, None, None)
                    output_depth_map_path = os.path.join(output_folder, os.path.basename(depth_map_file)+"_depthMap.exr")
                    save_exr(depth_map_transformed, output_depth_map_path)
                    output_depth_map_paths.append(output_depth_map_path)
            return output_depth_map_paths

        chunk.logManager.start(chunk.node.verboseLevel.value)
        depth_folder = chunk.node.depthMapsFolder.value
        transform_function = eval(chunk.node.transform.value)
        sfm_data=None
        if chunk.node.inputSfM.value != '':#get the depth from the sfm if passed
            sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
            depth_files = [os.path.join(depth_folder, str(views["viewId"])+"_depthMap.exr") for views in sfm_data["views"]]#FIXME: hardcoded filename
        else:
            depth_files = [f for f in listdir_fullpath(depth_folder) if (f.endswith('.npy') or f.endswith('.pfm') or f.endswith('.exr')) ]
        do_transform(depth_files, sfm_data, transform_function, chunk.node.output.value)

        chunk.logger.info('Depth map transform end')