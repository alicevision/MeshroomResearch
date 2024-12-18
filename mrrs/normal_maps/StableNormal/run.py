import os

# set huggingface and torch home directories before importing
os.environ['HF_HOME'] = "/s/prods/mvg/_source_global/users/almarouka/3rd_party/huggingface"
os.environ['TORCH_HOME'] = "/s/prods/mvg/_source_global/users/almarouka/3rd_party/torch"

# import sys
# sys.path.append(os.path.join(os.path.dirname(__file__), 'repo'))

import torch
from PIL import Image
from argparse import ArgumentParser, ArgumentTypeError
import json

# redundant, just to be sure XD
torch.hub.set_dir("/s/prods/mvg/_source_global/users/almarouka/3rd_party/torch/hub")

def str2bool(v):
    if isinstance(v, bool):
        return v
    if isinstance(v, str):
        v = v.lower()
        if v in ('yes', 'true', 't', 'y', '1'):
            return True
        elif v in ('no', 'false', 'f', 'n', '0'):
            return False
        else:
            raise ArgumentTypeError('Boolean value expected.')

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

def tile_image(image, tile_size):
    width, height = image.size
    tiles = []
    for y in range(0, height, tile_size):
        for x in range(0, width, tile_size):
            box = (x, y, x + tile_size, y + tile_size)
            tile = image.crop(box)
            tiles.append((tile, box))
    return tiles

def process_tile(tile, model, args):
    processed_tile = model(tile, image_resolution=args.size)
    return processed_tile

def reconstruct_image(tiles, image_size):
    output_image = Image.new('RGB', image_size)
    for tile, box in tiles:
        output_image.paste(tile, box)
    return output_image

def process_image(image, model, args):
    if args.useTiling:
        tiles = tile_image(image, args.size)
        processed_tiles = [(process_tile(tile, model, args), box) for tile, box in tiles]
        output_image = reconstruct_image(processed_tiles, image.size)
    else:
        output_image = process_tile(image, model, args)
    return output_image

def run():
    parser = ArgumentParser()
    parser.add_argument('--input', type=str, required=True)
    parser.add_argument('--imagesFolder', type=str, required=True)
    parser.add_argument('--useTiling', type=str2bool, default=False)
    parser.add_argument('--size', type=int, default=768)
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
    predictor.model.default_processing_resolution = args.size

    for view_id, img_path in data[rangeStart:min(rangeStart + rangeSize, len(data))]:
        if img_path == '':
                # raise RuntimeError
            print(f"Warning: Ambiguous case: Multiple image files found for the view {view_id} in folder {args.imagesFolder}, will be skipped")
            continue
        # Load an image
        input_image = Image.open(img_path)

        # Apply the model to the image
        normal_image = process_image(input_image, predictor, args)

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
