"""
This node converts sfmdata to nerf data.
"""

#TODO: add colmap format here too?

__version__ = "1.0"

import os
import json
import re
import cv2

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *


def variance_of_laplacian(image):
	return cv2.Laplacian(image, cv2.CV_64F).var()


def sharpness(imagePath):
	image = cv2.imread(imagePath)
	gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
	fm = variance_of_laplacian(gray)
	return fm

def convert_sfmdata_to_nerf(sfm_data, actual_path):

    # Intrinsics
    cameras = {}
    for intrinsic in sfm_data['intrinsics']:

        camera = {}
        camera_id = intrinsic['intrinsicId']

        w = float(intrinsic['width'])
        h = float(intrinsic['height'])

        if sfm_data['version'][2] == '1':
            fl_x = float(intrinsic['pxFocalLength'][0])
            fl_y = float(intrinsic['pxFocalLength'][1])
        elif sfm_data['version'][2] == '2':
            sensor_size = float(intrinsic['sensorWidth'])
            fl_mm = float(intrinsic['focalLength'])
            fl_x = fl_mm*max(w,h)/sensor_size
            fl_y = fl_x
        elif sfm_data['version'][2] == '3':
            sensor_size_x = float(intrinsic['sensorWidth'])
            sensor_size_y = float(intrinsic['sensorHeight'])
            fl_mm = float(intrinsic['focalLength'])
            fl_x = fl_mm*w/sensor_size_x
            fl_y = fl_mm*h/sensor_size_y

        k1, k2 = 0.0, 0.0
        if intrinsic['distortionParams'] != '':
            k1 = float(intrinsic['distortionParams'][0])
            k2 = float(intrinsic['distortionParams'][1])

        cx = w / 2 + float(intrinsic['principalPoint'][0])
        cy = h / 2 + float(intrinsic['principalPoint'][1])

        angle_x = math.atan(w / (fl_x * 2)) * 2
        angle_y = math.atan(h / (fl_y * 2)) * 2

        camera["camera_angle_x"] = angle_x
        camera["camera_angle_y"] = angle_y
        camera["fl_x"] = fl_x
        camera["fl_y"] = fl_y
        camera["k1"] = k1
        camera["k2"] = k2
        camera["cx"] = cx
        camera["cy"] = cy
        camera["w"] = w
        camera["h"] = h

        cameras[camera_id] = camera

    # Create frames
    bottom = np.array([0.0, 0.0, 0.0, 1.0]).reshape([1, 4])
    if len(cameras) == 1:
        camera = cameras[camera_id]
        out = {
            "camera_angle_x": camera["camera_angle_x"],
            "camera_angle_y": camera["camera_angle_y"],
            "fl_x": camera["fl_x"],
            "fl_y": camera["fl_y"],
            "k1": camera["k1"],
            "k2": camera["k2"],
            "cx": camera["cx"],
            "cy": camera["cy"],
            "w": camera["w"],
            "h": camera["h"],
            "aabb_scale": 1,
            "frames": [],
        }
    else:
        out = {
				"frames": [],
				"aabb_scale": 1
			}

    for view in sfm_data['views']:
        name = os.path.relpath(view['path'],os.path.dirname(actual_path))
        b = sharpness(view['path'])

        # Extrinsic
        pose_id = int(view['poseId'])
        for pose in sfm_data['poses']:
            if pose_id == int(pose['poseId']):
                R = np.array(pose['pose']['transform']['rotation'],dtype=np.float32).reshape([3,3]) # orientation
                t = np.expand_dims(np.array(pose['pose']['transform']['center'],dtype=np.float32), axis=1) # center
                c2w = np.concatenate([np.concatenate([R, t], 1), bottom], 0)

                c2w[0:3,2] *= -1 # flip the y and z axis
                c2w[0:3,1] *= -1
                c2w = c2w[[1,0,2,3],:]
                c2w[2,:] *= -1 # flip whole world upside down

                frame={"file_path":name,"sharpness":b,"transform_matrix":c2w}

                if len(cameras) != 1:
                    camera_id = view["intrinsicId"]
                    frame.update(cameras[camera_id])

                out["frames"].append(frame)

    for f in out["frames"]:
        f["transform_matrix"] = f["transform_matrix"].tolist()

    return out

class ConvertSfmData(desc.Node):
    category = 'Meshroom Research'

    documentation = '''Util node to convert sfm data.'''

    # size = desc.DynamicNodeSize('inputSfmData')

    inputs = [

        desc.File(
            name="inputSfmData",
            label="Input sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.ChoiceParam(
            name='outputType',
            label='Output Type',
            description='Output type',
            value='NeRF',
            values=['NeRF', 'IDR'],
            exclusive=True,
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
            description='Output file or folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.inputSfmData.value == '':
            chunk.logger.warning(
                'No input sfmData in node ConvertSfmData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Converts sfmData.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return

            # Load SFM data from sfm file
            chunk.logger.info("Starts to load data from sfmdata")
            sfm_data = json.load(open(chunk.node.inputSfmData.value, "r"))

            # Create new object
            if chunk.node.outputType.value == 'NeRF':

                output_sfm_data = convert_sfmdata_to_nerf(sfm_data,chunk.node.inputSfmData.value)

                # Save the new generated SFM data to JSON file
                with open(os.path.join(chunk.node.output.value,'transforms.json'), 'w') as f:
                    json.dump(output_sfm_data, f, indent=4)

            elif chunk.node.outputType.value == 'IDR':
                print('IDR')




            chunk.logger.info('Conversion done.')
        finally:
            chunk.logManager.end()
