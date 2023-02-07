""""
Module handling the inputs and outputs from and to Meshroom.
"""

import logging
import re
from struct import unpack

from PIL import Image
import numpy as np
import json

from mrrs.core.utils import format_float_array

FORCE_IOOI = False#FIXME: debug

#%% Images
def open_exr(exr_path, clip_negative=False):
    '''
    Uses OpenExr to import an EXR file.
    '''
    try:#try with openexr
        import OpenEXR, Imath# lazy import
        if FORCE_IOOI:
            raise RuntimeError("OpenImageIo overwite")
    except ImportError :#openimage io fallback
        logging.info("OpenExr bindings for python unavailable, switching to openimageio")
        #logging.warning("Openimageio does not support custom header for now, this might lead to issues")
        import OpenImageIO as oiio
        exr_file = oiio.ImageInput.open(exr_path)
        header = exr_file.spec()
        if exr_file is None :
            raise RuntimeError("Could not open exr file "+exr_path)
        output_array = exr_file.read_image("float32")
        exr_file.close()
    else:
        exr_file = OpenEXR.InputFile(exr_path)
        header = exr_file.header()#issue: can not parse our custom headers
        data_window = header['dataWindow']
        image_size = (data_window.max.y - data_window.min.y + 1,
                    data_window.max.x - data_window.min.x + 1)
        output_array = []
        for channel in header['channels']:
            exr_data = exr_file.channel(channel, Imath.PixelType(Imath.PixelType.FLOAT))
            exr_data = np.fromstring(exr_data, dtype=np.float32)
            exr_data = np.reshape(exr_data, image_size)
            if clip_negative:
                exr_data[exr_data<0]=0
            output_array.append(exr_data)
        output_array = np.stack(output_array, axis=-1)
    return output_array, header

def save_exr(input_array, output_file, data_type='RGB',#FIXME: ugly
            custom_header = None,#{'AliceVision:CArr':None,'AliceVision:iCamArr':None},
            channel_names = None):
    """
    Saves an exr for meshroom, using different formats.
    """
    if len(input_array.shape)<2 or len(input_array.shape)>3:
        raise RuntimeError('Data type not suported for save_exr')
    elif len(input_array.shape)==2:#gray level case
        input_array = np.expand_dims(input_array, -1)
    input_array_size = input_array.shape
    try:#try with openexr
        import OpenEXR, Imath# lazy import
        if FORCE_IOOI:
            raise RuntimeError("OpenImageIo overwite")
    except ImportError:#openimage io fallback
        logging.info("OpenExr bindings for python unavailable, switching to openimageio")
        import OpenImageIO as oiio
        out = oiio.ImageOutput.create(output_file)
        if out is None:
            raise RuntimeError("Could not open exr file "+output_file)
        spec = oiio.ImageSpec(input_array_size[1], input_array_size[0], input_array_size[2], 'float32')
        if custom_header is not None:
            for key in custom_header.keys():
                # print("Writting metadata "+key)
                # print(custom_header[key])
                if key=="AliceVision:CArr":
                    spec.attribute(key, "float[3]", list(custom_header[key]))
                elif key=="AliceVision:iCamArr":
                    spec.attribute (key, oiio.TypeDesc.TypeMatrix33,  list(custom_header[key].flatten()))
                elif key=="AliceVision:downscale":
                    spec.attribute(key, "float", custom_header[key])
                else:
                    spec[key]=custom_header[key]
        out.open(output_file, spec)
        out.write_image(input_array)
        out.close()
    else:
        channel_data = []

        input_array = input_array.astype(np.float32)#float64 causes issues

        for channel_index in range(input_array.shape[-1]):
            channel_data.append(input_array[:,:,channel_index].tostring() )
        import OpenEXR, Imath#lazy importSS
        # Write the three color channels to the output file
        header = OpenEXR.Header(input_array_size[1], input_array_size[0])
        header = {**header, **custom_header}#merges two dicts

        if data_type == 'RGB':
            out = OpenEXR.OutputFile(output_file, header)
            out.writePixels({'R' : channel_data[0], 'G' : channel_data[1], 'B' : channel_data[2] })
        elif data_type == 'depth':
            float_chan = Imath.Channel(Imath.PixelType(Imath.PixelType.FLOAT))
            header['channels']={'Y':float_chan}
            out = OpenEXR.OutputFile(output_file, header)
            out.writePixels({'Y' : channel_data[0]})
        elif data_type == 'segmentation':
            header['channels']={}
            channel_dict={}
            for channel in range(input_array.shape[-1]):
                float_chan = Imath.Channel(Imath.PixelType(Imath.PixelType.FLOAT))
                if channel_names is None:
                    header['channels']['channel_%d'%channel]=float_chan
                    channel_dict['channel_%d'%channel]=channel_data[channel]
                else:
                    header['channels'][channel_names[channel]]=float_chan
                    channel_dict[channel_names[channel]]=channel_data[channel]
            out = OpenEXR.OutputFile(output_file, header)
            out.writePixels(channel_dict)
        else:
            raise RuntimeError('Data type in save_exr not recognised')

def open_pfm(path):
    '''
    Parses a pfm file.
    '''
    with open(path,'rb') as pfm_file:
        header=pfm_file.readline().decode('latin-1')
        if 'PF' in header:
            channels = 3
        elif 'Pf' in header:
            channels = 1
        else:
            raise Exception('Error: not a Valid pfm file')
        line=pfm_file.readline().decode('latin-1')
        width,height = re.findall('\d+',line)
        width,height = int(width),int(height)
        line=pfm_file.readline().decode('latin-1')
        big_endian = True
        if '-' in line:
            big_endian = False
        samples = width*height*channels
        buffers = pfm_file.read(samples*4)
        if big_endian:
            fmt = '>'
        else:
            fmt = '<'
        fmt = fmt + str(samples) + 'f'
        data = unpack(fmt,buffers)
        shape = (height,width,channels)
        data = np.reshape(data,shape)
        data = np.flipud(data)
    return data

def open_depth_map(depth_file, raise_exception=True):
    '''
    Will open a depth map in npy, pfm or exr format.
    '''
    depth_map = None
    if depth_file.endswith('.npy'):
        depth_map = np.load(depth_file)
    elif depth_file.endswith('.pfm'):
        depth_map = open_pfm(depth_file)
        depth_map = depth_map.astype(np.float32)
    elif depth_file.endswith('.exr'):
        depth_map, _ =  open_exr(depth_file)
        depth_map = depth_map.astype(np.float32)
    else:
        if raise_exception:
            raise BaseException('Depth file format not recognised for '+depth_file)
        else:
            print('Depth file format not recognised for '+depth_file)
    return depth_map

def open_image(image_path):
    """
    Opens an image and returns it as a np array.
    """
    if image_path.endswith('.exr'):
        image , _ = open_exr(image_path) #FIXME: opencv image io to replace pillow?
    else:
        image = np.array(Image.open(image_path))
    image = image.astype(np.float32)
    if len(image.shape)==2:
        image = np.expand_dims(image, -1)
    return image[:,:, 0:3]

def save_image(image_path, np_array):
    """
    Save an image in a numpy array.
    Range must be 0-255 and channel 1 or 3.
    """
    if image_path.endswith('.exr'):
        save_exr(np_array, image_path)
    else:
        Image.fromarray(np_array.astype(np.uint8)).save(image_path)

#%% SFM
#FIXME: unify the sensor/pixel size
def sfm_data_from_matrices(extrinsics, intrinsics, poses_ids,
                            intrinsics_ids, images_size, sfm_data = {}, sensor_width = 1):
    '''
    Converts calibration matrices into sfm data used in meshroom.
    The camera is assumed pinhole.
    You may pass an existing sfm_data to overwrite the parameters, otherwise you need to handle views yourself.
    The focal and sensor width is assumed in m while the principal point is assumed in pixels, as a delta from the theoreticla center.
    '''
    sfm_data['poses']=[]
    if intrinsics is not None:#needed to keep what was in sfm_data
        sfm_data['intrinsics']=[]

    for extrinsic, pose_id in zip(extrinsics, poses_ids):#Note: in, theroy we might have a pose shared between views, in practice this never happens
        #if no pose, skipping, meshroom support pose_id in vews with no pose declared.
        if extrinsic is None:
            continue
        # if extrinsic.shape[0] == 3:#make square for inverse
        #     extrinsic=np.concatenate([extrinsic, [[0,0,0,1]]], axis=0)
        translation = format_float_array(extrinsic[0:3,3])
        rotation = format_float_array(extrinsic[0:3,0:3])
        pose = {
                'poseId':str(pose_id),
                "pose": {
                        "transform":{
                                    "rotation": rotation,
                                    "center": translation
                                    },
                        "locked": "1"
                        }
                }
        sfm_data['poses'].append(pose)

    already_done_intrisics = []
    for intrinsic, intrinsic_id, image_size in zip(intrinsics, intrinsics_ids, images_size):
        if intrinsic is not None:
            if intrinsic_id in already_done_intrisics:#gets rid of the intrinsic duplication i do
                continue
            already_done_intrisics.append(intrinsic_id)
            #in meshroom, principal point is delta from center of the images, in pixels, in our case its actual pp in pixel
            pixel_size = (sensor_width/image_size[0])
            principal_point = intrinsic[0:2,2]-np.asarray(image_size)/2
            principal_point = (principal_point).astype(str).tolist()
            intrinsic_sfm = {
                            "intrinsicId": str(intrinsic_id),
                            'width':str(image_size[0]), 'height':str(image_size[1]),
                            "sensorWidth": str(sensor_width),
                            "sensorHeight": str(sensor_width*image_size[1]/image_size[0]),
                            "serialNumber": "0",
                            "type": "pinhole",
                            "initializationMode": "unknown",
                            "initialFocalLength": "0.00048828125",
                            #pass focal into "mm"
                            "focalLength": str(intrinsic[0,0]*pixel_size),
                            "pixelRatio": "1",
                            "pixelRatioLocked": "false",
                            "principalPoint": principal_point,
                            "distortionParams": "",
                            "locked": "true"
                            }
            sfm_data['intrinsics'].append(intrinsic_sfm)

    return sfm_data

def parse_intrisics_sfm_data(sfm_intrinsic):
    """
    Extracts the relevant items from a sfm pose dictionary.
    The intrinsics are given in metrics.
    """
    intrinsic_id = sfm_intrinsic['intrinsicId']
    width=int(sfm_intrinsic["width"] )
    sensor_width = abs(float(sfm_intrinsic["sensorWidth"] ))
    sensor_height = abs(float(sfm_intrinsic["sensorHeight"] ))
    pixel_size = sensor_width/width
    #principal point is given in pixel, we pass it into metric for consistency with focal
    principal_point = np.asarray([sensor_width, sensor_height])/2\
                      +pixel_size*np.asarray(sfm_intrinsic['principalPoint'], np.float32)
    focal_length = abs(float(sfm_intrinsic['focalLength']))
    intrinsic = np.asarray([
                            [focal_length, 0, principal_point[0]],
                            [0, focal_length, principal_point[1]],
                            [0, 0, 1],
                            ], np.float32)#TODO: see if we cant use projection matrices instead
    return intrinsic, intrinsic_id, pixel_size

def parse_extrisic_sfm_data(sfm_pose):
    """
    Extracts the relevant items from a sfm pose dictionary.
    The pose is camera to world.
    """
    pose_id = sfm_pose['poseId']
    rotation = np.asarray(sfm_pose['pose']['transform']['rotation'], dtype=np.float32)
    rotation = rotation.reshape([3,3])
    translation = np.asarray(sfm_pose['pose']['transform']['center'], dtype=np.float32)
    extrinsic = np.concatenate([rotation, np.expand_dims(translation, axis=-1)], axis=-1)
    return  extrinsic, pose_id

#FIXME: unify the sensor/pixel size
def matrices_from_sfm_data(sfm_data):
    '''
    Returns extrinsics and intrinsics matrices from the sfm data.
    The poses and extrinsic ids are also passed for convenience.
    If the intrinsic is unique, it will be dupliated.
    Distortion is not supported.
    '''
    extrinsics = []
    intrinsics = []
    views_id = []
    poses_id = []
    intrinsics_id = []
    pixel_sizes = []

    for sfm_pose in sfm_data['poses']:
        extrinsic, pose_id = parse_extrisic_sfm_data(sfm_pose)
        extrinsics.append(extrinsic)
        poses_id.append(pose_id)

    for sfm_intrinsic in sfm_data['intrinsics']:
        intrinsic, intrinsic_id, pixel_size = parse_intrisics_sfm_data(sfm_intrinsic)
        intrinsics.append(intrinsic)
        intrinsics_id.append(intrinsic_id)
        pixel_sizes.append(pixel_size)

    #returns view and poses for each view
    poses_id = np.asarray(poses_id)
    intrinsics_id=np.asarray(intrinsics_id)
    intrinsics_all_cams = []
    extrinsics_all_cams = []
    pixel_sizes_all_cams = []
    for view in sfm_data["views"]:
        view_id = view["viewId"]
        views_id.append(view_id)
        pose_id = view["poseId"]
        intrinsic_id = view["intrinsicId"]
        pose_index = np.where(poses_id==pose_id)[0]#FIXME: raise warning if more than one find?
        if len(pose_index)==0:#sfm could not estimate pose : None
            intrinsics_all_cams.append(None)
            extrinsics_all_cams.append(None)
            pixel_sizes_all_cams.append(None)
            logging.warning("No pose found for view "+pose_id)
            continue
        intrinsic_index = np.where(intrinsics_id==intrinsic_id)[0]
        #fetch the correspoding poses and intrinsics
        intrinsics_all_cams.append(intrinsics[intrinsic_index[0]])
        extrinsics_all_cams.append(extrinsics[pose_index[0]])
        pixel_sizes_all_cams.append(pixel_sizes[intrinsic_index[0]])

    return extrinsics_all_cams, intrinsics_all_cams, views_id, poses_id, intrinsics_id, pixel_sizes_all_cams

def gt_depth_from_sfm_data(sfm_data):
    """
    Returns depth maps associated with views, or none is there isnt any
    """
    #return none if it apears the sfm dat has no ground thruth
    if "groudtruthDepth" not in sfm_data["views"][0].keys():
        return None
    gt_depths = []
    for view in sfm_data["views"]:
        if "groudtruthDepth" not in view.keys():
            logging.warning("No ground truth found in one of the view")
            return None
        gt_depth_file = view["groudtruthDepth"]
        gt_depth=open_depth_map(gt_depth_file)
        gt_depths.append(gt_depth)
    gt_depths = np.asarray(gt_depths)
    return gt_depths

def open_txt_calibration(calib_file, dataset="blendedMVG"):
    """
    Will open a calibration file in text format.
    The format depends of the source and must be passed in parameters.
    """
    if dataset == "blendedMVG":
        return open_txt_calibration_blendedMVG(calib_file)
    # elif dataset == "ETH":
    #     return open_txt_calibration_ETH(calib_file)
    else:
        raise RuntimeError("Unknown dataset")

def open_txt_calibration_blendedMVG(calib_file):
    '''
    Opens a text file containing the calibration for a single camera, in the form :

    extrinsic
    E00 E01 E02 E03
    E10 E11 E12 E13
    E20 E21 E22 E23
    E30 E31 E32 E33

    intrinsic
    K00 K01 K02
    K10 K11 K12
    K20 K21 K22

    see https://github.com/YoYo000/MVSNet.
    '''
    intrinsics = np.zeros((3, 3))
    extrinsics = np.zeros((4, 4))
    with open(calib_file, "r") as calib_file:
        words = calib_file.read().split()
        # read extrinsic
        for i in range(0, 4):
            for j in range(0, 4):
                extrinsic_index = 4 * i + j + 1
                extrinsics[i][j] = words[extrinsic_index]
        # read intrinsic
        for i in range(0, 3):
            for j in range(0, 3):
                intrinsic_index = 3 * i + j + 18
                intrinsics[i][j] = words[intrinsic_index]

        # #extra info about depth range (unsused for now)
        # if len(words) == 29:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = max_d
        #     intrinsics[3][3] = intrinsics[3][0] + intrinsics[3][1] * intrinsics[3][2]
        # elif len(words) == 30:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = words[29]
        #     intrinsics[3][3] = intrinsics[3][0] + intrinsics[3][1] * intrinsics[3][2]
        # elif len(words) == 31:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = words[29]
        #     intrinsics[3][3] = words[30]
        # else:
        #     intrinsics[3][0] = 0
        #     intrinsics[3][1] = 0
        #     intrinsics[3][2] = 0
        #     intrinsics[3][3] = 0

    return extrinsics, intrinsics

#%% Mesh
def open_mesh(mesh_path):#FIXME: add suport to uv, texture etc
    """
    Opens a mesh and return face and vertices
    """
    import trimesh#FIXME: lazy import to avoid dependency ?
    mesh = trimesh.load(mesh_path)
    mesh = [mesh.vertices, mesh.faces ]
    return mesh

def save_obj(file, scene_points, scene_faces=None, points_colors=None):
    with open(file, 'w') as objfile:
        for point_index, point in enumerate(scene_points):
            point_string = "v "+' '.join(map(str, point))
            if points_colors is not None:
                point_string += " "+' '.join(map(str, points_colors[point_index]))
            objfile.write(point_string+"\n")
        if scene_faces is not None:
            raise BaseException("To be tested")
            for face_index, face in enumerate(scene_faces):
                face_string = "f "+' '.join(map(str, face))
                objfile.write(face_string+"\n")
