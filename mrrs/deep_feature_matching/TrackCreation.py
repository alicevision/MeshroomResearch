__version__ = "3.0"

import os

from meshroom.core.plugin import PluginNode, EnvType
from meshroom.core import desc

class TrackCreation(PluginNode):

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
            name="minTracks",
            label="minTracks",
            description="Minimum number of tracks for a single view",
            range=(1,10000000,1),
            value=0
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
            name='tracksFile',
            label='tracksFile',
            description='tracksFile',
            value=os.path.join(desc.Node.internalFolder,"tracksFile.json"),
            group='',
        )
    ]

    def processChunk(self, chunk):
        """
        """
        import numpy as np
        from mrrs.core.ios import open_matches
        from mrrs.core.utils import time_it
        import json
        chunk.logManager.start(chunk.node.verboseLevel.value)

        # sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))

        chunk.logger.info("Opening files")
        with time_it() as t:
            feature_files = os.listdir(chunk.node.featureFolder.value)
            print("%d feature files detected"%len(feature_files))
            match_file = [os.path.join(chunk.node.matcheFolder.value, mf) for mf in os.listdir(chunk.node.matcheFolder.value) if mf.endswith(".txt")][0]
            chunk.logger.info('Opening matches from '+match_file)
            matches_flatten, images_uids, total_nb_match_per_view  = open_matches(match_file, flatten=True)

        chunk.logger.info("Creating tracks")
        
        import networkx as nx
        from networkx.utils import UnionFind

        def flat_matches_to_keys(m):
            """note: we always save all dense featues in feature files, soindex is static.
                key is uid_view+"_"+index_match
            """
            return [str(int(m[0]))+"_"+str(int(m[2])), str(int(m[1]))+"_"+str(int(m[2]))]

        def add_edges_and_union(matches_flatten, union_find):
            """Add edges to the graph based on pairwise matches and perform union operations."""
            for m in matches_flatten:
                k1, k2 = flat_matches_to_keys(m)
                # Perform union in Union-Find
                #ie => will happen to set with k1 or k2, or will make new set
                union_find.union(k1, k2)

  
        #NOTE: no weigts for root, issue=weigts are for nodes=>feaures, not maches

        # Initialize graph and union-find structure
        graph = nx.Graph()
        #generate unique feature keys
        #all_features_keys = [flat_matches_to_keys(m) for m in matches_flatten].reshape(-1)

        #union find object
        union_find = UnionFind()

        # Add edges and perform union operations based on pairwise matches, from most confidence to least
        add_edges_and_union(matches_flatten[::-1], graph, union_find)

        # Retrieve connected components
        tracks = list(union_find.to_sets())
        
        #save tracks
        track_data=[]
        for i, track in enumerate(tracks):
            
            for feature in track:
                    
        import json
        with open(chunk.node.tracksFile.value, 'w') as f:
            json.dump(data, f)

        chunk.logManager.end()

      