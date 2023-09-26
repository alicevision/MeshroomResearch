__version__ = "2.0"
import os 

from meshroom.core import desc
from mrrs.deep_feature_matching import ENV_FILE
from mrrs.core.CondaNode import CondaNode

LOFTR_EXEC = "python "+ os.path.join(os.path.dirname(__file__), "../../deep_feature_matching/deep_feature_matching.py")

class DeepFeatureMatching(CondaNode):

    category = 'Sparse Reconstruction'
    documentation = ''' '''

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
        
        # desc.File(
        #     name="imagePairsList",
        #     label="Image Pairs",
        #     description="Path to a file which contains the list of image pairs to match.",
        #     value="",
        #     uid=[0],
        # ),


        desc.StringParam(
            name='imageMaching',
            label='imageMaching',
            description='Method for image matching. Can be "all", an integer defining the windows around the framesId',
            value="all",
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
    outputs = [#FIXME: output features and output matches?
        desc.File(
            name="outputFolder",
            label="Output Folder",
            description="Path to a folder in which the computed results are stored.",
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name="featuresFolder",
            label="Features Folder",
            description="Path to a folder in which the features matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "features"),
            uid=[],
            group=""
        ),
        desc.File(
            name="machesFolder",
            label="Matches Folder",
            description="Path to a folder in which the computed matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "matches"),
            uid=[],
            group=""
        )
    ]


