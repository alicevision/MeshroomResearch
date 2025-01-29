__version__ = "1.0"

from meshroom.core import desc
import os.path

currentDir = os.path.dirname(os.path.abspath(__file__))

class GaussianSplattingOptim(desc.CommandLineNode):
    
    commandLine = 'rez env {rezEnvNameValue} -- gaussianSplattingOptim default --data_factor {dataFactorValue} --test_every 0 --max_steps {n_stepsValue} --data_dir {sfmValue} --result_dir {cache}/{nodeType}/{uid} --disable_viewer --eval_steps'
    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE

    # size = desc.DynamicNodeSize('sfm')
    # parallelization = desc.Parallelization(blockSize=40)
    # commandLineRange = '--rangeStart {rangeStart} --rangeSize {rangeBlockSize}'

    category = 'Inpainting 3D'
    documentation = '''
    This node creates and optimizes a gaussian splatting model based on sfm data and images.
'''

    def buildCommandLine(self, chunk):
        cmdLine = super(GaussianSplattingOptim, self).buildCommandLine(chunk) # ou juste super().buildCommandLine(chunk)
        node = chunk.node
        if node.use_masks.value:
            cmdLine = cmdLine + " --use_masks"
        return cmdLine + " --save_steps " + (str(node.n_steps.value) if not node.custom_ckpts.value else " ".join([str(e.value) for e in node.save_steps.value]))

    inputs = [
        desc.File(
            name="rezEnvName",
            label="Rez package name",
            description="Name (with path if necessary) of the rez package into which the computation should be executed.",
            value="gsplat-maskSupport",
            invalidate=False,
            group="",
            advanced=True,
            exposed=False,
        ),
        desc.File(
            name="sfm",
            label="SfmDataFolder",
            description="SfMData with the views, poses and intrinsics to use (in JSON format). Downscaled versions of the views should also be provided.",
            value="",
            group="",
        ),
        desc.IntParam(
            name="n_steps",
            label="Number of Steps",
            description="The number of steps performed by the optimization.",
            value=30000,
            group="",
        ),
        desc.IntParam(
            name="dataFactor",
            label="Data Factor",
            description="The height of the pyramid of subimages.",
            value=4,
            group="",
        ),
        desc.BoolParam(
            name="custom_ckpts",
            label="Use custom checkpoints",
            description="Set to True to provide custom checkpoints; default behavior is to save the model once, at the end of the optimization.",
            value=False,
            group="",
        ),
        desc.ListAttribute(
            desc.IntParam(
                name="save_step",
                label="Saving step",
                description="Step at which the model will be saved as checkpoint.",
                value=30000,
                group="",
            ),
            name="save_steps",
            label="Saving steps",
            description="All the steps at which the model will be saved as a check point.",
            group="",
            # TODO add enabled = 
        ),
        desc.BoolParam(
            name="use_masks",
            label="Use Masks",
            description="Whether segmentation masks will be used to remove certain parts of the image from the optimization, if available.",
            value=True,
            group="",
        ),
        # desc.BoolParam(
        #     name='use_masks',
        #     label="_",
        #     exposed=False,
        #     enabled = lambda node: node.useMasks.value,
        # ),
        desc.ListAttribute(
            elementDesc=desc.IntParam(
                name="input",
                label="Input",
                description="",
                value=0,
                #invalidate=False,
            ),
            name="stalling",
            label="Stalling",
            description="This input will not be processed. Use it to stall the node until some preliminary computation is done.",
            group="",
            exposed=False,
        )
    ]

    # def onCustom_ckptsChanged(self, node):
    #     node.save_steps_hidden.value = node.custom_ckpts.value

    outputs = [
        desc.File(
            name="output",
            label="Output",
            description="Output folder.",
            value=desc.Node.internalFolder,
        ),
        desc.File(
            name="model",
            label="Model",
            description="Optimized gaussian splatting model",
            value = lambda attr: desc.Node.internalFolder + f"/ckpts/ckpt_{attr.node.n_steps.value-1}_rank0.pt",
            group="",
        ),
        # desc.File(
        #     name="save_steps_hidden",
        #     label="Hidden",
        #     description="truc",
        #     value=lambda node: str(node.n_steps.value) if not node.custom_ckpts.value else " ".join([e.value for e in node.save_steps.value])
        # ),
    ]
