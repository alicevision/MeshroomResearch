import re
import numpy as np

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

def export_xmp(sfm_data):
    pass