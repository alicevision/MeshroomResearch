import json
import os
import numpy as np
import cv2

from meshroom.core import desc
from mrrs.core.ios import matrices_from_sfm_data, open_depth_map, save_exr
from mrrs.core.CondaNode import CondaNode
from mrrs.core.utils import format_float_array
from mrrs.depth_maps.vismvsnet import ENV_FILE, EXEC, MODEL_PATH


# parser.add_argument('--data_root', type=str, help='The root dir of the data.')
# parser.add_argument('--dataset_name', type=str, default='tanksandtemples', help='The name of the dataset. Should be identical to the dataloader source file. e.g. blended refers to data/blended.py.')
# parser.add_argument('--model_name', type=str, default='model_cas', help='The name of the model. Should be identical to the model source file. e.g. model_cas refers to core/model_cas.py.')

# parser.add_argument('--num_src', type=int, default=7, help='The number of source views.')
# parser.add_argument('--max_d', type=int, default=256, help='The standard max depth number.')
# parser.add_argument('--interval_scale', type=float, default=1., help='The standard interval scale.')
# parser.add_argument('--cas_depth_num', type=str, default='64,32,16', help='The depth number for each stage.')
# parser.add_argument('--cas_interv_scale', type=str, default='4,2,1', help='The interval scale for each stage.')
# parser.add_argument('--resize', type=str, default='1920,1080', help='The size of the preprocessed input resized from the original one.')
# parser.add_argument('--crop', type=str, default='1920,1056', help='The size of the preprocessed input cropped from the resized one.')

# parser.add_argument('--mode', type=str, default='soft', choices=['soft', 'hard', 'uwta', 'maxpool', 'average'], help='The fusion strategy.')
# parser.add_argument('--occ_guide', action='store_true', default=False, help='Deprecated')

# parser.add_argument('--load_path', type=str, default=None, help='The dir of the folder containing the pretrained checkpoints.')
# parser.add_argument('--load_step', type=int, default=-1, help='The step to load. -1 for the latest one.')

# parser.add_argument('--show_result', action='store_true', default=False, help='Set to show the results.')
# parser.add_argument('--write_result', action='store_true', default=False, help='Set to save the results.')
# parser.add_argument('--result_dir', type=str, help='The dir to save the results.')

class VizMVSNet(CondaNode):

    category = 'Meshroom Research'
    documentation = ''' '''
    gpu = desc.Level.INTENSIVE

    commandLine = EXEC+" --data_root {outputFolderValue} --result_dir {outputFolderValue}  --load_path "+MODEL_PATH\
                      +" {sizeParamValue} --write_result --dataset_name 'general' "


    #overides the env path
    @property
    def env_file(self):
        return ENV_FILE
    
    inputs = [
            desc.File(
                name="inputSfMData",
                label="SfMData",
                description="Input SfMData file.",
                value="",
                uid=[0],
                group=""
            ),
            desc.File(
                name="viewPairs",
                label="viewPairs",
                description="View pairs",
                value="",
                uid=[0],
            ),

            desc.FloatParam(
                name="minD",
                label="min depth",
                description="Min Depth",
                value=0.0,
                range=(0.0, 2048.0, 1.0),
                uid=[0],
                group=""
            ),
            desc.IntParam(
                name="stepsD",
                label="depth steps",
                description="depth steps",
                value=256,
                range=(0, 2048, 1),
                uid=[0],
                group=""
            ),
            desc.FloatParam(
                name="maxD",
                label="max depth",
                description="Max Depth",
                value=10.0,
                range=(0.0, 2048.0, 1.0),
                uid=[0],
                group=""
            ),
        
            desc.ChoiceParam(
                name='verboseLevel',
                label='Verbose Level',
                description='''verbosity level (fatal, error, warning, info, debug, trace).''',
                value='info',
                values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
                exclusive=True,
                uid=[0],
                )
            ]

    outputs = [
        desc.File(
            name="outputFolder",
            label="Output Folder",
            description="Path to a folder in which the computed results are stored.",
            value=desc.Node.internalFolder,
            uid=[],
        ),

        desc.StringParam(
            name="sizeParam",
            label="sizeParam",
            description="sizeParam",
            value="",
            uid=[],
        ),

        desc.File(
            name='depth',
            label='Depth maps',
            description='Generated depth maps.',
            semantic='image',
            value=desc.Node.internalFolder + '<VIEW_ID>_depthMap.exr',
            uid=[],
            group='',
            )   
    ]

    def processChunk(self, chunk):
        chunk.logManager.start(chunk.node.verboseLevel.value)
        if chunk.node.inputSfMData.value == "":
            raise RuntimeError('Must input SfM data')

        #FIXME: move this to mvsnet
        sfm_data=json.load(open(chunk.node.inputSfMData.value,"r"))
        (extrinsics, intrinsics, views_id, poses_ids, 
        intrinsics_ids, pixel_sizes_all_cams, images_size) = matrices_from_sfm_data(sfm_data, True)
        images_paths = [v['path'] for v in sfm_data["views"]]
        nb_views = len(images_paths)

        #set size param to avoid redim by default
        w=images_size[0][0]
        h=images_size[0][1]
        # doesnt work
        # chunk.node.sizeParam.value="--resize %d,%d --crop %d,%d"%(w,h,w,h)
        chunk.node._cmdVars["sizeParamValue"]="--resize %d,%d --crop %d,%d"%(w,h,w,h)
        #uppdate the cl
        self.buildCommandLine(chunk)
    
        #prepare views (using sfm order)
        os.makedirs(os.path.join(chunk.node.outputFolder.value, 'images'), exist_ok=True)
        os.makedirs(os.path.join(chunk.node.outputFolder.value, 'cams'), exist_ok=True)
        for j, (p, e, i) in enumerate(zip(images_paths, extrinsics, intrinsics)):
            #copy and rename images
            os.symlink(p, os.path.join(chunk.node.outputFolder.value, 'images', "%08d.jpg"%j) )#fixme: make sure we save in .png?
   
            min_depth = chunk.node.minD.value
            max_depth = chunk.node.maxD.value
            step_depth = chunk.node.stepsD.value
            depth_interval = (max_depth-min_depth)/step_depth

            #make view calib files and pairs
            with open(os.path.join(chunk.node.outputFolder.value, "cams", "%08d_cam.txt"%j), "w") as file:
                #convert intrinsic from mrrs to blended format
                #focal and pp in pixels
                i /= pixel_sizes_all_cams[j]
                i[2,2] = 1

                # inv cam
                e=np.linalg.inv(np.concatenate([e, [[0,0,0,1]]], axis=0))

                file.write("extrinsic\n")
                file.write(" ".join(format_float_array(e[0]))+"\n")
                file.write(" ".join(format_float_array(e[1]))+"\n")
                file.write(" ".join(format_float_array(e[2]))+"\n")
                file.write("0 0 0 1\n")

                file.write("\nintrinsic\n")              
                file.write(" ".join(format_float_array(i[0]))+"\n")
                file.write(" ".join(format_float_array(i[1]))+"\n")
                file.write(" ".join(format_float_array(i[2]))+"\n")
                file.write(f"\n{min_depth} {depth_interval} {step_depth} {max_depth}")

        #view pairs
        # chunk.node.viewPairs.value
        with open(os.path.join(chunk.node.outputFolder.value, "pair.txt"), "w") as file:
            
            if chunk.node.viewPairs.value == '':#by default exhaustive matching
                file.write(str(nb_views)+"\n")#write numb images
                for i in range(nb_views):
                    file.write(str(i)+"\n")# index of reference image n
                    views_and_score = [" "+str(j)+" 1.0" for j in range(nb_views) if j != i]
                    file.write(str(nb_views-1)+"".join(views_and_score)+"\n")# 10 best source images for reference image 0  ID0 SCORE0 ID1 SCORE1 ...
            else:
                #first element: view, other matching uid 
                with open(chunk.node.viewPairs.value, "r") as f:
                    pairs_raw = f.readlines()
                file.write(str(len(pairs_raw))+"\n")#sume views may be discarded
                pairs_uids={p[0]:p[1:] for p in [l.strip().strip("\n").split(' ') for l in pairs_raw]}
                for uid_0 in pairs_uids.keys():
                    uid_0_index = views_id.index(uid_0)
                    uid_n_indices = [views_id.index(u) for u in pairs_uids[uid_0]]
                    file.write(str(uid_0_index)+"\n")# index of reference image n
                    views_and_score = [" "+str(j)+" 1.0" for j in uid_n_indices]
                    file.write(str(len(uid_n_indices))+"".join(views_and_score)+"\n")
           

        #run the CL
        super().processChunk(chunk)

        #transform pfm outputs to exr output with matching filename    and res     
        for idx, vid in enumerate(views_id):
            depth_map_file = os.path.join(chunk.node.outputFolder.value, "%08d_flow3.pfm"%idx)
            # confidence_file = os.path.join(chunk.node.outputFolder.value, "%08d_flow3_prob.pfm"%vid)
            depth_map = open_depth_map(depth_map_file)
            output_depth_map_path = os.path.join(chunk.node.outputFolder.value, vid+'_depthMap.exr' )#'<VIEW_ID>_depthMap.exr',
            #resize to ouptut imaeg size
            depth_map = cv2.resize(depth_map, images_size[idx])

            #header
            depth_map_header={}
            depth_map_header["AliceVision:downscale"]=1
            camera_center = extrinsics[idx][0:3, 3].tolist()
            inverse_intr_rot = np.linalg.inv(intrinsics[idx] @ np.linalg.inv(extrinsics[idx][0:3, 0:3]))
            depth_map_header["AliceVision:CArr"] = camera_center
            depth_map_header["AliceVision:iCamArr"]= inverse_intr_rot

            save_exr(depth_map, output_depth_map_path, custom_header=depth_map_header)

     
        chunk.logManager.end()

