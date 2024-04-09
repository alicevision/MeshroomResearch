__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL
from mrrs.core.CondaNode import CondaNode
from mrrs.normal_maps.DSINE import SCRIPT_FILE, ENV_PATH, MODEL_FILE, ENV_FILE

class DSINE(CondaNode):
    # overrides the env path
    env_path = ENV_PATH
    env_file = ENV_FILE

    commandLine = 'python ' + SCRIPT_FILE + ' {allParams}'
    gpu = desc.Level.INTENSIVE
    size = desc.DynamicNodeSize('input')
    parallelization = desc.Parallelization(blockSize=12)
    commandLineRange = '--rangeStart {rangeStart} --rangeSize {rangeBlockSize}'

    category = 'Meshroom Research'
    documentation = '''
Normal map estimation using DSINE module.

Reference:
- Project page: (https://baegwangbin.github.io/DSINE/)
- Github repo: (https://github.com/baegwangbin/DSINE)
- Paper's arXiv link: (https://arxiv.org/abs/2403.00712)
'''

    inputs = [
        desc.File(
            name="input",
            label="SfMData",
            description="Input SfMData file.",
            value="",
            uid=[0],
        ),
        desc.File(
            name="imagesFolder",
            label="Images Folder",
            description="Use images from a specific folder instead of those specified in the SfMData file.\n"
                        "Filename should be the image UID.",
            value="",
            uid=[0],
        ),
        desc.IntParam(
            name="maxWidth",
            label="Max Width",
            description="Maximum image width (in pixel).",
            value=1024,
            range=(32, 4096, 32),
            uid=[0],
        ),
        desc.IntParam(
            name="fov",
            label="FOV",
            description="Field-of-view (in degree) to be used for estimating camera intrinsics if missing.",
            value=45,
            range=(1, 180, 5),
            uid=[0],
        ),
        desc.File(
            name="ckpt",
            label="Model Checkpoint",
            description="Path to the checkpoint of the pretrained model.",
            value=MODEL_FILE,
            uid=[0],
        ),
        desc.ChoiceParam(
            name="verboseLevel",
            label="Verbose Level",
            description="Verbosity level (fatal, error, warning, info, debug, trace).",
            values=VERBOSE_LEVEL,
            value="info",
            exclusive=True,
            uid=[],
        ),
    ]

    outputs = [
        desc.File(
            name="output",
            label="Folder",
            description="Output folder for generated normal maps.",
            value=desc.Node.internalFolder,
            uid=[],
        ),
        # these attributes are only here to describe more accurately the output of the node
        # by specifying that it generates 2 sequences of images
        # (see in Viewer2D.qml how these attributes can be used)
        desc.File(
            name="normal",
            label="Normal Maps",
            description="Generated normal maps.",
            semantic="image",
            value=desc.Node.internalFolder + "<VIEW_ID>_normalMap.jpg",
            uid=[],
            group="", # do not export on the command line
        ),
    ]
