"""
Module containing utility functions that do not fall into another module.
"""

import time
import numpy as np
import cv2
import os
import sys

#%%Folder scan
def listdir_fullpath(d):
    return [os.path.join(d, f) for f in os.listdir(d)]

#%% usefull array operations
def format_float_array(np_array):
    np_array = np_array.reshape([-1])
    output_list = []
    for element in np_array:
        output_list.append(np.format_float_positional(element, precision=17, unique=False))
    return output_list

def norm_01(input_array):
    """
    Normalise an array input_array between 0 and 1.
    """
    min_value = np.amin(input_array)
    max_value = np.amax(input_array)
    return (input_array-min_value) / (max_value-min_value)

def encode_uniques(input_array, uniques=None):
    """
    Assign an integer to each unique value of input_array an returns
    the transforned input_array and unique values to decode.
    """
    input_array=np.asarray(input_array)
    if uniques is None:
        uniques = np.unique(input_array)#super long for strings arrays
    output_indices = np.zeros(input_array.shape, dtype=np.int32)
    for index, unique in enumerate(uniques) :
        output_indices[input_array==unique] = index
    return output_indices, uniques

def vectorised_dot(input_array_0, input_array_1):
    """
    Compute the dot protuct between arrays of vectors of same size.
    """
    #return np.diag(input_array_0@np.transpose(input_array_1))#lots of useless operations, not efficicient
    return np.einsum('ij,ij->i',input_array_0,input_array_1)#einsum is good for you

def cross_with_broacsat(input_array_0, input_array_1):
    """
    cross product but will broadcast
    """
    c = np.einsum('ij,kj->ikj',np.roll(input_array_0, 1, axis=-1),np.roll(input_array_1, -1, axis=-1)) # [a2b3,a3b1,a1b2] for each vector*face
    d = np.einsum('ij,kj->ikj',np.roll(input_array_0, -1, axis=-1),np.roll(input_array_1, 1, axis=-1)) # [a3b2,a1b3,a2b1]  for each vector*face
    return c-d

#%% Debug and dev functions
class time_it():
    """
    Context class to measure elapsed time.
    Can be cast to float.
    """
    def __init__(self):
        self.start_time = np.nan
        self.end_time  = np.nan
    def __enter__(self):
        self.start_time = time.time()
        return self
    def __exit__(self, type, value, traceback):
        self.end_time= time.time()
    def __float__(self):
        return float(self.end_time- self.start_time)
    def __coerce__(self, other):
        return (float(self), other)
    def __str__(self):
        return str(float(self))
    def __repr__(self):
        return str(float(self))

#%% Coloring
def get_label_colors(input_array):#FIXME: test and integrate
    """
    Returns color-coded labels for an array.
    """
    label_indices, indices = encode_uniques(input_array)
    np.random.seed(0)#fix the seed for repeatability
    colormap = [[255,0,0],[0,255,0],[0,0,255], ]
    colormap += [(np.random.rand(3)*255).astype(np.uint8) for _ in indices]

    return colormap[label_indices]

#%% Functional
def recursive_call(object, function, stop_condition):
    """
    Will recursively call function on each element of object, until object is not iterable or stop_condition(object) is met
    """
    #if not iterable => leaf
    if (not hasattr(object, '__iter__')) or stop_condition(object) :
        return function(object)
    #else we loop
    return_elements = []
    for element in object:
        return_elements.append(recursive_call(element, function, stop_condition))
    return tuple(return_elements)


#%% Image manipulation
def cv2_resize_with_pad(image, new_shape, interpolation=cv2.INTER_NEAREST, padding_color = (255, 255, 255)):
    """
    Maintains aspect ratio and resizes with padding.
    """
    original_shape = (image.shape[1], image.shape[0])
    # ratio = float(max(new_shape))/max(original_shape)
    ratio = min(new_shape[0]/original_shape[0], new_shape[1]/original_shape[1])
    new_size = tuple([int(x*ratio) for x in original_shape])
    image = cv2.resize(image, new_size, interpolation=interpolation)
    delta_w = new_shape[0] - new_size[0]
    delta_h = new_shape[1] - new_size[1]
    top, bottom = delta_h//2, delta_h-(delta_h//2)
    left, right = delta_w//2, delta_w-(delta_w//2)
    image = cv2.copyMakeBorder(image, top, bottom, left, right, cv2.BORDER_CONSTANT, value=padding_color)
    return image, (top, bottom, left, right)

def cv2_resize_crop(image, new_shape, crop, interpolation):
    """
    Removes padding and resizes an image to the target dimention.
    """
    image = image[crop[0]:-(crop[1]+1), crop[2]:-(crop[3]+1)]
    image = cv2.resize(image, new_shape, interpolation=interpolation)
    return image

def do_system(arg):
	print(f"==== running: {arg}")
	err = os.system(arg)
	if err:
		print("FATAL: command failed")
		sys.exit(err)
