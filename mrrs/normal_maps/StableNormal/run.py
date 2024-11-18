import os

# set huggingface and torch home directories before importing
os.environ['HF_HOME'] = "/s/prods/mvg/_source_global/users/almarouka/3rd_party/huggingface"
os.environ['TORCH_HOME'] = "/s/prods/mvg/_source_global/users/almarouka/3rd_party/torch"

# import sys
# sys.path.append(os.path.join(os.path.dirname(__file__), 'repo'))

import torch
from PIL import Image
from argparse import ArgumentParser, ArgumentError
import json

# redundant, just to be sure XD
torch.hub.set_dir("/s/prods/mvg/_source_global/users/almarouka/3rd_party/torch/hub")

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
            img_path = paths.get(view_id, None)
            if img_path is None:
                continue
        else:
            img_path = view['path']
        data.append((view_id, img_path))

    return data

def run():
    parser = ArgumentParser()
    parser.add_argument('--input', type=str, required=True)
    parser.add_argument('--imagesFolder', type=str, required=True)
    parser.add_argument('--output', type=str, required=True)
    parser.add_argument("--rangeStart", default=-1, type=int, help="Compute a sub-range of images from index rangeStart to rangeStart+rangeSize.")
    parser.add_argument("--rangeSize", default=-1, type=int, help="Compute a sub-range of N images (N=rangeSize).")
    parser.add_argument("--verboseLevel", default="info", type=str)
    args = parser.parse_args()

    data = read_sfmData(args.input, args.imagesFolder)
    rangeStart = args.rangeStart
    if rangeStart < 0: rangeStart = 0
    rangeSize = args.rangeSize
    if rangeSize < 0: rangeSize = len(data)
    for view_id, img_path in data[rangeStart:min(rangeStart + rangeSize, len(data))]:
        if img_path == '':
                raise RuntimeError(f"Ambiguous case: Multiple image files found for the view {view_id} in folder {args.imagesFolder}")
    
    os.makedirs(args.output, exist_ok=True)

    # Create predictor instance
    predictor = torch.hub.load("Stable-X/StableNormal", "StableNormal", trust_repo=True)

    for view_id, img_path in data[rangeStart:min(rangeStart + rangeSize, len(data))]:
        if img_path == '':
                # raise RuntimeError
            print(f"Warning: Ambiguous case: Multiple image files found for the view {view_id} in folder {args.imagesFolder}, will be skipped")
            continue
        # Load an image
        input_image = Image.open(img_path)

        # Apply the model to the image
        normal_image = predictor(input_image)

        # Save or display the result
        normal_image.save(os.path.join(args.output, view_id + '_normalMap.png'))

if __name__ == '__main__':
    try:
        if not torch.cuda.is_available():
            raise
        run()
    except:
        import sys
        sys.stdout.write("TR_EXIT_STATUS -666")
        sys.stdout.flush()
        raise
