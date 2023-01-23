import os, sys

import cv2
import numpy as np
from mrrs.core.ios import open_image, save_image
from mrrs.core.utils import cv2_resize_with_pad, do_system
from mrrs.core.geometry import mesh_transform
import json
import trimesh
import math
import shutil

import os
os.environ['KMP_DUPLICATE_LIB_OK']='True'

NGP_COMMAND ="python "+ os.path.join(os.path.dirname(__file__), "instant-ngp/scripts/run.py")#FIXME: hardcoded
MODEL = "instant-ngp/configs/nerf/base.json"
# MODEL = "instant-ngp/configs/sdf/base.json"
MODEL_PATH = os.path.join(os.path.dirname(__file__), MODEL)#FIXME: hardcoded

def variance_of_laplacian(image):
            return cv2.Laplacian(image, cv2.CV_64F).var()

def sharpness(imagePath):
    image = cv2.imread(imagePath)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    fm = variance_of_laplacian(gray)
    return fm

def qvec2rotmat(qvec):
    return np.array([
        [
            1 - 2 * qvec[2]**2 - 2 * qvec[3]**2,
            2 * qvec[1] * qvec[2] - 2 * qvec[0] * qvec[3],
            2 * qvec[3] * qvec[1] + 2 * qvec[0] * qvec[2]
        ], [
            2 * qvec[1] * qvec[2] + 2 * qvec[0] * qvec[3],
            1 - 2 * qvec[1]**2 - 2 * qvec[3]**2,
            2 * qvec[2] * qvec[3] - 2 * qvec[0] * qvec[1]
        ], [
            2 * qvec[3] * qvec[1] - 2 * qvec[0] * qvec[2],
            2 * qvec[2] * qvec[3] + 2 * qvec[0] * qvec[1],
            1 - 2 * qvec[1]**2 - 2 * qvec[2]**2
        ]
    ])


def rotmat(a, b):
    a, b = a / np.linalg.norm(a), b / np.linalg.norm(b)
    v = np.cross(a, b)
    c = np.dot(a, b)
    # handle exception for the opposite direction input
    if c < -1 + 1e-10:
        return rotmat(a + np.random.uniform(-1e-2, 1e-2, 3), b)
    s = np.linalg.norm(v)
    kmat = np.array([[0, -v[2], v[1]], [v[2], 0, -v[0]], [-v[1], v[0], 0]])
    return np.eye(3) + kmat + kmat.dot(kmat) * ((1 - c) / (s ** 2 + 1e-10))


def closest_point_2_lines(oa, da, ob, db): # returns point closest to both rays of form o+t*d, and a weight factor that goes to 0 if the lines are parallel
    da = da / np.linalg.norm(da)
    db = db / np.linalg.norm(db)
    c = np.cross(da, db)
    denom = np.linalg.norm(c)**2
    t = ob - oa
    ta = np.linalg.det([t, db, c]) / (denom + 1e-10)
    tb = np.linalg.det([t, da, c]) / (denom + 1e-10)
    if ta > 0:
        ta = 0
    if tb > 0:
        tb = 0
    return (oa+ta*da+ob+tb*db) * 0.5, denom

#%%
class InstantNGPWrapper():
    """
    Wraper class around InstantNGP
    """

    def __init__(self, mesh_path, nerf_path, posetransform_path):
        super().__init__()
        self.mesh_path = mesh_path
        self.nerf_path = nerf_path
        self.posetransform_path = posetransform_path

        head_tail = os.path.split(nerf_path)
        self.imagesfolder_path = os.path.join(head_tail[0],'train/')

    def __call__(self, input_images_path, input_poses, input_intrinsics, input_pixel_sizes):
        """
        input_images: list of images_path,
        input_poses: list of 3x4 poses (c2w)
        input_intrinsics: list of 3x3 instricics
        input_pixel_sizes: list of floats
        """

        # Image
        ref_image = open_image(input_images_path[0])
        h = float(len(ref_image))
        w = float(len(ref_image[0]))

        # Intrinsics
        intrinsic = input_intrinsics[0]
        pixel_size = input_pixel_sizes[0]
        intrinsic = intrinsic/pixel_size
        fl_x = float(intrinsic[0,0])
        fl_y = float(intrinsic[1,1])
        cx = float(intrinsic[0,2])
        cy = float(intrinsic[1,2])
        angle_x = math.atan(w / (fl_x * 2)) * 2
        angle_y = math.atan(h / (fl_y * 2)) * 2

        out = {
            "camera_angle_x": angle_x,
            "camera_angle_y": angle_y,
            "cx": cx,
            "cy": cy,
            "w": w,
            "h": h,
            "aabb_scale": 1,
            "frames": [],
        }

        # Images
        if not os.path.exists(self.imagesfolder_path):
            os.makedirs(self.imagesfolder_path)

        # Views and poses
        input_poses = np.array(input_poses)
        bottom = np.array([0.0, 0.0, 0.0, 1.0]).reshape([1, 4])
        up = np.zeros(3)
        i = 0
        for im_path in input_images_path:

            # Save image
            shutil.copy(im_path,self.imagesfolder_path)
            head_tail = os.path.split(im_path)
            name = os.path.join('./train',head_tail[-1])
            b = sharpness(im_path)
            print(f"{head_tail[-1]} : sharpness={b}")

            # Extrinsic
            pose = input_poses[i]
            i += 1

            pose = np.concatenate([pose, bottom], 0)
            pose[0:3,2] *= -1 # flip the y and z axis
            pose[0:3,1] *= -1
            up += pose[0:3,1]
            frame={"file_path":name,"sharpness":b,"transform_matrix": pose}
            out["frames"].append(frame)

        nframes = len(out["frames"])

        # Create transform
        up = up / np.linalg.norm(up)
        print(f"up vector was {up}")
        R = rotmat(up,[0,0,1]) # rotate up vector to [0,0,1]
        R = np.pad(R,[0,1])
        R[-1, -1] = 1

        for f in out["frames"]:
            f["transform_matrix"] = np.matmul(R, f["transform_matrix"]) # rotate up to be the z axis

        # find a central point they are all looking at
        print("computing center of attention...")
        totw = 0.0
        totp = np.array([0.0, 0.0, 0.0])
        for f in out["frames"]:
            mf = f["transform_matrix"][0:3,:]
            for g in out["frames"]:
                mg = g["transform_matrix"][0:3,:]
                p, w = closest_point_2_lines(mf[:,3], mf[:,2], mg[:,3], mg[:,2])
                if w > 0.00001:
                    totp += p*w
                    totw += w
        if totw > 0.0:
            totp /= totw
        print(totp) # the cameras are looking at totp
        for f in out["frames"]:
            f["transform_matrix"][0:3,3] -= totp

        avglen = 0.
        for f in out["frames"]:
            avglen += np.linalg.norm(f["transform_matrix"][0:3,3])
        avglen /= nframes
        print(f"avg camera distance from origin {avglen}")
        for f in out["frames"]:
            f["transform_matrix"][0:3,3] *= 4.0 / avglen # scale to "nerf sized"

        # Inverse transformation
        R_inv = np.eye(4)
        R_inv[0:3,0:3] = np.linalg.inv(R[0:3,0:3])
        T = R_inv

        totp_inv = np.eye(4)
        totp_inv[0:3,3] = totp
        T = T @ totp_inv

        scale_inv = np.eye(4)
        scale_inv[0:3,0:3] *= avglen/4.0
        T = T @ scale_inv
        # print(f"Inverse transformation : {T}")

        rot_mat = np.array([
            [0, 0, 1, 0],
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 0, 1]
        ]) # instant-ngp representation to meshroom viewer
        T = T @ rot_mat
        print(f"Inverse transformation with axis rotation : {T}")

        # Save poseTransform file
        with open(self.posetransform_path, "w") as outfile:
            json.dump({"transform":T.tolist()}, outfile, indent=2)

        # Save NeRF transfroms file
        for f in out["frames"]:
            f["transform_matrix"] = f["transform_matrix"].tolist()
        print(f"{nframes} frames")
        print(f"writing {self.nerf_path}")

        with open(self.nerf_path, "w") as outfile:
            json.dump(out, outfile, indent=2)

        # Launch instant-ngp
        head_tail = os.path.split(self.mesh_path)
        tmp_mesh_path = os.path.join(head_tail[0],'tmp_'+head_tail[-1])
        #f"/home/bbrument/anaconda3/envs/instant-ngp/bin/python /home/bbrument/dev/instant-ngp/scripts/run.py \
        #--mode nerf\

        cmd = NGP_COMMAND + (f" --training_data {self.nerf_path}"
                            +f" --marching_cubes_res 256"
                            +f" --save_mesh {tmp_mesh_path}"
                            +f" --network {MODEL_PATH}")
        do_system(cmd)

        # Apply transform to the mesh
        mesh = trimesh.load(tmp_mesh_path)
        mesh_upd = mesh_transform(mesh,T)
        mesh_upd.export(self.mesh_path)

        return True

