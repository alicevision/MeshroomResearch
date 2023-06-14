"""
This node normalizes cameras and SfM points, if any.
"""
__version__ = "1.0"

import os
import json
import re
import cv2

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *


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


class NormalizeCameras(desc.Node):
    category = 'Meshroom Research'

    documentation = '''Util node to normalize sfm data.'''

    # size = desc.DynamicNodeSize('inputSfmData')

    inputs = [

        desc.File(
            name="inputSfmData",
            label="Input sfmData",
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
            name='outputSfmData',
            label='Output sfmData',
            description='Output sfmData',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        ),

        desc.File(
            name='transformationMatrix',
            label='Transformation matrix',
            description='Transformation matrix',
            value=desc.Node.internalFolder + 'transformationMat.json',
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.inputSfmData.value == '':
            chunk.logger.warning(
                'No input sfmData in node NormalizeCameras, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Normalizes sfmData.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return

            # Load SFM data from sfm file
            chunk.logger.info("Starts to load data from sfmdata")
            sfm_data = json.load(open(chunk.node.inputSfmData.value, "r"))
            input_extrinsics, input_intrinsics, views_id, poses_id, intrinsics_id, pixel_sizes_all_cams = matrices_from_sfm_data(sfm_data)

            if "structure" in sfm_data:
                chunk.logger.warning("Sfm point won't be converted.")
            
            # Get image sizes and sensor size
            images_size = []
            for v in sfm_data["views"]:
                im = open_image(v["path"])
                images_size.append([im.shape[1],im.shape[0]])

            sensor_width = images_size[0][0]*pixel_sizes_all_cams[0]

            # Get up vector
            up = np.zeros(3)
            for ii in range(len(input_extrinsics)):

                c2w = np.asarray(input_extrinsics[ii]) # cam2world matrix (x right/y bottom/z to the scene)
                up += -c2w[0:3,1] # up vector is -y

            # Get rotation matrix and apply it to cameras
            up = up / np.linalg.norm(up)
            print("up vector was", up)
            R = rotmat(up,[0,0,1]) # rotate up vector to [0,0,1]
            R = np.pad(R,[0,1])
            R[-1, -1] = 1

            bottom = np.array([0.0, 0.0, 0.0, 1.0]).reshape([1, 4])
            scaled_extrinsics = []
            for ii in range(len(input_extrinsics)):
                c2w = np.concatenate([input_extrinsics[ii], bottom], 0)
                Rc2w = R @ c2w # rotate up to be the z axis
                scaled_extrinsics.append(Rc2w)

            # find a central point they are all looking at
            totw = 0.0
            totp = np.array([0.0, 0.0, 0.0])
            for ii in range(len(scaled_extrinsics)):
                Rc2w_ii = scaled_extrinsics[ii]
                mf = Rc2w_ii[0:3,:]
                for jj in range(len(scaled_extrinsics)):
                    Rc2w_jj = scaled_extrinsics[jj]
                    mg = Rc2w_jj[0:3,:]
                    p, w = closest_point_2_lines(mf[:,3], mf[:,2], mg[:,3], mg[:,2])
                    if w > 0.00001:
                        totp += p*w
                        totw += w
            if totw > 0.0:
                totp /= totw
            print(totp) # the cameras are looking at totp

            for ii in range(len(scaled_extrinsics)):
                scaled_extrinsics[ii][0:3,3] -= totp

            avglen = 0.
            for ii in range(len(scaled_extrinsics)):
                avglen += np.linalg.norm(scaled_extrinsics[ii][0:3,3])
            avglen /= len(scaled_extrinsics)
            print(f"avg camera distance from origin {avglen}")
            for ii in range(len(scaled_extrinsics)):
                scaled_extrinsics[ii][0:3,3] *= 4.0 / avglen # scale to "nerf sized"

            # Reduce size
            # for ii in range(len(scaled_extrinsics)):
            #     scaled_extrinsics[ii] = scaled_extrinsics[ii][0:3,0:3]

            # Inverse transformation
            T = np.linalg.inv(R)
            totp_inv = np.eye(4)
            totp_inv[0:3,3] = totp
            T = T @ totp_inv
            scale_inv = np.eye(4)
            scale_inv[0:3,0:3] *= avglen/4.0
            T = T @ scale_inv
            print(f"Inverse transformation : {T}")
            # rot_mat = np.array([
            #     [0, 0, 1, 0],
            #     [1, 0, 0, 0],
            #     [0, 1, 0, 0],
            #     [0, 0, 0, 1]
            # ]) # instant-ngp representation to meshroom viewer
            # T = T @ rot_mat
            # print(f"Inverse transformation with axis rotation : {T}")

            # Save modified SFM data to sfm file
            out_sfm_data = sfm_data_from_matrices(scaled_extrinsics, input_intrinsics, poses_id, intrinsics_id, images_size, sfm_data, sensor_width)
            
            # Save the new generated SFM data to JSON file
            with open(chunk.node.outputSfmData.value, 'w') as f:
                json.dump(out_sfm_data, f, indent=4)

            # Save transformation matrix
            with open(chunk.node.transformationMatrix.value, "w") as f:
                json.dump({"transform":T.tolist()}, f, indent=4)

            chunk.logger.info('Cameras normalization done.')
        finally:
            chunk.logManager.end()
