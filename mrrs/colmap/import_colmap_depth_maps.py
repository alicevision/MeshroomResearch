import json
import argparse
import os
import glob

import numpy as np

from mrrs.core.ios import matrices_from_sfm_data, save_exr
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

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-i', '--inputFolder',
        help="",
    )
    parser.add_argument(
        '-j', '--inputSfm',
        help="",
    )
    parser.add_argument(
        '-o', '--depthMapFolder',
        help="",
    )

    args = parser.parse_args()    


    input_folder = args.inputFolder
    input_sfm = args.inputSfm
    depth_maps_folder = args.depthMapFolder

    depth_map_folder = os.path.join(input_folder,'stereo','depth_maps')
    normal_map_folder = os.path.join(input_folder,'stereo','normal_maps')

    depth_map_paths = [f for f in glob.glob(os.path.join(depth_map_folder,"*.*.photometric.bin"))]
    normal_map_paths = [f for f in glob.glob(os.path.join(normal_map_folder,"*.*.photometric.bin"))]

    view_uid_map = {}
    if input_sfm != '':
        sfm_data = json.load(open(input_sfm, 'r'))
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
        if input_sfm != '':
            depth_map_basename=os.path.basename(depth_map_path).split(".")[0]
            if depth_map_basename in view_uid_map.keys():
                depth_map_name = view_uid_map[depth_map_basename]+"_depthMap.exr"
            else:
                print('Warning depth map for view '+depth_map_path+' not found in sfm data')
        else:
            print('Warning depth map for view '+depth_map_path+' not found in sfm data')

        #also resize to sfm data size if any
        size=(int(sfm_data['views'][index]["width"]),int(sfm_data['views'][index]["height"]))
        depth_map, _ =cv2_resize_with_pad(depth_map, size, padding_color=0)

        save_exr(depth_map,os.path.join(depth_maps_folder, depth_map_name))

