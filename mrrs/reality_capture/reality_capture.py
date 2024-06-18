import re
import os
import numpy as np
import click
import json

from mrrs.core.ios import get_image_sizes, matrices_from_sfm_data, sfm_data_from_matrices 

#in RC the sensor size is set to 35mm
SENSOR_SIZE = 35

def _parse_xmp(xmp_file):
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
        if (camera_center is None or rotation_matrix is None or principal_point_u is None 
            or principal_point_v is None or focalLength_35mm is None):
            return None, None
        # DistortionCoeficients InMeshing
        camera_center = np.asarray(
            camera_center.group(1).strip().split(" "), dtype=np.float32)
        rotation_matrix = np.asarray(rotation_matrix.group(
            1).strip().split(" "), dtype=np.float32).reshape([3, 3])
        principal_point_u = np.asarray(
            principal_point_u.group(1).strip().split(" "), dtype=np.float32)
        principal_point_v = np.asarray(
            principal_point_v.group(1).strip().split(" "), dtype=np.float32)
        focalLength_35mm = np.asarray(
            focalLength_35mm.group(1).strip().split(" "), dtype=np.float32)
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

def _export_xmp(xmp_file, extrinsics, intrinsics, pixel_size, image_size):
    """
    Saves the xmp for reality capture.
    Will convert meshroom sfm extrinsics and intrinsics converted to mrrs, into reality capture format.
    """
    #pixel_size = sensor_width/width, so focal 35mm => we get sensor_width = 
    our_sensor_width = pixel_size*image_size[0]
    our_sensor_height = pixel_size*image_size[1]
    our_focal = intrinsics[0,0]
    #turn focal from unit sensor into equivalent 35mm
    focal = our_focal*SENSOR_SIZE/our_sensor_width
    #convert pp in mm into offset from center in mm
    principal_point_u = intrinsics[0,2]-our_sensor_height/2
    principal_point_v = intrinsics[1,2]-our_sensor_width/2
    #pass it into relative 
    principal_point_u /= our_sensor_height
    principal_point_v /= our_sensor_width

    rotation = np.linalg.inv(extrinsics[0:3,0:3])
    position = extrinsics[0:3, 3]

    def format_array(array):
        formated_str = ""
        for r in array:
            formated_str+=" "+str(r)
        return formated_str
    xmp_string="""<x:xmpmeta xmlns:x="adobe:ns:meta/">
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
""".format(str(focal), principal_point_u, principal_point_v, format_array(rotation.flatten()), format_array(position), '0 0 0 0 0 0')#FIXME: for now we dont support distortion

    with open(xmp_file, "w") as f:
       f.write(xmp_string)

def _import_xmp(sfm_data, xmp_folder):
    """
    Will import XMPs based on the path in sfmdata
    """
    extrinsics=[]
    intrinsics=[]
    poses_ids = []
    intrinsics_ids = []
    images_size = []
    for i, view in enumerate(sfm_data["views"]):
        print("Loading xmp for view "+view["viewId"]+" "+view["path"])
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
        
        e, i = _parse_xmp(scenes_calib)
        if e is None:
            raise RuntimeError("Invalid XMP "+scenes_calib)
           
        #rc to mrrs
        e[0:3, 0:3] = np.linalg.inv(e[0:3, 0:3])
        #convert focal into px
        pixel_size = SENSOR_SIZE / image_size[0]
        i[0, 0] /= pixel_size
        i[1, 1] /= pixel_size
        # convert principal point in pixels
        # https://support.capturingreality.com/hc/en-us/community/posts/115002199052-Unit-and-convention-of-PrincipalPointU-and-PrincipalPointV
        # dimentionless because already /35 => we pass it into pixels, and offset from top image

        #lookign for  "-0.75009676916349455", "-5.1187297220630112"
        #from array([0.00814665, 0.00596611])
        #this should pass the principal point in offset relative to actuall pp in pixels
        # pp_pixels = np.asarray(image_size)/2.0-i[0:2,2]*image_size[0] 
        # This should turn the pp back in mm
        image_ratio = image_size[0]/image_size[1]
        pp_mm = np.asarray((SENSOR_SIZE,image_ratio*SENSOR_SIZE))/2+ i[0:2,2]*SENSOR_SIZE
        i[0:2, 2] = pp_mm

        extrinsics.append(e)
        intrinsics.append(i)
    return extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size

@click.group()
def rc():
    pass

@rc.command()
@click.argument("sfmdata")
@click.argument("xmpdata")
@click.argument("outputsfmdata")
def importXMP(sfmdata, xmpdata, outputsfmdata):
    xmp_folder = xmpdata
    with open(sfmdata, "r") as json_file:
        sfm_data = json.load(json_file)
    #ifxmp folder not set, assumes it is with the images
    if xmp_folder == "":
        xmp_folder = os.path.dirname(sfm_data["views"][0]["path"])
    #note: focal already in pixels
    extrinsics, intrinsics, poses_ids, intrinsics_ids, images_size  = _import_xmp(sfm_data, xmp_folder)
    sfm_data = sfm_data_from_matrices(extrinsics, intrinsics, 
                                        poses_ids, intrinsics_ids, images_size,
                                        sfm_data=sfm_data, sensor_width = SENSOR_SIZE
                                        )
    # Save the generated SFM data to JSON file
    with open(os.path.join(outputsfmdata), 'w') as f:
        json.dump(sfm_data, f, indent=4)

@rc.command()
@click.argument("sfmdata")
@click.argument("outputfolder")
def exportXMP(sfmdata, outputfolder):
    sfm_data = json.load(open(sfmdata, "r"))
    (extrinsics_all_cams, intrinsics_all_cams, views_id,
    poses_id, intrinsics_id, pixel_sizes_all_cams) = matrices_from_sfm_data(sfm_data)
    image_sizes = get_image_sizes(sfm_data)
    images_names = [os.path.basename(view["path"])[:-4] for view in sfm_data["views"]]
    for image_name, extrinsics, intrinsics, pixel_size, image_size in zip(images_names, extrinsics_all_cams, 
                                                                intrinsics_all_cams, pixel_sizes_all_cams, image_sizes):
        if extrinsics is not None:
            xmp_file = os.path.join(outputfolder, image_name+".xmp")
            _export_xmp(xmp_file, extrinsics, intrinsics, pixel_size,image_size )

 

if __name__ == '__main__':
    rc()
