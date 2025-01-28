__version__ = "3.0"

import os

from meshroom.core.plugin import PluginNode, EnvType
from meshroom.core import desc

class TestSparseWarp(PluginNode):

    category = 'MRRS - Deep Matching'
    documentation = ''''''

    envFile=os.path.join(os.path.dirname(__file__), 'minenv.yaml')
    envType=EnvType.CONDA

    inputs = [
        desc.File(
            name='inputSfMData',
            label='inputSfMData',
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
            name="matchFolder",
            label="Match Folder",
            description="",
            value=""
        ),

        desc.File(
            name="rawMatchFolder",
            label="rawMatchFolder",
            description="",
            value=""
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),

    desc.ChoiceParam(
            name='describerTypes',
            label='describerTypes',
            description="",
            value='dspsift',
            values=['dspsift'],
            exclusive=True)
    ]

    outputs = [
        desc.File(
            name='output',
            label='output',
            description='output',
            value=desc.Node.internalFolder,
            group='',
        ),
    ]

    def processChunk(self, chunk):
        """
        """
        import numpy as np
        from mrrs.core.ios import open_exr, open_matches
        import json

        chunk.logManager.start(chunk.node.verboseLevel.value)

        chunk.logger.info("Opening files")
        with open(chunk.node.inputSfMData.value, "r") as json_file:
            sfm_data = json.load(json_file)
        #sort by frame id
        if "frameId" in sfm_data["views"][0].keys():
            sfm_data["views"] = sorted(sfm_data["views"], key= lambda x:int(x["frameId"]))
        images_uids = [v["viewId"] for v in sfm_data["views"]]
        nb_view = len(images_uids)
        oW = int(sfm_data["views"][0]["width"])
        oH = int(sfm_data["views"][0]["height"])
        print("Image size (wh) %d %d"%(oW,oH))
        #
        match_file = [os.path.join(chunk.node.matchFolder.value, mf) for mf in os.listdir(chunk.node.matchFolder.value) if mf.endswith(".txt")][0]
        chunk.logger.info('Opening matches from '+match_file)
        matches, images_uids  = open_matches(match_file)
        chunk.logger.info('Opening feature files')
        features = {uid:np.loadtxt(os.path.join(chunk.node.featureFolder.value, uid+".sift.feat")) for uid in images_uids }
        #
        warp_files = [f for f in os.listdir(chunk.node.rawMatchFolder.value) if f.endswith("_warp.exr")]
        chunk.logger.info("%d warps found"%(len(warp_files)))
        warps = {view_id_0:{view_id_1:None for view_id_1 in images_uids } for i, view_id_0 in enumerate(images_uids)}
        for warp_file in warp_files:
            uid_0, uid_1 = warp_file.replace("_warp.exr","").split("_")
            # chunk.logger.info(uid_0+" "+uid_1)
            w,_=open_exr(os.path.join(chunk.node.rawMatchFolder.value, warp_file))
            H,W = w.shape[0:2]
            w[:,:,0]*=W
            w[:,:,1]*=H
            warps[uid_0][uid_1] = w
       
       
        # #####
        # print(matches)
        # for k in features.keys():
        #     print(k)
        #     print(features[k])
        # #
        WORKING_REZ = (864,864)
        invalid = {}
        for uid0 in images_uids:
            features_0=features[uid0]
            for uid1 in images_uids:
                features_1=features[uid1]
                if (uid0 not in matches.keys()) or (uid1 not in matches[uid0].keys()) or  (warps[uid0][uid1] is None):
                    continue
             
                matches01 = matches[uid0][uid1]
                warp01 = warps[uid0][uid1]
            
                def full2down(y, x, round=False):
                    return int(np.round(WORKING_REZ[0]*y/oH)), int(np.round(WORKING_REZ[1]*x/oW))
                valid=0
                for f_idx_0,f_idx_1 in matches01:
                    x0,y0,_,_ = features_0[int(f_idx_0)]
                    x1,y1,_,_ = features_1[int(f_idx_1)]
                    ny0, nx0=full2down(y0,x0)
                    wx, wy, c = warp01[ny0,nx0]

                    ny1, nx1 = full2down(y1, x1)
                    chunk.logger.info(wy-ny1)
                    chunk.logger.info(wx-nx1)

                    if np.sqrt((wy-ny1)**2 + (wx-nx1)**2)<=1:
                        valid+=1
                    else:
                        if uid0+"_"+uid1 in invalid.keys():
                            invalid[uid0+"_"+uid1].append([[[ny0,nx0],full2down(y1, x1), [wy, wx], c]])
                        else:
                            invalid[uid0+"_"+uid1]=[[[ny0,nx0],full2down(y1, x1), [wy, wx], c]]
                chunk.logger.info(("%d/%d valid"%(valid, len(matches01))))

        chunk.logManager.end()

