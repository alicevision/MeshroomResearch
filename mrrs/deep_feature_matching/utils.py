from PIL import Image

import numpy as np
import struct

#FIXME: imports
def open_and_prepare_image(sfm_data, index, device, grayscale=True):
    """
    Opens and prepare an image tensor from sfm data
    """
    import kornia 
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

#FIXME: all of this should be in core
def open_image_grapĥ(imagepairs, nb_image):
    with open(imagepairs, 'r') as matchfile:
        matches_raw = matchfile.readlines()
    #one line per image
    image_pairs = [line.strip().split(" ") for line in matches_raw]
    if len(image_pairs) !=  nb_image:
        if len(image_pairs) ==  nb_image-1:#file is not properly written in AV, if last image no match, no \n
            image_pairs.append("")
        else:
            raise RuntimeError("Malformed image match file, %d vs %d images"%(len(image_pairs), nb_image-1))
    return image_pairs

def open_descriptor_file(descriptor_file):
    with open(descriptor_file, "rb") as df:
        #read number of desc from first byte
        nb_desv_encoded = struct.unpack('N', df.read(struct.calcsize('N')))[0]
        #read rematinign floats
        descriptors = np.asarray(list(struct.iter_unpack('f', df.read())))
        descriptors=np.reshape(descriptors, (nb_desv_encoded, -1))
    return descriptors
    
def write_descriptor_file(descriptors, desk_filename):
    with open(desk_filename, "wb") as df:
        #nb of desc, as size_t (should be 1 byte)
        nb_desv_encoded = struct.pack('N', int(descriptors.shape[0]))
        df.write(nb_desv_encoded)
        for descriptor in descriptors:#write descriptor as floats (4 bytes)
            for d in descriptor:
                d=struct.pack('f', d)
                df.write(d)
