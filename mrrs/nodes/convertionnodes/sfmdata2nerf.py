__version__ = "3.0"

import json
import logging
import numpy as np
import os
import cv2
import math
import shutil

from meshroom.core import desc

class SfmData2Nerf(desc.Node):
    """Converts sfmData to NeRF compatible data."""

    category = 'Meshroom Research'#Machine Learning Effort for Meshroom #'Sparse Reconstruction'

    documentation = '''This node converts sfmData to NeRF data.'''

    inputs = [

        desc.File(
            name='sfmdata',
            label='SfMData',
            description='SfMData file.',
            value=desc.Node.internalFolder,
            uid=[0],
        ),
        desc.IntParam(
            name='aabb_scale',
            label='AABB Scale',
            description='.',
            value=2,
            range=(1, 64, 1),
            uid=[0],
        ),
        desc.BoolParam(
            name='keep_meshroom_coords',
            label='Keep meshroom sfmData coords',
            description='Keep meshroom sfmData coords.',
            value=True,
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
            name="out",
            label="OutputFile",
            description="Output NeRF file",
            value=desc.Node.internalFolder + 'transforms.json',
            uid=[],
        ),
        desc.File(
            name="imagesFolder",
            label="ImagesFolder",
            description="Images folder",
            value=desc.Node.internalFolder + 'train/',
            uid=[],
        ),
        desc.File(
            name="poseTransformFile",
            label="poseTransformFile",
            description="Pose transform file",
            value=desc.Node.internalFolder + 'poseTransform.json',
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.sfmdata.value:
            chunk.logger.warning('No input SfmData in node SfmData2Nerf, skipping')
            return False
        if not chunk.node.out.value:
            chunk.logger.warning('No output path in node SfmData2Nerf, skipping')
            return False
        return True


    def processChunk(self, chunk):
        """
        Launchs SfmData2NeRF.
        """

    
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

        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            #check inputs
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Convert sfmData to NeRF data.")
            with open(chunk.node.sfmdata.value,"r") as json_file:
                input_sfm_data= json.load(json_file)

            intrinsic = input_sfm_data['intrinsics'][0]
            w = float(intrinsic['width'])
            h = float(intrinsic['height'])

            if input_sfm_data['version'][2] == '1':
                fl_x = float(intrinsic['pxFocalLength'][0])
                fl_y = float(intrinsic['pxFocalLength'][1])
            elif input_sfm_data['version'][2] == '2':
                sensor_size = float(intrinsic['sensorWidth'])
                fl_mm = float(intrinsic['focalLength'])
                fl_x = fl_mm*max(w,h)/sensor_size
                fl_y = fl_x

            k1, k2 = 0.0, 0.0
            if intrinsic['distortionParams'] != '':
                k1 = float(intrinsic['distortionParams'][0])
                k2 = float(intrinsic['distortionParams'][1])
            
            cx = w / 2 + float(intrinsic['principalPoint'][0])
            cy = h / 2 + float(intrinsic['principalPoint'][1])

            angle_x = math.atan(w / (fl_x * 2)) * 2
            angle_y = math.atan(h / (fl_y * 2)) * 2
            fovx = angle_x * 180 / math.pi
            fovy = angle_y * 180 / math.pi

            chunk.logger.info(f"camera:\n\tres={w,h}\n\tcenter={cx,cy}\n\tfocal={fl_x,fl_y}\n\tfov={fovx,fovy}\n\tk={k1,k2}")

            # Out
            i = 0
            out = {
                "camera_angle_x": angle_x,
                # "camera_angle_y": angle_y,
                # "fl_x": fl_x,
                # "fl_y": fl_y,
                # "k1": k1,
                # "k2": k2,
                "cx": cx,
                "cy": cy,
                "w": w,
                "h": h,
                "aabb_scale": chunk.node.aabb_scale.value,
                "frames": [],
            }
            
            # Images
            if not os.path.exists(chunk.node.imagesFolder.value):
                os.makedirs(chunk.node.imagesFolder.value)

            # Views
            bottom = np.array([0.0, 0.0, 0.0, 1.0]).reshape([1, 4])
            up = np.zeros(3)
            for view in input_sfm_data['views']:

                # Save image
                shutil.copy(view['path'],chunk.node.imagesFolder.value)
                head_tail = os.path.split(view['path'])
                name = os.path.join('./train',head_tail[-1])
                b = sharpness(view['path'])
                chunk.logger.info(f"{head_tail[-1]} : sharpness={b}")

                # Extrinsic
                pose_id = int(view['poseId'])
                for pose in input_sfm_data['poses']:
                    if pose_id == int(pose['poseId']):
                        R = np.array(pose['pose']['transform']['rotation'],dtype=np.float32).reshape([3,3]) # orientation
                        t = np.expand_dims(np.array(pose['pose']['transform']['center'],dtype=np.float32), axis=1) # center
                        c2w = np.concatenate([np.concatenate([R, t], 1), bottom], 0)
                        if not chunk.node.keep_meshroom_coords.value:
                            #c2w = c2w[[1,0,2,3],:] # swap y and z
                            c2w[0:3,2] *= -1 # flip the y and z axis
                            c2w[0:3,1] *= -1
                            
                            #c2w[2,:] *= -1 # flip whole world upside down

                            up += c2w[0:3,1]
                        frame={"file_path":name,"sharpness":b,"transform_matrix": c2w}
                        out["frames"].append(frame)

            nframes = len(out["frames"])

            if chunk.node.keep_meshroom_coords.value:
                flip_mat = np.array([
                    [1, 0, 0, 0],
                    [0, -1, 0, 0],
                    [0, 0, -1, 0],
                    [0, 0, 0, 1]
                ])

                for f in out["frames"]:
                    f["transform_matrix"] = np.matmul(f["transform_matrix"], flip_mat) # flip cameras (it just works)
            
            else:
                # don't keep meshroom coords - reorient the scene to be easier to work with
                up = up / np.linalg.norm(up)
                chunk.logger.info(f"up vector was {up}")
                R = rotmat(up,[0,0,1]) # rotate up vector to [0,0,1]
                R = np.pad(R,[0,1])
                R[-1, -1] = 1

                for f in out["frames"]:
                    f["transform_matrix"] = np.matmul(R, f["transform_matrix"]) # rotate up to be the z axis

                # find a central point they are all looking at
                chunk.logger.info("computing center of attention...")
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
                chunk.logger.info(totp) # the cameras are looking at totp
                for f in out["frames"]:
                    f["transform_matrix"][0:3,3] -= totp

                avglen = 0.
                for f in out["frames"]:
                    avglen += np.linalg.norm(f["transform_matrix"][0:3,3])
                avglen /= nframes
                chunk.logger.info(f"avg camera distance from origin {avglen}")
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
                # chunk.logger.info(f"Inverse transformation : {T}")

                rot_mat = np.array([
                    [0, 0, 1, 0],
                    [1, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 0, 1]
                ]) # instant-ngp representation to meshroom viewer
                T = T @ rot_mat
                chunk.logger.info(f"Inverse transformation with axis rotation : {T}")

                with open(chunk.node.poseTransformFile.value, "w") as outfile:
                    json.dump({"transform":T.tolist()}, outfile, indent=2)


            for f in out["frames"]:
                f["transform_matrix"] = f["transform_matrix"].tolist()
            chunk.logger.info(f"{nframes} frames")
            chunk.logger.info(f"writing {chunk.node.out.value}")

            with open(chunk.node.out.value, "w") as outfile:
                json.dump(out, outfile, indent=2)

        finally:
            chunk.logManager.end()
