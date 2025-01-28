__version__ = "2.0"
import json
import os
from this import d 

from meshroom.core import desc

from meshroom.core.plugin import PluginNode, EnvType

MATCHER =   [
            # Dense
            "roma", "tiny-roma", "dust3r", "mast3r",
            # Semi-dense 
            "loftr", "eloftr", "se2loftr", "aspanformer", "matchformer", "xfeat-star",
            # Sparse 
            "sift-lg", "superpoint-lg", "disk-lg", "aliked-lg", "dedode-lg", "doghardnet-lg", "gim-lg", "xfeat-lg", 
            "dedode", "steerers", "dedode-kornia", "sift-nn", "orb-nn", "doghardnet-nn", "patch2pix", "superglue", 
            "r2d2", "d2net",  "gim-dkm", "xfeat", "omniglue", "dedode-subpx", "xfeat-subpx", "aliked-subpx"
            ]


class DeepImageMatching(PluginNode):

    category = 'MRRS - Deep Matching'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE
    
    #overides the env path
    envFile=os.path.join(os.path.dirname(__file__), 'env.yaml')
    envType=EnvType.CONDA
    
    inputs = [
        desc.File(
            name="inputSfMData",
            label="SfMData",
            description="Input SfMData file.",
            value="",
        ),

        # desc.File(
        #     name="input",
        #     label="inputPairs",
        #     description="Input image pairs",
        #     value="",
        # ),

        desc.ChoiceParam(
            name="matcher",
            label="matcher",
            description="matcher method",
            value="roma",
            values=MATCHER,
            exclusive=True,
        ),

        desc.ChoiceParam(
            name="imageMatching",
            label="imageMatching",
            description="",
            value="exhaustive_roundtrip",
            values=["exhaustive", "exhaustive_roundtrip", "sequential", "star"],
            exclusive=True,
        ),

        desc.BoolParam(
            name='rawMatches',
            label='Save raw matches',
            description='''''',
            value=False,
            advanced=True
        ),

        desc.IntParam(
            name='maxKeypoints',
            label='maxKeypoints',
            description='''''',
            value=2048,
            range=(0, 1000000000, 1),
            advanced=True
        ),

        # desc.BoolParam(
        #     name='removeInconsistantRawMatches',
        #     label='Remove Inconsistant Raw Matches',
        #     description='''''',
        #     value=False,
        #     advanced=True
        # ),

        desc.BoolParam(
            name='rawWarps',
            label='Save raw warps',
            description='''''',
            value=False,
            advanced=True
        ),

        desc.ChoiceParam(
            name="verboseLevel",
            label="Verbose Level",
            description="Verbosity level (fatal, error, warning, info, debug, trace).",
            value="info",
            values=["fatal", "error", "warning", "info", "debug", "trace"],
            exclusive=True,
        )
    ]

    outputs = [
        desc.File(
            name="outputFolder",
            label="Output Folder",
            description="Path to a folder in which the computed results are stored.",
            value=desc.Node.internalFolder,
            visible=False
        ),
        desc.File(
            name="imagePairs",
            label="Image Pairs",
            description="",
            value=os.path.join(desc.Node.internalFolder, "imageMatches.txt"),
        ),
        desc.File(
            name="featuresFolder",
            label="Features Folder",
            description="Path to a folder in which the features matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "features"),
        ),
        desc.File(
            name="matchesFolder",
            label="Matches Folder",
            description="Path to a folder in which the computed matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "matches"),
        ),
        desc.File(
            name="rawFeaturesFolder",
            label="Raw features Folder",
            description="Path to a folder in which the features matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "features_raw"),
        ),
        desc.File(
            name="rawMatchesFolder",
            label="Raw matches Folder",
            description="Path to a folder in which the raw computed matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "matches_raw"),
        )
    ]
         
    def processChunk(self, chunk):
        """
        Computes the different transforms
        """
        import numpy as np

        chunk.logManager.start(chunk.node.verboseLevel.value)

        #load sfmdata
        chunk.logger.info("Loading sfm data")
        with open(chunk.node.inputSfMData.value, "r") as json_file:
            sfm_data = json.load(json_file)
        #sort by frame id
        if "frameId" in sfm_data["views"][0].keys():
            sfm_data["views"] = sorted(sfm_data["views"], key= lambda x:int(x["frameId"]))
        nb_image = len(sfm_data["views"]) 
        images_paths = [v["path"] for v in sfm_data["views"]]
        images_uids = [v["viewId"] for v in sfm_data["views"]]
        oW,oH=int(sfm_data["views"][0]["width"]),int(sfm_data["views"][0]["height"])

        #making image list wih diferent strategies
        if chunk.node.imageMatching.value == "exhaustive":
            image_pairs = [(i, j) for i in range(nb_image) for j in range(i+1, nb_image)]
        elif chunk.node.imageMatching.value == "sequential":
            image_pairs = [(i, i+1) for i in range(nb_image-1)]
        elif chunk.node.imageMatching.value == "exhaustive_roundtrip":
            image_pairs = []
            for i in range(nb_image):
                for j in range(nb_image):
                    if i!=j:
                        image_pairs.append((i,j))
        elif chunk.node.imageMatching.value == "star":
            raise RuntimeError('not implemented yet')
            STEP = 20
            for i in range(nb_image):
                if i%STEP == 0:
                    pass
                else:
                    pass
            


        chunk.logger.info(" %d images, %d pairs"%(nb_image, len(image_pairs)))

        # #opening imagematching file if any
        # if chunk.node.inputPairs.value  != "":
        #     print("Opening imagepairs file:")
        #     image_pairs=open_image_grapĥ(imagepairs, nb_image)
        
        #saving pairs again
        with open(chunk.node.imagePairs.value , "w") as mf:
            for view_index_0 in range(nb_image):
                matched_views = [images_uids[p[1]] for p in image_pairs if p[0] == view_index_0]
                if len(matched_views)>0:
                    mf.write(images_uids[view_index_0]) 
                    for m in matched_views:
                        mf.write(" "+m)
                    mf.write("\n")
       
        # #opening masks if any 
        # masks = {}
        # if maskfolder:
        #     from PIL import Image
        #     for view_id in all_view_ids:
        #         masks[view_id] = np.array(Image.open(os.path.join(maskfolder, view_id+".png")), dtype=np.bool_)

        #creates output folders
        chunk.logger.info("Creating output folders")
        os.makedirs(chunk.node.featuresFolder.value, exist_ok=True)
        os.makedirs(chunk.node.rawFeaturesFolder.value, exist_ok=True)
        os.makedirs(chunk.node.matchesFolder.value, exist_ok=True)
        os.makedirs(chunk.node.rawMatchesFolder.value, exist_ok=True)

        if chunk.node.matcher.value == "roma": 
            #Load Model
            chunk.logger.info("Loading model")
            device = 'cuda'
            
            from romatch import roma_outdoor
            matcher = roma_outdoor(device=device)

            #Loop over image pairs
            chunk.logger.info("Running image matching for %d "%len(image_pairs))
            desc_type = "sift"
            extention = "."+desc_type+".feat" #FIXME: for now we write  as sift
            nb_features = [0 for _ in range(nb_image)]
        
            for i, (view_index_0, view_index_1) in enumerate(image_pairs):
                chunk.logger.info("  Matching :"+str(view_index_0)+" "+str(view_index_1)+"(%d/%d)"%(i,len(image_pairs)))
                #working resolution
                H,W = 864,864
                warp, certainty = matcher.match(images_paths[view_index_0], images_paths[view_index_1], device=device)
                warp01 = warp[:, :W, :]
                # warp10 = warp[:, W:, :]
                certainty01 = certainty[:, :W]
                # certainty10 = certainty[:, W:]
                chunk.logger.info("  Done")
                # Sample matches for estimation
                chunk.logger.info("  Sampling for %d keypoints "%(chunk.node.maxKeypoints.value))
                matches01, matches_certainty01 = matcher.sample(warp01, certainty01, num=chunk.node.maxKeypoints.value)
                # matches10, matches_certainty10 = matcher.sample(warp10, certainty10, num=chunk.node.maxKeypoints.value)               
                chunk.logger.info("  Done")

                # X = torch.round(((matches01[:, 0] * 864) + 863) / 2).to(torch.int32)
                # Y = torch.round(((matches01[:, 1] * 864) + 863) / 2).to(torch.int32)
                # X2 = torch.round(((matches01[:, 2] * 864) + 863) / 2).to(torch.int32)
                # Y2 = torch.round(((matches01[:, 3] * 864) + 863) / 2).to(torch.int32)
                # val = warp01[Y, X, 2]
                # val = ((val * 864) + 863) / 2
                # print(torch.max(torch.abs(val - X2)))
                # val = warp01[Y, X, 3]
                # val = ((val * 864) + 863) / 2
                # print(torch.max(val - Y2))
                # exit(0)
                
                #convertions
                #matches in px
                matches01 = ((matches01* 864) + 863) / 2
                # matches10 = ((matches10* 864) + 863) / 2
                #warps in px
                warp01= ((warp01[:,:,2:4]* 864+863)/2).detach().cpu().numpy() #0:1 is in original image?
                # warp10 = ((warp10[:,:,2:4]* 864+863)/2).detach().cpu().numpy()
                matches01=matches01.detach().cpu().numpy() 
                # matches10=matches10.detach().cpu().numpy()
                certainty01=certainty01.detach().cpu().numpy()
                # certainty10=certainty10.detach().cpu().numpy()

                #sanity check
                X =  np.round(matches01[:, 0]).astype(np.int32)
                Y =  np.round(matches01[:, 1]).astype(np.int32)
                X2 = np.round(matches01[:, 2]).astype(np.int32)
                Y2 = np.round(matches01[:, 3]).astype(np.int32)
                val = warp01[Y, X,0]
                max_dist_x=(np.max(np.abs(val - X2)))
                val = warp01[Y, X,1]
                max_dist_y=(np.max(np.abs(val - Y2)))
                print(max_dist_x)
                print(max_dist_y)
                assert(max_dist_x<1)
                assert(max_dist_y<1)

                #write sampled/filterer matches
                kpts01_0 = matches01[:,0:2]
                kpts01_1 = matches01[:,2:4]
                #put it in original image coordinates for meshroom
                kpts01_0[:,0] = oW*(kpts01_0[:,0]/W)
                kpts01_0[:,1] = oH*(kpts01_0[:,1]/H)
                kpts01_1[:,0] = oW*(kpts01_1[:,0]/W)
                kpts01_1[:,1] = oH*(kpts01_1[:,1]/H)
                num_kp = kpts01_0.shape[0]
                chunk.logger.info("  Saving %d matches"%num_kp)
                with open(os.path.join(chunk.node.featuresFolder.value,images_uids[view_index_0]+extention), "a") as kpf:
                    for kp in kpts01_0:
                        kpf.write("%f %f 0 0\n"%(kp[0], kp[1]))
                with open(os.path.join(chunk.node.featuresFolder.value,images_uids[view_index_1]+extention), "a") as kpf:
                    for kp in kpts01_1:
                        kpf.write("%f %f 0 0\n"%(kp[0], kp[1]))
                with open(os.path.join(chunk.node.matchesFolder.value,"0.matches.txt"), "a") as mf:
                    mf.write("%s %s\n"%(images_uids[view_index_0], images_uids[view_index_1]))
                    mf.write("1\n")
                    mf.write("sift %d\n"%(num_kp))
                    for match_indx in range(num_kp):
                        kp0_idx = match_indx+nb_features[view_index_0]
                        kp1_idx = match_indx+nb_features[view_index_1]
                        mf.write("%d %d\n"%(kp0_idx, kp1_idx))
                #update index offset
                nb_features[view_index_0]+=num_kp
                nb_features[view_index_1]+=num_kp
                chunk.logger.info("  Done")
                
                #saving warp image between 0-1
                if chunk.node.rawWarps.value :
                    import OpenEXR#lazy import
                    chunk.logger.info("  Saving raw matches images")
                    
                    warppath01=os.path.join(chunk.node.rawMatchesFolder.value, images_uids[view_index_0]+"_"+images_uids[view_index_1]+"_warp.exr")
                    # warppath10=os.path.join(chunk.node.rawMatchesFolder.value, images_uids[view_index_1]+"_"+images_uids[view_index_0]+"_warp.exr")
                    def save_exr(image, path):
                        h={"compression": OpenEXR.ZIP_COMPRESSION, "type":OpenEXR.scanlineimage}
                        c={"RGB": image} 
                        with OpenEXR.File(h,c) as image:
                            image.write(path)
                    save_exr(np.concatenate([warp01/H, np.expand_dims(certainty01, axis=-1)], axis=-1), warppath01 )
                    # save_exr(np.concatenate([warp10/H, np.expand_dims(certainty10, axis=-1)], axis=-1), warppath10 )
                    chunk.logger.info("  Done")

                #old code
                # if chunk.node.matcher.value == "roma": #if dense
                #     W = int(matcher._certainty.shape[1]/2) #width after resize
                #     H = matcher._certainty.shape[0]         
                #     chunk.logger.info("  Output certainty image size %d %d "%(W,H))
                #     chunk.logger.info("  Output warp image size %d %d "%(W,H))
                    
                #     ##write raw matches with confidence
                #     if chunk.node.rawMatches.value or chunk.node.rawWarps.value :
                #         chunk.logger.info("  Saving %d raw matches working rez (%d, %d), for image res (%d,%d)"%(H*W, H, W, oH, oW))
                #         #warp_021 specifies im1 pixel locations x and y, which are used to interpolate the im0 values, between 0 and 1
                #         warp_021 = (matcher._warp[:,:W, 2:]+1)/2#pass from -1 1 to 0 1
                #         certainty_01 = matcher._certainty[:, :W].cpu().detach().numpy()
                #         #turn into px coordinates (original image size), NOTE: also pass xy=>yx
                #         warp_021_px = torch.stack([torch.clamp(oH*warp_021[:,:,1], 0, oH-1), 
                #                                    torch.clamp(oW*warp_021[:,:,0], 0, oW-1)], axis=-1).int()
                #         #
                #         warp_120 = (matcher._warp[:, W:,:2]+1)/2 
                #         warp_120_px = torch.stack([torch.clamp(H*warp_120[:,:,0], 0, H-1), 
                #                                    torch.clamp(W*warp_120[:,:,1], 0, W-1)], axis=-1).int() 
                                                                            
                #         certainty_10 = matcher._certainty[:, W:].cpu().detach().numpy()

                #         chunk.logger.info("  Median certainty: %f "%np.median(certainty_01.flatten()))
                        
                        # if chunk.node.rawWarps.value :
                        #     import OpenEXR#lazy import
                        #     chunk.logger.info("  Saving raw matches images")
                        #     warppath10=os.path.join(chunk.node.rawMatchesFolder.value, images_uids[view_index_1]+"_"+images_uids[view_index_0]+"_warp")
                        #     warppath01=os.path.join(chunk.node.rawMatchesFolder.value, images_uids[view_index_0]+"_"+images_uids[view_index_1]+"_warp")
                        #     confpath10 = os.path.join(chunk.node.rawMatchesFolder.value,  "conf_"+images_uids[view_index_1]+"_"+images_uids[view_index_0]+".exr")
                        #     confpath01 = os.path.join(chunk.node.rawMatchesFolder.value,  "conf_"+images_uids[view_index_0]+"_"+images_uids[view_index_1]+".exr")
                        #     warp_021_px_smoll = torch.stack([torch.clamp(H*warp_021[:,:,1], 0, H-1), 
                        #                                      torch.clamp(W*warp_021[:,:,0], 0, W-1)], axis=-1).cpu().detach().numpy()
                        #     warp_012_px_smoll = torch.stack([torch.clamp(H*warp_120[:,:,1], 0, H-1), 
                        #                                      torch.clamp(W*warp_120[:,:,0], 0, W-1)], axis=-1).cpu().detach().numpy()
                        #     h={"compression": OpenEXR.ZIP_COMPRESSION, "type":OpenEXR.scanlineimage}
                        #     c={"RGB":np.concatenate([warp_021_px_smoll/H, np.expand_dims(certainty_01, axis=-1)], axis=-1)}
                        #     with OpenEXR.File(h,c) as image:
                        #         image.write(warppath10+".exr")
                        #     c={"RGB":np.concatenate([warp_012_px_smoll/H, np.expand_dims(certainty_10, axis=-1)], axis=-1)}
                        #     with OpenEXR.File(h,c) as image:
                        #         image.write(warppath01+".exr")  
                        #     # c={"Y":warp_021_px_smoll[:,:,0]/H}
                        #     # with OpenEXR.File(h,c) as image:
                        #     #     image.write(warppath10+"_x.exr")
                        #     # c={"Y":warp_021_px_smoll[:,:,1]/W}S
                        #     # with OpenEXR.File(h,c) as image:
                        #     #     image.write(warppath10+"_y.exr")
                        #     # c={"Y":warp_012_px_smoll[:,:,0]/H}
                        #     # with OpenEXR.File(h,c) as image:
                        #     #     image.write(warppath01+"_x.exr")
                        #     # c={"Y":warp_012_px_smoll[:,:,1]/W}
                        #     # with OpenEXR.File(h,c) as image:
                        #     #     image.write(warppath01+"_y.exr")
                        #     # c={"Y":certainty_01}
                        #     # with OpenEXR.File(h,c) as image:
                        #     #     image.write(confpath10)
                        #     # c={"Y":certainty_10}
                        #     # with OpenEXR.File(h,c) as image:
                        #     #     image.write(confpath01)

                        #     #warpdebug
                        #     import torchvision
                        #     # warppathviz01 = os.path.join(chunk.node.rawMatchesFolder.value,  "warpviz_"+images_uids[view_index_0]+"_"+images_uids[view_index_1]+".png")
                        #     # warppathviz10 = os.path.join(chunk.node.rawMatchesFolder.value,  "warpviz_"+images_uids[view_index_1]+"_"+images_uids[view_index_0]+".png")
                        #     # confvizpath0 = os.path.join(chunk.node.rawMatchesFolder.value,  "conf_"+images_uids[view_index_1]+".png")
                        #     # confvizpath1 = os.path.join(chunk.node.rawMatchesFolder.value,  "conf_"+images_uids[view_index_0]+".png")
                        #     # torchvision.utils.save_image(torch.from_numpy(certainty_01), confvizpath0)
                        #     # torchvision.utils.save_image(torch.from_numpy(certainty_10), confvizpath1)
                        #     # #resize the input image to W, H, because it could have been resized 
                        #     # warped_im1 = nimg1[:, warp_021_px_smoll[:,:,0], warp_021_px_smoll[:,:,1]] #warp is x y??
                        #     # warped_im0 = nimg0[:, warp_012_px_smoll[:,:,0], warp_012_px_smoll[:,:,1]]
                        #     print(os.path.join(chunk.node.rawMatchesFolder.value,images_uids[view_index_0]+".png"))
                        #     nimg0=torch.nn.functional.interpolate(torch.unsqueeze(img0, axis =0),size=(H,W), align_corners=False,mode="bilinear", )[0]
                        #     nimg1=torch.nn.functional.interpolate(torch.unsqueeze(img1, axis =0),size=(H,W), align_corners=False,mode="bilinear", )[0]
                        #     torchvision.utils.save_image(nimg0, os.path.join(chunk.node.rawMatchesFolder.value,images_uids[view_index_0]+".png"))
                        #     torchvision.utils.save_image(nimg1, os.path.join(chunk.node.rawMatchesFolder.value,images_uids[view_index_1]+".png"))
                        #     # torchvision.utils.save_image(warped_im0, warppathviz01)
                        #     # torchvision.utils.save_image(warped_im1, warppathviz10)

                        # if chunk.node.rawMatches.value :
                        #     if i == 0: #making dense kps files once
                        #         # summary(matcher, img0, img1)
                        #         chunk.logger.info("  Initializing dense keypoint files")
                        #         kpts0_y,kpts0_x  = torch.meshgrid((torch.arange(0, oH), torch.arange(0, oW)), indexing="ij")
                        #         kpts0 = torch.stack([kpts0_y.flatten(), kpts0_x.flatten()], axis=-1) 
                        #         chunk.logger.info("  Creating dummy %d kp"%kpts0_x.flatten().shape[0])
                        #         kp0_string  = "".join(["%f %f 0 0\n"%(kp[1], kp[0]) for kp in kpts0 ])

                        #         chunk.logger.info("  Saving files")
                        #         for j, uid in enumerate(images_uids):
                        #             chunk.logger.info("   %d/%d "%(j,len(images_uids)))
                        #             with open(os.path.join(chunk.node.rawFeaturesFolder.value,uid+extention), "w") as kpf:
                        #                 kpf.write(kp0_string)
                        #             # with open(os.path.join(chunk.node.rawFeaturesFolder.value,uid+"."+desc_type+".desc"), "wb") as df:
                        #             #     df.write(d_string)
                
                        #     #meshrif in working res H W, but coordinates in original res oW oH
                        #     kpts0_y,kpts0_x = np.meshgrid(np.round(oH*np.arange(0,1,1.0/H)), 
                        #                                   np.round(oW*np.arange(0,1,1.0/W)), 
                        #                                   indexing='ij')
                    
                        #     kpts0_indices = kpts0_y.flatten()*oW+kpts0_x.flatten()
                        #     #keypoint in image 1 from waprs 
                        #     kpts1=warp_021_px.reshape([-1,2]).cpu().detach().numpy()
                        #     kpts1_indices=kpts1[:,0]*oW+kpts1[:,1]
                        #     #free sanity check
                        #     if kpts0_indices.shape[0] != kpts1_indices.shape[0] != certainty_01.flatten().cpu().shape[0]:
                        #         raise RuntimeError("Invalid keypoints shape")
                        #     if np.any(kpts0_indices>=oH*oW) or np.any(kpts1_indices>=oH*oW):
                        #         raise RuntimeError("Keypoint outside of image")

                        #     certainty_01=certainty_01.flatten()

                        #     if chunk.node.removeInconsistantRawMatches.value:
                        #         py,px = np.meshgrid(np.arange(0,H), np.arange(0,W), indexing='ij')
                        #         warp_021_px_smoll = torch.stack([torch.clamp(H*warp_021[:,:,1], 0, H-1), 
                        #                                          torch.clamp(W*warp_021[:,:,0], 0, W-1)], axis=-1).cpu().detach().numpy()
                        #         warp_120_px_smoll = torch.stack([torch.clamp(H*warp_120[:,:,1], 0, H-1), 
                        #                                          torch.clamp(W*warp_120[:,:,0], 0, W-1)], axis=-1).cpu().detach().numpy()
                        #         warp_021_px_smoll = np.round(warp_021_px_smoll).astype(np.int32)
                        #         warp_120_px_smoll = np.round(warp_120_px_smoll).astype(np.int32)
                        #         dist=np.sum((warp_021_px_smoll[warp_120_px_smoll[:,:,0], warp_120_px_smoll[:,:,1], :]-np.stack([py,px], axis=-1))**2,axis=-1).flatten()
                        #         # print(dist)
                        #         THRESHOLD=2
                        #         valid=dist<THRESHOLD
                        #         print(dist.shape)

                        #         print("%d kept %d discarded"%(np.count_nonzero(dist<THRESHOLD), np.count_nonzero(dist>=THRESHOLD)))
                        #         kpts0_indices=kpts0_indices[valid]
                        #         kpts1_indices=kpts1_indices[valid]
                        #         certainty_01=certainty_01[valid]
                                

                        #     #writting keypoints as meshroom format
                        #     os.makedirs(chunk.node.rawMatchesFolder.value, exist_ok=True)
                        #     with open(os.path.join(chunk.node.rawMatchesFolder.value,"0.matches.txt"), "a") as mf:
                        #         mf.write("%s %s\n"%(images_uids[view_index_0], images_uids[view_index_1]))
                        #         mf.write("1\n")
                        #         mf.write("sift %d\n"%(kpts1_indices.shape[0]))#for now we disguise as sift
                        #         #FIXME: cetrainty with kpts0 inside?
                        #         for kp0_idx,kp1_idx,c in zip(kpts0_indices, kpts1_indices,  certainty_01):
                        #             mf.write("%d %d %f\n"%(kp0_idx, kp1_idx, c))
        else: #other sparse descriptors in the lib
            chunk.logger.info("Matching with other matcher")
            from matching import get_matcher
            matcher = get_matcher(chunk.node.matcher.value, device=device)  
            chunk.logger.info("  Load images "+images_paths[view_index_0]+" "+images_paths[view_index_1])
            img0 = matcher.load_image(images_paths[view_index_0], resize=None)
            img1 = matcher.load_image(images_paths[view_index_1], resize=None)
            oW = img0.shape[2]
            oH = img0.shape[1]
            chunk.logger.info("  Image size %d %d "%(oW,oH))
            chunk.logger.info("  Computing matches...")
            result = matcher(img0, img1)
            
            num_kp, H, kpts0, kpts1 = result['num_inliers'], result['H'], result['inlier_kpts0'], result['inlier_kpts1']
            # write all keypoints in image 0 and 1
            # all matcher keypoint (y,x) 
            kpts0=result['matched_kpts0']
            kpts1=result['matched_kpts1']
            num_kp = result['matched_kpts0'].shape[0]            
            with open(os.path.join(chunk.node.featuresFolder.value,images_uids[view_index_0]+extention), "a") as kpf:
                for kp in kpts0:
                    kpf.write("%f %f 0 0\n"%(kp[0], kp[1]))
            with open(os.path.join(chunk.node.featuresFolder.value,images_uids[view_index_1]+extention), "a") as kpf:
                for kp in kpts1:
                    kpf.write("%f %f 0 0\n"%(kp[0], kp[1]))
            #write matches
            #Write matches, note "0." beacause mewhroom suports several matches files for batching
            with open(os.path.join(chunk.node.matchesFolder.value,"0.matches.txt"), "a") as mf:
                mf.write("%s %s\n"%(images_uids[view_index_0], images_uids[view_index_1]))
                mf.write("1\n")
                mf.write("sift %d\n"%(num_kp))#for now we disguise as sift
                for match_indx in range(num_kp):#save feature index with offset for each view
                    kp0_idx = match_indx+nb_features[view_index_0]
                    kp1_idx = match_indx+nb_features[view_index_1]
                    mf.write("%d %d\n"%(kp0_idx, kp1_idx))
            #update index offset
            nb_features[view_index_0]+=num_kp
            nb_features[view_index_1]+=num_kp
            print("Done")
        
        chunk.logManager.end()


