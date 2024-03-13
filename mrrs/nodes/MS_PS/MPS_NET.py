#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan  4 18:48:56 2022

@author: hardy216
"""
import numpy as np
import torch
import cv2
from NENet import NENet
from tqdm import tqdm
from utils import add_dirs, create_stage, find_power_2, find_size_stage



    


class MPS_NET(torch.nn.Module):
    
    def __init__(self):
        super(MPS_NET, self).__init__()
        
        self.Net = []

        self.Net_first = NENet(c_in=6)
        self.Net_stage = NENet(c_in=9)
        
        
        self.patch_size = 1024
        
        self.padding = 128
        self.stride = self.patch_size-2*self.padding
        
        self.layer_unfold = torch.nn.Unfold(self.patch_size,
                                            dilation=1,
                                            padding=0,
                                            stride=self.stride)
    
    def build_unfold(self, img):

        img1 = self.layer_unfold(img.float())
        img1 =  img1.reshape(img.shape[0],
                             img.shape[1],
                             self.patch_size,
                             self.patch_size,
                             img1.shape[-1])
     
        return img1
    
    def build_unfold_img(self, img, coord_x, coord_y):
        img = img[:,:,
                  coord_x,
                  coord_y]

        img =  img.reshape(img.shape[0],
                           img.shape[1],
                           self.patch_size,
                           self.patch_size)
     
        return img


    def build_fold(self, img, size_img, coords_x, coords_y):
        
        result = torch.zeros(img.shape[0],
                             img.shape[1],
                             size_img[0],
                             size_img[1])

        for i in range(img.shape[-1]):
            result[:,:,
                   coords_x[:,:,i],
                   coords_y[:,:,i]] += img[:,:,:,:,i]

        return result

        
    def eval(self):
        self.Net_first.eval()
        self.Net_stage.eval()
            
    
    def interpolate_normal(self, normal, shape):
        normal = torch.nn.functional.interpolate(input=normal,
                                                 size=shape,
                                                 align_corners=True,
                                                 mode="bilinear")
        normal = torch.nn.functional.normalize(normal, 
                                               2, 1) 
        return normal
    
    
    def forward_img_by_img(self,
                           img,
                           num_scale,
                           normal=None):
            
        if num_scale>0 and self.normal[0,0].shape!=img[0,0].shape:
              self.normal = self.interpolate_normal(normal=self.normal,
                                                    shape=img[0,0].shape)
            
        if num_scale>0:
            if normal is None:
                normal = self.normal
            img = torch.cat([img,
                             normal], 1)
        
        if num_scale==0:
            self.Net_first.forward_img_by_img(img)
        else:
            self.Net_stage.forward_img_by_img(img)
            
            
    def finish_scale(self, num_scale, mask):
        if num_scale==0:
            self.normal = self.Net_first.finish_scale(mask)
        else:
            self.normal = self.Net_stage.finish_scale(mask)
        
            
    def get_normal(self):
        return torch.moveaxis(self.normal.cpu()[0],
                              0, -1).numpy()
    
    
    
    def forward(self, inputs, masks, all_in):
        normal = None
        for i in range(len(inputs)):
            if i>0: 
                normal = torch.nn.functional.interpolate(input=normal,
                                                         size=inputs[i][0,0,0].shape,
                                                         align_corners=True,
                                                         mode="bilinear")
                normal = torch.nn.functional.normalize(normal, 2, 1)   
                normal = normal.unsqueeze(0)
                normal = normal.repeat(inputs[i].shape[0],
                                       1, 1, 1, 1)
                inputs[i] = torch.cat([inputs[i],
                                       normal], 2)
            if i==0:
                with torch.no_grad():
                    normal = self.Net_first.forward(inputs[i],
                                                        masks[i],
                                                        all_in)
            else:
                with torch.no_grad():
                    normal = self.Net_stage.forward(inputs[i],
                                                        masks[i],
                                                        all_in)
            
            normal = torch.nn.functional.normalize(normal, 2, 1)
        return normal
    
    
    def load_weights(self, file, cpu=True):
        if cpu:
            map_location = torch.device('cpu')
        else:
            map_location = None
            
        checkpoint = torch.load(file,
                                map_location=map_location)["state_dict"]
        self.load_state_dict(checkpoint)


    
    def gen_mask_patch(self, coord_x, coord_y, shape_img):
        mask_patch = torch.ones((1, 3,
                                 self.patch_size,
                                 self.patch_size))
        border = False
        coord_x = coord_x.cpu().numpy()
        coord_y = coord_y.cpu().numpy()

        if np.min(coord_x)==0 and np.min(coord_y)!=0:
            mask_patch[:,:,
                       :-self.padding,
                       self.padding:-self.padding] = 0
            border = True
        elif np.min(coord_x)==0 and np.min(coord_y)==0:
            mask_patch[:,:,
                       :-self.padding,
                       :-self.padding] = 0
            border = True
        elif np.min(coord_x)!=0 and np.min(coord_y)==0:
            mask_patch[:,:,
                       self.padding:-self.padding,
                       :-self.padding] = 0
            border = True
            
        if np.max(coord_x)==shape_img[0]-1 and np.max(coord_y)!=shape_img[1]-1:
            mask_patch[:,:,
                       self.padding:,
                       self.padding:-self.padding] = 0
            border = True
        elif np.max(coord_x)==shape_img[0]-1 and np.max(coord_y)==shape_img[1]-1:
            mask_patch[:,:,
                       self.padding:,
                       self.padding:] = 0
            border = True
        elif np.max(coord_x)!=shape_img[0]-1 and np.max(coord_y)==shape_img[1]-1:
            mask_patch[:,:,
                       self.padding:-self.padding,
                       self.padding:] = 0
            border = True
            
        if np.min(coord_x)==0 and np.max(coord_y)==shape_img[1]-1:
            mask_patch[:,:,
                       :-self.padding,
                       self.padding:] = 0
            border = True
            
        if np.max(coord_x)==shape_img[0]-1 and np.min(coord_y)==0:
            mask_patch[:,:,
                       self.padding:,
                       :-self.padding:] = 0
            border = True
            
        if not border:
            mask_patch[:,:,
                       self.padding:-self.padding,
                       self.padding:-self.padding] = 0
        mask_patch = mask_patch>0
        return mask_patch
    
        
    def process(self, imgs, mask, dirs):
        dirs = torch.Tensor(dirs)
        
        self.shape_original = imgs[0].shape[:2]
        max_size = np.max(imgs[0].shape[:2])
        nb_stage = int(np.ceil(find_power_2(max_size*0.8)-3))
        for i in range(nb_stage):
            mask_stage = create_stage(img=mask,
                                      num_stage=i,
                                      shape_original_img=self.shape_original,
                                      stride=self.stride,
                                      patch_size=self.patch_size)
            mask_stage = torch.from_numpy(mask_stage)
            mask_stage = torch.moveaxis(mask_stage, -1, 0)
            mask_stage = mask_stage.unsqueeze(0)
            
            if i<7:
                for j in range(len(imgs)):
                    img = imgs[j].copy()
                
                    img = create_stage(img=img,
                                       num_stage=i,
                                       shape_original_img=self.shape_original,
                                       stride=self.stride,
                                       patch_size=self.patch_size)
                    img = add_dirs(img, dirs[j])
                
                    #img = torch.from_numpy(img)
                    img = torch.moveaxis(img, -1, 0)
                    img = img.unsqueeze(0)

                    with torch.no_grad():
                        self.forward_img_by_img(img=img,
                                                num_scale=i)
                with torch.no_grad():
                    self.finish_scale(i, mask_stage)
            else:
                size_stage_x, size_stage_y = find_size_stage(shape_original_img=imgs[0].shape[:2],
                                                                  num_stage=i,
                                                                  stride=self.stride,
                                                                  patch_size=self.patch_size)
                self.size_img_pad = (size_stage_x,
                                     size_stage_y)                
                
                normal = self.interpolate_normal(normal=self.normal,
                                                 shape=[size_stage_x,
                                                        size_stage_y])
                normal = torch.nn.functional.normalize(normal, 2, 1)  

                x = torch.arange(0, self.size_img_pad[0])
                y = torch.arange(0, self.size_img_pad[1])
                coords = torch.meshgrid(x, y,
                                        indexing='ij')
                coords_x = coords[0].unsqueeze(0).unsqueeze(0).float()
                coords_y = coords[1].unsqueeze(0).unsqueeze(0).float()
                coords_x = self.build_unfold(coords_x).long().squeeze()
                coords_y = self.build_unfold(coords_y).long().squeeze()
                
                
                normal_output = torch.zeros(1, 3,
                                            self.patch_size,
                                            self.patch_size,
                                            coords_x.shape[-1])
                
                for j in tqdm(range(coords_x.shape[-1])):
                    for k in range(len(imgs)):
                        with torch.no_grad():
                            img = cv2.resize(imgs[k], (size_stage_y,
                                                   size_stage_x))
                            img = add_dirs(img, dirs[k])

                            img = torch.moveaxis(img, -1, 0)
                            img = img.unsqueeze(0)

                            img = self.build_unfold_img(img=img,
                                                        coord_x=coords_x[:,:,j],
                                                        coord_y=coords_y[:,:,j])
                            normal1 = self.build_unfold_img(img=normal,
                                                            coord_x=coords_x[:,:,j],
                                                            coord_y=coords_y[:,:,j])
            
                            self.forward_img_by_img(img=img,
                                                    num_scale=i,
                                                    normal=normal1)
                    mask_patches = self.gen_mask_patch(coord_x=coords_x[:,:,j],
                                                       coord_y=coords_y[:,:,j],
                                                       shape_img=self.size_img_pad)
                    mask_patches = (mask_patches*self.build_unfold_img(img=mask_stage,
                                                                      coord_x=coords_x[:,:,j],
                                                                      coord_y=coords_y[:,:,j]))>0

                    with torch.no_grad():
                        self.finish_scale(i, mask_patches)
                    #print(self.normal)
                    normal_output[:,:,
                                  :,:,
                                  j] += self.normal
                
                self.normal = self.build_fold(normal_output,
                                              coords_x = coords_x,
                                              coords_y=coords_y,
                                              size_img=self.size_img_pad)   
     
        self.normal = self.interpolate_normal(normal=self.normal,
                                              shape=[self.shape_original[0],
                                                     self.shape_original[1]])
        self.normal = torch.nn.functional.normalize(self.normal, 2, 1) 
        normal = self.get_normal()
        return normal
