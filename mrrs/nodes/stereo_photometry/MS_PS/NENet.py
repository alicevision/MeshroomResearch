import torch
from feature_extractor import FeatExtractor, Regressor



class NENet(torch.nn.Module):
    def __init__(self, c_in):
        super(NENet, self).__init__()

        self.extractor = FeatExtractor(c_in=c_in)
        self.regressor = Regressor(c_in=128)
        self.feats = None

    
    def check_output_size(self, x, size):
        if x.shape[-2:]!=size:            
            x = torch.nn.functional.interpolate(input=x,
                                                size=size,
                                                align_corners=True,
                                                mode="bilinear")
            
            x = torch.nn.functional.normalize(x, 2, 1)
        return x
        
    
    def forward_img_by_img(self, img):
        self.input_size = img[0,0].shape
        if next(self.parameters()).is_cuda:
            img = img.cuda()
            
        with torch.no_grad():
            feat, shape = self.extractor(img)
            self.shape = shape
        
        if self.feats is None:
            self.feats = feat
        else:
            self.feats, _ = torch.stack([self.feats, feat], 1).max(1)
        
        
    def finish_scale(self, mask):
        self.feats = self.feats.view(self.shape[0],
                                     self.shape[1],
                                     self.shape[2],
                                     self.shape[3])
        with torch.no_grad():
            self.normal = self.regressor(self.feats)

        self.normal = self.check_output_size(self.normal,
                                             self.input_size).cpu()
        self.normal = self.normal.masked_fill(mask, 0)
        self.feats = None
        
        return self.normal
    
        
    def forward(self, inputs, mask, all_in):
        feats = torch.Tensor()
        input_size = inputs[0][0][0].shape
        if all_in:
            inputs = torch.stack(inputs)
            shape_inputs = inputs.shape
            inputs = inputs.reshape(-1, inputs.shape[2], inputs.shape[3], inputs.shape[4])
            feat, shape = self.extractor(inputs)
            inputs = inputs.cpu()
            
            shape[0] = shape_inputs[1]
            feat = feat.reshape(shape_inputs[0], shape_inputs[1],
                                shape[1], shape[2], shape[3])
            #feat = feat.moveaxis(0, 1)
            feats, _  = feat.max(0)
            
            feat = feat.cpu()
        else:
            for i in range(len(inputs)):
                with torch.no_grad():
                    feat, shape = self.extractor(inputs[i])
                    
                if i == 0:
                    feats = feat
                else:               
                    feats, _ = torch.stack([feats, feat], 1).max(1)
        
        feats = feats.view(shape[0], shape[1],
                           shape[2], shape[3])

        normal = self.regressor(feats)

        normal = self.check_output_size(normal, input_size)
        feats = feats.cpu()
        normal = normal.cpu()
        
        return normal.masked_fill(mask, 0)

    
