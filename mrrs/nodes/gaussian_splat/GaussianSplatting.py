
import os
from meshroom.core import desc
from mrrs.core.DockerNode import DockerNode
from distutils.dir_util import copy_tree


from collections import namedtuple
from trimesh.exchange.ply import _parse_header, _ply_binary
import numpy as np

def sigmoid(x):
  return 1 / (1 + np.exp(-x))

def load_gs_ply(path, max_sh_degree=3):
    """
    (modified from original repo)
    """
    with open(path, 'rb') as f:
        elements, _, _ = _parse_header(f)
        _ply_binary(elements, f)

    xyz = np.stack((np.asarray(elements['vertex']['data']["x"]),
                    np.asarray(elements['vertex']['data']["y"]),
                    np.asarray(elements['vertex']['data']["z"])),  axis=1)
    opacities = np.asarray(elements['vertex']['data']["opacity"])[..., np.newaxis]
    #aaply activation
    opacities = sigmoid(opacities)
    
    features_dc = np.zeros((xyz.shape[0], 3, 1))
    features_dc[:, 0, 0] = np.asarray(elements['vertex']['data']["f_dc_0"])
    features_dc[:, 1, 0] = np.asarray(elements['vertex']['data']["f_dc_1"])
    features_dc[:, 2, 0] = np.asarray(elements['vertex']['data']["f_dc_2"])
    
    extra_f_names = [p for p in elements['vertex']['properties'] if p.startswith("f_rest_")]
    extra_f_names = sorted(extra_f_names, key = lambda x: int(x.split('_')[-1]))
    assert len(extra_f_names)==3*(max_sh_degree + 1) ** 2 - 3
    features_extra = np.zeros((xyz.shape[0], len(extra_f_names)))
    for idx, attr_name in enumerate(extra_f_names):
        features_extra[:, idx] = np.asarray(elements['vertex']['data'][attr_name])
    # Reshape (P,F*SH_coeffs) to (P, F, SH_coeffs except DC)
    features_extra = features_extra.reshape((features_extra.shape[0], 3, (max_sh_degree + 1) ** 2 - 1))
    
    scale_names = [p for p in elements['vertex']['properties']if p.startswith("scale_")]
    scale_names = sorted(scale_names, key = lambda x: int(x.split('_')[-1]))
    scales = np.zeros((xyz.shape[0], len(scale_names)))
    for idx, attr_name in enumerate(scale_names):
        scales[:, idx] = np.asarray(elements['vertex']['data'][attr_name])
    #scaling activation
    scales=np.exp(scales)



    rot_names = [p for p in elements['vertex']['properties']if p.startswith("rot")]
    rot_names = sorted(rot_names, key = lambda x: int(x.split('_')[-1]))
    rots = np.zeros((xyz.shape[0], len(rot_names)))
    for idx, attr_name in enumerate(rot_names):
        rots[:, idx] = np.asarray(elements['vertex']['data'][attr_name])

    
    return xyz, rots, scales, \
            opacities, features_dc, features_extra


def rgb_from_sh(sh_0):
    """
    Get RGB values for sh coef 0 (solid color)
    """
    C0 = 0.28209479177387814
    result = C0 * sh_0 + 0.5
    result = np.clip(result, 0, 1)
    return result

class GaussianSplatting(DockerNode):

    category = 'Meshroom Research'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = "python gaussian-splatting/train.py -s /node_folder/input -m /node_folder/output {allParams} \
                   --save_iterations {iterationsValue}"# --test_iterations {iterationsValue} "

    docker_file = os.path.abspath(os.path.join(__file__,"..","..","..","gaussian_splat"))

    inputs = [
            desc.File(
                name="inputColmapFolder",
                label="inputColmapFolder",
                description="inputColmapFolder",
                value="",
                uid=[0],
                group=""
                ),
            desc.StringParam(
                name="resolution",
                label="resolution",
                description="Specifies resolution of the loaded images before training. If provided 1, 2, 4 or 8, uses original, 1/2, 1/4 or 1/8 resolution, respectively. For all other values, rescales the width to the given number while maintaining image aspect. If not set and input image width exceeds 1.6K pixels, inputs are automatically rescaled to this target.",
                value="1",
                uid=[0],
            ),
            desc.IntParam(
                name="sh_degree",
                label="sh_degree",
                description="Order of spherical harmonics to be used (no larger than 3). 3 by default.",
                value=3,
                range=(0, 3, 1),
                uid=[0],
            ),
            desc.IntParam(
                name="iterations",
                label="iterations",
                description="Number of total iterations to train for, 30000 by default.",
                value=30000,
                range=(0, 100000, 1),
                uid=[0],
            ),

            # desc.ChoiceParam(
            #     name="data_device",
            #     label="data_device",
            #     description="Specifies where to put the source image data, cuda by default, recommended to use cpu if training on large/high-resolution dataset, will reduce VRAM consumption, but slightly slow down training. Thanks to HrsPythonix.",
            #     value="cuda",
            #     values=["cuda","cpu"],
            #     uid=[0],
            # advanced=True
            # ),

            # --feature_lr
            # Spherical harmonics features learning rate, 0.0025 by default.
            # --opacity_lr
            # Opacity learning rate, 0.05 by default.
            # --scaling_lr
            # Scaling learning rate, 0.005 by default.
            # --rotation_lr
            # Rotation learning rate, 0.001 by default.
            # --position_lr_max_steps
            # Number of steps (from 0) where position learning rate goes from initial to final. 30_000 by default.
            # --position_lr_init
            # Initial 3D position learning rate, 0.00016 by default.
            # --position_lr_final
            # Final 3D position learning rate, 0.0000016 by default.
            # --position_lr_delay_mult
            # Position learning rate multiplier (cf. Plenoxels), 0.01 by default.

            # --densify_from_iter
            # Iteration where densification starts, 500 by default.
            # --densify_until_iter
            # Iteration where densification stops, 15_000 by default.
            # --densify_grad_threshold
            # Limit that decides if points should be densified based on 2D position gradient, 0.0002 by default.
            # --densification_interval
            # How frequently to densify, 100 (every 100 iterations) by default.
            # --percent_dense
            # Percentage of scene extent (0--1) a point must exceed to be forcibly densified, 0.01 by default.
            
            # --opacity_reset_interval
            # How frequently to reset opacity, 3_000 by default.
            
            # --lambda_dssim
            # Influence of SSIM on total loss from 0 to 1, 0.2 by default.

            desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
                uid=[0],
                group=""
                )
            ]

    outputs = [
            desc.File(
                name='outputFolder',
                label='OutputFolder',
                description='Output folder.',
                value=os.path.join(desc.Node.internalFolder, "output"),
                uid=[],
                group="",
            ),
            desc.File(
                name='meshPreview',
                label='meshPreview',
                description='meshPreview',
                value=os.path.join(desc.Node.internalFolder, "preview_mesh.ply"),
                uid=[],
                group="",
            )
    ]

    def processChunk(self, chunk):
        #copy input data to node's folder (we mount only this folder)
        input_folder = os.path.join(chunk.node.internalFolder, 'input')
        output_folder = os.path.join(chunk.node.internalFolder, 'output')
        os.makedirs(input_folder)
        os.makedirs(output_folder)
        copy_tree(os.path.join(chunk.node.inputColmapFolder.value,'sparse'), os.path.join(input_folder, 'sparse', '0'))
        copy_tree(os.path.join(chunk.node.inputColmapFolder.value,'images'), os.path.join(input_folder, 'images'))
        #run the process
        super().processChunk(chunk)

        # create 3D display
        output_mesh = os.path.join(output_folder, "point_cloud", "iteration_%d"%chunk.node.iterations.value, "point_cloud.ply")
        
        import trimesh
        from trimesh.transformations import compose_matrix
        from trimesh.creation import icosphere
        gaussians = load_gs_ply(output_mesh)

        meshes = []
        for i, (c, r, s, o, fdc, fe) in enumerate(zip(*gaussians)):
            if not (i%10==0):
                continue
            print("%d/%d"%(i, gaussians[0].shape[0]))
            rgb=np.squeeze(rgb_from_sh(fdc))
            rgba=255*np.concatenate([rgb,o])
            unit_sphere = icosphere(subdivisions=1)
            unit_sphere.visual.face_colors[:] = np.array(rgba)
            unit_sphere.visual.vertex_colors[:] = np.array(rgba)
            transform = compose_matrix(scale=s, angles=r, translate=c)
            unit_sphere.apply_transform(transform)
            meshes.append(unit_sphere)
        preview_mesh = trimesh.util.concatenate(meshes)
        preview_mesh.export(chunk.node.meshPreview.value)
