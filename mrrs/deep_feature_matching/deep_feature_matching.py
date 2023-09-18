import json
import os

from PIL import Image
import click
import numpy as np
import cv2
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
    feature_folder = os.path.join(outputfolder, "features")
    matches_folder = os.path.join(outputfolder, "matches")
    os.makedirs(feature_folder, exist_ok=True)
    os.makedirs(matches_folder, exist_ok=True)
    #load sfmdata
    with open(inputsfmdata, "r") as json_file:
        sfm_data = json.load(json_file)
    nb_image = len(sfm_data["views"]) 
    #init model
    device = torch.device('cuda:0')
    loftr_model = LoFTR('outdoor').to(device)#FIXME: var
    
    #loop over pairs of images
    nb_features = [0 for i in range(nb_image)]#number of features per images
    with time_it() as total_time:
        for view_index_0  in range(nb_image):#FIXME: graph?
            image_0 = Image.open(sfm_data["views"][view_index_0]["path"])
            uid_image_0 = sfm_data["views"][view_index_0]["viewId"]
            timage_0 = kornia.color.rgb_to_grayscale(kornia.utils.image_to_tensor(np.array(image_0), False).float() / 255.).to(device)
            for view_index_1  in range(nb_image):
                print("Matches images %d to %d"%(view_index_0, view_index_1))
                image_1 = Image.open(sfm_data["views"][view_index_1]["path"])
                uid_image_1 = sfm_data["views"][view_index_1]["viewId"]
                timage_1 = kornia.color.rgb_to_grayscale(kornia.utils.image_to_tensor(np.array(image_1), False).float() / 255.).to(device)
                with time_it() as time:
                    out = loftr_model({"image0": timage_0, "image1": timage_1})
                keypoints_0=out["keypoints0"].to('cpu').numpy()
                keypoints_1=out["keypoints1"].to('cpu').numpy()
                confidences=out["confidence"].to('cpu').numpy()
                nb_keypoint = keypoints_0.shape[0]
                print("%d matches found is %fs"%(nb_keypoint, time))
                #FIXME: confidence threshold?

                #Write features (note: we combine features from several matches)
                #format is x y scale orientation, we use scale for confidence
                #TODO: need index
                extention = ".sift.feat"#".loftr.feat" #FIXME: for now we deize as sift
                with open(os.path.join(feature_folder,uid_image_0+extention), "a+") as kpf:
                    for kp,c in zip(keypoints_0, confidences):
                        kpf.write("%f %f %f 0\n"%(kp[0], kp[1], c))
                with open(os.path.join(feature_folder,uid_image_1+extention), "a+") as kpf:
                    for kp,c  in zip(keypoints_1, confidences):
                        kpf.write("%f %f %f 0\n"%(kp[0], kp[1], c))
                #Write maches, note 0 beacause mewhroom suports several matches files for batching
                with open(os.path.join(matches_folder,"0.matches.txt"), "a+") as mf:
                    mf.write("%s %s\n"%(uid_image_0, uid_image_1))
                    mf.write("1\n")
                    #kpf.write("loftr %d\n"%(nb_keypoint))
                    mf.write("sift %d\n"%(nb_keypoint))#for now we disuise as sift
                    for kp_indx in range(nb_keypoint):#save feature index with offset
                        mf.write("%d %d\n"%(kp_indx+nb_features[view_index_0], kp_indx+nb_features[view_index_1]))
                    #update offsets
                    nb_features[view_index_0]+=nb_keypoint
                    nb_features[view_index_1]+=nb_keypoint
                # img_matches_display = np.concatenate([np.array(image_0), np.array(image_1)], axis=1)
                # p=1
                # o=np.array(image_0).shape[1]
                # for kp in keypoints_0:
                #     img_matches_display[int(kp[1])-p:int(kp[1])+p,
                #                  int(kp[0])-p:int(kp[0])+p, :]=[255,0,0]
                # for kp in keypoints_0:
                #     img_matches_display[int(kp[1])-p:int(kp[1])+p,
                #                         o+int(kp[0])-p:o+int(kp[0])+p, :]=[0,255,0]
                # for kp0, kp1 in zip(keypoints_0, keypoints_0):
                #     cv2.line(img_matches_display, kp0, kp1, color = [0,0,255])
                # Image.fromarray(img_matches_display).save(os.path.join(outputfolder, uid_image_0+"_"+uid_image_1)+".png")
                # print("done")
                
if __name__ == '__main__':
    run_matching()