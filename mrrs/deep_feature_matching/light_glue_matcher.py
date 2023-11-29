import json
import os
import sys

import click
import numpy as np

import kornia
import torch

sys.path.append(os.path.abspath(__file__))
from utils import time_it, open_image_grapĥ, open_descriptor_file

@click.command()
@click.option('--inputSfMData', help='Input sfm data')
@click.option('--inputFeatureFolder', help='Input feature folder')
@click.option('--outputFolder', help='Output to store the results in')
@click.option('--imageMaching', default="all", help=("Method to select the views to be matched. 'all' will match all the views."
                                                    +"If a number is passed, will assume sequence and the number is going to be half window around a frame to compute the maches into"
                                                    +"If 'file' open the matches from the file in imagePairs"))
@click.option('--imagePairs', default="", help=("Image pair file to be used for the image matching"))
@click.option('--keepNmatches', default=0, type=int, help='If specified will keep the n first matches between views')
@click.option('--distanceThreshold', default=0.0, type=float, help='If specified will only keep the matches with at least this confidence')
@click.option('--verboseLevel', help='.')#FIXME: todo
def run_matching(inputsfmdata, outputfolder, inputfeaturefolder,
                 imagemaching, imagepairs,
                 keepnmatches, distancethreshold,
                 verboselevel): #note: lower caps
    """
    """
    print("Hello")
    print(kornia.__version__)

    extention = "unknown"
    feature_type = "disk"#FIXME: parameter

    def open_and_prepare_features(sfm_data, index, device):
        uid_image = sfm_data["views"][index]["viewId"]
        frame_id = int(sfm_data["views"][index]["frameId"])
        image_size = (int(sfm_data["views"][index]["width"]),
                      int(sfm_data["views"][index]["height"]))
        keypoint_file=os.path.join(inputfeaturefolder, uid_image+"."+extention+".feat")
        features=np.loadtxt(keypoint_file)[:,0:2]
        descriptor_file=os.path.join(inputfeaturefolder, uid_image+"."+extention+".desc")
        descritors = open_descriptor_file(descriptor_file)
        features = torch.from_numpy(features).to(device).to(torch.float32)
        descritors = torch.from_numpy(descritors).to(device).to(torch.float32)
        return features, descritors, uid_image, frame_id, image_size

    #Load sfmdata
    print("Loading sfm data")
    with open(inputsfmdata, "r") as json_file:
        sfm_data = json.load(json_file)
    nb_image = len(sfm_data["views"]) 
    all_view_ids = [v["viewId"] for v in sfm_data["views"]]

    #opening imagematching file if any
    if imagemaching == "file":
        print("Opening imagepairs file:")
        image_pairs=open_image_grapĥ(imagepairs, nb_image)

    #creates output folders
    print("Creating output folder")
    matches_folder = os.path.join(outputfolder, "matches")
    os.makedirs(matches_folder, exist_ok=True)

    #init model
    print("Loading model")
    device = torch.device('cuda:0')
    lightglue_model = kornia.feature.LightGlue(feature_type).to(device)

    print("Running matching")
    with time_it() as total_time:
        for view_index_0 in range(nb_image):
            #open and prepare fearures for image 0
            features_0, descritors_0, uid_image_0, frame_id_0, image_size_0  = open_and_prepare_features(sfm_data, view_index_0, device)

            #depending of the matching method, we get a list of views to match
            view_indices_1 = []
            if imagemaching.isnumeric():
                view_indices_1 = [i for i,view in enumerate(sfm_data["views"])
                                    if abs(int(view["frameId"])-frame_id_0)<=int(imagemaching)]
            elif imagemaching == "all":
                view_indices_1=range(nb_image) 
            elif imagemaching == "file":
                view_uids_1 = image_pairs[view_index_0]
                view_indices_1 = [all_view_ids.index(v) for v in view_uids_1 if v != ""]
            elif imagemaching == "uni":
                view_indices_1=range(view_index_0, nb_image) 
            else:
                raise RuntimeError("Invalid imagemaching argument")

            with time_it() as t:        
                for view_index_1  in view_indices_1:
                    #if same image, skip
                    if view_index_0 == view_index_1:
                        continue
                    # print("\nMatches images %d to %d\n"%(view_index_0, view_index_1))

                    #open and prepare second image
                    features_1, descritors_1, uid_image_1, _, _ = open_and_prepare_features(sfm_data, view_index_1, device)

                    if (descritors_0.shape[0] < 2) or (descritors_0.shape[0] < 2):
                        print("Not enough keypoints, skipping\n")
                        continue

                    hw_0 = torch.Tensor(image_size_0)
                    hw_1 = torch.Tensor(image_size_0)#FIXME: assumes same image size
                    # print(features_0.shape)
                    # print(features_1.shape)
                    # print(descritors_0.shape)
                    # print(descritors_1.shape)
                    input_dict = {
                                    "image0": {
                                        "keypoints": torch.unsqueeze(features_0, dim=0),
                                        "descriptors": torch.unsqueeze(descritors_0, dim=0),
                                        "image_size": torch.unsqueeze(hw_0.to(device), dim=0),
                                    },
                                    "image1": {
                                        "keypoints": torch.unsqueeze(features_1, dim=0),
                                        "descriptors": torch.unsqueeze(descritors_1, dim=0),
                                        "image_size": torch.unsqueeze(hw_1.to(device), dim=0),
                                    }
                                  }
                    pred = lightglue_model(input_dict)
                    matches, distance = pred["matches"], pred["scores"]

                    distance=distance[0].detach().cpu().numpy()
                    matches=matches[0].detach().cpu().numpy()
         
                    #sort by confidence (distance descending)
                    order = np.argsort(distance)
                    matches=matches[order]

                    # print(matches.shape)

                    #if we dont define a max nb of match, will write all matches, otherwise will write only the n best matches
                    if keepnmatches == 0:
                        nb_to_write = matches.shape[0]
                    else:
                        nb_to_write = min(keepnmatches, matches.shape[0])
                   
                    #if we passed confidenceThreshold, will find the index dynamically such that the remaining matches keep the trheshold
                    if  distancethreshold !=0:
                        #will return index of first occurence of confidence bellow the threshold=> index when we stop
                        nb_to_write = np.argmin(distance<distancethreshold)

                    #Write matches, note "0." beacause mewhroom suports several matches files for batching
                    with open(os.path.join(matches_folder,"0.matches.txt"), "a+") as mf:
                        mf.write("%s %s\n"%(uid_image_0, uid_image_1))
                        mf.write("1\n")
                        mf.write("unknown %d\n"%(nb_to_write))#for now we disuise as sift
                        for kp_indx in range(nb_to_write):#save feature index with offset for each view
                            mf.write("%d %d\n"%(matches[kp_indx][0], matches[kp_indx][1]))
                    

            print("Matches for view %d/%d done for %d views, in %fs (est. remaining if constant %fm)"%(view_index_0+1, 
            nb_image, len(view_indices_1), t,  (nb_image-view_index_0)*float(t)/60.0), end="\n")
    print("\n")
    print("Matching done in %fs"%total_time)
        
if __name__ == '__main__':
    run_matching()