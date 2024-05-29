from run import run
from utils import load_model
import sys
import os
import cv2
import json
import torch
import scipy.io



def parser_argv(argv):
    args = {}
    args["script_file"] = argv[0]
    for i in range(1, len(argv[1:])-1, 2):
        key = argv[i].split("--")[1]
        args[key] = argv[i+1]
    return args
    
def run_inference(files):
            
    path_weight = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                               "weight")
    cuda = torch.cuda.is_available()
    model = load_model(path_weight=path_weight,
                       cuda=cuda,
                       mode_inference=True)

    normal = run(model=model,
                 files=files)
    return normal
       


args = parser_argv(sys.argv)

with open(args["inputPath"], 'r') as file:
    data = json.load(file)

files = [data["views"][i]["path"] for i in range(len(data["views"]))]


outputPath = args['outputPath']

normal = run_inference(files=files)
normal_rgb = ((normal+1)/2.)*255.0
normal_rgb = normal_rgb[:,:,::-1]


file_save = os.path.join(outputPath,
                         "normal.png")
cv2.imwrite(file_save,
            normal_rgb)

file_save = os.path.join(outputPath,
                         "normal.mat")
scipy.io.savemat(file_save,
                 {'Normal_est': normal})
