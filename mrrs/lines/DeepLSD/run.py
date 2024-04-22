import argparse
import json

import os
import cv2
import torch
from deeplsd.models.deeplsd_inference import DeepLSD

def str2bool (val):
    val = val.lower()
    if val in ('y', 'yes', 't', 'true', 'on', '1'):
        return True
    elif val in ('n', 'no', 'f', 'false', 'off', '0'):
        return False
    else:
        raise ValueError(f"invalid truth value {val}")

def read_sfmData(sfmData_path: str, images_folder: str):
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
    data = []
    for view in sfm_data['views']:
        view_id = view['viewId']
        if custom_dir:
            img_path = paths[view_id]
        else:
            img_path = view['path']
        data.append((view_id, img_path))

    return data

def imwrite(target, img):
    os.makedirs(os.path.dirname(target), exist_ok=True)
    cv2.imwrite(target, img)

def run(args: argparse.Namespace, conf: dict):
    # Model config
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    line_neighborhood = 5.

    # Load the model
    ckpt = args.ckpt
    ckpt = torch.load(str(ckpt), map_location='cpu')
    net = DeepLSD(conf)
    net.load_state_dict(ckpt['model'])
    net = net.to(device).eval()

    with torch.no_grad():
        data = read_sfmData(args.input, args.imagesFolder)
        rangeStart = args.rangeStart
        if rangeStart < 0: rangeStart = 0
        rangeSize = args.rangeSize
        if rangeSize < 0: rangeSize = len(data)
        for view_id, img_path in data[rangeStart:min(rangeStart + rangeSize, len(data))]:
            if img_path == '':
                raise RuntimeError(f"Ambiguous case: Multiple image files found for the view {view_id} in folder {args.imagesFolder}")
            # Load an image
            img = cv2.imread(img_path)
            size = args.maxWidth
            height, width, _ = img.shape
            if width > size:
                dim = (size, int(size * height / width))
            img = cv2.resize(img, dim)
            gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            # Detect (and optionally refine) the lines
            inputs = {'image': torch.tensor(gray_img, dtype=torch.float, device=device)[None, None] / 255.}
            out = net(inputs)
            pred_lines = out['lines'][0]
            with open(os.path.join(args.output, view_id + '.txt'), 'w') as file:
                file.write('\n'.join([' '.join(line.flatten().astype(str)) for line in pred_lines]))

            if args.exportLines:
                lines = pred_lines.astype(int)
                img_ = img.copy()
                for i in range(len(lines)):
                    cv2.line(img_, (lines[i, 0, 0], lines[i, 0, 1]), (lines[i, 1, 0], lines[i, 1, 1]), (255, 0, 0), 1)
                    cv2.circle(img_, (lines[i, 0, 0], lines[i, 0, 1]), radius=1, color=(0,255,0), thickness=-1)
                    cv2.circle(img_, (lines[i, 1, 0], lines[i, 1, 1]), radius=1, color=(0,255,0), thickness=-1)
                target_path = os.path.join(args.output, 'lines', view_id + '.jpg')
                imwrite(target_path, img_)
            if args.exportLinesWithVP:
                import seaborn as sns
                import numpy as np
                lines = pred_lines.astype(int)
                img_ = img.copy()
                num_labels = np.max(out['vp_labels'][0]) + 1
                colors = sns.color_palette("hls", num_labels)
                colors = [(int(color[2] * 255), int(color[1] * 255), int(color[0] * 255)) for color in colors]
                vp_labels = out['vp_labels'][0]
                for i in range(len(lines)):
                    if vp_labels[i] == -1: continue
                    cv2.line(img_, (lines[i, 0, 0], lines[i, 0, 1]), (lines[i, 1, 0], lines[i, 1, 1]), colors[vp_labels[i]], 1)
                target_path = os.path.join(args.output, 'lines_with_vp', view_id + '.jpg')
                imwrite(target_path, img_)
            if args.exportDF:
                img_ = out['df'].squeeze(0).detach().cpu().numpy() * 255 / line_neighborhood
                target_path = os.path.join(args.output, 'df', view_id + '.jpg')
                imwrite(target_path, img_)
            if args.exportDFNorm:
                img_ = out['df_norm'].squeeze(0).detach().cpu().numpy()
                img_ = (img_ - img_.min()) * 255 / img_.max()
                target_path = os.path.join(args.output, 'df_norm', view_id + '.jpg')
                imwrite(target_path, img_)
            if args.exportAF:
                import numpy as np
                img_ = out['line_level'].squeeze(0).detach().cpu().numpy()
                img_ *= 255 / np.pi
                img_ = cv2.applyColorMap(img_.astype(np.uint8), cv2.COLORMAP_HSV)
                target_path = os.path.join(args.output, 'af', view_id + '.jpg')
                imwrite(target_path, img_)
            if args.export_DF_AF_as_UV:
                from deeplsd.geometry.viz_2d import get_flow_vis
                df = out['df'].squeeze(0).detach().cpu().numpy()
                af = out['line_level'].squeeze(0).detach().cpu().numpy()
                img_ = get_flow_vis(df, af)
                img_ = cv2.cvtColor(img_, cv2.COLOR_RGB2BGR)
                target_path = os.path.join(args.output, 'df_af_as_uv', view_id + '.jpg')
                imwrite(target_path, img_)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True, type=str, help='Input SfMData file.')
    parser.add_argument('--ckpt', default='', type=str, help='Path to the checkpoint of the pretrained model.')
    parser.add_argument('--model', default='', type=str, help='Ignored')
    parser.add_argument('--imagesFolder', type=str,
        help="Use images from a specific folder instead of those specified in the SfMData file.\n"
             "Filename should be the image UID.")
    parser.add_argument('--maxWidth', default=1024, type=int, help='Maximum image width (in pixel).')

    parser.add_argument('--lineDetectionEnabled', default=True, type=str2bool, help='Whether to detect lines or only DF/AF (Distances/Angles fields).')
    parser.add_argument('--grad_thresh', default=3, type=float, help='')
    parser.add_argument('--grad_nfa', default=True, type=str2bool,
        help='If True, use the image gradient and the NFA score of LSD to further threshold lines.\n'
             'We recommand using it for easy images, but to turn it off for challenging images (e.g. night, foggy, blurry images)')
    parser.add_argument('--filteringEnabled', default=True, type=str2bool, help='Whether to filter out lines based on the DF/AF.')
    parser.add_argument('--filteringMode', default='normal', type=str, help="Use 'strict' to get an even stricter filtering.")
    parser.add_argument('--mergeEnabled', default=True, type=str2bool, help='Whether to merge close-by lines.')

    parser.add_argument('--refinementEnabled', default=True, type=str2bool, help='Whether to refine the lines after detecting them')
    parser.add_argument('--useVPs', default=True, type=str2bool, help='Whether to use vanishing points (VPs) in the refinement')
    parser.add_argument('--refineVPs', default=True, type=str2bool, help='Whether to also refine the VPs in the refinement')

    parser.add_argument('--exportLines', default=False, type=str2bool, help='Whether to export detected lines drawn on images.')
    parser.add_argument('--exportLinesWithVP', default=False, type=str2bool, help='Whether to export detected lines drawn on images with VP color labels.')
    parser.add_argument('--exportDF', default=False, type=str2bool, help='Whether to export distance fields as images.')
    parser.add_argument('--exportDFNorm', default=False, type=str2bool, help='Whether to export normalized distance fields as images.')
    parser.add_argument('--exportAF', default=False, type=str2bool, help='Whether to export angle fields as images.')
    parser.add_argument('--export_DF_AF_as_UV', default=False, type=str2bool, help='Whether to export distance and angle fields as UV flow image.')

    parser.add_argument("--rangeStart", default=-1, type=int, help="Compute a sub-range of images from index rangeStart to rangeStart+rangeSize.")
    parser.add_argument("--rangeSize", default=-1, type=int, help="Compute a sub-range of N images (N=rangeSize).")
    parser.add_argument("--verboseLevel", default="info", type=str)

    parser.add_argument("--output", required=True, type=str, help='Output folder for detected line segments.')

    args = parser.parse_args()

    if args.refinementEnabled:
        from deeplsd.models.deeplsd import DeepLSD
        conf = {
            'sharpen': True,  # Use the DF normalization (should be True)
            'detect_lines': args.lineDetectionEnabled,  # Whether to detect lines or only DF/AF
            'line_detection_params': {
                'merge': args.mergeEnabled,  # Whether to merge close-by lines
                'optimize': args.refinementEnabled,  # Whether to refine the lines after detecting them
                'use_vps': args.useVPs,  # Whether to use vanishing points (VPs) in the refinement
                'optimize_vps': args.refineVPs,  # Whether to also refine the VPs in the refinement
                'filtering': args.filteringMode if args.filteringEnabled else False,  # Whether to filter out lines based on the DF/AF. Use 'strict' to get an even stricter filtering
                'grad_thresh': args.grad_thresh,
                'grad_nfa': args.grad_nfa,  # If True, use the image gradient and the NFA score of LSD to further threshold lines. We recommand using it for easy images, but to turn it off for challenging images (e.g. night, foggy, blurry images)
            }
        }
    else:
        from deeplsd.models.deeplsd_inference import DeepLSD
        conf = {
            'detect_lines': args.lineDetectionEnabled,  # Whether to detect lines or only DF/AF
            'line_detection_params': {
                'merge': args.mergeEnabled,  # Whether to merge close-by lines
                'filtering': args.filteringMode if args.filteringEnabled else False,  # Whether to filter out lines based on the DF/AF. Use 'strict' to get an even stricter filtering
                'grad_thresh': args.grad_thresh,
                'grad_nfa': args.grad_nfa,  # If True, use the image gradient and the NFA score of LSD to further threshold lines. We recommand using it for easy images, but to turn it off for challenging images (e.g. night, foggy, blurry images)
            }
        }

    run(args, conf)