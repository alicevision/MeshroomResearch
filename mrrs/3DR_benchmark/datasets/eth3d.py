
import os
from typing import List
import xml.etree.ElementTree as ET
import numpy as np
import trimesh 

from mrrs.core.geometry import is_rotation_mat, make_homogeneous, transform_cg_cv, unmake_homogeneous

class MeshLabProjectMeshInfo:
    """
    Small util struct to contain the mesh info
    """
    def __init__(self):
        self.label = ""
        self.file_path = ""
        self.global_T_mesh = np.zeros((4, 4), dtype=np.float32)

def open_meshlab_project(project_file_path)->List[MeshLabProjectMeshInfo]:
    """
    Opens the meshlab project containing references to the meshes, along with their respective relative poses
    """
    meshes = []

    tree = ET.parse(project_file_path)
    root = tree.getroot()

    # Check if the root element is "MeshLabProject"
    if root.tag != "MeshLabProject":
        raise ValueError(f"Error: File does not have a MeshLabProject tag: {project_file_path}")

    # Find the MeshGroup element
    mesh_group = root.find("MeshGroup")
    if mesh_group is None:
        raise ValueError(f"Error: MeshLabProject tag does not have a MeshGroup tag: {project_file_path}")

    # Iterate over MLMesh elements
    for xml_mlmesh in mesh_group.findall("MLMesh"):
        new_mesh = MeshLabProjectMeshInfo()

        # Read label attribute
        new_mesh.label = xml_mlmesh.get("label", "")
        if new_mesh.label =="":
            raise ValueError(f"Error: Encountered a mesh without label in file: {project_file_path}")
        
        # Read filename attribute
        new_mesh.file_path = os.path.join(os.path.dirname(project_file_path),  xml_mlmesh.get("filename", ""))
        if new_mesh.file_path =="":
            raise ValueError(f"Error: Encountered a mesh without filename in file: {project_file_path}")

        # Read MLMatrix44 element
        xml_mlmatrix44 = xml_mlmesh.find("MLMatrix44")
        if xml_mlmatrix44 is not None:
            mlmatrix44_text = xml_mlmatrix44.text
            M = new_mesh.global_T_mesh
            values = list(map(float, mlmatrix44_text.split()))
            M[0,0:4] = values[0:4]
            M[1,0:4] = values[4:8]
            M[2,0:4] = values[8:12]
            M[3,0:4] = values[12:16]
        else:
            raise ValueError(f"Error: Encountered a mesh without pose in file: {project_file_path}")

        meshes.append(new_mesh)

    return meshes

def quartenion2matrix(qw, qx, qy, qz):
    """
    Build the intrinsic matrix from the quaternions
    """
    #norm quaternion
    n = 1/np.sqrt(qx**2+qy**2+qz**2+qw**2)
    qx*= n
    qy*= n
    qz*= n
    qw*= n
    #create  matrix (note: transpose because we are collumn major)
    mat= np.asarray([1-2*qy*qy - 2*qz*qz, 2*qx*qy - 2*qz*qw      , 2*qx*qz + 2*qy*qw,
                    2*qx*qy + 2*qz*qw   , 1 - 2*qx*qx - 2*qz*qz  , 2*qy*qz - 2*qx*qw, 
                    2*qx*qz - 2*qy*qw   , 2*qy*qz + 2*qx*qw      , 1 - 2*qx*qx - 2*qy*qy, 
                    ]).reshape([3,3])
    return mat

def open_poses(poses_file):
    """
    Image list with two lines of data per image:
       IMAGE_ID, QW, QX, QY, QZ, TX, TY, TZ, CAMERA_ID, NAME
       POINTS2D[] as (X, Y, POINT3D_ID)
    """
    poses = []
    image_names = []
    camera_ids = []
    with open(poses_file) as f:
        lines = f.readlines()
        for i in range(0, len(lines), 2):
            if lines[i].startswith('#'):
                i=i-1
                continue
            image_id, qw, qx, qy, qz, tx, ty, tz, camera_id, name = lines[i].split(' ')
            points_2D = np.asarray(lines[i+1].split(' ')).reshape([-1, 3])
            rotation = quartenion2matrix(float(qw), float(qx), float(qy), float(qz))
            if not is_rotation_mat(rotation):
                raise ValueError("Not a rotation matrix for "+name+":", rotation)
            pose = np.concatenate([rotation, np.array([[float(tx)], [float(ty)], [float(tz)]]) ], axis=1)
            pose = np.concatenate([pose, np.array([[0,0,0,1]])] )
            pose=np.linalg.inv(pose)
            poses.append(pose)
            image_names.append(os.path.basename(name).strip("\n"))
            camera_ids.append(int(camera_id))
    return poses, image_names, camera_ids
    
def open_intrinsics(intrinsic_file):
    """
    # Camera list with one line of data per camera:
    #   CAMERA_ID, MODEL, WIDTH, HEIGHT, PARAMS[]
    """
    cameras = []
    intrinsics = []
    with open(intrinsic_file) as f:
        lines = f.readlines()
        for i in range(len(lines)):
            if lines[i].startswith('#'):
                continue
            camera_id, model, width, height, *params = lines[i].split(' ')
            camera = {"camera_id":int(camera_id), "model":model,
                      "width":int(width), "height":int(height), "params":[float(p) for p in params] }
            #first 4 params are always fx, fy, cx, cy, in pixels
            intrinsic = np.asarray([camera["params"][0], 0,                   camera["params"][2], \
                                    0,                   camera["params"][1], camera["params"][3], \
                                    0,                   0,                   1 ]).reshape([3,3])
            intrinsics.append(intrinsic)
            cameras.append(camera)
    return cameras, intrinsics

def open_dataset(sfm_data):
    """
    Opens an eth3d dataset from a given image path.
    """
    #get the root of the dataset
    image_path = os.path.dirname(sfm_data["views"][0]["path"])
    dataset_root_path = os.path.abspath(os.path.join(image_path, "..", ".."))

    #load and merge meshes
    mesh_folder_path = os.path.join(dataset_root_path, "dslr_scan_eval")
    meshlab_project_path = os.path.join(mesh_folder_path, "scan_alignment.mlp")
    meshes_info = open_meshlab_project(meshlab_project_path)
    all_points = np.zeros([0,3])
    for mesh_info in meshes_info: 
        # print(f"Label: {mesh_info.label}, Filename: {mesh_info.file_path}, Pose Matrix: {mesh_info.global_T_mesh}") 
        points = trimesh.load(mesh_info.file_path, force="mesh")
        points.apply_transform(mesh_info.global_T_mesh)#FIXME test inv?
        all_points = np.concatenate([all_points, points.vertices], axis=0)
    
    #put in cg FIXME?
    all_points=transform_cg_cv(all_points)

    #load poses from corresponding filename
    poses_folder_path = os.path.join(dataset_root_path, "dslr_calibration_jpg")
    intrics_file = os.path.join(poses_folder_path, "cameras.txt") 
    poses_file = os.path.join(poses_folder_path, "images.txt")
    poses, image_names, camera_ids = open_poses(poses_file)

    # load intrinsic from corresponding filename
    cameras, intrinsics = open_intrinsics(intrics_file)

    #make intrinsic list (duplicates intrinsic matrices
    intrinsics = np.asarray(intrinsics)[np.asarray(camera_ids)]

    #extract image sizes
    camera_image_sizes = [ [c["width"], c["height"] ] for c in cameras ]
    image_sizes = np.asarray(camera_image_sizes)[np.asarray(camera_ids)]

    data ={
            "image_names": image_names,
            "mesh": trimesh.PointCloud(vertices=all_points),
            "extrinsics" : poses,
            "intrinsics" : intrinsics,
            "image_sizes": image_sizes
           }

    # re-order the camera parameters using filename
    if len(image_names) != len(sfm_data["views"]):
        raise RuntimeError("Different number of images in the sfm and the GT")
    extrinsics=[]
    intrinsics=[]
    image_sizes=[]
    for v in sfm_data["views"]:
        for i, image_name in enumerate(image_names):
            if image_name == os.path.basename(v["path"]):
                # print(i, os.path.basename(v["path"])+" vs "+image_name)
                extrinsics.append(data["extrinsics"][i])
                intrinsics.append(data["intrinsics"][i])
                image_sizes.append(data["image_sizes"][i])
                break

    return data
