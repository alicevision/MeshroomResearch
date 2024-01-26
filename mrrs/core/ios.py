""""
Module handling the inputs and outputs from and to Meshroom.
"""

import logging
import re
from struct import unpack

import numpy as np

from mrrs.core.utils import format_float_array

FORCE_IOOI = True#FIXME: probably a good idea to open everything with openimage IO, for now not woring on windows

#%% Images
def open_exr(exr_path):
    '''
    Uses oiio to import an EXR file.
    '''
    import OpenImageIO as oiio #lazy import?
    exr_file = oiio.ImageInput.open(exr_path)
    if exr_file is None :
        raise RuntimeError("Could not open exr file "+exr_path)
    # use exra atributes as the header
    extra_attribs = exr_file.spec().extra_attribs
    header={}
    for attrib in extra_attribs:
        header[attrib.name]=attrib.value
    
    output_array = exr_file.read_image("float32")
    exr_file.close()
  
    return output_array, header

def save_exr(input_array, output_file,
            custom_header = None,
            channel_names = None):#FIXME: need to put baxk support for channel name
    """
    Saves an exr for meshroom, using different formats.
    """
    if len(input_array.shape)<2 or len(input_array.shape)>3:
        raise RuntimeError('Data type not suported for save_exr')
    elif len(input_array.shape)==2:#gray level case
        input_array = np.expand_dims(input_array, -1)
    input_array_size = input_array.shape
    import OpenImageIO as oiio
    out = oiio.ImageOutput.create(output_file)
    if out is None:
        raise RuntimeError("Could not open exr file "+output_file)
    spec = oiio.ImageSpec(input_array_size[1], input_array_size[0], input_array_size[2], 'float32')
    if custom_header is not None:
        for key in custom_header.keys():
            if key=="AliceVision:CArr":#FIXME: not working?
                spec.attribute(key, "float[3]", list(custom_header[key]))
            elif key=="AliceVision:iCamArr":
                spec.attribute(key, oiio.TypeDesc.TypeMatrix33,  list(np.asarray(custom_header[key]).flatten()))
            elif key=="AliceVision:downscale":
                spec.attribute(key, "float", custom_header[key])
            else:
                try:
                    spec[key]=custom_header[key]
                except:
                    print("WARNING: could not write attribute"+key)
    out.open(output_file, spec)
    out.write_image(input_array)
    out.close()
  
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
        depth_map, _ = open_exr(depth_file)
        depth_map = depth_map.astype(np.float32)
    else:
        if raise_exception:
            raise BaseException('Depth file format not recognised for '+depth_file)
        else:
            print('Depth file format not recognised for '+depth_file)
    return depth_map

def open_image(image_path, auto_rotate=False, return_orientation=False, to_srgb=False):
    """
    Opens an image and returns it as a np array.
    """
    # 0 normal (top to bottom, left to right)
    # 1 flipped horizontally (top to botom, right to left)
    # 2 rotated  (bottom to top, right to left)
    # 3 flipped vertically (bottom to top, left to right)
    # 4 transposed (left to right, top to bottom)
    # 5 rotated 90 clockwise (right to left, top to bottom)
    # 6 transverse (right to left, bottom to top)
    # 7 rotated 90 counter-clockwise (left to right, bottom to top)
    orientation=0#oiio standard

    import OpenImageIO as oiio
    exr_file = oiio.ImageInput.open(image_path)
    if exr_file is None:
        raise RuntimeError("Something went wrong while opening "+image_path)
    meta = exr_file.spec()
    orientation = meta.get("Orientation", orientation)
    image_buff = oiio.ImageBuf(image_path)
    if auto_rotate and orientation !=0:
        image_buff = oiio.ImageBufAlgo.reorient(image_buff)#straigten the image
    if to_srgb:
        image_buff = oiio.ImageBufAlgo.colorconvert(image_buff,meta.get("oiio:ColorSpace"), "sRGB")
    
    image = 255*np.clip(image_buff.get_pixels(), 0, 1)#return float and whole roi by default

    if len(image.shape)==2:
        image = np.expand_dims(image, -1)
    if return_orientation:
        return image[:,:, 0:3], orientation
    else:
        return image[:,:, 0:3]

def save_image(image_path, np_array, orientation=None, auto_rotate=False):
    """
    Save an image in a numpy array.
    Range must be 0-255 and channel 1 or 3.
    """
    import OpenImageIO as oiio
    out = oiio.ImageOutput.create(image_path)
    if out is None:
        raise RuntimeError("Could not open file "+image_path)
    spec = oiio.ImageSpec(np_array.shape[1], np_array.shape[0], np_array.shape[2], oiio.UINT8)
    out.open(image_path, spec)
    out.write_image(np_array.astype(np.uint8))
    out.close()

    if orientation is not None:
        image_buff = oiio.ImageBuf(image_path)
        image_buff.orientation=orientation
        if auto_rotate and orientation != 0:
            #reverso rotation
            if orientation == 1:
                reverse_orientation = 3
            elif orientation == 3:
                reverse_orientation = 1
            elif orientation == 2:
                reverse_orientation = 4
            elif orientation == 4:
                reverse_orientation = 2
            elif orientation == 5:
                reverse_orientation = 7
            elif orientation == 7:
                reverse_orientation = 5
            elif orientation == 6:
                reverse_orientation = 8
            elif orientation == 8:
                reverse_orientation = 6
            #apply inverse
            image_buff.orientation=reverse_orientation
            image_buff = oiio.ImageBufAlgo.reorient(image_buff)
            #but right meta
            image_buff.orientation=orientation
        image_buff.write(image_path)
 

# %%

#%% SFM
#FIXME: unify the sensor/pixel size, also we open it in mm but expect save from pixels
def sfm_data_from_matrices(extrinsics, intrinsics, poses_ids,
                            intrinsics_ids, images_size, sfm_data = {}, sensor_width = 1):
    '''
    Converts calibration matrices into sfm data used in meshroom.
    The camera is assumed pinhole.
    You may pass an existing sfm_data to overwrite the parameters, otherwise you need to handle views yourself.
    the principal point is assumed in pixels, as a delta from the theoreticla center
    focal in pixels
    '''
    sfm_data = sfm_data.copy()
    sfm_data['poses']=[]
    if intrinsics is not None:#needed to keep what was in sfm_data
        sfm_data['intrinsics']=[]

    for extrinsic, pose_id in zip(extrinsics, poses_ids):#Note: in, theory we might have a pose shared between views, in practice this never happens
        #if no pose, skipping, meshroom support pose_id in vews with no pose declared.
        if extrinsic is None:
            print('No extrinsic for view pose '+pose_id)
            continue

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
            principal_point = intrinsic[0:2,2]-np.asarray(image_size)/2#FIXME: our pp is in mm?!
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
    sensor_height = abs(float(sfm_intrinsic["sensorHeight"] )) #FIXME: not axtually used, sensor_heightis pixelratio*sensor_widtha
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

def get_image_sizes(sfm_data):
    return [ (int(view["width"]), int(view["height"])) for view in sfm_data["views"] ]
    

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
    """
    Home made obj save function
    """
    with open(file, 'w') as objfile:
        for point_index, point in enumerate(scene_points):
            point_string = "v "+' '.join(map(str, point))
            if points_colors is not None:
                point_string += " "+' '.join(map(str, points_colors[point_index]))
            objfile.write(point_string+"\n")
        if scene_faces is not None:
            for face_index, face in enumerate(scene_faces):
                face_string = "f "+' '.join(map(str, face))
                objfile.write(face_string+"\n")