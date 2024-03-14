#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 17 10:44:53 2023

@author: hardy216
"""
import numpy as np
import cv2
import math
import torch


def load_img(file, scale_decrease=1):
    img = cv2.cvtColor(cv2.imread(file,
                                  cv2.IMREAD_UNCHANGED),
                       cv2.COLOR_BGR2RGB)
    
    if scale_decrease>1:
        shape_x = int(img.shape[0]/scale_decrease)
        shape_y = int(img.shape[1]/scale_decrease)
        img = cv2.resize(img,
                         (shape_y, shape_x))
        
    if img.dtype==np.dtype("uint8"):
        img = img/255
    elif img.dtype==np.dtype("uint16"):
        img = img/65535

    img = img.astype(np.float32)
    return img

def load_dirs(file, index):
    temp = np.loadtxt(file)
    temp = temp[index]
    #temp[0] = -temp[0]
    temp[1] = -temp[1]
    temp[2] = -temp[2]
    return temp

def load_ints(file, index):
    temp = np.loadtxt(file)
    return temp[index]

def find_power_2(x):
    return (math.log10(x) /
            math.log10(2))

def find_size_stage(num_stage,
                    shape_original_img,
                    stride=768,
                    patch_size=1024):
    
    size = int(16*(2**num_stage))
    if num_stage>=7:
        rapport = np.min(shape_original_img)/np.max(shape_original_img)
        
        size_max = int(16*(2**num_stage))
        nb_patch_line = np.ceil((size_max - patch_size)/stride)
        size_max = int(patch_size+nb_patch_line*stride)
        
        
        size_min = size_max*rapport
        nb_patch_line = np.ceil((size_min - patch_size)/stride)
        size_min = int(patch_size+nb_patch_line*stride)
        size_min = np.max((size_min, patch_size))
        
        size_max = int(size_max)
        size_min = int(size_min)
        
        if shape_original_img[0]>shape_original_img[1]:
            return size_max, size_min
        else:
            return size_min, size_max
    return size, size
    
    

def create_stage(img, num_stage,
                 shape_original_img,
                 stride=768,
                 patch_size=1024): 
    
    size_x, size_y = find_size_stage(num_stage=num_stage,
                           stride=stride,
                           shape_original_img=shape_original_img,
                           patch_size=patch_size)
    img = cv2.resize(img, (size_y, size_x))
    return img


def add_dirs(img, dirs):
    if type(img)==np.ndarray:
        img = torch.from_numpy(img)
        
    final = torch.ones((img.shape[0],
                      img.shape[1],
                      3), dtype=torch.float16)
    final[:,:,0] = dirs[0]
    final[:,:,1] = dirs[1]
    final[:,:,2] = dirs[2]

    final = torch.cat((img, final),
                      -1)
    return final

def correct_intensity(img, ints):
    img = img/ints
    return img
