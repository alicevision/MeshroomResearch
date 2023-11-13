import json
import os
import struct
import sys
import click
import numpy as np
import kornia
import torch 
from torch.nn.functional import pad

sys.path.append(os.path.abspath(__file__))
from utils import time_it, open_and_prepare_image

FEATURE_SIZE = 128

#todo add 
# FEATURE_TYPES = ["DISK", "SIFTFeature", "SIFTFeatureScaleSpace", 
#                  "GFTTAffNetHardNet", "KeyNetAffNetHardNet", "KeyNetHardNet"]

@click.command()
@click.option('--inputSfMData', help='Input sfm data')
@click.option('--outputFolder', help='Output to store the results in')
@click.option('--method', type=click.Choice(["DISK", "SIFT"]), help="Feature extraction method")
@click.option('--verboseLevel', help='.')#FIXME: todo

def run_extraction(inputsfmdata, outputfolder, method, verboselevel): 
    """
    run the feature detection and description
    """
    print("Hello")

    #load sfmdata
    print("Loading sfm data")
    with open(inputsfmdata, "r") as json_file:
        sfm_data = json.load(json_file)
    nb_image = len(sfm_data["views"]) 
    all_view_ids = [v["viewId"] for v in sfm_data["views"]]

    #init model
    print("Loading model")
    device = torch.device('cuda:0')
    feature_model = None
    if method == "DISK":
        feature_model = kornia.feature.DISK.from_pretrained("depth").to(device)
    elif method == "SIFT":
        feature_model = kornia.feature.SIFTFeature(num_features=8000,  device=device)
    else:
        raise RuntimeError("Method no valid")
    feature_model=feature_model.to(device)
    #loop over images
    for view_index_0 in range(nb_image):
        with time_it() as t:
            timage_0, uid_image_0, _,_  = open_and_prepare_image(sfm_data, view_index_0, device, grayscale=False)
            if method == "DISK":
                #pad image to be divisible by 16   
                image_size = np.asarray(timage_0.shape[2:4])
                new_image_size = (np.ceil(image_size/16)*16).astype(np.int32)
                padding= new_image_size-image_size
                if padding[0] !=0 or padding[1] != 0:
                    timage_0 = pad(timage_0, (0,0,padding[0],padding[1]) , value=0)#bad on right/bottom
            if method == "SIFT":
                timage_0 = kornia.color.rgb_to_grayscale(timage_0)
            #get features from image
            with torch.no_grad():
                output = feature_model(timage_0)

            if method == "DISK":
                keypoints=output[0].keypoints.cpu()
                descriptors=output[0].descriptors.cpu()
                #remove keypoints/descriptors in padding
                outside = (keypoints[:,0]>=image_size[1]) | (keypoints[:,1]>=image_size[0])
                print("removing %d kp"%np.count_nonzero(outside))
                keypoints = keypoints[~outside]
                descriptors = descriptors[~outside]
            elif method == "SIFT":
                keypoints=output[0].cpu()
                descriptors=output[2].cpu()
            #write all keypoints
            kp_filename = os.path.join(outputfolder,uid_image_0+".unknown.feat")
            with open(kp_filename, "w") as kpf:
                for kp_x, kp_y in keypoints:
                    kpf.write("%f %f 0 0\n"%(kp_x, kp_y))

            # write descriptors as in aliceVision
            # https://github.com/alicevision/AliceVision/blob/develop/src/aliceVision/feature/Descriptor.hpp#L255C13-L255C33
            desk_filename = os.path.join(outputfolder,uid_image_0+".unknown.desc")
            #TODO: pad descrippr descriptors.shape[0] to FEATURE_SIZE 
            #TODO: put that in fc
            with open(desk_filename, "wb") as df:
                #nb of desc, as size_t (should be 1 byte)
                nb_desv_encoded = struct.pack('N', int(descriptors.shape[0]))
                df.write(nb_desv_encoded)
                for descriptor in descriptors:#write descriptor as floats (4 bytes)
                    for d in descriptor:
                        d=struct.pack('f', d)
                        df.write(d)
                
        remaining = (nb_image-view_index_0-1)*float(t)    
        print("Extraction done in %fs (%d desc of size %d est remaining %fs/%fm)"%(t,descriptors.shape[0], descriptors.shape[1],remaining, remaining/60.0))
        
if __name__ == '__main__':
    run_extraction()