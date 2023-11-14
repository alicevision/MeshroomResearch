__version__ = "2.0"
import os 

from meshroom.core import desc
from mrrs.deep_feature_matching import ENV_FILE
from mrrs.core.CondaNode import CondaNode

LOFTR_EXEC = "python "+ os.path.join(os.path.dirname(__file__), "../../deep_feature_matching/loftr_matcher.py")

class LoftrMatcher(CondaNode):

    category = 'Sparse Reconstruction'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = LOFTR_EXEC+" {allParams}"

    #overides the env path
    @property
    def env_file(self):
        return ENV_FILE
    
    inputs = [
        desc.File(
            name="inputSfMData",
            label="SfMData",
            description="Input SfMData file.",
            value="",
            uid=[0],
        ),

        desc.IntParam(
            name="keepNmatches",
            label="keepNmatches",
            description="Only keep the n strongest matches per view. 0 to disable",
            range=(0,1000,1),
            value=0,
            uid=[0],
        ),

        desc.FloatParam(
            name="confidenceThreshold",
            label="confidenceThreshold",
            description="Only keep the matches if their confidence hits this threshold.",
            range=(0.0,1.0,0.01),
            value=0.5,
            uid=[0],
        ),
        
        desc.StringParam(
            name='imageMaching',
            label='imageMatching',
            description='Method for image matching. Can be "all", "file" to use the file in imagePairs, or an integer defining a window around the framesId',
            value="all",
            uid=[0],
        ),

        desc.File(
            name='imagePairs',
            label='imagePairs',
            description='Optional file defining the images pairs to be matched',
            value="",
            uid=[0],
        ),

        desc.BoolParam(
            name="debugImages",
            label="debugImages",
            description="Will write image matches",
            value=False,
            uid=[0],
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
            name="outputFolder",
            label="Output Folder",
            description="Path to a folder in which the computed results are stored.",
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name="featuresFolders",
            label="Features Folder",
            description="Path to a folder in which the features matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "features"),
            uid=[],
            group=""
        ),
        desc.File(
            name="matchesFolders",
            label="Matches Folder",
            description="Path to a folder in which the computed matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "matches"),
            uid=[],
            group=""
        )
    ]


