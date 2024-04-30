import argparse
import torch
import json
import os
# import glob
import argparse
import numpy as np
import torch
import torch.nn.functional as F
from torchvision import transforms
from PIL import Image

import sys
sys.path.append(os.path.join(os.path.dirname(__file__), 'repo'))

from utils.utils import get_intrins_from_fov

def read_sfmData(sfmData_path: str, images_folder: str, fov: int = 45):
    custom_dir = False
    if images_folder != "":
        assert os.path.isdir(images_folder), f"imagesFolder doesn't exist: {images_folder}"
        custom_dir = True
        _, _, filenames = next(os.walk(images_folder))
        paths = {}
        for filename in filenames:
            view_id, _ = os.path.splitext(filename)
            path = paths.get(view_id, None)
            if path is None:
                paths[view_id] = os.path.join(images_folder, filename)
            else:
                paths[view_id] = ''
    with open(sfmData_path, "r") as sfm_file:
        sfm_data = json.load(sfm_file)
    
    intrinsics = {}
    for intrinsic in sfm_data['intrinsics']:
        intrinsic_id = intrinsic['intrinsicId']
        focal_x = float(intrinsic['focalLength']) * float(intrinsic['width']) / float(intrinsic['sensorWidth'])
        focal_y = focal_x * float(intrinsic['pixelRatio'])
        pp_x = float(intrinsic['width']) * 0.5 + float(intrinsic['principalPoint'][0]) - 0.5
        pp_y = float(intrinsic['height']) * 0.5 + float(intrinsic['principalPoint'][1]) - 0.5
        intrinsic_matrix = torch.tensor([
            [   focal_x,   0,          pp_x    ],
            [   0,         focal_y,    pp_y    ],
            [   0,         0,          1       ]
        ], dtype=torch.float32, device='cpu')
        intrinsics[intrinsic_id] = intrinsic_matrix

    data = []
    for view in sfm_data['views']:
        view_id = view['viewId']
        if custom_dir:
            img_path = paths[view_id]
        else:
            img_path = view['path']
        intrinsic_matrix = intrinsics.get(view['intrinsicId'], None)
        if intrinsic_matrix is None:
            intrinsic_matrix = get_intrins_from_fov(fov, view['height'], view['width'], 'cpu')
        data.append((view_id, img_path, intrinsic_matrix.clone()))

    return data

def run(args: argparse.Namespace):
    device = torch.device('cuda')

    from repo.models.dsine import DSINE
    import repo.utils.utils as utils
    torchhub_cache = os.path.join(os.path.dirname(args.ckpt), 'torch', 'hub')
    if os.path.exists(torchhub_cache):
        torch.hub.set_dir(torchhub_cache)
    model = DSINE().to(device)
    model.pixel_coords = model.pixel_coords.to(device)
    model = utils.load_checkpoint(args.ckpt, model)
    model.eval()
    
    # normalize
    normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])

    with torch.no_grad():
        data = read_sfmData(args.input, args.imagesFolder, args.fov)
        rangeStart = args.rangeStart
        if rangeStart < 0: rangeStart = 0
        rangeSize = args.rangeSize
        if rangeSize < 0: rangeSize = len(data)
        for view_id, img_path, intrinsic_matrix in data[rangeStart:min(rangeStart + rangeSize, len(data))]:
            print(img_path)
            img = Image.open(img_path).convert('RGB')
            img = np.array(img).astype(np.float32) / 255.0
            width, height = img.shape[1], img.shape[0]
            img = torch.from_numpy(img).permute(2, 0, 1).unsqueeze(0).to(device)

            # resize image if too big
            if width > args.maxWidth:
                scale = args.maxWidth / width
                img = transforms.Resize((int(height * scale), args.maxWidth))(img)
                intrinsic_matrix *= scale
                intrinsic_matrix[2, 2] = 1

            _, _, orig_H, orig_W = img.shape
            # zero-pad the input image so that both the width and height are multiples of 32
            l, r, t, b = utils.pad_input(orig_H, orig_W)
            img = F.pad(img, (l, r, t, b), mode="constant", value=0.0)
            img = normalize(img)

            intrinsic_matrix = intrinsic_matrix.unsqueeze(0).to(device)

            intrinsic_matrix[:, 0, 2] += l
            intrinsic_matrix[:, 1, 2] += t

            pred_norm = model(img, intrins=intrinsic_matrix)[-1]
            pred_norm = pred_norm[:, :, t:t+orig_H, l:l+orig_W]

            # save to output folder
            # NOTE: by saving the prediction as uint8 png format, you lose a lot of precision
            # if you want to use the predicted normals for downstream tasks, we recommend saving them as float32 NPY files
            pred_norm_np = pred_norm.cpu().detach().numpy()[0,:,:,:].transpose(1, 2, 0) # (H, W, 3)
            pred_norm_np = ((pred_norm_np + 1.0) / 2.0 * 255.0).astype(np.uint8)
            target_path = os.path.join(args.output, view_id + '_normalMap.jpg')
            im = Image.fromarray(pred_norm_np)
            im.save(target_path)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True, type=str, help='Input SfMData file.')
    parser.add_argument('--ckpt', default='', type=str, help='Path to the checkpoint of the pretrained model.')
    parser.add_argument('--imagesFolder', type=str,
        help="Use images from a specific folder instead of those specified in the SfMData file.\n"
             "Filename should be the image UID.")
    parser.add_argument('--maxWidth', default=1024, type=int, help='Maximum image width (in pixel).')
    parser.add_argument('--fov', default=45, type=int, help='Field-of-view (in degree) to be used for estimating camera intrinsics if missing.')
    parser.add_argument("--rangeStart", default=-1, type=int, help="Compute a sub-range of images from index rangeStart to rangeStart+rangeSize.")
    parser.add_argument("--rangeSize", default=-1, type=int, help="Compute a sub-range of N images (N=rangeSize).")
    parser.add_argument("--verboseLevel", default="info", type=str)

    parser.add_argument("--output", required=True, type=str, help='Output folder for generated normal maps.')

    args = parser.parse_args()

    run(args)