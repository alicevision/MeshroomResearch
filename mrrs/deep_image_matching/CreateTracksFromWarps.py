__version__ = "3.0"

import os

from meshroom.core.plugin import PluginNode, EnvType
from meshroom.core import desc


class CreateTracksFromWarps(PluginNode):

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
            name="matchFolder",
            label="Match Folder",
            description="",
            value=""
        ),

        desc.ChoiceParam(
            name="mode",
            label="mode",
            description="",
            value="clique",
            values=["greedy", "clique"],
            exclusive=True,
        ),

        # desc.FloatParam(
        #     name='errorThreshold',
        #     label='errorThreshold',
        #     description=''' ''',
        #     value=1.0,
        #     range=(0.0, 1000000000.0, 0.1),
        #     advanced=True
        # ),

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
        desc.File(
            name="outputTracks",
            label="Output tracks",
            description="",
            value=os.path.join(desc.Node.internalFolder, "tracks.json"),
        )
    ]

    def processChunk(self, chunk):
        """
        """
        import numpy as np
        from mrrs.core.ios import open_exr
        import json

        chunk.logManager.start(chunk.node.verboseLevel.value)

        chunk.logger.info("Opening files")
        with open(chunk.node.inputSfMData.value, "r") as json_file:
            sfm_data = json.load(json_file)
        #sort by frame id
        if "frameId" in sfm_data["views"][0].keys():
            sfm_data["views"] = sorted(sfm_data["views"], key= lambda x:int(x["frameId"]))
        else:
            chunk.logger.info("No frameId")
        images_uids = [v["viewId"] for v in sfm_data["views"]]
        nb_view = len(images_uids)
        oW = int(sfm_data["views"][0]["width"])
        oH = int(sfm_data["views"][0]["height"])

        chunk.logger.info(("Image size (wh): %d %d"%(oW,oH)))

        warp_files = [f for f in os.listdir(chunk.node.matchFolder.value) if f.endswith("_warp.exr")]
        
        chunk.logger.info("%d warps found"%(len(warp_files)))

        warps = {view_id_0:{view_id_1:[] for view_id_1 in images_uids } for i, view_id_0 in enumerate(images_uids)}
        
        for warp_file in warp_files:
            uid_0, uid_1 = warp_file.replace("_warp.exr","").split("_")
            # chunk.logger.info(uid_0+" "+uid_1)
            w,_=open_exr(os.path.join(chunk.node.matchFolder.value, warp_file))
            H,W = w.shape[0:2]
            w[:,:,0]*=W
            w[:,:,1]*=H
            warps[uid_0][uid_1] = w
       
        WORKING_REZ = (864,864)

        def to_1d(v,x,y):
            return v*WORKING_REZ[0]*WORKING_REZ[1]+y*WORKING_REZ[1]+x
        def from_1d(i):
            v=np.asarray(i/(WORKING_REZ[0]*WORKING_REZ[1])).astype(np.int32)
            y=np.asarray((i/WORKING_REZ[1])%WORKING_REZ[1]).astype(np.int32)
            x=i%WORKING_REZ[1]
            return v,x,y

        pys,pxs = np.meshgrid(np.arange(0,WORKING_REZ[0]), np.arange(0,WORKING_REZ[1]), indexing='ij')
        pys=pys.flatten()
        pxs=pxs.flatten()
        
        if chunk.node.mode.value == "clique":
            import networkx as nx 
            match_graph = nx.Graph()
            match_graph.add_nodes_from(range(nb_view*WORKING_REZ[0]*WORKING_REZ[1]))
            for i,uid_0 in enumerate(images_uids):
                for j,uid_1 in enumerate(images_uids):
                    if (uid_0 != uid_1) and (uid_0 in warps) and (uid_1 in warps[uid_0]) and len(warps[uid_0][uid_1])!= 0:
                        chunk.logger.info("Adding matches from %d %d"%(i,j))
                        w = warps[uid_0][uid_1].reshape([-1,3]).astype(np.int32)
                        if len(w) == 0:
                            continue
                        idx_0 = to_1d(i,pys,pxs)
                        idx_1 = to_1d(j,w[:,1], w[:,0])

                        # print(w[100:110,0:2])
                        # print("--")
                        # print(np.stack([pys,pxs], axis=-1)[100:110,:])
                        # print("--")
                        # print(np.stack([idx_0[100:110], idx_1[100:110]],axis=-1))
                        # break
                        #add edges for each match FIXME: could add a window FIXME: add weight
                        match_graph.add_edges_from(np.stack([idx_0, idx_1], axis=-1))
            chunk.logger.info("Find cliques")
            #cliques suggest strong matches
            cliques = list(nx.find_cliques(match_graph))
            chunk.logger.info("Done, %d cliques found"%len(cliques))
            selected_matches = []
            MIN_TRACK_SIZE=3
            for cl in cliques:
                if len(cl)>=MIN_TRACK_SIZE:
                    selected_matches.append(cl)
            chunk.logger.info("found %d tracks with more than %d matches"%(len(selected_matches), MIN_TRACK_SIZE))
        elif chunk.node.mode.value == "greedy":
            chunk.logger.info("Greedy mode computing...")

            #init tracks with pixel grid
            all_selected_matches = [[to_1d(0,x,y)] for x,y in zip(pxs, pys)]
            MIN_CONF = 0.9
            #for each frame
            for i in range(0, len(images_uids)-1):
                chunk.logger.info("%d tracks"%(len(all_selected_matches)))
                chunk.logger.info("%d/%d"%(i, len(images_uids)))
                #get uit a i and i+1
                uid_0=images_uids[i]
                uid_1=images_uids[i+1]
                #warps fro->i+1: from each px of i-1 coresp coordinate in i
                w = warps[uid_0][uid_1].reshape([-1,3])

                #select last features of each track (sequenial mode)
                prev_feature_idx = np.asarray([sm[-1] for sm in all_selected_matches])
                prev_vs, prev_xs, prev_ys = from_1d(prev_feature_idx)
                print("%d active tracks "%prev_xs.shape[0])
            
                #x,y coord at i, warp i->i+1 on i, wx wy, matchingcoord in i+1
                assert(pys.shape[0]==w.shape[0])
                for y,x,wy,wx,c in zip(pys, pxs, w[:,0], w[:,1], w[:,2]):
                    if c>MIN_CONF: #FIXME: hardcoded?
                        wx=int(np.round(wx))
                        wy=int(np.round(wy))#indx at i+1
                        # print(wy,wx,y,x)
                        
                        next_feat_idx = to_1d(i+1,wx,wy)
                        #if there is an ongoing track at i, get matching index
                        j=np.nonzero((x==prev_xs) & (y==prev_ys) & (prev_vs==i))
                        if len(j[0])>=1:# 
                            # print("adding %d %d "%(wx,wy)+str(i+1)+" to %d %d "%(x,y)+str(all_selected_matches[j[0][0]]))
                            all_selected_matches[j[0][0]].append(next_feat_idx)
                        elif len(j[0])==0:#else create new trak
                            # print("Create")
                            all_selected_matches.append([next_feat_idx])
                


            # #init tracks with pixel grid
            # all_selected_matches = [[to_1d(0,x,y)] for x,y in zip(pxs, pys)]
            # MIN_CONF = 0.9
            # #for each frame
            # for i in range(1, len(images_uids)):
            #     chunk.logger.info("%d tracks"%(len(all_selected_matches)))
            #     chunk.logger.info("%d/%d"%(i, len(images_uids)))
            #     #get uit a i and i-1
            #     uid_0=images_uids[i-1]
            #     uid_1=images_uids[i]
            #     #warps fro i-1->i: from each px of i-1 coresp coordinate in i
            #     w = warps[uid_0][uid_1].reshape([-1,3])
            #     #select last feature of each track (sequenial)
            #     prev_feature_idx = np.asarray([sm[-1] for sm in all_selected_matches])
            #     #for now sequential, only interested in i-1
            #     prev_vs, prev_xs, prev_ys = from_1d(prev_feature_idx)
            #     print("%d active tracks "%prev_xs.shape[0])
               
            #     #for each warped pixex
            #     #x,y coord at i, warp i-1->i on i, 
            #     for y,x,wy,wx,c in zip(pys, pxs, w[:,1], w[:,0], w[:,2]):
            #         if c>MIN_CONF: #FIXME: hardcoded?
            #             wx=int(wx)
            #             wy=int(wy)#
            #             current_feat_idx = to_1d(i,x,y)
            #             #if there was an ongoing track at this pixel on i-1 
            #             j=np.nonzero((wx==prev_xs) & (wy==prev_ys) & (prev_vs==(i-1)))
            #             if len(j[0])>=1:# 
            #                 all_selected_matches[j[0][0]].append(current_feat_idx)
            #             elif len(j[0])==0:#else create new trak
            #                 # print("Create")
            #                 all_selected_matches.append([current_feat_idx])
                        
                
            chunk.logger.info("Cleaning up one length traskcs from %d"%(len(all_selected_matches)))
            selected_matches  = [sm for sm in all_selected_matches if len(sm)>=2]
            chunk.logger.info("%d remaining "%len(selected_matches))
        else:
            raise RuntimeError("Invalid mode")

        chunk.logger.info("Tracks stats")
        track_length={}
        for sm in selected_matches:
            if len(sm) in track_length.keys():
                track_length[len(sm)]+=1
            else:
                track_length[len(sm)]=1
        for t in sorted(track_length.keys()):
            chunk.logger.info("%d:%d"%(t, track_length[t]))

        # print(selected_matches)

        MAX_TRACK = 50000
        selected_matches = sorted(selected_matches, key=lambda x:len(x), reverse=True)
        selected_matches=selected_matches[:MAX_TRACK]

        # print(selected_matches)

        chunk.logger.info("Tracks stats")
        track_length={}
        for sm in selected_matches:
            if len(sm) in track_length.keys():
                track_length[len(sm)]+=1
            else:
                track_length[len(sm)]=1
        for t in sorted(track_length.keys()):
            chunk.logger.info("%d:%d"%(t, track_length[t]))

        chunk.logger.info("Writting %d tracks"%(len(selected_matches)))
        #writing tracks
        # os.makedirs(chunk.node.output.value, exist_ok=True)
        tracks=[]
        features_per_view = {}
        sequ1d_to_feat_id = {}
        clean_matches = { uid0: {uid1:[] for uid1 in images_uids} for uid0 in images_uids}
        for i,matches in enumerate(selected_matches):
            feats = []
            # print("Track %d:"%i)
            for j,f in enumerate(matches):
                view_index, x,y  = from_1d(f)
                # print(x,y)
                v_uid = images_uids[view_index]
                if not v_uid in features_per_view.keys():
                    features_per_view[v_uid]=[]
                f_uid = len(features_per_view[v_uid])
                sequ1d_to_feat_id[f]=f_uid
                x= float(oH*x/WORKING_REZ[1])
                y= float(oW*y/WORKING_REZ[0])
                features_per_view[v_uid].append([x,y]) 
                feats.append([  int(v_uid), 
                                {"featureId": int(f_uid),
                                "coords": [x,y],
                                "scale": float(0)}
                            ])
                if j>0:
                    pv_idx,_,_ = from_1d(matches[j-1])#previous feature in match
                    pv_uid = images_uids[pv_idx] #view uid of this feature
                    pf_uid = len(features_per_view[pv_uid])-1 #feature id in the view
                    clean_matches[pv_uid][v_uid].append([pf_uid, f_uid])

            tracks.append([int(i), {"descType": chunk.node.describerTypes.value,"featPerView": feats}])

        with open(chunk.node.outputTracks.value, "w") as tf:
            json.dump(tracks, tf)

        #save features from only tracks
        for v_uid in features_per_view: 
            kpts = features_per_view[v_uid]
            with open(os.path.join(chunk.node.output.value,v_uid+"."+chunk.node.describerTypes.value+".feat"), "w") as kpf:
                kpf.write("".join(["%f %f 0 0\n"%(kp[1], kp[0]) for kp in kpts ]))

        #save matches from only tracks, will only create match from a frame to the other 
        # for i,matches in enumerate(clean_matches):
        # print(clean_matches)
        with open(os.path.join(chunk.node.output.value,"0.matches.txt"), "a") as mf:
            for uid0 in images_uids:
                if uid0 in clean_matches.keys():
                    for uid1 in images_uids:
                        if uid1 in clean_matches[uid0].keys():
                            matches = clean_matches[uid0][uid1]

                            if len(matches)>=1:
                                # print(matches)
                                num_kp = len(matches)
                                mf.write("%s %s\n"%(uid0, uid1))
                                mf.write("1\n")
                                mf.write(chunk.node.describerTypes.value+" %d\n"%(num_kp))#
                                for m in matches:#save feature index with offset for each view
                                    mf.write("%d %d\n"%(m[0], m[1]))
    
        chunk.logManager.end()

