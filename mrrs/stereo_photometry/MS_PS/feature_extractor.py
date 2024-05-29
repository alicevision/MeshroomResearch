#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan  5 16:08:03 2022

@author: hardy216
"""
import torch.nn as nn
from conv import conv, deconv


class FeatExtractor(nn.Module):
    def __init__(self, batchNorm=False, c_in=3, c_out=128):
        super(FeatExtractor, self).__init__()
        
        self.c_in = c_in
        self.c_out = c_out
        self.batchNorm = batchNorm
        
        self.build_NET()
        #self.init_weight()
    
    
    def build_NET(self):
        
        self.conv1 = conv(self.batchNorm, self.c_in, 64,  k=3, stride=1, pad=1)

        self.conv2 = conv(self.batchNorm, 64,   128, k=3, stride=2, pad=1)
        
        self.conv3 = conv(self.batchNorm, 128,  128, k=3, stride=1, pad=1)
        
        self.conv4 = conv(self.batchNorm, 128,  256, k=3, stride=2, pad=1)
        
        self.conv5 = conv(self.batchNorm, 256,  256, k=3, stride=1, pad=1)
        
        self.conv6 = deconv(256, 128)
            
        self.conv7 = conv(self.batchNorm, 128, self.c_out, k=3, stride=1, pad=1)
        
        
    def forward(self, x):
        out = self.conv1(x)
        out = self.conv2(out)
        out = self.conv3(out)
        out = self.conv4(out)
        out = self.conv5(out)
        out = self.conv6(out)
        out_feat = self.conv7(out)
        n, c, h, w = out_feat.data.shape
        return out_feat, [n, c, h, w]
    
        
class Regressor(nn.Module):
    def __init__(self, batchNorm=False, c_in=256): 
        super(Regressor, self).__init__()
        self.batchNorm = batchNorm
        self.c_in = c_in

        self.build_NET()

    def build_NET(self):
        self.deconv1 = conv(self.batchNorm, self.c_in, 128,  k=3, stride=1)
        self.deconv2 = conv(self.batchNorm, 128, 128,  k=3, stride=1,
                            pad=1)
        self.deconv3 = deconv(128, 64)
        self.est_normal = self._make_output(64, cout=3, k=3, stride=1, pad=1)
        
        
    def _make_output(self, cin, cout, k=3, stride=1, pad=1):
        return nn.Sequential(
               nn.Conv2d(cin, cout, kernel_size=k,
                         stride=stride, padding=pad,
                         bias=False))

    def forward(self, x):
        out    = self.deconv1(x)
        out    = self.deconv2(out)
        out    = self.deconv3(out)
        normal = self.est_normal(out)
        
        normal = nn.functional.normalize(normal, 2, 1)
        return normal
    

