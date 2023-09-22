"""
This node converts sfmdata to nerf data.
"""

#TODO: add colmap format here too?

__version__ = "1.0"

import os
import json
import re
import cv2
import glob

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *
from mrrs.core.utils import cv2_resize_with_pad

def read_array(path):
    with open(path, "rb") as fid:
        width, height, channels = np.genfromtxt(fid, delimiter="&", max_rows=1,
                                                usecols=(0, 1, 2), dtype=int)
        fid.seek(0)
        num_delimiter = 0
        byte = fid.read(1)
        while True:
            if byte == b"&":
                num_delimiter += 1
                if num_delimiter >= 3:
                    break
            byte = fid.read(1)
        array = np.fromfile(fid, np.float32)
    array = array.reshape((width, height, channels), order="F")
    return np.transpose(array, (1, 0, 2)).squeeze()


class ImportColmapDepthMaps(desc.Node):
    category = 'Meshroom Research'

    documentation = ''''''

    inputs = [

        desc.File(
            name="input",
            label="Input",
            description="COLMAP Dense folder in workspace",
            value="",
            uid=[0],
        ),

        desc.File(
            name="inputSfm",
            label="InputSfm",
            description="Input sfm data, used to match the views",
            value="",
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
            name='depthMapFolder',
            label='Depth maps folder',
            description='Generated depth maps folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        #for viz
        desc.File(
            name='depth',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>_depthMap.exr',
            uid=[],
        ),

    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.input.value == '':
            chunk.logger.warning(
                'No input workspace in node ImportColmapDepthMaps, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Import depth maps from COLMAP.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return

            depth_map_folder = os.path.join(chunk.node.input.value,'stereo','depth_maps')
            normal_map_folder = os.path.join(chunk.node.input.value,'stereo','normal_maps')

            depth_map_paths = [f for f in glob.glob(os.path.join(depth_map_folder,"*.*.photometric.bin"))]
            normal_map_paths = [f for f in glob.glob(os.path.join(normal_map_folder,"*.*.photometric.bin"))]

            view_uid_map = {}
            if chunk.node.inputSfm.value != '':
                sfm_data = json.load(open(chunk.node.inputSfm.value, 'r'))
                #map view path => uid
                for view in sfm_data['views']:
                    view_basename = os.path.basename(view['path']).split(".")[0]
                    view_uid_map[view_basename] =view['viewId']
                extrinsics, intrinsics, _, _, _, pixel_sizes_all_cams=matrices_from_sfm_data(sfm_data)

            for index, (depth_map_path, normal_map_path) in enumerate(zip(depth_map_paths, normal_map_paths)):

                depth_map = read_array(depth_map_path)
                normal_map = read_array(normal_map_path)

                min_depth, max_depth = np.percentile(
                    depth_map, [1, 99])
                depth_map[depth_map < min_depth] = min_depth
                depth_map[depth_map > max_depth] = max_depth

                depth_map_name = "%d_depthMap.exr"%index
                #if a sfmdata has been passed, matches the uid
                if chunk.node.inputSfm.value != '':
                    depth_map_basename=os.path.basename(depth_map_path).split(".")[0]
                    if depth_map_basename in view_uid_map.keys():
                        depth_map_name = view_uid_map[depth_map_basename]+"_depthMap.exr"
                    else:
                        chunk.logger.warning('Warning depth map for view '+depth_map_path+' not found in sfm data')

                    #also resize to sfm data size if any
                    size=(int(sfm_data['views'][index]["width"]),int(sfm_data['views'][index]["height"]))
                    depth_map, _ =cv2_resize_with_pad(depth_map, size, padding_color=0)

                    # #add metadata as well (used for display)
                    # # camera_center = extrinsics[index][0:3, 3]
                    # # inverse_intr_rot = np.linalg.inv(
                    # #     intrinsics[index] @ np.linalg.inv(extrinsics[index][0:3, 0:3]))
                    # camera_center = np.linalg.inv(np.concatenate([extrinsics[index], [[0,0,0,1]]]))[0:3, 3]
                    # depth_meta = {
                    #     "AliceVision:CArr": camera_center,
                    #     "AliceVision:iCamArr": extrinsics[index][0:3, 0:3],#inverse_intr_rot,
                    #     "AliceVision:downscale": 1
                    # } FIXME: moved to depthmap transform?
                    save_exr(depth_map,os.path.join(chunk.node.depthMapFolder.value, depth_map_name),'depth')#, custom_header=depth_meta)

            chunk.logger.info('Import done.')
        finally:
            chunk.logManager.end()
