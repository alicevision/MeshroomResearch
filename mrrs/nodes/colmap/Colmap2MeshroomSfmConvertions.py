__version__ = "2.0"

import collections
import struct
import json
import os

import numpy as np
from meshroom.core import desc


#from https://github.com/colmap/colmap/blob/dev/scripts/python/read_write_model.py
#TODO: make repo import
CameraModel = collections.namedtuple(
    "CameraModel", ["model_id", "model_name", "num_params"])
Camera = collections.namedtuple(
    "Camera", ["id", "model", "width", "height", "params"])

CAMERA_MODELS = {
    CameraModel(model_id=0, model_name="SIMPLE_PINHOLE", num_params=3),
    CameraModel(model_id=1, model_name="PINHOLE", num_params=4),
    CameraModel(model_id=2, model_name="SIMPLE_RADIAL", num_params=4),
    CameraModel(model_id=3, model_name="RADIAL", num_params=5),
    CameraModel(model_id=4, model_name="OPENCV", num_params=8),
    CameraModel(model_id=5, model_name="OPENCV_FISHEYE", num_params=8),
    CameraModel(model_id=6, model_name="FULL_OPENCV", num_params=12),
    CameraModel(model_id=7, model_name="FOV", num_params=5),
    CameraModel(model_id=8, model_name="SIMPLE_RADIAL_FISHEYE", num_params=4),
    CameraModel(model_id=9, model_name="RADIAL_FISHEYE", num_params=5),
    CameraModel(model_id=10, model_name="THIN_PRISM_FISHEYE", num_params=12)
}
CAMERA_MODEL_IDS = dict([(camera_model.model_id, camera_model)
                         for camera_model in CAMERA_MODELS])
CAMERA_MODEL_NAMES = dict([(camera_model.model_name, camera_model)
                           for camera_model in CAMERA_MODELS])

def read_next_bytes(fid, num_bytes, format_char_sequence, endian_character="<"):
    """Read and unpack the next bytes from a binary file.
    :param fid:
    :param num_bytes: Sum of combination of {2, 4, 8}, e.g. 2, 6, 16, 30, etc.
    :param format_char_sequence: List of {c, e, f, d, h, H, i, I, l, L, q, Q}.
    :param endian_character: Any of {@, =, <, >, !}
    :return: Tuple of read and unpacked values.
    """
    data = fid.read(num_bytes)
    return struct.unpack(endian_character + format_char_sequence, data)

def read_cameras_binary(path_to_model_file):
    """
    Read colmap camera binary format
    see: src/base/reconstruction.cc
        void Reconstruction::WriteCamerasBinary(const std::string& path)
        void Reconstruction::ReadCamerasBinary(const std::string& path)
    """
    cameras = {}
    with open(path_to_model_file, "rb") as fid:
        num_cameras = read_next_bytes(fid, 8, "Q")[0]
        for _ in range(num_cameras):
            camera_properties = read_next_bytes(
                fid, num_bytes=24, format_char_sequence="iiQQ")
            camera_id = camera_properties[0]
            model_id = camera_properties[1]
            model_name = CAMERA_MODEL_IDS[camera_properties[1]].model_name
            width = camera_properties[2]
            height = camera_properties[3]
            num_params = CAMERA_MODEL_IDS[model_id].num_params
            params = read_next_bytes(fid, num_bytes=8*num_params,
                                     format_char_sequence="d"*num_params)
            cameras[camera_id] = Camera(id=camera_id,
                                        model=model_name,
                                        width=width,
                                        height=height,
                                        params=np.array(params))
        if len(cameras) != num_cameras:
            raise RuntimeError("Cameras dont match num_camera")
    return cameras
#

def colmap2meshroom(colmap_cameras, sfm_data={}):
    intrinsics = []
    for camera_id, colmap_camera in colmap_cameras.items():
        intrinsic={
        "intrinsicId": camera_id,
        "width": colmap_camera.width,
        "height": colmap_camera.height,
        "sensorWidth": "1",
        "sensorHeight": str(colmap_camera.height/colmap_camera.width),
        "serialNumber": "-1",
        "initializationMode": "unknown",
        "initialFocalLength": "-1",
        "pixelRatio": "1",
        "pixelRatioLocked": "true",
        "locked": "false"
        }
        # print(colmap_camera.model)
        if colmap_camera.model == "SIMPLE_PINHOLE":
            intrinsic["type"]="pinhole"
            intrinsic["focalLength"]=colmap_camera.params[0]
            intrinsic["principalPoint"]=[colmap_camera.params[1], colmap_camera.params[2]]
        if colmap_camera.model == "PINHOLE":
            intrinsic["type"]="pinhole"
            intrinsic["focalLength"]=[colmap_camera.params[0], colmap_camera.params[1]]
            intrinsic["principalPoint"]=[colmap_camera.params[2], colmap_camera.params[3]]
        elif colmap_camera.model == "SIMPLE_RADIAL" or colmap_camera.model == "RADIAL":
            raise RuntimeError("Camera model not supported yet")#TODO
            ## "type": "radial3",
            ## "distortionParams": [
            #     "0.0060113550893550497",
            #     "-0.016002005282894624",
            #     "0.01440446682231027"
            # ],
        else:
            raise RuntimeError("Camera model not supported yet")
        intrinsic["principalPoint"]=[intrinsic["principalPoint"][0]-colmap_camera.width,
                                     intrinsic["principalPoint"][1]-colmap_camera.height,
                                    ]
        intrinsics.append(intrinsic)
    sfm_data["intrinsics"] = intrinsics
    return sfm_data

class Colmap2MeshroomSfmConvertion(desc.Node):

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input',
            label='Input',
            description='SfMData file.',
            value='',
            uid=[0],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='verbosity level (fatal, error, warning, info, debug, trace).',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfm',
            label='Output Sfm',
            description='Path to the output SfM file.',
            value=os.path.join(desc.Node.internalFolder, "sfmdata.sfm"),
            uid=[],
            ),
    ]

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            colmap_cameras = read_cameras_binary(chunk.node.input.value)
            sfm_data = colmap2meshroom(colmap_cameras)
            with open(chunk.node.outputSfm.value, "w") as json_file:
                json_file.write(json.dumps(sfm_data, indent=4))
        finally:
            chunk.logManager.end()



