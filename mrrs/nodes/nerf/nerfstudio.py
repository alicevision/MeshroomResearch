import json
import os
import numpy as np
import cv2
import shutil

from meshroom.core import desc
from mrrs.core.ios import matrices_from_sfm_data, open_depth_map, save_exr
from mrrs.core.CondaNode import CondaNode
from mrrs.nerf import ENV_PATH

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
        else:
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

        angle_x = np.arctan(w / (fl_x * 2)) * 2
        angle_y = np.arctan(h / (fl_y * 2)) * 2

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
            "frames": [],
        }
    else:
        out = {
				"frames": [],
			}

    for view in sfm_data['views']:
        name = os.path.relpath(view['path'],os.path.dirname(actual_path))

        # Extrinsic
        pose_id = int(view['poseId'])
        for pose in sfm_data['poses']:
            if pose_id == int(pose['poseId']):
                R = np.array(pose['pose']['transform']['rotation'],dtype=np.float32).reshape([3,3]) # orientation
                t = np.expand_dims(np.array(pose['pose']['transform']['center'],dtype=np.float32), axis=1) # center
                c2w = np.concatenate([np.concatenate([R, t], 1), bottom], 0)

                c2w[0:3,2] *= -1 # flip the y and z axis
                c2w[0:3,1] *= -1

                frame={"file_path":name,"transform_matrix":c2w}

                if len(cameras) != 1:
                    camera_id = view["intrinsicId"]
                    frame.update(cameras[camera_id])

                out["frames"].append(frame)

    for f in out["frames"]:
        f["transform_matrix"] = f["transform_matrix"].tolist()

    return out

def copy_recursive_walk(root_path, path):
    for root, dirs, files in os.walk(path):
        for d in dirs:
            copy_recursive_walk(root_path, os.path.join(root, d))
        for f in files:
            shutil.move(os.path.join(root, f), root_path)

class NeRFStudio(CondaNode):

    category = 'Meshroom Research'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = "ns-train {methodValue} --viewer.quit-on-train-completion True {allParams} --data {outputFolderValue} --output-dir {outputFolderValue}"

    #overides the env path
    # @property
    # def env_file(self):
    #     return ENV_FILE
    
    env_path = ENV_PATH

    inputs = [
            desc.File(
                name="inputSfMData",
                label="SfMData",
                description="Input SfMData file.",
                value="",
                uid=[0],
                group=""
            ),
            desc.ChoiceParam(
                name='method',
                label='Method',
                description='Method',
                value='nerfacto',
                values=['dnerf', 'generfacto', 'instant-ngp', 'instant-ngp-bounded', 'mipnerf', 'nerfacto', 'nerfacto-big', 'nerfacto-huge', 'neus', 'neus-facto', 'splatfacto', 'splatfacto-big', 'tensorf', 'vanilla-nerf'],
                exclusive=True,
                uid=[0],
                group=""
            ),
            desc.IntParam(
                name='max-num-iterations',
                label='Number of Iterations',
                description='Maximum number of iterations to run.',
                value=30000,
                range=(5000, 100000, 5000),
                uid=[0],
            ),
            # desc.BoolParam(
            #     name='pipeline.model.predict-normals',
            #     label='Predict Normals',
            #     description='Predict normals.',
            #     value=True,
            #     uid=[0],
            #     enabled=lambda attr: (attr.node.method.value=='nerfacto' or attr.node.method.value=='nerfacto-big' or attr.node.method.value=='nerfacto-huge'),
            # ),
            desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
                uid=[0],
                group="",
                )
            ]

    outputs = [
            desc.File(
                name='output',
                label='Output',
                description='Output folder.',
                value=desc.Node.internalFolder,
                uid=[],
                group="",
            ),
    ]

    def processChunk(self, chunk):
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfMData.value == "":
            raise RuntimeError('Must input SfM data')
        
        # Load SFM data from sfm file
        sfmData = json.load(open(chunk.node.inputSfMData.value,"r"))
        nerfData = convert_sfmdata_to_nerf(sfmData, chunk.node.inputSfMData.value)
        
        # Save the new generated SFM data to JSON file
        outputFolderValue = chunk.node.output.value
        with open(os.path.join(outputFolderValue,'transforms.json'), 'w') as f:
            json.dump(nerfData, f, indent=4)

        # Run the CL
        chunk.node._cmdVars["methodValue"] = chunk.node.method.value
        chunk.node._cmdVars["outputFolderValue"] = outputFolderValue
        cmd = self.buildCommandLine(chunk)
        super().processChunk(chunk)

        # Copy the folders and files in ././. to .
        resPath = os.path.join(outputFolderValue, os.path.basename(outputFolderValue))
        copy_recursive_walk(outputFolderValue, resPath)
        shutil.rmtree(resPath)

        chunk.logManager.end()