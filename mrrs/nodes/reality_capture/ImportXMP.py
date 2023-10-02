"""
This nodes make an sfm data from an xmp 
"""
__version__ = "3.0"

import json
import os
from meshroom.core import desc
from mrrs.core.ios import sfm_data_from_matrices
from mrrs.datasets.reality_capture import import_xmp, SENSOR_SIZE


class ImportXMP(desc.Node):

    category = 'Meshroom Research'

    documentation = '''Node to import a camera calibration from an XMP'''

    inputs = [

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.File(
            name="xmpData",
            label="xmpData",
            description="Input xmpData",
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
            name='outoutputSfMDataputSfM',
            label='outputSfMData',
            description='Path to the outputSfMData',
            value=os.path.join(desc.Node.internalFolder, "outputSfMData.sfm"),
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
        if chunk.node.xmpData.value=='':
            chunk.logger.warning('No xmpData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Starts to load data from XMP")
            extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size  = import_xmp(chunk.node.sfmData.value, chunk.node.xmpData.value)
            sfm_data = sfm_data_from_matrices(extrinsics, intrinsics, 
                                              poses_ids, intrinsics_ids, images_size,
                                              sfm_data=sfm_data, sensor_width = SENSOR_SIZE
                                              )
            # Save the generated SFM data to JSON file
            with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
                json.dump(sfm_data, f, indent=4)
            chunk.logger.info('XMP import ends')
        finally:
            chunk.logManager.end()



