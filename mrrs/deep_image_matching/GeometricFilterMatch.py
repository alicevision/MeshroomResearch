__version__ = "3.0"

from crypt import methods
import os

from meshroom.core.plugin import PluginNode, EnvType
from meshroom.core import desc

class GeometricFilterMatch(PluginNode):

    category = 'MRRS - Deep Matching'
    documentation = ''''''

    envFile=os.path.join(os.path.dirname(__file__), 'minenv.yaml')
    envType=EnvType.CONDA

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value=''
        ),

        desc.File(
            name="featureFolder",
            label="Feature Folder",
            description="Featurefolder",
            value=""
        ),

        desc.File(
            name="matcheFolder",
            label="Match Folder",
            description="",
            value=""
        ),

        desc.File(
            name="rawMatcheFolder",
            label="Raw Match Folder",
            description="",
            value=""
        ),

        desc.File(
            name="rawFeatureFolder",
            label="raw feature Folder",
            description="Featurefolder",
            value=""
        ),

        desc.ChoiceParam(
            name='method',
            label='method',
            description='',
            value='roundtrip',
            values=['roundtrip', 'fundamental'],
            exclusive=True,
            joinChar=',',
        ),

        desc.FloatParam(
            name='errorThreshold',
            label='errorThreshold',
            description=''' ''',
            value=1.0,
            range=(0.0, 1000000000.0, 0.1),
            advanced=True
        ),

        desc.BoolParam(
            name='saveConfidence',
            label='saveConfidence',
            description=''' ''',
            value=True,
            advanced=True
        ),
        

    desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
             
        ),

    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='outputFolder',
            description='outputFolder',
            value=desc.Node.internalFolder,
            group='',
        ),
        desc.File(
            name="outputMatchesFolders",
            label="Matches Folder",
            description="Path to a folder in which the computed matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "matches"),
        ),
    ]

    def open_matches_from_warp():



    def processChunk(self, chunk):
        """
        """
        import numpy as np
        from mrrs.core.ios import open_matches
        from mrrs.core.utils import time_it
        from mrrs.core.geometry import make_homogeneous
        import cv2
        from cv2 import findFundamentalMat
        chunk.logManager.start(chunk.node.verboseLevel.value)

        chunk.logger.info("Opening files")
        matches={}
        WORKING_RES = 864
        with time_it() as t:
            match_file = [os.path.join(chunk.node.matcheFolder.value, mf) for mf in os.listdir(chunk.node.matcheFolder.value) if mf.endswith(".txt")][0]
            # match_file_raw = [os.path.join(chunk.node.rawMatcheFolder.value, mf) for mf in os.listdir(chunk.node.rawMatcheFolder.value) if mf.endswith(".txt")][0]  
            chunk.logger.info('Opening matches from '+match_file+' and '+match_file_raw )
            matches, images_uids  = open_matches(match_file)
            # raw_matches, images_uids  = open_matches(match_file_raw)

            chunk.logger.info('Opening feature files')
            features = {uid:np.loadtxt(os.path.join(chunk.node.featureFolder.value, uid+".sift.feat")) for uid in images_uids }
            # features_raw = {uid:np.loadtxt(os.path.join(chunk.node.rawFeatureFolder.value, uid+".sift.feat")) for uid in images_uids }
            
            features_raw = np.meshgrid(np.round(oH*np.arange(0,1,1.0/H)), 
                                       np.round(oW*np.arange(0,1,1.0/W)), 
                                       indexing='ij')
            raw_matches, features_raw = open_matches_from_warp()
        chunk.logger.info("Done in %fs"%t)
    
        #for each pair of images
        if 'fundamental' in chunk.node.method.value:
            clean_matches= {view_id_0:{view_id_1:[] for view_id_1 in images_uids } for i, view_id_0 in enumerate(images_uids)}
            for i, view_id_0 in enumerate(matches.keys()):
                chunk.logger.info("%d/%d"%(i, len(matches.keys())))
                for j,view_id_1 in enumerate(matches[str(int(view_id_0))].keys()): 
                    chunk.logger.info(" %d/%d"%(j, len(matches[str(int(view_id_0))].keys())))
                    #find funcdamentaly matrix for filtered matches
                    matches01 = matches[str(int(view_id_0))][str(int(view_id_1))]
                    kp_idx_0 = matches01[:,0].astype(np.int32)
                    kp_idx_1 = matches01[:,1].astype(np.int32)
                    keypoints_0 = features[view_id_0][kp_idx_0,0:2]
                    keypoints_1 = features[view_id_1][kp_idx_1,0:2]
                    F, _ = findFundamentalMat(keypoints_0, keypoints_1, cv2.RANSAC) 
                    import cv2
                    from cv2 import findFundamentalMat
                    chunk.logger.info(" F:")
                    chunk.logger.info(F)
                    # filter raw matches outliers
                    raw_matches01 = raw_matches[str(int(view_id_0))][str(int(view_id_1))]
                    raw_kp_idx_0=raw_matches01[:,0].astype(np.int32)
                    raw_kp_idx_1=raw_matches01[:,1].astype(np.int32)
                    raw_keypoints_0 = features_raw[view_id_0][raw_kp_idx_0,0:2]
                    raw_keypoints_1 = features_raw[view_id_1][raw_kp_idx_1,0:2]
                    # compute epipolar error
                    #epipolar lines
                    l1 = make_homogeneous(raw_keypoints_0)@F.T
                    l0 = make_homogeneous(raw_keypoints_1)@F
                    #distance of each match point to line
                    def distance_point_to_line(p,l):
                        #from each point in p [N*3], compute the reprojection error from the epipolar line l [N*3]
                        return np.abs(np.sum(l*make_homogeneous(p), axis=1))/np.sqrt(np.sum(np.power(l[:,0:2],2), axis=1))
                    error = (distance_point_to_line(raw_keypoints_0, l0)+distance_point_to_line(raw_keypoints_1, l1))/2.0
                    
                    chunk.logger.info(" Mean/Med %f , %f"%(np.mean(error), np.median(error)))
                    
                    THRESHOLD=  chunk.node.errorThreshold.value
                    match_selection = raw_matches01[error<THRESHOLD, :]
                    chunk.logger.info(' %d/%d matches kept'%(match_selection.shape[0], raw_matches01.shape[0]))
                    clean_matches[str(int(view_id_0))][str(int(view_id_1))]=match_selection
                    
        if 'roundtrip' in chunk.node.method.value:
            raise RuntimeError("Not implemented")
            # clean_matches= {view_id_0:{view_id_1:[] for view_id_1 in images_uids } for i, view_id_0 in enumerate(images_uids)}
            # #for each feature in image 0, check how much time it was matched, discard 
            # for i, view_id_0 in enumerate(matches.keys()):
            #     chunk.logger.info("%d/%d"%(i, len(matches.keys())))
            #     all_kps_0 = []
            #     all_kps_1 = []
            #     for j,view_id_1 in enumerate(matches[str(int(view_id_0))].keys()): 
            #         matches01 = matches[str(int(view_id_0))][str(int(view_id_1))]
            #         kp_idx_0 = matches01[:,0].astype(np.int32)
            #         kp_idx_1 = matches01[:,1].astype(np.int32)
            #         keypoints_0 = features[view_id_0][kp_idx_0,0:2]
            #         keypoints_1 = features[view_id_1][kp_idx_1,0:2]
            #         all_kps_0.append(keypoints_0)
            #         all_kps_1.append(keypoints_1)
            #     for 



        print("Writting")
        #writting remaining matches
        out_matches_folder = chunk.node.outputMatchesFolders.value
        #FIXME: call fc
        os.makedirs(out_matches_folder, exist_ok=True)
        with open(os.path.join(out_matches_folder,"0.matches.txt"), "a") as mf:
            for view_id_0 in clean_matches.keys():
                for view_id_1 in clean_matches[view_id_0]:
                    ms = clean_matches[str(int(view_id_0))][str(int(view_id_1))]
                    if len(ms) == 0:#skipping views without matches
                        continue
                    mf.write("%s %s\n"%(view_id_0, view_id_1))
                    mf.write("1\n")
                    mf.write("sift %d\n"%(len(ms)))#for now we disguise as sift
                    for kp0_idx,kp1_idx, c in ms:
                        if chunk.node.saveConfidence.value :
                            print("Saving confidence")
                            mf.write("%d %d %d\n"%(int(kp0_idx), int(kp1_idx), (100*c)))
                        else:
                            mf.write("%d %d\n"%(int(kp0_idx), int(kp1_idx)))
            
        chunk.logManager.end()

