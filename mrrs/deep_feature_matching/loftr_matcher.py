import json
import os, sys

import click
import numpy as np
import torch
from kornia.feature.loftr.loftr import LoFTR
from kornia.feature.loftr.loftr import default_cfg#the default config file

sys.path.append(os.path.abspath(__file__))
from utils import time_it, open_and_prepare_image, open_image_grapĥ

def get_all_keypoints(feature_map_size):
    """
    Get all possibles features in an image
    """
    all_keypoints_0_y, all_keypoints_0_x = np.meshgrid(range(feature_map_size[0]), 
                                                       range(feature_map_size[1]), indexing='ij')
    all_keypoints_0_x=8*all_keypoints_0_x.flatten()
    all_keypoints_0_y=8*all_keypoints_0_y.flatten()
    return all_keypoints_0_y, all_keypoints_0_x

@click.command()
@click.option('--inputSfMData', help='Input sfm data')
@click.option('--outputFolder', help='Output to store the results in')
@click.option('--imageMaching', default="all", help=("Method to select the views to be matched. 'all' will match all the views."
                                                    +"If a number is passed, will assume sequence and the number is going to be half window around a frame to compute the maches into"
                                                    +"If 'file' open the matches from the file in imagePairs"))
@click.option('--imagePairs', default="", help=("Image pair file to be used for the image matching"))
@click.option('--maskFolder', default="", help=("Optional mask folder used to discard matches"))
@click.option('--keepNmatches', default=0, type=int, help='If specified will keep the n first matches between views')
@click.option('--confidenceThreshold', default=0.0, type=float, help='If specified will only keep the matches with at least this confidence')
@click.option('--coarseMatch', default=True, type=bool, help='Will use the coarse patch-level matches to create longer track.')
@click.option('--debugImages', default=False, type=bool, help='Will Write match images') #TODO: remove
@click.option('--verboseLevel', help='.')#FIXME: todo
def run_matching(inputsfmdata, outputfolder, imagemaching, imagepairs, maskfolder,
                 keepnmatches, confidencethreshold, coarsematch,
                 debugimages, verboselevel): #note: lower caps
    """
    Will runs loftr on the input set of images.
    Writes meshroom feature and maches files.
    Since loftr matches features in a grid from image 0 to floating features on image 1, i is not bijective.
    We consider the feature grid on image 0 as common features, wile the matced features are saved independedtly.
    """
    #To debug
    print("Hello")
    extention = ".sift.feat"#".loftr.feat" #FIXME: for now we write  as sift
    loftr_weigts = 'outdoor'#FIXME: var
    loftr_config = default_cfg
    #we remove matches a posteriori
    loftr_config["match_coarse"]["thr"]=0#

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

    #opening masks if any 
    masks = {}
    if maskfolder:
        from PIL import Image
        for view_id in all_view_ids:
            masks[view_id] = np.array(Image.open(os.path.join(maskfolder, view_id+".png")), dtype=np.bool8)

    #creates output folders
    print("Creating output folders")
    feature_folder = os.path.join(outputfolder, "features")
    matches_folder = os.path.join(outputfolder, "matches")
    os.makedirs(feature_folder, exist_ok=True)
    os.makedirs(matches_folder, exist_ok=True)

    #init model
    print("Loading model")
    device = torch.device('cuda:0')
    loftr_model = LoFTR(loftr_weigts, config=loftr_config).to(device)

    #loop over pairs of images
    #we ned this to keep track  the feature indices in case we keep the refined matches
    nb_features = [0 for _ in range(nb_image)]
    #write all possible features on image 0 (to make sure thay are the first indices)
    print("Preparing feature files")
    with time_it() as t:
        for view_index_0 in range(nb_image):
            print("writting file for view %d/%d"%(view_index_0, nb_image), end="\r")
            timage_0, uid_image_0, image_0,_  = open_and_prepare_image(sfm_data,view_index_0, device)
            #each feature in image 0 has coords int(X/8)
            feature_map_size = (np.asarray(np.flip(timage_0.shape[2:]))/8.0).astype(np.int32)
            #all potential keypoints in image 0
            all_keypoints_0_y, all_keypoints_0_x = get_all_keypoints(feature_map_size)
            #write all keypoints 0 
            with open(os.path.join(feature_folder,uid_image_0+extention), "w") as kpf:
                for kp_x, kp_y in zip(all_keypoints_0_x, all_keypoints_0_y):
                    kpf.write("%f %f 0 0\n"%(kp_y, kp_x))
                #update offsets for view 0
                nb_features[view_index_0]+=all_keypoints_0_x.shape[0]

    #FIXME: assume constant feature map size and keep latest size
    #to retrieve the index later
    def map_indices(X):
        """
        maps a float x,y feature coord into a linear index 
        """
        y,x=(np.asarray(X)/8.0).astype(np.int32)
        if (x > feature_map_size[1]) or (y > feature_map_size[0]):
            raise RuntimeError("Feature %f %f outside of feature map (%d %d) vs (%d %d)"%(X[0],X[1],x,y,feature_map_size[0], feature_map_size[1]))
        linear_index =  feature_map_size[1]*y+x
        return linear_index
    # for x,y in zip(all_keypoints_0_x, all_keypoints_0_y) :
    #     print(map_indices((x,y)))
    # exit(0)
    print("\nDone in %f seconds"%t)

    print("Running matching")
    with time_it() as total_time:
        for view_index_0 in range(nb_image):
            #open and prepare
            timage_0, uid_image_0, image_0, frame_id_0  = open_and_prepare_image(sfm_data,view_index_0, device)

            #depending of the matching method, we get a list of views to match
            view_indices_1 = []
            if imagemaching.isnumeric():
                view_indices_1 = [i for i,view in enumerate(sfm_data["views"])
                                    if abs(int(view["frameId"])-frame_id_0)<=int(imagemaching)]
            elif imagemaching == "all":
                view_indices_1=range(nb_image)
            elif imagemaching == "uni":
                view_indices_1=range(view_index_0, nb_image) 
            elif imagemaching == "file":
                #get view from graph
                # each line corresponds to an image in the same order as in the sfm? #FIXME: to check
                #FIXME : non bijective matching matrix
                view_uids_1 = image_pairs[view_index_0]
                view_indices_1 = [all_view_ids.index(v) for v in view_uids_1 if v != ""]
            else:
                raise RuntimeError("Invalid imagemaching argument")

            with time_it() as t:        
                for view_index_1  in view_indices_1:
                    #if same image, skip
                    if view_index_0 == view_index_1:
                        continue
                    print("\nMatches images %d to %d\n"%(view_index_0, view_index_1))

                    #open and prepare second image
                    timage_1, uid_image_1, image_1, _ = open_and_prepare_image(sfm_data,view_index_1, device)

                    #run loftr and get results
                    out = loftr_model({"image0": timage_0, "image1": timage_1})
                    keypoints_0=out["keypoints0"].to('cpu').numpy()
                    keypoints_1=out["keypoints1"].to('cpu').numpy()
                    confidences=out["confidence"].to('cpu').numpy()
                    
                    nb_keypoint = keypoints_0.shape[0]
                    print("Found %d matches"%nb_keypoint) 

                    #sort by confidence (descending)
                    order = np.argsort(-confidences)
                    keypoints_0=keypoints_0[order]
                    keypoints_1=keypoints_1[order]
                    confidences=confidences[order]

                    #if we keep the original matches
                    if not coarsematch:
                        #Write features on img 2 as brand new features
                        with open(os.path.join(feature_folder,uid_image_1+extention), "a+") as kpf:
                            for kp in keypoints_1:
                                kpf.write("%f %f 0 0\n"%(kp[0], kp[1]))

                    #if masks defined
                    if len(masks) > 0:
                        mask_0 = masks[uid_image_0]
                        mask_1 = masks[uid_image_1]
                        nn_keypoints_0 = np.round(keypoints_0).astype(np.int32)
                        nn_keypoints_1 = np.round(keypoints_1).astype(np.int32)
                        mask_0_kp = mask_0[nn_keypoints_0[:,1], nn_keypoints_0[:,0],0]
                        mask_1_kp = mask_1[nn_keypoints_1[:,1], nn_keypoints_1[:,0],0]
                        valid_kp = mask_0_kp&mask_1_kp
                        #remove masked keypoints
                        keypoints_0 = keypoints_0[valid_kp,:]
                        keypoints_1 = keypoints_1[valid_kp,:]
                        confidences = confidences[valid_kp,:]
                        nb_keypoint = keypoints_0.shape[0]
                        print("%d matches after masking"%nb_keypoint) 
                    
                    if coarsematch:
                        #FIXME: not elegant, better get the index of the match from loftr
                        #removes the duplicate indices, can happen if the refine move the keypoint outside the initial patch
                        # keypoint_0_index_matched = {}
                        # keypoint_0_indices = [map_indices(k) for k in keypoints_0]
                        keypoint_1_indices = [map_indices(k) for k in keypoints_1]
                        keypoint_1_index_matched = {}
                        to_del = []
                        print("%d unique match found"%np.unique(keypoint_1_indices).shape[0])
                        for kp_indx in range(nb_keypoint):
                            keypoint_1_index=keypoint_1_indices[kp_indx]
                            # keypoint_0_index=keypoint_0_indices[kp_indx]
                            if keypoint_1_index in keypoint_1_index_matched.keys():
                                # print("Keypoint %f %f already matched with %f %f with higher confidence, discarding"%(keypoints_1[kp_indx][0],
                                #                                                                                     keypoints_1[kp_indx][1],
                                #                                                                                     keypoint_1_index_matched[keypoint_1_index][0],
                                #                                                                                     keypoint_1_index_matched[keypoint_1_index][1]
                                #         ))
                                to_del.append(kp_indx)
                            else:
                                keypoint_1_index_matched[keypoint_1_index]=keypoints_1[kp_indx]
                        print("Found %d duplicates, removing"%len(to_del))
                        keypoints_0=np.delete(keypoints_0,to_del, axis=0)
                        keypoints_1=np.delete(keypoints_1,to_del, axis=0)
                        confidences=np.delete(confidences,to_del, axis=0)
                        nb_keypoint = keypoints_0.shape[0]
                        
                    #if we dont define a max nb of match, will write all matches, otherwise will write only the n best matches
                    if keepnmatches == 0:
                        nb_to_write = nb_keypoint
                    else:
                        nb_to_write = min(keepnmatches, nb_keypoint)
                    #if we passed confidenceThreshold, will find the index dynamically such that the remaining matches keep the trheshold
                    if  confidencethreshold != 0:
                        #will return index of first occurence of confidence bellow the threshold=> index when we stop
                        nb_to_write = np.argmin(confidences>confidencethreshold)
   
                    keypoint_0_indices = [map_indices(k) for k in keypoints_0]
                    keypoint_1_indices = [map_indices(k) for k in keypoints_1]
                    
                    print("Writting %d matches"%nb_to_write) 
                    #Write matches, note "0." beacause mewhroom suports several matches files for batching
                    with open(os.path.join(matches_folder,"0.matches.txt"), "a+") as mf:
                        mf.write("%s %s\n"%(uid_image_0, uid_image_1))
                        mf.write("1\n")
                        mf.write("sift %d\n"%(nb_to_write))#for now we disuise as sift
                        for kp_indx in range(nb_to_write):#save feature index with offset for each view
                            # print("%d/%d"%(kp_indx, nb_to_write))
                            keypoint_0_index = keypoint_0_indices[kp_indx]#retrieve index in the pre-written features
                            if not coarsematch:#if we keep the normal matches
                                keypoint_1_index = kp_indx+nb_features[view_index_1]#index is offsetted by the allready written features
                            else:
                                keypoint_1_index = keypoint_1_indices[kp_indx]
                            mf.write("%d %d\n"%(keypoint_0_index, keypoint_1_index))
                    if not coarsematch:
                        nb_features[view_index_1]+=nb_keypoint#nb_to_write 
            # exit(0)
            print("Matches for view %d/%d done for %d views, in %fs (est. remaining if constant %fm)"%(view_index_0+1, 
            nb_image, len(view_indices_1)-1, t,  (nb_image-view_index_0)*float(t)/60.0), end="\n")
    print("\n")
    print("Matching done in %fs"%total_time)
        
if __name__ == '__main__':
    run_matching()