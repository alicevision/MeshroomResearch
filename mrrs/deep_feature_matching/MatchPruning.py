__version__ = "3.0"

import os

from meshroom.core.plugin import PluginNode, EnvType
from meshroom.core import desc

class MatchPruning(PluginNode):

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
            name="minMatches",
            label="minMatches",
            description="Minimum matches to keep for a single view",
            range=(1,10000000,1),
            value=0
        ),

        desc.FloatParam(
            name="confThreshold",
            label="confThreshold",
            description="Confidence threshold used to keep matches whatsoever",
            range=(0.0,1.0,0.01),
            value=0.0
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

    def processChunk(self, chunk):
        """
        """
        import numpy as np
        from mrrs.core.ios import open_matches
        from mrrs.core.utils import time_it
        chunk.logManager.start(chunk.node.verboseLevel.value)

        chunk.logger.info("Opening files")
        matches={}
        with time_it() as t:
            feature_files = os.listdir(chunk.node.featureFolder.value)
            print("%d feature files detected"%len(feature_files))
            match_file = [os.path.join(chunk.node.matcheFolder.value, mf) for mf in os.listdir(chunk.node.matcheFolder.value) if mf.endswith(".txt")][0]
            chunk.logger.info('Opening matches from '+match_file)
            matches_flatten, images_uids, total_nb_match_per_view  = open_matches(match_file, flatten=True)
            print(matches_flatten.shape)
        print(t)

        chunk.logger.info("Pruning")
        def prune(matches_flatten, total_nb_match_per_view):
            i = 0
            CONF_TH = chunk.node.confThreshold.value
            MIN_MATCH = chunk.node.minMatches.value
            nb_invalid_matchs=np.count_nonzero(matches_flatten[:,-1]<CONF_TH)
            to_keep=[]
            #adding the valid matches
            for i in range(nb_invalid_matchs, matches_flatten.shape[0]):
                to_keep.append(i)
            #for each potiential invalid
            for i in range(nb_invalid_matchs):
                if i%100 == 0:
                    print("%d percent"%(100*(i/nb_invalid_matchs)))
                view_id_0 = str(int(matches_flatten[i][0]))
                view_id_1 = str(int(matches_flatten[i][1]))
                #if nb match is enought to delete match
                if (total_nb_match_per_view[view_id_0] > MIN_MATCH) and (total_nb_match_per_view[view_id_1] > MIN_MATCH):
                    continue
                to_keep.append(i)
            nb_to_rm = matches_flatten.shape[0]-len(to_keep)
            chunk.logger.info("Removing %d weak and redondant matches, keeping %d"%(nb_to_rm, len(to_keep)))
            matches_flatten=matches_flatten[to_keep,:]
            return matches_flatten

        matches_flatten = prune(matches_flatten, total_nb_match_per_view)
        print(matches_flatten.shape)
        print("Writting")
        #writting remaining matches
        out_matches_folder = chunk.node.outputMatchesFolders.value

        #reshaping into dic of dic of list
        clean_matches= {view_id_0:{view_id_1:[] for view_id_1 in images_uids } for i, view_id_0 in enumerate(images_uids)}
        for m in matches_flatten:
            clean_matches[str(int(m[0]))][str(int(m[1]))].append(m[2:4])

        #FIXME: call fc
        os.makedirs(out_matches_folder, exist_ok=True)
        with open(os.path.join(out_matches_folder,"0.matches.txt"), "a") as mf:
            for view_id_0 in clean_matches.keys():
                for view_id_1 in list(clean_matches.keys()):
                    ms = clean_matches[str(int(view_id_0))][str(int(view_id_1))]
                    if len(ms) == 0:#skipping views without matches
                        continue
                    mf.write("%s %s\n"%(view_id_0, view_id_1))
                    mf.write("1\n")
                    mf.write("sift %d\n"%(len(ms)))#for now we disguise as sift
                    for kp0_idx,kp1_idx in ms:
                        mf.write("%d %d\n"%(kp0_idx, kp1_idx))
            
        chunk.logManager.end()

