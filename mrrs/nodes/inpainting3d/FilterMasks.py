
__version__ = "3.0"

import os

from meshroom.core import desc
import cv2
import numpy as np

SHAPES = {'rect':cv2.MORPH_RECT, 'ellipse':cv2.MORPH_ELLIPSE, 'cross':cv2.MORPH_CROSS}

#TODO: add params

def _temporal_filtering(frames, masks, window_size=3, use_of=True, metric=np.median):
    """
    Ensure temporal consistency of segmentation masks across video frames using a sliding window and median filtering.
    """
    import numpy as np
    import cv2

    if len(frames) != len(masks):
        raise ValueError("The number of frames and masks must be the same.")
   
    n_frames = len(frames)
    consistent_masks = []

    for i in range(n_frames):
        start_idx = max(0, i - window_size // 2)
        end_idx = min(n_frames, i + window_size // 2 + 1)
       
        window_masks = []
        for j in range(start_idx, end_idx):
            if use_of:
                # OF calculation from j to i
                prev_gray = cv2.cvtColor(frames[j], cv2.COLOR_BGR2GRAY)
                curr_gray = cv2.cvtColor(frames[i], cv2.COLOR_BGR2GRAY)
                flow = cv2.calcOpticalFlowFarneback(prev_gray, curr_gray, None,
                                                    pyr_scale=0.5, levels=3, winsize=15,
                                                    iterations=3, poly_n=5, poly_sigma=1.2, flags=0)
                # warp the masks  j to  i 
                h, w, _ = masks[j].shape
                grid_x, grid_y = np.meshgrid(np.arange(w), np.arange(h))
                map_x = grid_x + flow[..., 0]
                map_y = grid_y + flow[..., 1]
                warped_mask = cv2.remap(masks[j].astype(np.float32), map_x.astype(np.float32), 
                                        map_y.astype(np.float32), interpolation=cv2.INTER_LINEAR, borderMode=cv2.BORDER_CONSTANT, borderValue=0)
                # threshold needed because of interpolation
                warped_mask = (warped_mask > 0.5).astype(np.uint8)
                window_masks.append(warped_mask)
            else:
                window_masks.append(masks[j])

        # median of the masks in the window = final mask 
        median_mask = metric(window_masks, axis=0).astype(np.uint8)
        consistent_masks.append(median_mask)

    return consistent_masks
   
def temporal_filtering_of(frames, masks, window_size=3, dummy=None):
    """
    Ensure temporal consistency of segmentation masks across video frames using a sliding window and median filtering.
    """
    return _temporal_filtering(frames, masks, window_size=3, use_of=True)

def temporal_filtering_nof(frames, masks, window_size=3, dummy=None):
    """
    Ensure temporal consistency of segmentation masks across video frames using a sliding window and median filtering.
    """
    return _temporal_filtering(frames, masks, window_size=3, use_of=False)

def temporal_filtering_acc(frames, masks, window_size=3, dummy=None):
    """
    Ensure temporal consistency of segmentation masks across video frames using a sliding window and accumulative filtering.
    """
    return _temporal_filtering(frames, masks, window_size=3, use_of=True, metric=np.min)


def guided_filtering(frames, masks, kernel_size=5, dummy=None, epsilon=0.01):
    """
    Apply guided filtering to a list of masks and their corresponding RGB frames using OpenCV's guidedFilter.
    """
    import cv2
    import numpy as np

    filtered_masks = []
   
    for mask, frame in zip(masks, frames):
        # guided filter
        filtered = cv2.ximgproc.guidedFilter(
            guide=frame,
            src=mask.astype(np.float32),
            radius=radius,
            eps=epsilon
        )
        filtered_masks.append(filtered)
   
    return filtered_masks


def alpha_mate(frames, masks, base_kernel_size=5, dummy=None):
    """
    Compute the alpah mate using trimat compused of the difference if erosion + dilatation 
    """
    import cv2
    import numpy as np

    filtered_masks = []
   
    for mask, frame in zip(masks, frames):
        # guided filter
        filtered = cv2.ximgproc.FastBilateralSolverFilter(
            guide=frame,
            src=mask.astype(np.float32),
            radius=radius,
            eps=epsilon
        )
        filtered_masks.append(filtered)
   
    return filtered_masks


def dilation(frames, masks, kernel_size=5, shape='rect', iterations=1):
    """
    Apply dilation to a list of masks.
    """
    import cv2
    import numpy as np
    kernel = cv2.getStructuringElement(SHAPES[shape], (kernel_size, kernel_size))   
    dilated_masks = [cv2.dilate(mask, kernel, iterations=iterations) for mask in masks] 
    return dilated_masks

def erosion(frames, masks, kernel_size=5, shape='rect', iterations=1):
    """
    Apply erosion to a list of masks.
    """
    import cv2
    import numpy as np

    kernel = cv2.getStructuringElement(SHAPES[shape], (kernel_size, kernel_size))   
    dilated_masks = [cv2.erode(mask, kernel, iterations=iterations) for mask in masks]  
    return dilated_masks

def opening(frames, masks, kernel_size=5, shape='rect', iterations=1):
    """
    Apply opening to a list of masks.
    """
    import cv2
    import numpy as np

    kernel = cv2.getStructuringElement(SHAPES[shape], (kernel_size, kernel_size))   
    dilated_masks = [cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel) for mask in masks]  
    return dilated_masks

def closing(frames, masks, kernel_size=5, shape='rect', iterations=1):
    """
    Apply closing to a list of masks.
    """
    import cv2
    import numpy as np

    kernel = cv2.getStructuringElement(SHAPES[shape], (kernel_size, kernel_size))   
    dilated_masks = [cv2.morphologyEx(mask, cv2.MORPH_CLOSE, kernel) for mask in masks]  
    return dilated_masks

def blur(frames, masks, kernel_size=5, shape=None):
    '''
    Blur a list of masks.
    '''
    import cv2
    import numpy as np
    blurred_masks = [cv2.blur(mask, (kernel_size, kernel_size)) for mask in masks]
    return blurred_masks 

def invertion(frames, masks, dummy, dummy2):
    '''
    Invert a list of masks.
    '''
    return [1-mask for mask in masks]  

def segmentation_refinement(frames, masks, window_size=3, dummy=None):
    """
    """
    pass

class FilterMasks(desc.Node):

    category = 'Inpainting 3D'
    documentation = ''''''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.File(
            name="maskFolder",
            label="Mask Folder",
            description="maskFolder",
            value="",
        ),

        desc.ChoiceParam(
            name='filterType',
            label='Filter Type',
            description=''' ''',
            value='segmentation_refinement',
            values=['guided_filtering', 'temporal_filtering_nof', 'temporal_filtering_of', 'temporal_filtering_acc', 'dilation', 'erosion', 'closing', 'opening', 'invertion', 'blur', 'segmentation_refinement'],
            exclusive=True,
        ),

        desc.ChoiceParam(
            name='kernelShape',
            label='Filter shape',
            description='For spatial filtering, the shape of the kernel',
            value='rect',
            values=['rect', 'ellipse', 'cross'],
            exclusive=True,
        ),

        desc.IntParam(
            name="kernelSize",
            label="Filter size",
            description="For temporal foltering, the size of the temporal window, for the spatial filtering, the size of the kernel",
            value=3,
            range=(3, 100000, 1)
        ),

        desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
            ),

    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='outputFolder',
            description='outputFolder',
            value=desc.Node.internalFolder,
            group='',
        ),
        desc.File(
            name="masks",
            label="Masks",
            description="Generated segmentation masks.",
            semantic="image",
            value=lambda attr: desc.Node.internalFolder + "<VIEW_ID>.jpg",
            group="",
            visible=False
        ),
    ]

    def processChunk(self, chunk):
        """
        """

        import json
        import numpy as np
        import cv2
        from mrrs.core.ios import open_image, save_image
      
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfM.value == '':
            raise RuntimeError("No inputSfM specified")
        if chunk.node.maskFolder.value == '':
            raise RuntimeError("No maskFolder specified")
        chunk.logger.info("Loading masks")
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        #temporal sort
        sfm_data["views"]=sorted(sfm_data["views"], key=lambda v:int(v["frameId"])) 
        images=[]
        masks=[]
        for view in sfm_data["views"]:
            # image_basename = view["viewId"]
            image_basename = os.path.basename(view["path"])[:-4]
            mask_file = os.path.join(chunk.node.maskFolder.value, image_basename+".exr")
            if not os.path.exists(mask_file):
                mask_file = os.path.join(chunk.node.maskFolder.value, image_basename+".jpg")
            images.append(open_image(view["path"], auto_rotate=True))
            masks.append(open_image(mask_file)/255.0)
        
        chunk.logger.info("Applying filter")
        filter_function = eval(chunk.node.filterType.value)
        filtered_masks = filter_function(images, masks, chunk.node.kernelSize.value, chunk.node.kernelShape.value)
     
        chunk.logger.info("Saving masks")
        for view, mask in zip(sfm_data["views"], filtered_masks):
            # image_basename = view["viewId"]
            image_basename = os.path.basename(view["path"])[:-4]
            save_image(chunk.node.outputFolder.value+"/"+image_basename+".jpg",(255*mask).astype(np.uint8))
        chunk.logManager.end()

