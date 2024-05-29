import sys
import numpy as np
import json
import cv2
import os
import scipy.io
from MPS_NET import MPS_NET
from utils import load_img, correct_intensity


def parser_argv(argv):
    args = {}
    args["script_file"] = argv[0]
    for i in range(1, len(argv[1:])-1, 2):
        key = argv[i].split("--")[1]
        args[key] = argv[i+1]
    return args
            

def prepare_data(data):
    
    imgs = []
    dirs = []
    
    keys_view = list(data.keys())
    
    for key in keys_view:
        #file_img = os.path.join(path, "{:03d}".format(i)+".png")
        file_img = data[key]['path']
        
        img = load_img(file=file_img)
        ints = np.array(data[key]["intensity"]).astype(np.float32)
        img = correct_intensity(img,
                                ints).astype(np.float32)
        temp = np.array(data[key]["direction"]).astype(np.float32)
        temp[1] = -temp[1]
        temp[2] = -temp[2]
        dirs.append(temp)
        
        imgs.append(img)
    mask = np.ones(imgs[0].shape)
    return imgs, mask, dirs
       

def run_inference(data):
    model = MPS_NET()
    model.eval()
    model.cuda()
    file_weight = os.path.join("weight", 
                               "MPS_NET")
    model.load_weights(file=file_weight)

    imgs, mask, dirs = prepare_data(data)

    normal = model.process(imgs, mask,
                           dirs)
    return normal


args = parser_argv(sys.argv)

outputPath = args['outputPath']

data_camera = json.load(open(args["inputPath"]))
data_lights = json.load(open(args["pathToJSONLightFile"]))['lights']

data_view = {}
for i in range(len(data_camera['views'])):
    key = data_camera['views'][i]['viewId']
    data_view[key] = data_camera['views'][i]

for i in range(len(data_lights)):
    key = data_lights[i]['viewId']
    for key1 in data_lights[i]:
        if key1!='viewId':
            data_view[key][key1] = data_lights[i][key1]
            
            

normal = run_inference(data=data_view)
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
