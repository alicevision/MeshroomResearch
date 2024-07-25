__version__ = "2.0"
import os 

from meshroom.core import desc

from meshroom.core.plugin import PluginNode


EXEC = "python "+ os.path.join(os.path.dirname(__file__), "kornia_wrappers/deep_feature_extraction.py")

class DeepFeatureExtraction(PluginNode):

    category = 'Sparse Reconstruction'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = EXEC+" {allParams}"

    #overides the env path
    envFile=os.path.dirname(__file__), 'env.yaml'
    
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

        desc.IntParam(
            name="maxKeypoints",
            label="maxKeypoints",
            description="Only keep maxKeypoints features.",
            range=(0,100000000,1),
            value=3000,
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
        )
    ]


