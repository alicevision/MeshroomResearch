__version__ = "2.0"
import os 

from meshroom.core import desc
from mrrs.deep_feature_matching import ENV_FILE
from mrrs.core.CondaNode import CondaNode

EXEC = "python "+ os.path.join(os.path.dirname(__file__), "../../deep_feature_matching/deep_feature_extraction.py")

class DeepFeatureExtraction(CondaNode):

    category = 'Sparse Reconstruction'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = EXEC+" {allParams}"

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

        desc.ChoiceParam(
            name="method",
            label="method",
            description="method",
            value="DISK",
            values=["DISK", "SIFT"],
            exclusive=True,
            uid=[],
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
        )
    ]

