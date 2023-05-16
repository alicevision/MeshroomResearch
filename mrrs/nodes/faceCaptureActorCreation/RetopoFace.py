"""
Copy data that is not exposed from a node output folder.
Usefull for exposing intermediate data.
"""
__version__ = "3.0"


from meshroom.core import desc

import numpy as np
import msgpack
import os
import trimesh
import torch
import json

#FIXME: normalize the 3dmm/head scan to make sure we are dealing <ith the same values?

#General params
DEBUG=True
BUFFER_EARLY_STOP = 20# how many iteration to consider in the early stopping
EARLY_STOP_RATIO = 1/10000#stop when std of error is x smaller than N*average error
MAX_ITERATION = 50000#max iteration FIXME: clever init might reduce iterations

#init pose params
LANDMARK_BLAKLIST = np.arange(0,16+1)#removes the jaw landmarks FIXME: hardcoded
LEARNING_RATE_ALIGN = 10e-5

#3dmm optim 
LEARNING_RATE_FIT = 10e-4#

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

def _euler_angles_to_matrix(euler_angles: torch.Tensor, convention: str = "ZYX") -> torch.Tensor:
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
    return torch.matmul(torch.matmul(matrices[0], matrices[1]), matrices[2])

def align_meshes_from_landmarks(neutral_scan_landmarks_vertices, neutral_3dmm_landmarks_vertices, debug_folder="./"):
    ##Init scales and translation
    #translation from barycenter scan ->  0 -> 3dmm
    neutral_scan_barycenter = np.mean(neutral_scan_landmarks_vertices, axis=0)
    neutral_3dmm_barycenter = np.mean(neutral_3dmm_landmarks_vertices, axis=0)
    init_translation = neutral_3dmm_barycenter-neutral_scan_barycenter
    #init scale from RMSD scan ->  0 -> 3dmm
    # neutral_scan_scale = np.std(neutral_scan_landmarks_vertices-neutral_scan_barycenter, axis=0)
    # neutral_3dmm_scale = np.std(neutral_3dmm_landmarks_vertices-neutral_3dmm_barycenter, axis=0)
    init_scale = [1.0] #np.mean(neutral_3dmm_scale/neutral_scan_scale) #scale may not be the same in 3ds because of errors in lms

    #init torch variables
    neutral_scan_landmarks_vertices=torch.FloatTensor(neutral_scan_landmarks_vertices)
    neutral_3dmm_landmarks_vertices=torch.FloatTensor(neutral_3dmm_landmarks_vertices)
    translation = torch.autograd.Variable(torch.FloatTensor(init_translation), requires_grad=True)
    rotation_euler_angles = torch.autograd.Variable(torch.FloatTensor([0,0,0]), requires_grad=True)
    scale = torch.autograd.Variable(torch.FloatTensor(init_scale), requires_grad=True)

    def tranform(vertices, scale, rotation_euler_angles, translation):
        rot_matrix = _euler_angles_to_matrix(rotation_euler_angles)
        return torch.matmul(rot_matrix,scale*np.transpose(vertices)).t()+translation

    def loss_fc(x,y):
        return ((x-y)**2).sum()

    optimizer = torch.optim.SGD([translation, rotation_euler_angles, scale], lr=LEARNING_RATE_ALIGN, momentum=0.9)

    # if DEBUG:
    #     with open(debug_folder+"/orig.obj", "w") as f:
    #         for v in neutral_scan_landmarks_vertices:
    #             f.write("v %f %f %f 1 0 0\n"%(v[0], v[1], v[2]))
    #         for v in neutral_3dmm_landmarks_vertices:
    #             f.write("v %f %f %f 0 1 0\n"%(v[0], v[1], v[2]))
    losses = []
    for iteration in range(MAX_ITERATION):#simple GD with loss between landmarks on the meshes
        neutral_scan_landmarks_vertices_transformed = tranform(neutral_scan_landmarks_vertices, scale, rotation_euler_angles, translation)
        loss = loss_fc(neutral_3dmm_landmarks_vertices,
                        neutral_scan_landmarks_vertices_transformed)
        print("Iteration %d loss %f scale %f translation %f %f %f rotation %f %f %f "%(iteration, loss, scale,
                                                                                        translation[0], translation[1], translation[2],
                                                                                        rotation_euler_angles[0], rotation_euler_angles[1], rotation_euler_angles[2],
                                                                                        ), end="\r")
        losses.append(loss.detach().numpy())
        loss.backward()
        optimizer.step()
        optimizer.zero_grad()

        #earky stopping
        std = np.std(losses[-BUFFER_EARLY_STOP:])
        mean = np.mean(losses[-BUFFER_EARLY_STOP:])
        if (iteration > BUFFER_EARLY_STOP) and (std < EARLY_STOP_RATIO*mean):
            print("\nConvergeance reached, stopping")
            break
    print("\n")

    translation = translation.detach().numpy()
    rot_matrix = _euler_angles_to_matrix(rotation_euler_angles).detach().numpy()  
    scale = scale.detach().numpy()

    return scale, translation, rot_matrix

def dist_to_closest(x,y):
    if x.shape[0]==0 or y.shape[0]==0:
        return torch.tensor(0.0, device=x.get_device()), torch.zeros_like(x, device=x.get_device())
    # (N,3)=>(M,N,3)
    y_new = torch.tile(torch.unsqueeze(y,axis=1),dims=[1,x.shape[0],1])
    # (M,3))=(M,N,3)
    x_new = torch.tile(torch.unsqueeze(x,axis=0),dims=[y.shape[0],1,1])
    # (M,N,3)=>(M,N)
    dist = torch.sum(torch.abs(x_new - y_new),axis=-1)
    # M
    closest_dists=torch.min(dist, axis=0).values
    # closets for each element if x
    total_dist = torch.sum(closest_dists)

    return total_dist, closest_dists

def optimise_3dmm_pca(neutral_mean_3dmm, neutral_scan, pca_mean, pca_pc, vertex_mask= None, neutral_scan_downsampling=1, debug_folder="./"):
    print("Building voxel chopping for efficient loss computation")

    #init
    pca_coefficients = torch.autograd.Variable(torch.zeros((pca_pc.shape[0],1,1), device="cuda:0"), requires_grad=True)
    optimizer = torch.optim.SGD([pca_coefficients], lr=LEARNING_RATE_FIT)

    neutral_optimized_3dmm = neutral_mean_3dmm.copy()
    target_vertices = torch.tensor(neutral_scan.vertices, device="cuda:0")

    #optim"
    print("Optimising")
    losses=[]
    for iteration in range(MAX_ITERATION):
        # subsampling and masking
        new_vertices = pca_mean[::neutral_scan_downsampling] + torch.sum(pca_coefficients*pca_pc[:, ::neutral_scan_downsampling], axis=0)
        if vertex_mask is not None:
            new_vertices=new_vertices[vertex_mask[::neutral_scan_downsampling], :]
            # with open(debug_folder+"/new_vertices_%d.obj"%iteration, "w") as f:
            #     for v in new_vertices:
            #         f.write("v %f %f %f \n"%(v[0], v[1], v[2]))
        # loss,_=loss_fc(new_vertices,target_vertices[::neutral_scan_downsampling]) #use class
        loss,_=dist_to_closest(new_vertices,target_vertices[::neutral_scan_downsampling]) #use fc
        
        print("Iteration %d loss %f first coefs %f %f %f"%(iteration, loss, pca_coefficients[0],  pca_coefficients[1],  pca_coefficients[2]), end="\r")
        loss.backward()
        optimizer.step()
        optimizer.zero_grad()
        if DEBUG:
            if iteration%100 == 0:
                new_vertices = pca_mean+ torch.sum(pca_coefficients*pca_pc, axis=0)
                neutral_optimized_3dmm.vertices = new_vertices.cpu().detach().numpy()
                neutral_optimized_3dmm.export(debug_folder+"/mesh_optimised_3dmm_%d.obj"%iteration)

        #early stopping
        losses.append(loss.detach().cpu().numpy())
        std = np.std(losses[-BUFFER_EARLY_STOP:])
        mean = np.mean(losses[-BUFFER_EARLY_STOP:])
        if (iteration > BUFFER_EARLY_STOP) and (std < EARLY_STOP_RATIO*mean):
            print("\nConvergeance reached, stopping")
            break
    return pca_coefficients.cpu().detach().numpy()

def loadMeshOffFile(filename, no_colors=False):
    """
    Load mesh from a .off file
    
    Inputs:
        * filename
        * device
        * no_colors
    Outputs:
        * vertices: float tensor [#vertices,3]
        * faces: long tensor[#faces,3]
        * colors (only if no_colors == False): uint8 tensor [#vertices,3]
    """
    import numpy as np
    from io import StringIO
    
    with open(filename) as filein:
        lines0 = filein.readlines()
    lines = []
    for line in lines0:
        if line.strip() == "":
            continue
        if line.startswith('#'):
            continue
        lines.append(line)

    assert lines[0].strip() in ['OFF', 'COFF'], 'OFF header missing in {}'.format(filename)
    has_colors = lines[0].strip() == 'COFF'
    n_verts, n_faces, _ = map(int, lines[1].split())
    lines = [line for line in lines if line.strip() != '']
    vertex_data = np.loadtxt(StringIO(u''.join(lines[2:2 + n_verts])), dtype=np.float)
    if n_faces > 0:
        faces = np.loadtxt(StringIO(u''.join(lines[2 + n_verts:])), dtype=np.int)[:, 1:]
    else:
        faces = None

    if has_colors:
        colors = vertex_data[:, 3:6].astype(np.uint8)
        vertex_data = vertex_data[:, :3]
    else:
        colors = None

    if no_colors:
        return vertex_data, faces
    else:        
        return vertex_data, faces, colors

class RetopoFace(desc.Node):
    category = 'Meshroom Research'
    gpu = desc.Level.INTENSIVE

    documentation = '''This nodes takes an input scan, projected landmarks and a target actor model folder 
                        and will optimise the actor model 3DMM to the scan topology'''

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
        desc.IntParam(
            name='downsampleScanLoss',
            label='downsampleScanLoss',
            description='Resample the mesh by a given factor for the loss computation',
            value=1,
            range=(0, 100, 1),
            uid=[0],
        ),
        desc.BoolParam(
            name='recenter',
            label='recenter',
            description='''Will place the optimised neutral into the scan's location''',
            value=True,
            uid=[0],
        ),
        desc.BoolParam(
            name='useMask',
            label='UseMask',
            description='''Will use the monkey mask during the optimisation''',
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
            name='outputFolder',
            label='Output Folder',
            description='Path to the output folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='outputMesh',
            label='Output Mesh',
            description='Path to the output mesh',
            value=os.path.join(desc.Node.internalFolder,"neutral.obj"),
            uid=[],
        ),
        desc.File(
            name='outputAlignedNeutral',
            label='Output Aligned Neutral',
            description='Path to neutral scan aligned to the mesh',
            value=os.path.join(desc.Node.internalFolder,"scan_aligned.obj"),
            uid=[],
        ),
    ]

    def processChunk(self, chunk):
        #Load scan
        neutral_scan = trimesh.load(chunk.node.inputMesh.value)
        neutral_scan_vertices = neutral_scan.vertices
        with open(chunk.node.landmarksCorrespondances.value,"r") as json_file:
                neutral_scan_landmarks_vertex_idx = np.asarray(json.load(json_file)["idx_to_landmark_verts"])#FIXME: hardcoded

        #Load 3dmm
        # uvmap is the mesh? shape_mean.npy => neutral? average.off? should be all the same
        neutral_mean_3dmm = trimesh.load(os.path.join(chunk.node.input3DMMFolder.value, "average.off"))#FIXME: hardcoded
        # neutral_3dmm_vertices = neutral_mean_3dmm.vertices
        #FIXME: for now do alignement from mean pca
        neutral_3dmm_vertices = np.load(os.path.join(chunk.node.input3DMMFolder.value, "shape_mean.npy"))
        vertex_mask = None
        if chunk.node.useMask.value:
            # #load mask FIXME: issue there, cannot retrieve color per vertex
            # vertex_mask_mesh = trimesh.load(os.path.join(chunk.node.input3DMMFolder.value, "mask.off"))
            # vertex_mask = np.all((vertex_mask_mesh.visual.vertex_colors-[[255,0,0,255]])==0, axis=-1) 
            _, _, vertex_mask_colors = loadMeshOffFile(os.path.join(chunk.node.input3DMMFolder.value, "mask.off"))
            vertex_mask = np.all(vertex_mask_colors == [255,0,0], axis=-1) 
     
        # lmm-thomas2-fan3d-9-9-5.msgpack contains the lamdnarks - vertices index correspts
        def array_from_msgpack(obj):
            array = np.frombuffer(obj[b'data'], dtype=np.dtype(obj[b'dtype'])).reshape(obj[b'shape'])
            return array
        with open(os.path.join(chunk.node.input3DMMFolder.value, "lmm-thomas2-fan3d-9-9-5.msgpack"), "rb") as f:#FIXME: hardcoded
            neutral_3dmm_landmarks_vertex_idx = msgpack.load(f)["landmark2vertex_indices"]
        neutral_3dmm_landmarks_vertex_idx=array_from_msgpack(neutral_3dmm_landmarks_vertex_idx)
        neutral_3dmm_landmarks_vertex_idx=neutral_3dmm_landmarks_vertex_idx[:,0]    #10 closest matching vertices, we keep only best one as in fc

        # filter out landmarks we dont want to use for alignement (Note: in FC the extra mesh are used (eyes), so the indices are overflowing)
        valid_vertex_indices_mask = neutral_3dmm_landmarks_vertex_idx<neutral_3dmm_vertices.shape[0]
        valid_vertex_indices_mask &= [i not in LANDMARK_BLAKLIST for i,_ in enumerate(neutral_3dmm_landmarks_vertex_idx)] 
        neutral_3dmm_landmarks_vertices=neutral_3dmm_vertices[neutral_3dmm_landmarks_vertex_idx[valid_vertex_indices_mask], :]
        neutral_scan_landmarks_vertices=neutral_scan_vertices[neutral_scan_landmarks_vertex_idx[valid_vertex_indices_mask]]

        #align meshes using landmarks
        scale, translation, rot_matrix = align_meshes_from_landmarks(neutral_scan_landmarks_vertices, neutral_3dmm_landmarks_vertices, chunk.node.outputFolder.value)

        #apply tranform to mesh 
        neutral_scan.vertices = np.transpose(rot_matrix@np.transpose(scale*neutral_scan.vertices))+ translation
        neutral_scan.export(chunk.node.outputAlignedNeutral.value)
        if DEBUG:
            neutral_mean_3dmm.export(chunk.node.outputFolder.value+"/mesh_mean_3dmm.obj")

        #fit 3dmm 
        print("Loading 3dmm")
        pca_mean = np.load(os.path.join(chunk.node.input3DMMFolder.value, "shape_mean.npy"))#pca mean #FIXME: hardcoded
        pca_pc = np.load(os.path.join(chunk.node.input3DMMFolder.value, "shape_pc.npy"))#pca principal components #FIXME: hardcoded

        pca_coefs = optimise_3dmm_pca(neutral_mean_3dmm, neutral_scan, torch.tensor(pca_mean, device="cuda:0"), 
                                      torch.tensor(pca_pc, device="cuda:0"), neutral_scan_downsampling=chunk.node.downsampleScanLoss.value,
                                      vertex_mask=vertex_mask, debug_folder=chunk.node.outputFolder.value)
        optimised_3dmm = neutral_mean_3dmm.copy()
        optimised_3dmm.vertices = pca_mean + np.sum(pca_coefs*pca_pc, axis=0)

        #inverse transform on mesh
        if chunk.node.recenter.value:
            optimised_3dmm.vertices = np.transpose(np.linalg.inv(rot_matrix)@np.transpose(optimised_3dmm.vertices-translation))/scale

        #export result
        optimised_3dmm.export(chunk.node.outputMesh.value)