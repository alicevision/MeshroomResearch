__version__ = "2.0"
import os 

from meshroom.core import desc

from meshroom.core.plugin import PluginCommandLineNode, EnvType

EXEC = "python "+ os.path.join(os.path.dirname(__file__), "kornia_wrappers/light_glue_matcher.py")

class LightGlueMatching(PluginCommandLineNode):

    category = 'MRRS - Deep Matching'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = EXEC+" {allParams}"

    envFile=os.path.join(os.path.dirname(__file__), 'env.yaml')
    envType=EnvType.CONDA
    
    inputs = [
        desc.File(
            name="inputSfMData",
            label="SfMData",
            description="Input SfMData file.",
            value="",
            uid=[0],
        ),

        desc.File(
            name="inputFeatureFolder",
            label="inputFeatureFolder",
            description="inputFeatureFolder",
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
            name="distanceThreshold",
            label="distanceThreshold",
            description="distanceThreshold",
            range=(0.0,1.0,0.01),
            value=0.0,
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
            name="matchesFolders",
            label="Matches Folder",
            description="Path to a folder in which the computed matches are stored.",
            value=os.path.join(desc.Node.internalFolder, "matches"),
            uid=[],
            group=""
        )
    ]


