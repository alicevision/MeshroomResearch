import re
import os 
import numpy as np

#in RC the sensor size is set to 35mm
SENSOR_SIZE = 35

def parse_xmp(xmp_file):
    """
    Parses the xmp from reality capture.
    """
    with open(xmp_file) as f:
        xmp_lines = " ".join(f.readlines())
        camera_center = re.search(
            "<xcr:Position>(.*)</xcr:Position>", xmp_lines)
        rotation_matrix = re.search(
            "<xcr:Rotation>(.*)</xcr:Rotation>", xmp_lines)
        principal_point_u = re.search(
            "PrincipalPointU=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        principal_point_v = re.search(
            "PrincipalPointV=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        focalLength_35mm = re.search(
            "xcr:FocalLength35mm=\"([+-]?([0-9]*[.])?[0-9]+)\"", xmp_lines)
        if camera_center is None or rotation_matrix is None or principal_point_u is None or principal_point_v is None or focalLength_35mm is None:
            return None, None
        # DistortionCoeficients InMeshing
        camera_center = np.asarray(
            camera_center.group(1).split(" "), dtype=np.float32)
        rotation_matrix = np.asarray(rotation_matrix.group(
            1).split(" "), dtype=np.float32).reshape([3, 3])
        principal_point_u = np.asarray(
            principal_point_u.group(1).split(" "), dtype=np.float32)
        principal_point_v = np.asarray(
            principal_point_v.group(1).split(" "), dtype=np.float32)
        focalLength_35mm = np.asarray(
            focalLength_35mm.group(1).split(" "), dtype=np.float32)
        # TODO if needed, xcr:DistortionModel="brown3" xcr:Skew="0" xcr:AspectRatio="1"
        intrinsics = np.zeros([3, 3])
        extrinsics = np.zeros([4, 4])
        intrinsics[0, 0] = focalLength_35mm
        intrinsics[1, 1] = focalLength_35mm
        intrinsics[1, 2] = principal_point_u
        intrinsics[0, 2] = principal_point_v
        intrinsics[2, 2] = 1
        extrinsics[0:3, 0:3] = rotation_matrix
        extrinsics[0:3, 3] = camera_center
        extrinsics[3, 3] = 1
        return extrinsics, intrinsics

def export_reality_capture(xmp_file, extrinsics, intrinsics, pixel_size):
    """
    Saves the xmp for reality capture.
    Will convert meshroom sfm extrinsics and intrinsics converted to mrrs, into reality capture format.
    """

    focal = intrinsics[0,0]*36 #turn focal from unit sensor  into equivalent 35mm
    principal_point_u = intrinsics[0,2]/pixel_size
    principal_point_v = intrinsics[1,2]/pixel_size #convert back into metric principal point

    rotation = np.linalg.inv(extrinsics[0:3,0:3])
    position = extrinsics[0:3, 3]

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
""".format(str(focal), principal_point_u, principal_point_v, format_array(rotation.flatten()), format_array(position), '0 0 0')#FIXME: for now we dont support distortion?

    with open(xmp_file, "w") as f:
       f.write(xmp_string)

def import_xmp(sfm_data, xmp_folder):
    """
    Will import XMPs based on the path in sfmdata
    """
    extrinsics=[]
    intrinsics=[]
    poses_ids = []
    intrinsics_ids = []
    images_size = []
    for i, view in enumerate(sfm_data["views"]):
        print("Loading xmp for view "+view["viewId"])
        scene_image = view["path"]
        image_size = (int(view["width"]),int(view["height"]))#FIXME: check
        images_size.append(image_size)
        poses_ids.append(view["poseId"])
        intrinsics_ids.append(view["intrinsicId"])

        basename = os.path.basename(scene_image)[:-4]#FIXME: not great, use split
        scenes_calib = os.path.join(xmp_folder, basename + ".xmp")#FIXME: actually has several intrisinc
            
        if  not os.path.exists(scenes_calib):#Skip unreconstructed views
            print("No XMP found, skipping")
            extrinsics.append(None)
            intrinsics.append(None)
            continue
        
        e, i = parse_xmp(scenes_calib)
        if e is None:
            raise RuntimeError("Invalid XMP "+scenes_calib)
           
        #rc to mrrs
        e[0:3, 0:3] = np.linalg.inv(e[0:3, 0:3])
        # convert principal point in pixels
        # https://support.capturingreality.com/hc/en-us/community/posts/115002199052-Unit-and-convention-of-PrincipalPointU-and-PrincipalPointV
        # dimentionless because already /35 => we pass it into pixels
        pixel_size = SENSOR_SIZE / image_size[0]
        i[0, 0] /= pixel_size
        i[1, 1] /= pixel_size
        i[0, 2] = image_size[0] / 2 + i[0, 2] * 1000000 * 1 / image_size[0]
        i[1, 2] = image_size[1] / 2 + i[1, 2] * 1000000 * 1 / image_size[0]

        extrinsics.append(e)
        intrinsics.append(i)
    return extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size
                