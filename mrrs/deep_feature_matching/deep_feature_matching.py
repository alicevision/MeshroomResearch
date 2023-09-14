import json
import os

from PIL import Image

import click
import numpy as np
import kornia
from kornia.feature.loftr.loftr import LoFTR
import torch

#FIXME: call to 
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


@click.command()
@click.option('--inputSfMData', help='Input sfm data')
@click.option('--verboseLevel', help='.')
@click.option('--outputFolder', help='.')
def run_matching(inputsfmdata, verboselevel, outputfolder): #note: lower caps
    """
    image correspondences and confidence scores.
    """
    print("Hello")
    # exit(-1)
    #load sfmdata
    with open(inputsfmdata, "r") as json_file:
        sfm_data = json.load(json_file)
    nb_image = len(sfm_data["views"]) 
    #init model
    device = torch.device('cuda:0')
    loftr_model = LoFTR('outdoor').to(device)#FIXME: var
    #loop over pairs of images
    keypoints_0 = []
    keypoints_1 = []
    confidences = []
    with time_it() as total_time:
        for view_index_0  in range(nb_image):#FIXME: graph?
            img1 = Image.open(sfm_data["views"][view_index_0]["path"])
            for view_index_1  in range(nb_image):
                print("Matches images %d to %d"%(view_index_0, view_index_1))
                img2 = Image.open(sfm_data["views"][view_index_1]["path"])
                #prepare images 0-1 gray level
                timg1 = kornia.color.rgb_to_grayscale(kornia.utils.image_to_tensor(np.array(img1), False).float() / 255.).to(device)
                timg2 = kornia.color.rgb_to_grayscale(kornia.utils.image_to_tensor(np.array(img2), False).float() / 255.).to(device)
                with time_it() as time:
                    out = loftr_model({"image0": timg1, "image1": timg2})
                print("%d matches found is %fs"%(out["keypoints0"].shape[0], time))
                # keypoints_0.append(out["keypoints0"].to('cpu').numpy())
                # keypoints_1.append(out["keypoints1"].to('cpu').numpy())
                # confidences.append(out["confidence"].to('cpu').numpy())
                np.savetxt(os.path.join(outputfolder, sfm_data["views"]["viewId"]+"keypoints_0"),keypoints_0)
                np.savetxt(os.path.join(outputfolder, sfm_data["views"]["viewId"]+"keypoints_1"),keypoints_1)
                np.savetxt(os.path.join(outputfolder, sfm_data["views"]["viewId"]+"confidences"),confidences)
    # np.savetxt(os.path.join(outputfolder, "keypoints_0"),keypoints_0)
    # np.savetxt(os.path.join(outputfolder, "keypoints_1"),keypoints_1)
    # np.savetxt(os.path.join(outputfolder, "confidences"),confidences)
if __name__ == '__main__':
    run_matching()