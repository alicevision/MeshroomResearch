import struct 
import numpy as np
import os
import tensorflow as tf #pip install tensorflow==2.9.1
from PIL import Image#pip install pillow
#conda install -c conda-forge openexr-python
import OpenEXR as oexr
import Imath

def normalise_01(tensor):
     return (tensor-tf.reduce_min(tensor))/(tf.reduce_max(tensor)-tf.reduce_min(tensor))

def open_image(image_path):
    """
    Opens, batches and rescale images.
    """
    image = tf.convert_to_tensor(Image.open(image_path), dtype=tf.uint8)
    if len(image.shape) == 2:#grayscale case
        image = tf.stack([image, image, image], axis=-1)
    image = tf.cast(tf.expand_dims(image, axis=0), tf.float32)/255
    return image

def open_exr(exr_path, clip_negative=True):
    exr_file =   oexr.InputFile(exr_path)
    header = exr_file.header()
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
    output_array =  tf.convert_to_tensor(output_array, dtype=tf.float32)
    return tf.expand_dims(output_array, axis=0)

def open_npy(npy_path):
    """
    Open, batches and normalises an npy
    """
    npy = tf.convert_to_tensor(np.load(npy_path), dtype=tf.float32)
    if len(npy.shape) == 2:#if no channel add one
        npy = tf.expand_dims(npy, axis=-1)
    npy = tf.expand_dims(npy, axis=0)
    #normalise btw 0 and 1 
    npy=normalise_01(npy)
    return npy

def open_pfm(filename):
    with os.Path(filename).open('rb') as pfm_file:
        line1, line2, line3 = (pfm_file.readline().decode('latin-1').strip() for _ in range(3))
        assert line1 in ('PF', 'Pf')
        channels = 3 if "PF" in line1 else 1
        width, height = (int(s) for s in line2.split())
        scale_endianess = float(line3)
        bigendian = scale_endianess > 0
        scale = abs(scale_endianess)
        buffer = pfm_file.read()
        samples = width * height * channels
        assert len(buffer) == samples * 4
        fmt = f'{"<>"[bigendian]}{samples}f'
        decoded = struct.unpack(fmt, buffer)
        shape = (height, width, 3) if channels == 3 else (height, width)
        return np.flipud(np.reshape(decoded, shape)) * scale
