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
BaseImage = collections.namedtuple(
    "Image", ["id", "qvec", "tvec", "camera_id", "name", "xys", "point3D_ids"])

def qvec2rotmat(qvec):
    return np.array([
        [1 - 2 * qvec[2]**2 - 2 * qvec[3]**2,
         2 * qvec[1] * qvec[2] - 2 * qvec[0] * qvec[3],
         2 * qvec[3] * qvec[1] + 2 * qvec[0] * qvec[2]],
        [2 * qvec[1] * qvec[2] + 2 * qvec[0] * qvec[3],
         1 - 2 * qvec[1]**2 - 2 * qvec[3]**2,
         2 * qvec[2] * qvec[3] - 2 * qvec[0] * qvec[1]],
        [2 * qvec[3] * qvec[1] - 2 * qvec[0] * qvec[2],
         2 * qvec[2] * qvec[3] + 2 * qvec[0] * qvec[1],
         1 - 2 * qvec[1]**2 - 2 * qvec[2]**2]])

class Image(BaseImage):
    def qvec2rotmat(self):
        return qvec2rotmat(self.qvec)

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

def read_images_binary(path_to_model_file):
    """
    see: src/base/reconstruction.cc
        void Reconstruction::ReadImagesBinary(const std::string& path)
        void Reconstruction::WriteImagesBinary(const std::string& path)
    """
    images = {}
    with open(path_to_model_file, "rb") as fid:
        num_reg_images = read_next_bytes(fid, 8, "Q")[0]
        for _ in range(num_reg_images):
            binary_image_properties = read_next_bytes(
                fid, num_bytes=64, format_char_sequence="idddddddi")
            image_id = binary_image_properties[0]
            qvec = np.array(binary_image_properties[1:5])
            tvec = np.array(binary_image_properties[5:8])
            camera_id = binary_image_properties[8]
            image_name = ""
            current_char = read_next_bytes(fid, 1, "c")[0]
            while current_char != b"\x00":   # look for the ASCII 0 entry
                image_name += current_char.decode("utf-8")
                current_char = read_next_bytes(fid, 1, "c")[0]
            num_points2D = read_next_bytes(fid, num_bytes=8,
                                           format_char_sequence="Q")[0]
            x_y_id_s = read_next_bytes(fid, num_bytes=24*num_points2D,
                                       format_char_sequence="ddq"*num_points2D)
            xys = np.column_stack([tuple(map(float, x_y_id_s[0::3])),
                                   tuple(map(float, x_y_id_s[1::3]))])
            point3D_ids = np.array(tuple(map(int, x_y_id_s[2::3])))
            images[image_id] = Image(
                id=image_id, qvec=qvec, tvec=tvec,
                camera_id=camera_id, name=image_name,
                xys=xys, point3D_ids=point3D_ids)
    return images
#
def colmap2meshroom_instrinsics(colmap_intrinsics, sfm_data={}):
    intrinsics = []
    for camera_id, colmap_camera in colmap_intrinsics.items():
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
        if colmap_camera.model == "SIMPLE_PINHOLE":
            intrinsic["type"]="pinhole"
            intrinsic["focalLength"]=colmap_camera.params[0]
            intrinsic["principalPoint"]=[colmap_camera.params[1], colmap_camera.params[2]]
        if colmap_camera.model == "PINHOLE":
            intrinsic["type"]="pinhole"
            intrinsic["focalLength"]=[colmap_camera.params[0], colmap_camera.params[1]]
            intrinsic["principalPoint"]=[colmap_camera.params[2], colmap_camera.params[3]]
        elif colmap_camera.model == "SIMPLE_RADIAL" :
            intrinsic["type"]="radial1"
            intrinsic["focalLength"]=colmap_camera.params[0]
            intrinsic["principalPoint"]=[colmap_camera.params[1], colmap_camera.params[2]]
            intrinsic["distortionParams"]=[colmap_camera.params[3]]
        else:
            raise RuntimeError("Camera model not supported yet") # TODO: or colmap_camera.model == "RADIAL"
        #principal point as delta from center (in mm)
        pixel_size = 1/colmap_camera.width
        #converts the focal in "mm", assuming sensor width=1
        intrinsic["focalLength"]=100*pixel_size*intrinsic["focalLength"]
        intrinsic["principalPoint"]=[intrinsic["principalPoint"][0]-colmap_camera.width/2.0,
                                     intrinsic["principalPoint"][1]-colmap_camera.height/2.0,
                                    ]
        intrinsics.append(intrinsic)
    sfm_data["intrinsics"] = intrinsics
    return sfm_data

def colmap2meshroom_extrinsics(colmap_extrinsics, colmap_intrinsics, image_folder="", sfm_data={}):
    extrinsics = []
    views = []
    camera_index = 0
    for camera_id, colmap_camera in colmap_extrinsics.items():
        path=colmap_camera.name
        rotation = qvec2rotmat(colmap_camera.qvec)
        translation=colmap_camera.tvec
        extrinsic = {
            "poseId": camera_index,
            "pose": {
                    "transform": {
                                    "rotation": rotation.flatten().tolist(),
                                    "center": translation.flatten().tolist(),
                                },
                    "locked": "0"
                    }
        }

        view =  {
                "viewId": camera_index,
                "poseId": camera_index,
                "frameId": camera_index,
                "intrinsicId": camera_id,
                "path": os.path.join(image_folder, path),
                "width": colmap_intrinsics[camera_id].width,
                "height": colmap_intrinsics[camera_id].height
                }
        views.append(view)
        extrinsics.append(extrinsic)
        camera_index += 1
    sfm_data["views"] = views
    sfm_data["poses"] = extrinsics
    return sfm_data


class Colmap2MeshroomSfmConvertion(desc.Node):
    """
    Converts colmap's sfm infos into meshroom format
    """

    category = 'Colmap'
    documentation = '''Converts colmap's sfm infos into meshroom format'''

    inputs = [
        desc.File(
            name='input',
            label='Input',
            description='Input sparse folder',
            value='',
            uid=[0],
        ),
        desc.File(
            name='inputSfm',
            label='InputSfm',
            description='Input sfm from cameraInit',
            value='',
            uid=[0],
        ),
        desc.File(
            name='imageFolder',
            label='ImageFolder',
            description='Input image folder (needed if you dont use a SfM)',
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
            if chunk.node.imageFolder.value=="" and chunk.node.inputSfm.value == "":
                raise RuntimeError("Must input image folder or sfm data")
            colmap_intrinsics = read_cameras_binary(os.path.join(chunk.node.input.value, "cameras.bin"))
            colmap_extrinsics = read_images_binary(os.path.join(chunk.node.input.value, "images.bin"))
            sfm_data = {}
            sfm_data["version"] = ["1", "2", "3"]
            sfm_data = colmap2meshroom_instrinsics(colmap_intrinsics, sfm_data)
            sfm_data = colmap2meshroom_extrinsics(colmap_extrinsics, colmap_intrinsics, chunk.node.imageFolder.value, sfm_data)
            #if sfm was passed
            if chunk.node.inputSfm.value != '':
                source_sfm_data = json.load(open(chunk.node.inputSfm.value, 'r'))
                sfm_data["version"] = source_sfm_data["version"]
                #match view by filename, and replace path and uid
                for view in sfm_data["views"]:
                    view_found = False
                    for source_view in source_sfm_data["views"]:
                        if os.path.basename(source_view["path"]) == os.path.basename(view["path"]):
                            view["path"] = source_view["path"]
                            view["viewId"] = source_view["viewId"]
                            view_found = True
                            break
                    if not view_found:
                        chunk.logger.warn("View "+view["path"]+" not found in sfm")
            with open(chunk.node.outputSfm.value, "w") as json_file:
                json_file.write(json.dumps(sfm_data, indent=4))
        finally:
            chunk.logManager.end()
