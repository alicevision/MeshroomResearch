__version__ = "3.0"

import os
import json

import cv2
import numpy as np

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.core.geometry import *

def parse_line(matches):
    result = [m.strip() for m in matches.readline().split(" ")]
    if len(result) == 1:
        if result[0] == "":
            return None
        result = result[0]
    return result

def open_matches(match_file):
    with open(match_file, "r") as match_file:
        match_data = {}
        while True:
            view_ids = parse_line(match_file)
            if view_ids is None:
                break
            view_id_0, view_id_1 = view_ids
            nb_type_feat = parse_line(match_file)
            if nb_type_feat != "1":
                raise RuntimeError("Only supports one descriptor type at the time")
            type_feat, nb_match = parse_line(match_file)
            nb_match = int(nb_match)
            matches_raw = [match_file.readline() for _ in range(nb_match)]
            #avoid the squeeze when onlly one match
            if len(matches_raw)  == 1:
                matches = np.expand_dims(np.loadtxt(matches_raw).astype(np.int32), axis=0)
            else:
                matches = np.loadtxt(matches_raw).astype(np.int32)
            if matches.shape[0] != nb_match:
                raise RuntimeError("Unexpected number of matches for view %s %d vs %d"%(view_id_0, matches.shape[0], nb_match))
            #save result
            if not (view_id_0 in match_data.keys()):
                match_data[view_id_0]={}
            match_data[view_id_0][view_id_1] = matches
    return match_data

def draw_keypoints(image, keypoints, downsample=1, p = 2, o = 0):
    for kp in keypoints[::downsample]:
        image[int(kp[1])-p:int(kp[1])+p, o+int(kp[0])-p:o+int(kp[0])+p, :]=[0,255,0]
    return image 

def get_best_matching_view(view_matches):
    values = list(view_matches.values())
    lengths = [v.shape[0] for v in values]
    keys = list(view_matches.keys())
    index_max = np.argmax(lengths)
    return keys[index_max], values[index_max]

class VizFeatures(desc.Node):

    category = 'Meshroom Research'
    documentation = ''''''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
            uid=[0],
        ),

        desc.File(
            name="featureFolder",
            label="Feature Folder",
            description="Featurefolder",
            value="",
            uid=[0],
        ),

        desc.File(
            name="matcheFolder",
            label="Match Folder",
            description="Featurefolder",
            value="",
            uid=[0],
        ),
        
        desc.IntParam(
            name="keepMatches",
            label="keepMatches",
            description="Only display first n matches",
            range=(1,1000,1),
            value=0,
            uid=[0],
        ),

        desc.BoolParam(
            name="matchOnly",
            label="matchOnly",
            description="Only display the matches",
            value=True,
            uid=[0],
        ),

        desc.IntParam(
            name="markerSize",
            label="markerSize",
            description="marker wize /2",
            range=(1,1000,1),
            value=1,
            uid=[0],
        ),


    desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),

    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='outputFolder',
            description='outputFolder',
            value=desc.Node.internalFolder,
            uid=[],
            group='',
        ),
        desc.File(
            name='featureViz',
            label='featureViz',
            description='featureViz',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder, 'features_<VIEW_ID>.png'),
            uid=[],
            group='',
        ),
        desc.File(
            name='matchingViz',
            label='matchingViz',
            description='matchingViz',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder, 'matches_<VIEW_ID>.png'),
            uid=[],
            group='',
        ),
    ]

    def processChunk(self, chunk):
        """
        """
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
        
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
            matches = open_matches(match_file)
            chunk.logger.info('Done open')
            for view_id_0 in matches.keys():
                chunk.logger.info('Matching for view '+view_id_0)
                #for now, only select the best matched view (the one with most matches)
                view_id_1, matches_0_to_1=get_best_matching_view(matches[view_id_0])
                chunk.logger.info('Best matcing for view '+view_id_0+" is "+view_id_1+ " (%d matches)"%len(matches_0_to_1))
                
                if chunk.node.matchOnly.value: #if match only, will only display line
                    image_file_0 = [view["path"] for view in sfm_data["views"] if view["viewId"]==view_id_0][0]
                    image_file_1 = [view["path"] for view in sfm_data["views"] if view["viewId"]==view_id_1][0]
                else:
                    image_file_0 = os.path.join(chunk.node.outputFolder.value, "features_"+view_id_0+".png")
                    image_file_1 = os.path.join(chunk.node.outputFolder.value, "features_"+view_id_1+".png")
                
                image_0 = open_image(image_file_0)
                image_1 = open_image(image_file_1)

                match_image = np.concatenate([image_0, image_1], axis=1)
                keypoint_file_0 = [os.path.join(chunk.node.featureFolder.value, ff) for ff in feature_files if ((view_id_0 in ff) and ff.endswith(".feat"))][0]
                keypoint_file_1 = [os.path.join(chunk.node.featureFolder.value, ff) for ff in feature_files if ((view_id_1 in ff) and ff.endswith(".feat"))][0]
                keypoints_0 = np.loadtxt(keypoint_file_0)
                keypoints_1 = np.loadtxt(keypoint_file_1)
                o=image_0.shape[1]
                for m in matches_0_to_1[0:chunk.node.keepMatches.value]:
                    if m[0]>keypoints_0.shape[0]:
                        raise RuntimeError("ERROR FEATURE INDEX IN MATCH OUTSIDE OF LISTED FEATURES FOR %s (%d vs %d)"%(view_id_0, m[0],keypoints_0.shape[0]))
                    if m[1]>keypoints_1.shape[0]:
                        raise RuntimeError("ERROR FEATURE INDEX IN MATCH OUTSIDE OF LISTED FEATURES FOR %s (%d vs %d)"%(view_id_1, m[1],keypoints_1.shape[0])) 
                    kp0 = keypoints_0[m[0]]
                    kp1 = keypoints_1[m[1]]
                    
                    cv2.line(match_image, (int(kp0[0]),int(kp0[1])), (int(o+kp1[0]),int(kp1[1])), color = [0,0,255])
                save_image(os.path.join(chunk.node.outputFolder.value, "matches_"+view_id_0+".png"),match_image)
  
        chunk.logManager.end()

