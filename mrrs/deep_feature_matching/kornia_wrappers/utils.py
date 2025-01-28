from PIL import Image
import numpy as np
import struct

import kornia 

def open_and_prepare_image(sfm_data, index, device, grayscale=True):
    """
    Opens and prepare an image tensor from sfm data
    """
    
    image_0 = np.asarray(Image.open(sfm_data["views"][index]["path"]))#FIXME: replace will call to open_image
    image_0 = image_0[:,:,0:3]
    uid_image_0 = sfm_data["views"][index]["viewId"]
    frame_id = int(sfm_data["views"][index]["frameId"])
    timage_0=kornia.utils.image_to_tensor(image_0, False).float() / 255.
    if grayscale:
        timage_0 = kornia.color.rgb_to_grayscale(timage_0)
    timage_0=timage_0.to(device)
    return timage_0,  uid_image_0, image_0, frame_id


#FIXME: call to mrrs, see with kelian conda node 
import time 
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
