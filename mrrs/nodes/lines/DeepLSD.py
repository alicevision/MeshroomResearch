__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL
from mrrs.core.CondaNode import CondaNode
from mrrs.lines.DeepLSD import SCRIPT_FILE, ENV_PATH, MODEL_FILE_MD, MODEL_FILE_WIREFRAME, ENV_FILE

class DeepLSD(CondaNode):
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
Line segment detection using DeepLSD model.

Reference:
- Github repo: (https://github.com/cvg/DeepLSD)
- Paper's arXiv link: (https://arxiv.org/abs/2212.07766)
'''

    models = {
        'WireFrame': MODEL_FILE_WIREFRAME,
        'MegaDepth': MODEL_FILE_MD,
        'Custom': ''
    }

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
        desc.BoolParam(
            name="lineDetectionEnabled",
            label="Detect Lines",
            description="Whether to detect lines or only DF/AF (Distances/Angles fields).",
            value=True,
            uid=[0],
        ),
        desc.GroupAttribute(
            name="lineDetection",
            label="Line Detection",
            description="Line extraction from DF/AF.",
            group=None,
            enabled=lambda node: node.lineDetectionEnabled.value,
            groupDesc=[
                desc.FloatParam(
                    name="grad_thresh",
                    label="Gradient Threshold",
                    description="Gradient Threshold",
                    value=3.,
                    range=(0., 5., 1.),
                    uid=[0],
                    enabled=lambda node: node.lineDetection.lineDetectionEnabled.value,
                ),
                desc.BoolParam(
                    name="grad_nfa",
                    label="Image Gradient NFA",
                    description="If True, use the image gradient and the NFA score of LSD to further threshold lines.\n"
                    "We recommand using it for easy images, but to turn it off for challenging images (e.g. night, foggy, blurry images)",
                    value=True,
                    uid=[0],
                    enabled=lambda node: node.lineDetection.lineDetectionEnabled.value,
                ),
                desc.GroupAttribute(
                    name="filtering",
                    label="Filter Lines",
                    description="Whether to filter out lines based on the DF/AF.",
                    group=None,
                    groupDesc=[
                        desc.BoolParam(
                            name="filteringEnabled",
                            label="Enabled",
                            description="Enable line filtering.",
                            value=True,
                            uid=[0],
                        ),
                        desc.ChoiceParam(
                            name="filteringMode",
                            label="Filtering Mode",
                            description="Use 'strict' to get an even stricter filtering.",
                            value="normal",
                            values=["normal", "strict"],
                            exclusive=True,
                            uid=[0],
                            enabled=lambda node: node.lineDetection.filtering.filteringEnabled.value,
                        ),
                    ]
                ),
                desc.BoolParam(
                    name="mergeEnabled",
                    label="Merge Lines",
                    description="Whether to merge close-by lines.",
                    value=True,
                    uid=[0],
                ),
                desc.GroupAttribute(
                    name="refinement",
                    label="Refinement",
                    description="Whether to refine the lines after detecting them",
                    group=None,
                    groupDesc=[
                        desc.BoolParam(
                            name="refinementEnabled",
                            label="Enabled",
                            description="Enable refinement.",
                            value=True,
                            uid=[0],
                        ),
                        desc.BoolParam(
                            name="useVPs",
                            label="Use VPs",
                            description="Whether to use vanishing points (VPs) in the refinement",
                            value=True,
                            uid=[0],
                            enabled=lambda node: node.lineDetection.refinement.refinementEnabled.value,
                        ),
                        desc.BoolParam(
                            name="refineVPs",
                            label="Refine VPs",
                            description="Whether to also refine the VPs in the refinement",
                            value=True,
                            uid=[0],
                            enabled=lambda node: node.lineDetection.refinement.refinementEnabled.value,
                        ),
                    ]
                ),
            ],
        ),
        desc.ChoiceParam(
            name="model",
            label="Model",
            description="Which pretrained model to use:\n"
            "- Wireframe: trained on Wireframe dataset, can be used for easy indoor datasets\n"
            "- MegaDepth: trained on MegaDepth dataset, more generic and works outdoors and on more challenging scenes\n"
            "- Custom: custom model checkpoint given by path",
            values=list(models.keys()),
            value=list(models.keys())[1],
            exclusive=True,
            uid=[0],
        ),
        desc.File(
            name="ckpt",
            label="Model Checkpoint",
            description="Path to the checkpoint of the pretrained model.",
            value=models[list(models.keys())[1]],
            enabled=lambda node: node.model.value=='Custom',
            uid=[0],
        ),
        desc.GroupAttribute(
            name="export",
            label="Export",
            description="Export result visualization",
            group=None,
            groupDesc=[
                desc.BoolParam(
                    name="exportLines",
                    label="Export Lines Drawing",
                    description="Whether to export detected lines drawn on images.",
                    value=False,
                    enabled=lambda node: node.lineDetectionEnabled.value,
                    uid=[],
                ),
                desc.BoolParam(
                    name="exportLinesWithVP",
                    label="Export Lines with VP",
                    description="Whether to export detected lines drawn on images with VP color labels.",
                    value=False,
                    enabled=lambda node: node.lineDetectionEnabled.value and node.lineDetection.refinement.refinementEnabled.value,
                    uid=[],
                ),
                desc.BoolParam(
                    name="exportDF",
                    label="Export DF",
                    description="WWhether to export distance fields as images.",
                    value=False,
                    uid=[],
                ),
                desc.BoolParam(
                    name="exportDFNorm",
                    label="Export DF Norm",
                    description="Whether to export normalized distance fields as images.",
                    value=False,
                    uid=[],
                ),
                desc.BoolParam(
                    name="exportAF",
                    label="Export AF",
                    description="Whether to export angle fields as images.",
                    value=False,
                    uid=[],
                ),
                desc.BoolParam(
                    name="export_DF_AF_as_UV",
                    label="Export DF&AF as UV",
                    description="Whether to export distance and angle fields as UV flow image.",
                    value=False,
                    uid=[],
                ),
            ]
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
            description="Output folder for detected line segments.",
            value=desc.Node.internalFolder,
            uid=[],
        ),
        # these attributes are only here to describe more accurately the output of the node
        # by specifying that it generates 1 sequence of images
        # (see in Viewer2D.qml how these attributes can be used)
        desc.File(
            name="lines",
            label="Line Segments",
            description="",
            semantic="image",
            value=desc.Node.internalFolder + "lines/<VIEW_ID>.jpg",
            uid=[],
            group="", # do not export on the command line
            enabled = lambda node: node.export.exportLines.value
        ),
        desc.File(
            name="lines_with_vp",
            label="Line with VP",
            description="",
            semantic="image",
            value=desc.Node.internalFolder + "lines_with_vp/<VIEW_ID>.jpg",
            uid=[],
            group="", # do not export on the command line
            enabled = lambda node: node.export.exportLinesWithVP.value
        ),
        desc.File(
            name="df",
            label="DF",
            description="",
            semantic="image",
            value=desc.Node.internalFolder + "df/<VIEW_ID>.jpg",
            uid=[],
            group="", # do not export on the command line
            enabled = lambda node: node.export.exportDF.value
        ),
        desc.File(
            name="df_norm",
            label="DF Norm",
            description="",
            semantic="image",
            value=desc.Node.internalFolder + "df_norm/<VIEW_ID>.jpg",
            uid=[],
            group="", # do not export on the command line
            enabled = lambda node: node.export.exportDFNorm.value
        ),
        desc.File(
            name="af",
            label="AF",
            description="",
            semantic="image",
            value=desc.Node.internalFolder + "af/<VIEW_ID>.jpg",
            uid=[],
            group="", # do not export on the command line
            enabled = lambda node: node.export.exportAF.value
        ),
        desc.File(
            name="df_af_as_uv",
            label="DF and AF as UV",
            description="",
            semantic="image",
            value=desc.Node.internalFolder + "df_af_as_uv/<VIEW_ID>.jpg",
            uid=[],
            group="", # do not export on the command line
            enabled = lambda node: node.export.export_DF_AF_as_UV.value
        ),
    ]

    def onModelChanged(self, node):
        node.ckpt.value = self.models[node.model.value]
        # if node.model.value != "Custom":
        #     node.ckpt.setEnabled(False)
        #     print(node.ckpt.enabled)


    def onCkptChanged(self, node):
        if node.model.value == "Custom":
            self.models["Custom"] = node.ckpt.value