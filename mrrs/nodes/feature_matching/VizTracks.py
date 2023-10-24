__version__ = "3.0"

import os
import json

import cv2
from mrrs.core.utils import listdir_fullpath
from mrrs.nodes.feature_matching.VizFeatures import open_matches
import numpy as np

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.core.geometry import *

class VizTracks(desc.Node):

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
            name='inputTracks',
            label='inputTracks',
            description='inputTracks',
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

    desc.ChoiceParam(
            name="describerTypes",
            label="Describer Types",
            description="Describer types to keep.",
            value=["dspsift"],
            values=["sift", "sift_float", "sift_upright", "dspsift", "akaze", "akaze_liop", "akaze_mldb", "cctag3", "cctag4", "sift_ocv", "akaze_ocv", "tag16h5", "unknown"],
            exclusive=True,
            uid=[0]
        ),

    desc.ChoiceParam(
            name="verboseLevel",
            label="Verbose Level",
            description="Verbosity level (fatal, error, warning, info, debug, trace).",
            value="info",
            values=["fatal", "error", "warning", "info", "debug", "trace"],
            exclusive=True,
            uid=[],
        )
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
            name='trackViz',
            label='trackViz',
            description='trackViz',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder, 'tracks_<VIEW_ID>.png'),
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
        track_data=json.load(open(chunk.node.inputTracks.value,"r"))
        
        all_view_uids = [v["viewId"] for v in sfm_data["views"]]
        uids_to_ids = {v:all_view_uids.index(v) for v in all_view_uids if v != ""}

        feature_files = [os.path.join(chunk.node.featureFolder.value, 
                                      uid+"."+chunk.node.describerTypes.value+".feat") for uid in all_view_uids]
        features = [np.loadtxt(ff) for ff in feature_files]

        # for each image 
        for view in sfm_data["views"]:
            image_path = view["path"]
            image_uid = view["viewId"]
            image = open_image(image_path)
            #for all tracks
            for track in track_data:
                track_views = [str(v) for v,_ in track[1]["featPerView"]]
                #only if the track is visible on the view
                if image_uid not in track_views:
                    continue
                #get the features and draw them on the reference image
                feat_color = np.random.randint(0,255, size=3).tolist()
                prev_feat=None 
                for view_uid, feature_id in track[1]["featPerView"]:
                    view_index = uids_to_ids[str(view_uid)]
                    feat = features[view_index][feature_id]
                    if prev_feat is not None:
                        image=cv2.line( image, (int(prev_feat[0]),int(prev_feat[1])), 
                                               (int(feat[0]),int(feat[1])), color = feat_color)
                    prev_feat=feat

            save_image(os.path.join(chunk.node.outputFolder.value, "tracks_"+image_uid+".png"),image)


        chunk.logManager.end()

