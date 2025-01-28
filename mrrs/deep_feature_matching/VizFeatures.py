__version__ = "3.0"

import os

from meshroom.core.plugin import PluginNode, EnvType
from meshroom.core import desc

class VizFeatures(PluginNode):

    category = 'MRRS - Deep Matching'
    documentation = ''''''

    envFile=os.path.join(os.path.dirname(__file__), 'vizenv.yaml')
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
            description="Featurefolder",
            value="",
             
        ),
        
        desc.IntParam(
            name="keepMatches",
            label="keepMatches",
            description="Only display first n matches",
            range=(1,1000,1),
            value=0,
             
        ),

        desc.BoolParam(
            name="matchOnly",
            label="matchOnly",
            description="Only display the matches",
            value=True,
             
        ),

        desc.IntParam(
            name="markerSize",
            label="markerSize",
            description="marker wize /2",
            range=(1,1000,1),
            value=1,
             
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
            name='featureViz',
            label='featureViz',
            description='featureViz',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder, 'features_<VIEW_ID>.png'),
             
            group='',
        ),
        desc.File(
            name='matchingViz',
            label='matchingViz',
            description='matchingViz',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder, 'matches_<VIEW_ID>.png'),
             
            group='',
        ),
    ]

    def processChunk(self, chunk):
        """
        """
        import numpy as np
        import json
        import cv2
        from mrrs.core.ios import open_image, save_image, open_matches
     
        def draw_keypoints(image, keypoints, downsample=1, p = 2, o = 0, cols=[0,255,0]):
            for kp in keypoints[::downsample]:
                image[int(kp[1])-p:int(kp[1])+p, o+int(kp[0])-p:o+int(kp[0])+p, :]=cols
            return image 

        def get_best_matching_view(view_matches):
            values = list(view_matches.values())
            lengths = [v.shape[0] for v in values]
            keys = list(view_matches.keys())
            index_max = np.argmax(lengths)
            return keys[index_max], values[index_max]

        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            chunk.logger.warning("No inputSfM specified")
        
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        feature_files = os.listdir(chunk.node.featureFolder.value)
        print("%d feature files detected"%len(feature_files))
        if not chunk.node.matchOnly.value: 
            print("Writting features")
            for view in sfm_data["views"]:
                image_path = view["path"]
                image_uid = view["viewId"]
                image = open_image(image_path)
                keypoint_file = [os.path.join(chunk.node.featureFolder.value, ff) for ff in feature_files if ((image_uid in ff) and ff.endswith(".feat"))][0]
                keypoints = np.loadtxt(keypoint_file)
                image = draw_keypoints(image, keypoints, p=chunk.node.markerSize.value)
                save_image(os.path.join(chunk.node.outputFolder.value, "features_"+image_uid+".png"),image)

        if chunk.node.matcheFolder.value != "":
            print("Writting matches")
            chunk.logger.info('Displaying Matching')
            match_file = [os.path.join(chunk.node.matcheFolder.value, mf) for mf in os.listdir(chunk.node.matcheFolder.value) if mf.endswith(".txt")][0]
            chunk.logger.info('Opening matches')
            matches,_ = open_matches(match_file)
            chunk.logger.info('Done open')
            for i, view_id_0 in enumerate(matches.keys()):
                chunk.logger.info('%d/%d'%(i, len(matches.keys()))+' Matching for view '+view_id_0)
                #for now, only select the best matched view (the one with most matches)
                # view_id_1, matches_0_to_1=get_best_matching_view(matches[view_id_0])
                # chunk.logger.info('Best matcing for view '+view_id_0+" is "+view_id_1+ " (%d matches)"%len(matches_0_to_1))
                for view_id_1 in matches[view_id_0].keys():
                    matches_0_to_1 = matches[view_id_0][view_id_1]
                    if matches_0_to_1.shape[0] == 0:
                        chunk.logger.info("No matches for "+view_id_0+" "+view_id_1+"\n. ")
                        continue
                    if ((     matches_0_to_1[:,0].shape[0] != np.unique(matches_0_to_1[:,0]).shape[0] ) 
                         or ( matches_0_to_1[:,1].shape[0] != np.unique(matches_0_to_1[:,1]).shape[0] ) ):
                        # chunk.logger.warning("Found duplicated points fo images "+view_id_0+" "+view_id_1+"\n. ")
                        print("Found duplicated points for images "+view_id_0+" "+view_id_1)
                    if chunk.node.matchOnly.value: #if match only, will only display line
                        image_file_0 = [view["path"] for view in sfm_data["views"] if view["viewId"]==view_id_0][0]
                        image_file_1 = [view["path"] for view in sfm_data["views"] if view["viewId"]==view_id_1][0]
                    else:
                        image_file_0 = os.path.join(chunk.node.outputFolder.value, "features_"+view_id_0+".png")
                        image_file_1 = os.path.join(chunk.node.outputFolder.value, "features_"+view_id_1+".png")      
                    image_0 = open_image(image_file_0)[:,:,0:3]
                    image_1 = open_image(image_file_1)[:,:,0:3]
                    match_image = np.concatenate([image_0, image_1], axis=1)
                    keypoint_file_0 = [os.path.join(chunk.node.featureFolder.value, ff) for ff in feature_files if ((view_id_0 in ff) and ff.endswith(".feat"))][0]
                    keypoint_file_1 = [os.path.join(chunk.node.featureFolder.value, ff) for ff in feature_files if ((view_id_1 in ff) and ff.endswith(".feat"))][0]
                    keypoints_0 = np.loadtxt(keypoint_file_0)
                    keypoints_1 = np.loadtxt(keypoint_file_1)

                    #sort by confidence if any
                    if matches_0_to_1.shape[-1]>2:
                        chunk.logger.info("Sorting by confidence")
                        matches_0_to_1=np.asarray(sorted(matches_0_to_1, key=lambda m:m[2], reverse=True))     
                    #else random
                    else:
                        matches_0_to_1=np.asarray(sorted(matches_0_to_1, key=lambda m:np.random.rand(1), reverse=True))     

                    o=image_0.shape[1]
                    for m in matches_0_to_1[0:chunk.node.keepMatches.value].astype(np.int32):
                        if m[0]>keypoints_0.shape[0]:
                            chunk.logger.warning("ERROR FEATURE INDEX IN MATCH OUTSIDE OF LISTED FEATURES FOR %s (%d vs %d)"%(view_id_0, m[0],keypoints_0.shape[0]))
                            continue
                        if m[1]>keypoints_1.shape[0]:
                            chunk.logger.warning("ERROR FEATURE INDEX IN MATCH OUTSIDE OF LISTED FEATURES FOR %s (%d vs %d)"%(view_id_1, m[1],keypoints_1.shape[0])) 
                            continue
                        kp0 = keypoints_0[m[0]]
                        kp1 = keypoints_1[m[1]]
        
                        if chunk.node.matchOnly.value:
                            color= (np.random.rand(3)*255).astype(np.uint8)
                            match_image=draw_keypoints(match_image, np.asarray( [(int(kp0[0]),int(kp0[1])), 
                                                                                (int(o+kp1[0]),int(kp1[1]))]), cols=color )
                        cv2.line(match_image, (int(kp0[0]),int(kp0[1])), (int(o+kp1[0]),int(kp1[1])), color = color.tolist())
                    save_image(os.path.join(chunk.node.outputFolder.value, 
                                            "matches_"+view_id_0+"_"+view_id_1+".png"), match_image)
                
        chunk.logManager.end()

