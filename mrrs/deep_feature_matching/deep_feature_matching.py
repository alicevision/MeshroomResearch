import json
import os

from PIL import Image
import click
import numpy as np

import kornia
from kornia.feature.loftr.loftr import LoFTR
import torch

import cv2

#FIXME: call to mrr, see with kelian conda node 
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
@click.option('--outputFolder', help='Output to store the results in')
@click.option('--imageMaching', default="all", help=("Method to select the views to be matched. 'all' will match all the views."
                                                    +"If a number is passed, will assume sequence and the number is going to be half window around a frame to compute the maches into"
                                                    ))
@click.option('--keepNmatches', default=0, type=int, help='If specified will keep the n first matches between views')
@click.option('--debugImages', default=False, type=bool, help='Will Write match images')
@click.option('--verboseLevel', help='.')#FIXME: todo
def run_matching(inputsfmdata, outputfolder, imagemaching, 
                 keepnmatches, debugimages, verboselevel): #note: lower caps
    """
    Will runs loftr on the input set of images.
    Writes meshroom feature and maches files.
    Since loftr matches features in a grid from image 0 to floating features on image 1, i is not bijective.
    We consider the feature grid on image 0 as common features, wile the matced features are saved independedtly.
    """
    #To debug
    print("Hello")
    extention = ".sift.feat"#".loftr.feat" #FIXME: for now we write  as sift
    model = 'outdoor'#FIXME: var

    #creates output folders
    print("Creating output folders")
    feature_folder = os.path.join(outputfolder, "features")
    matches_folder = os.path.join(outputfolder, "matches")
    os.makedirs(feature_folder, exist_ok=True)
    os.makedirs(matches_folder, exist_ok=True)

    #load sfmdata
    print("Loading sfm data")
    with open(inputsfmdata, "r") as json_file:
        sfm_data = json.load(json_file)
    nb_image = len(sfm_data["views"]) 

    #init model
    print("Loading model")
    device = torch.device('cuda:0')
    loftr_model = LoFTR(model).to(device)

    #use full functions
    def open_and_prepare_image(sfm_data, index):
        """
        Opens and prepare an image tensor from sfm data
        """
        image_0 = np.asarray(Image.open(sfm_data["views"][index]["path"]))
        uid_image_0 = sfm_data["views"][index]["viewId"]
        frame_id = int(sfm_data["views"][index]["frameId"])
        timage_0 = kornia.color.rgb_to_grayscale(kornia.utils.image_to_tensor(image_0, False).float() / 255.).to(device)
        return timage_0,  uid_image_0, image_0, frame_id
    
    def get_all_keypoints(feature_map_size):
        """
        Get all possibles features in an image
        """
        all_keypoints_0_x, all_keypoints_0_y = np.meshgrid(range(feature_map_size[1]), range(feature_map_size[0]))
        all_keypoints_0_x=8*all_keypoints_0_x.flatten()
        all_keypoints_0_y=8*all_keypoints_0_y.flatten()
        return all_keypoints_0_x, all_keypoints_0_y

    #loop over pairs of images
    #we ned this to keep track of the feature indices
    nb_features = [0 for _ in range(nb_image)]
    #write all possible features on image 0 (to make sure thay are in the first indices)
    print("Preparing feature files")
    with time_it() as t:
        for view_index_0 in range(nb_image):
            print("writting file for view %d/%d"%(view_index_0, nb_image), end="\r")
            timage_0, uid_image_0, image_0,_  = open_and_prepare_image(sfm_data,view_index_0)
            #each feature in image 0 has coords int(X/8)
            feature_map_size = (np.asarray(timage_0.shape[2:])/8.0).astype(np.int32)
            #all potential keypoints in image 0
            all_keypoints_0_x, all_keypoints_0_y = get_all_keypoints(feature_map_size)
            #write all keypoints 0 
            with open(os.path.join(feature_folder,uid_image_0+extention), "w") as kpf:
                for kp_x, kp_y in zip(all_keypoints_0_x, all_keypoints_0_y):
                    kpf.write("%f %f 0 0\n"%(kp_x, kp_y))
            #update offsets for view 0
            nb_features[view_index_0]+=all_keypoints_0_x.shape[0]
    #FIXME: assume constant feaure map size and keep latest
    #to retrieve the index later
    def map_indices(X):
        """
        maps a float x,y feature coord into a linear index 
        """
        x,y=(np.asarray(X)/8.0).astype(np.int32)
        if (x > feature_map_size[1]) or (y > feature_map_size[0]):
            raise RuntimeError("Feature outside of feature map (%d %d) vs (%d %d)"%(x,y,feature_map_size[0], feature_map_size[1]))
        linear_index =  feature_map_size[1]*y+x.astype(np.int32)
        return linear_index
    print("\nDone in %f seconds"%t)
    print("Running matching")
    with time_it() as total_time:
        for view_index_0 in range(nb_image):
            #open and prepare
            timage_0, uid_image_0, image_0, frame_id_0  = open_and_prepare_image(sfm_data,view_index_0)

            #depending of the matching method, we get a list of views to match
            view_indices_1 = []
            if imagemaching.isnumeric():
                view_indices_1 = [i for i,view in enumerate(sfm_data["views"])
                                    if abs(int(view["frameId"])-frame_id_0)<=int(imagemaching)]
            elif imagemaching == "all":
                view_indices_1=range(nb_image) 
            else:
                raise RuntimeError("imagemaching not valid")#FIXME: graph?
            
            #for all the other images
            print("View %d, frame id %d to be matched with:"%(view_index_0, view_index_0))
            print(view_indices_1)
            print("Frame ids")
            [print(sfm_data["views"][f]["frameId"]) for f in view_indices_1]
            with time_it() as t:        
                for view_index_1  in view_indices_1:
                    #if same image, skip
                    if view_index_0 == view_index_1:
                        continue
                    # print("\nMatches images %d to %d\n"%(view_index_0, view_index_1))

                    #open and prepare second image
                    timage_1, uid_image_1, image_1, _ = open_and_prepare_image(sfm_data,view_index_1)

                    #run loftr and get results
                    out = loftr_model({"image0": timage_0, "image1": timage_1})
                    keypoints_0=out["keypoints0"].to('cpu').numpy()
                    keypoints_1=out["keypoints1"].to('cpu').numpy()
                    confidences=out["confidence"].to('cpu').numpy()
                    nb_keypoint = keypoints_0.shape[0]
              
                    #sort by confidence (descending)
                    order = np.argsort(-confidences)
                    keypoints_0=keypoints_0[order]
                    keypoints_1=keypoints_1[order]

                    if debugimages:
                        #display N strongest matches
                        img_matches_display = np.concatenate([image_0, image_1], axis=1)
                        n=keepnmatches
                        p=1
                        o=image_0.shape[1]
                        for kp in keypoints_0[0:n]:
                            img_matches_display[int(kp[1])-p:int(kp[1])+p,
                                        int(kp[0])-p:int(kp[0])+p, :]=[255,0,0]
                        for kp in keypoints_1[0:n]:
                            img_matches_display[int(kp[1])-p:int(kp[1])+p,
                                                o+int(kp[0])-p:o+int(kp[0])+p, :]=[0,255,0]
                        for kp0, kp1 in zip(keypoints_0[0:n], keypoints_1[0:n]):
                            cv2.line(img_matches_display, (int(kp0[0]),int(kp0[1])), (int(o+kp1[0]),int(kp1[1])), color = [0,0,255])
                        Image.fromarray(img_matches_display).save(os.path.join(outputfolder, uid_image_0+"_"+uid_image_1)+".png")
                    
                    #Write features on img 2 as brand new features
                    with open(os.path.join(feature_folder,uid_image_1+extention), "a+") as kpf:
                        for kp  in keypoints_1:
                            kpf.write("%f %f 0 0\n"%(kp[0], kp[1]))

                    #Write matches, note "0." beacause mewhroom suports several matches files for batching
                    #if we dont define a threshold, will write all matches, otherwise will write only the n best matches
                    if keepnmatches == 0:
                        keepnmatches = nb_keypoint
                    else:
                        keepnmatches = min(keepnmatches, nb_keypoint)
                    with open(os.path.join(matches_folder,"0.matches.txt"), "a+") as mf:
                        mf.write("%s %s\n"%(uid_image_0, uid_image_1))
                        mf.write("1\n")
                        mf.write("sift %d\n"%(keepnmatches))#for now we disuise as sift
                        for kp_indx in range(keepnmatches):#save feature index with offset for each view
                            keypoint_0_index = map_indices(keypoints_0[kp_indx])#retrieve index in the pre-written features
                            keypoint_1_index = kp_indx+nb_features[view_index_1]#index is offsetted by the olready written featuress
                            mf.write("%d %d\n"%(keypoint_0_index, keypoint_1_index))
                    
                    #update offsets for view 1
                    nb_features[view_index_1]+=nb_keypoint
            #FIXME: remainng time would be more convenient
            print("Maches for view %d/%d done (%fs, est. total for view %f, est. total %f)"%(view_index_0, nb_image, t, float(t)*len(view_indices_1), nb_image*float(t)*len(view_indices_1)), end="\r")

    print("Matching done in %fs"%total_time)
        
if __name__ == '__main__':
    run_matching()