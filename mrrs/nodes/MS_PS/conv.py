#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan  5 15:50:58 2022

@author: hardy216
"""
import torch.nn as nn



def conv(batchNorm, cin, cout, k=3, stride=1, pad=-1):
    pad = pad if pad >= 0 else (k - 1) // 2       
    return nn.Sequential(
                    nn.Conv2d(cin,
                              cout,
                              kernel_size=k,
                              stride=stride,
                              padding=pad,
                              bias=True),
                    nn.LeakyReLU(0.1, inplace=False)
                    )
            

def deconv(cin, cout):
    return nn.Sequential(
            nn.ConvTranspose2d(cin, cout, kernel_size=4,
                               stride=2, padding=1, bias=False),
            nn.LeakyReLU(0.1, inplace=False)
            )

