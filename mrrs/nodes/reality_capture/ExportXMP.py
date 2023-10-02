"""
This nodes make an xmp from the sfm data.
"""
__version__ = "3.0"

import json
import os

from meshroom.core import desc

from mrrs.core.ios import matrices_from_sfm_data
from mrrs.datasets.reality_capture import export_reality_capture


class ExportXMP(desc.Node):

    category = 'Meshroom Research'

    documentation = '''Node to create an XMP file from camera calibration.'''

    inputs = [

        desc.ChoiceParam(
            name='targetXMP',
            label='target XMP',
            description='''Target XMP format to be used''',
            value='export_reality_capture',
            values=['export_reality_capture'],
            exclusive=True,
            uid=[0],
        ),

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output folder',
            description='Path to the XMP folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.sfmData.value=='':
            chunk.logger.warning('No sfmData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Starts to load data from sfmdata")
            sfm_data = json.load(open(chunk.node.sfmData.value, "r"))

            (extrinsics_all_cams, intrinsics_all_cams, views_id,
            poses_id, intrinsics_id, pixel_sizes_all_cams) = matrices_from_sfm_data(sfm_data)
            chunk.logManager.start("Exporting calibration")
            images_names = [os.path.basename(view["path"])[:-4] for view in sfm_data["views"]]
            for image_name, extrinsics, intrinsics, pixel_size in zip(images_names, extrinsics_all_cams, intrinsics_all_cams, pixel_sizes_all_cams):
                if extrinsics is not None:
                    xmp_file = os.path.join(chunk.node.outputFolder.value, image_name+".xmp") #FIXME: image basename+xmp
                    export_reality_capture(xmp_file, extrinsics, intrinsics, pixel_size)

            chunk.logger.info('XMP export ends')
        finally:
            chunk.logManager.end()



