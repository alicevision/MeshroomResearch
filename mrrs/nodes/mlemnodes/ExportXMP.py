"""
This nodes make an xmp from the sfm data.
"""
__version__ = "3.0"

import json
import os

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *
from mrrs.core.utils import format_float_array

#FIXME: move this into a reality capture folder
def export_reality_capture(xmp_file, extrinsics, intrinsics):
    """
    Saves the xmp for reality capture.
    """
    #TODO: convertions
    focal = intrinsics[0,0]*35 #turn into equivalent 35mm
    pp_u = intrinsics[0,2]
    pp_v = intrinsics[1,2]
    rotation = np.linalg.inv(extrinsics[0:3,0:3])
    position = -rotation@extrinsics[2,0:3]

    def format_array(array):
        formated_str = ""
        for r in array:
            formated_str+=" "+str(r)
        return formated_str
    xmp_string="""
<x:xmpmeta xmlns:x="adobe:ns:meta/">
  <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <rdf:Description xmlns:xcr="http://www.capturingreality.com/ns/xcr/1.1#" xcr:Version="3"
       xcr:PosePrior="initial" xcr:Coordinates="absolute" xcr:DistortionModel="brown3"
       xcr:FocalLength35mm="{0}" xcr:Skew="0" xcr:AspectRatio="1"
       xcr:PrincipalPointU="{1}" xcr:PrincipalPointV="{2}"
       xcr:CalibrationPrior="initial" xcr:CalibrationGroup="-1" xcr:DistortionGroup="-1"
       xcr:InTexturing="1" xcr:InMeshing="1">
      <xcr:Rotation>{3}</xcr:Rotation>
      <xcr:Position>{4}</xcr:Position>
      <xcr:DistortionCoeficients>{5}</xcr:DistortionCoeficients>
    </rdf:Description>
  </rdf:RDF>
</x:xmpmeta>
""".format(str(focal), pp_u, pp_v, format_array(rotation.flatten()), format_array(position), '0 0 0')#FIXME: for now we dont support this

    with open(xmp_file, "w") as f:
       f.write(xmp_string)

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
            for image_name, extrinsics, intrinsics in zip(images_names, extrinsics_all_cams, intrinsics_all_cams):
                if extrinsics is not None:
                    xmp_file = os.path.join(chunk.node.outputFolder.value, image_name+".xmp") #FIXME: image basename+xmp
                    export_reality_capture(xmp_file, extrinsics, intrinsics)

            chunk.logger.info('XMP export ends')
        finally:
            chunk.logManager.end()



