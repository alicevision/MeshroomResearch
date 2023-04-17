"""
Copy data that is not exposed from a node output folder.
Usefull for exposing intermediate data.
"""
__version__ = "3.0"

import json
from meshroom.core import desc

import numpy as np
import msgpack
import os
import trimesh
import torch

# LANDMARK_SELECTION = np.asarray([ #
#                                  28,29,30,31,#nose center
#                                  32,33,34,35,36,#nose
#                                  37,38,39,40,41,42#reye
#                                  43,44,45,46,47,48#leye

#                                 ])-1#because ofc on every piture index starts at 1

LANDMARK_BLAKLIST = np.arange(0,16+1)#removes the jaw landmarks

class RetopoFace(desc.Node):
    category = 'Meshroom Research'

    documentation = ''' '''

    inputs = [

        desc.File(
            name='inputMesh',
            label='Input Mesh',
            description='''Input Mesh''',
            value='',
            uid=[0],
        ),

        desc.File(
            name='landmarksCorrespondances',
            label='landmarksCorrespondances',
            description='''Landmarks correspondances''',
            value='',
            uid=[0],
        ),

        desc.File(
            name='input3DMMFolder',
            label='input3DMMFolder',
            description='''Input 3DMM folder(from FC)''',
            value='/s/apps/users/multiview/faceCaptureData/develop/runtime_data/topologies/mpc/mpcHumanFemale_ICT_alb3_fine2',
            uid=[0],
        ),
        # ---
        # shape_ev.npy 
        # shape_pc.npy pca princiapl comps

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
            label='Output Folder',
            description='Path to the output folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),

    ]


    def processChunk(self, chunk):
        """
        X
        """
        try:
            pass
        finally:
            chunk.logManager.end()

        ##Data loading: scan
        neutral_scan = trimesh.load(chunk.node.inputMesh.value)
        neutral_scan_vertices = neutral_scan.vertices
        with open(chunk.node.landmarksCorrespondances.value,"r") as json_file:
                neutral_scan_landmarks_vertex_idx = np.asarray(json.load(json_file)["idx_to_landmark_verts"])
        
        ##Data loading: 3dmm
        #uvmap is the mesh? shape_mean.npy => neutral? average.off?
        neutral_3dmm = trimesh.load(os.path.join(chunk.node.input3DMMFolder.value, "average.off"))#FIXME: hardcoded
        neutral_3dmm_vertices = neutral_3dmm.vertices
        # neutral_3dmm_vertices = np.load(os.path.join(chunk.node.input3DMMFolder.value, "shape_mean.npy"))
        # lmm-thomas2-fan3d-9-9-5.msgpack contains the lamdnarks - vertices index correspts
        def array_from_msgpack(obj):
            array = np.frombuffer(obj[b'data'], dtype=np.dtype(obj[b'dtype'])).reshape(obj[b'shape'])
            return array
        with open(os.path.join(chunk.node.input3DMMFolder.value, "lmm-thomas2-fan3d-9-9-5.msgpack"), "rb") as f:
            neutral_3dmm_landmarks_vertex_idx = msgpack.load(f)["landmark2vertex_indices"]
        neutral_3dmm_landmarks_vertex_idx=array_from_msgpack(neutral_3dmm_landmarks_vertex_idx)
        neutral_3dmm_landmarks_vertex_idx=neutral_3dmm_landmarks_vertex_idx[:,0]    #10 closest matching vertices, we keep only one


        #filter out landmarks we dont want to use
        #Note: in FC the extra mesh are used (eyes) 
        valid_vertex_indices_mask = neutral_3dmm_landmarks_vertex_idx<neutral_3dmm_vertices.shape[0]
        #TMP debug
        # neutral_3dmm_landmarks_vertices=neutral_3dmm_vertices[neutral_3dmm_landmarks_vertex_idx[valid_vertex_indices_mask], :]
        # neutral_scan_landmarks_vertices=neutral_scan_vertices[neutral_scan_landmarks_vertex_idx[valid_vertex_indices_mask]]
        # with open(chunk.node.outputFolder.value+"/lm_nofilter.obj", "w") as f:
        #     for v in neutral_3dmm_landmarks_vertices:
        #         f.write("v %f %f %f 0 1 0\n"%(v[0], v[1], v[2]))
        #     for v in neutral_scan_landmarks_vertices:
        #         f.write("v %f %f %f 0 0 1\n"%(v[0], v[1], v[2]))
        #blacklist
        valid_vertex_indices_mask &= [i not in LANDMARK_BLAKLIST for i,_ in enumerate(neutral_3dmm_landmarks_vertex_idx)] 

        # ##aligh meshes using trimesh
        # print("Registration with trimesh")
        # transform, cost = trimesh.registration.mesh_other(neutral_3dmm, neutral_scan)
        # neutral_3dmm.apply_transform(transform)

        print("Done")
        #align faces using landmarks
        neutral_3dmm_landmarks_vertices=neutral_3dmm_vertices[neutral_3dmm_landmarks_vertex_idx[valid_vertex_indices_mask], :]
        neutral_scan_landmarks_vertices=neutral_scan_vertices[neutral_scan_landmarks_vertex_idx[valid_vertex_indices_mask]]
        print("OK")

        #Init scales and translation
        #translation from barycenter scan ->  0 -> 3dmm
        neutral_scan_barycenter = np.mean(neutral_scan_landmarks_vertices, axis=0)
        neutral_3dmm_barycenter = np.mean(neutral_3dmm_landmarks_vertices, axis=0)
        init_translation = neutral_3dmm_barycenter-neutral_scan_barycenter
        #init scale from RMSD scan ->  0 -> 3dmm
        # neutral_scan_scale = np.std(neutral_scan_landmarks_vertices-neutral_scan_barycenter, axis=0)
        # neutral_3dmm_scale = np.std(neutral_3dmm_landmarks_vertices-neutral_3dmm_barycenter, axis=0)
        init_scale = [1.0] #np.mean(neutral_3dmm_scale/neutral_scan_scale) #scale may not be the same in 3ds because of errors in lms

        ## init transform
        neutral_scan_landmarks_vertices=torch.FloatTensor(neutral_scan_landmarks_vertices)
        neutral_3dmm_landmarks_vertices=torch.FloatTensor(neutral_3dmm_landmarks_vertices)
        translation = torch.autograd.Variable(torch.FloatTensor(init_translation), requires_grad=True)
        rotation_euler_angles = torch.autograd.Variable(torch.FloatTensor([0,0,0]), requires_grad=True)
        scale = torch.autograd.Variable(torch.FloatTensor(init_scale), requires_grad=True)

        learning_rate  = 10e-5
        iterations = 10000
        def euler_x_angle_to_matrix(angle):
            c=torch.cos(angle)
            s=torch.sin(angle)
            return torch.tensor([   [ 1, 0, 0],
                                    [ 0, c,-s],
                                    [ 0, s, c]  ], requires_grad=True)
        def euler_y_angle_to_matrix(angle):
            c=torch.cos(angle)
            s=torch.sin(angle)
            return torch.tensor([   [ c, 0, s],
                                    [ 0, 1, 0],
                                    [-s, 0, c]], requires_grad=True)
        def euler_z_angle_to_matrix(angle):
            c=torch.cos(angle)
            s=torch.sin(angle)
            return torch.tensor([   [ c, -s, 0 ],
                                    [ s, c , 0 ],
                                    [ 0, 0 , 1 ]], requires_grad=True)


        def _axis_angle_rotation(axis: str, angle: torch.Tensor) -> torch.Tensor:
            """
            Return the rotation matrices for one of the rotations about an axis
            of which Euler angles describe, for each value of the angle given.
            Args:
                axis: Axis label "X" or "Y or "Z".
                angle: any shape tensor of Euler angles in radians
            Returns:
                Rotation matrices as tensor of shape (..., 3, 3).
            """

            cos = torch.cos(angle)
            sin = torch.sin(angle)
            one = torch.ones_like(angle)
            zero = torch.zeros_like(angle)

            if axis == "X":
                R_flat = (one, zero, zero, zero, cos, -sin, zero, sin, cos)
            elif axis == "Y":
                R_flat = (cos, zero, sin, zero, one, zero, -sin, zero, cos)
            elif axis == "Z":
                R_flat = (cos, -sin, zero, sin, cos, zero, zero, zero, one)
            else:
                raise ValueError("letter must be either X, Y or Z.")

            return torch.stack(R_flat, -1).reshape(angle.shape + (3, 3))


        def euler_angles_to_matrix(euler_angles: torch.Tensor, convention: str = "ZYX") -> torch.Tensor:
            """
            Convert rotations given as Euler angles in radians to rotation matrices.
            Args:
                euler_angles: Euler angles in radians as tensor of shape (..., 3).
                convention: Convention string of three uppercase letters from
                    {"X", "Y", and "Z"}.
            Returns:
                Rotation matrices as tensor of shape (..., 3, 3).
            """
            if euler_angles.dim() == 0 or euler_angles.shape[-1] != 3:
                raise ValueError("Invalid input euler angles.")
            if len(convention) != 3:
                raise ValueError("Convention must have 3 letters.")
            if convention[1] in (convention[0], convention[2]):
                raise ValueError(f"Invalid convention {convention}.")
            for letter in convention:
                if letter not in ("X", "Y", "Z"):
                    raise ValueError(f"Invalid letter {letter} in convention string.")
            matrices = [
                _axis_angle_rotation(c, e)
                for c, e in zip(convention, torch.unbind(euler_angles, -1))
            ]
            # return functools.reduce(torch.matmul, matrices)
            return torch.matmul(torch.matmul(matrices[0], matrices[1]), matrices[2])


        def tranform(vertices, scale, rotation_euler_angles, translation):
            # rot_matrix = torch.matmul(euler_z_angle_to_matrix(rotation_euler_angles[0]),
            #              torch.matmul(euler_y_angle_to_matrix(rotation_euler_angles[1]),
            #                           euler_x_angle_to_matrix(rotation_euler_angles[2]) ) )
            rot_matrix = euler_angles_to_matrix(rotation_euler_angles)
            return torch.matmul(rot_matrix,scale*np.transpose(vertices)).t()+translation
        
        def loss_fc(x,y):
            return ((x-y)**2).sum()

        optimizer = torch.optim.SGD([translation, rotation_euler_angles, scale], lr=learning_rate, momentum=0.9)
        
        #tmp display
        with open(chunk.node.outputFolder.value+"/orig.obj", "w") as f:
            for v in neutral_scan_landmarks_vertices:
                f.write("v %f %f %f 1 0 0\n"%(v[0], v[1], v[2]))
            for v in neutral_3dmm_landmarks_vertices:
                f.write("v %f %f %f 0 1 0\n"%(v[0], v[1], v[2]))

        prev_loss = 0
        for iteration in range(iterations):#simple GD with loss between landmarks on the meshes
            neutral_scan_landmarks_vertices_transformed = tranform(neutral_scan_landmarks_vertices, scale, rotation_euler_angles, translation)
            loss = loss_fc(neutral_3dmm_landmarks_vertices,
                           neutral_scan_landmarks_vertices_transformed)
            print("Iteration %d loss %f scale %f translation %f %f %f rotation %f %f %f "%(iteration, loss, scale, 
                                                                                            translation[0], translation[1], translation[2],
                                                                                            rotation_euler_angles[0], rotation_euler_angles[1], rotation_euler_angles[2],
                                                                                            ))
         
            loss.backward()
            optimizer.step()
            optimizer.zero_grad()

            if iteration%1000 == 0:
                with open(chunk.node.outputFolder.value+"/%d.obj"%iteration, "w+") as f:
                    for v in neutral_scan_landmarks_vertices_transformed:
                        f.write("v %f %f %f 0 0 1\n"%(v[0], v[1], v[2]))
                # translation_tmp = translation.detach().numpy()
                # rot_matrix_tmp = euler_angles_to_matrix(rotation_euler_angles).detach().numpy()  
                # scale_tmp = scale.detach().numpy()
                # neutral_scan_tmp = neutral_scan.copy()
                # neutral_scan_tmp.vertices = np.transpose(rot_matrix_tmp@np.transpose(scale_tmp*neutral_scan.vertices))+ translation_tmp
                # neutral_scan_tmp.export(chunk.node.outputFolder.value+"/mesh_transformed_%d.obj"%iteration)


            if prev_loss == loss.detach().numpy():
                print("Convergenance found after %d iterations"%iteration)
                break
            prev_loss = loss

        translation = translation.detach().numpy()
        rot_matrix = euler_angles_to_matrix(rotation_euler_angles).detach().numpy()  
        scale = scale.detach().numpy()
        #apply tranform to mesh 
        neutral_scan.vertices = np.transpose(rot_matrix@np.transpose(scale*neutral_scan.vertices))+ translation
        neutral_scan.export(chunk.node.outputFolder.value+"/mesh_transformed.obj")
        neutral_3dmm.export(chunk.node.outputFolder.value+"/mesh_3dmm.obj")

        ##uses closest vertex to optimise pca morphology coeficients


        ## Optimise coeficients of the PCA
