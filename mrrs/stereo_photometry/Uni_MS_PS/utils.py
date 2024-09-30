import numpy as np
from PIL import Image
import os
import torch
import cv2
from Transformer_multi_res_7 import Transformer_multi_res_7




def resize(img, expected_size):
    img = cv2.resize(img,
                     expected_size,
                     interpolation=cv2.INTER_LANCZOS4)
    return img


def resize_with_padding(img, expected_size):
    if type(img)==np.ndarray:
        if img.dtype==np.uint16:
            img1 = img.astype(np.uint8)
        else:
            img1 = img
        img1 = Image.fromarray(img1)
    else:
        img1 = img
    img1.thumbnail((expected_size[0], expected_size[1]))

    delta_width = expected_size[0] - img1.size[0]
    delta_height = expected_size[1] - img1.size[1]
    pad_width = delta_width // 2
    pad_height = delta_height // 2
    padding = (pad_width,
               pad_height,
               delta_width - pad_width,
               delta_height - pad_height)
    img2 = np.zeros((expected_size[0], expected_size[1], 3))

    if padding[3]!=0 and padding[2]!=0:
        img2[padding[1]:-padding[3],
             padding[0]:-padding[2]] = img
    elif padding[3]!=0:
        img2[padding[1]:-padding[3],
             padding[0]:] = img
    elif padding[2]!=0:
        img2[padding[1]:,
             padding[0]:-padding[2]] = img
    else:
        img2[padding[1]:,
             padding[0]:] = img
    return img2, padding



def depadding(img, padding):
    img = np.array(img)
    if padding[3]!=0 and padding[2]!=0:
        img = img[padding[1]:-padding[3],
                  padding[0]:-padding[2]]
    elif padding[3]!=0:
        img = img[padding[1]:-padding[3],
                  padding[0]:]
    elif padding[2]!=0:
        img = img[padding[1]:,
                  padding[0]:-padding[2]]
    else:
        img = img[padding[1]:,
                  padding[0]:]
    return img


def normal_to_rgb(img):
    return (((img+1)/2)*255).astype(np.uint8)

    

def get_nb_stage(shape):
    max_shape = np.max(shape)
    nb_stage = np.ceil(np.log2(max_shape/32))+1
    nb_stage = int(nb_stage)
    return nb_stage
    

def find_max_size(mask, max_size=256):
    coord = np.argwhere(mask[:,:,0]>0)
    x_min, x_max = np.min(coord[:,0]), np.max(coord[:,0])
    y_min, y_max = np.min(coord[:,1]), np.max(coord[:,1])

    x_max_pad = mask.shape[0] - x_max
    y_max_pad = mask.shape[1] - y_max
    
    original_size = mask.shape
    
    mask1 = mask[x_min:x_max,
                 y_min:y_max]
    size_x = x_max-x_min
    size_y = y_max-y_min
    
    size = np.max([size_x,
                   size_y])
    
    if max_size is None or size<=max_size:
        return mask1, x_min, x_max, y_min, y_max, x_max_pad, y_max_pad, 1, mask.shape[0], mask.shape[1]

    factor = (max_size-1)/size
    size_x = int(np.floor(original_size[0]*factor))
    size_y = int(np.floor(original_size[1]*factor))

    mask = cv2.resize(mask,
                      (size_y, size_x))
    coord = np.argwhere(mask[:,:,0]>0)
    x_min, x_max = np.min(coord[:,0]), np.max(coord[:,0])
    y_min, y_max = np.min(coord[:,1]), np.max(coord[:,1])

    x_max_pad = mask.shape[0] - x_max
    y_max_pad = mask.shape[1] - y_max
    
    mask = mask[x_min:x_max,
                y_min:y_max]
    return mask, x_min, x_max, y_min, y_max, x_max_pad, y_max_pad, factor, size_x, size_y



def load_imgs_mask(files,
                   do_padding=True,
                   zoom_mask=True, 
                   masking=True,
                   max_size=25600):
    
    extension = ('.png', '.jpg', '.jpeg', '.tif', '.tiff', '.bmp', '.gif')
    
    mask = None
    for file in files:
        if 'mask' in file:
            mask = cv2.imread(file)
        elif mask is None and file.lower().endswith(extension):
            mask = cv2.imread(file)
            mask = np.ones(mask.shape,
                           dtype=np.uint8)
        
    if not masking:
        mask = np.ones(mask.shape, 
                       dtype=np.uint8)
            
    original_shape = mask.shape
    
    if zoom_mask:
        mask, x_min, x_max, y_min, y_max, x_max_pad, y_max_pad, factor, size_x, size_y = find_max_size(mask=mask,
                                                                                                       max_size=max_size)
        
    nb_stage = get_nb_stage(mask.shape)
    size_img = 32*2**(nb_stage-1)
    
    if do_padding:
        mask, _ = resize_with_padding(mask,
                                      expected_size=(size_img,
                                                     size_img))
    else:
        mask = resize(mask,
                      expected_size=(size_img,
                                     size_img))
    mask = (mask>0)
    mask = mask[:,:,0]
    
    imgs = []
    files_imgs = []
    for file in files:
        if "mask" not in file and file.lower().endswith(extension):
            files_imgs.append(file)
            img = cv2.imread(file, 
                             cv2.IMREAD_UNCHANGED)
            if len(img.shape)==2:
                img = np.expand_dims(img, -1)
                img = np.concatenate((img, img, img),
                                     axis=-1)
            
            img = cv2.resize(img, (size_y, size_x))
                    
            if zoom_mask:
                img = img[x_min:x_max,
                          y_min:y_max]
                
            if do_padding:
                img, padding = resize_with_padding(img=img,
                                                   expected_size=(size_img, size_img))
            else:
                img = resize(img, expected_size=(size_img,
                                                 size_img))
                padding = (0, 0, 0, 0)
            
            img = img.astype(np.float32)
            mean_img = np.mean(img, -1)
            mean_img = mean_img.flatten()
            mean_img1 = np.mean(mean_img[mask.flatten()])
            img = img/mean_img1
            
            imgs.append(img)
    
    
    imgs = np.array(imgs)
    imgs = np.moveaxis(imgs,
                       -1,
                       0)
    imgs = torch.from_numpy(imgs).unsqueeze(0).float()        
    
    mask = torch.from_numpy(mask).unsqueeze(0).unsqueeze(0)
    return imgs, mask, padding, [x_min, x_max_pad, y_min, y_max_pad], original_shape



def load_model(path_weight, cuda,
               mode_inference=False): 
    
    file_weight = os.path.join(path_weight, "model_uncalibrated.pth")

    model = Transformer_multi_res_7(c_in=3)
        
    model.load_weights(file=file_weight)
    model.eval()
    if mode_inference:
        model.set_inference_mode(use_cuda_eval_mode=cuda)
    elif cuda:
        model.cuda()
    return model


def process_normal(model, imgs, mask):
    nb_stage = get_nb_stage(mask.shape)
    x = {}
    x["imgs"] = imgs
    x["mask"] = mask

    with torch.no_grad():
        a = model.process(x,
                          nb_stage)
        normal = a["n"].squeeze().movedim(0,-1).numpy()
    return normal
        
