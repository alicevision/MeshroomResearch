import numpy as np
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
