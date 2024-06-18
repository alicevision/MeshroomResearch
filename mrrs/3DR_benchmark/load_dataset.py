import json
import argparse
import os

import trimesh
import numpy as np

from datasets import load_dataset
from mrrs.core.geometry import camera_projection, random_sample_points_mesh_2, transform_cg_cv
from mrrs.core.ios import open_depth_map, open_image, save_exr, save_image, sfm_data_from_matrices


parser = argparse.ArgumentParser()
parser.add_argument(
    '--inputSfM',
    help="",
)
parser.add_argument(
    '--datasetType',
    help="",
)

parser.add_argument(
    '--initSfmLandmarksVertices',
    help="",
)
parser.add_argument(
    '--landMarksProj',
    help="",
)
parser.add_argument(
    '--outputSfMData',
    help="",
)
parser.add_argument(
    '--depthMapsFolder',
    help="",
)
parser.add_argument(
    '--initMasks',
    help="",
)
parser.add_argument(
    '--maskFolder',
    help="",
)
parser.add_argument(
    '--mesh',
    help="",
)
parser.add_argument(
    '--meshDisplay',
    help="",
)
parser.add_argument(
    '--landMarksProjDisplay',
    help="",
)
args = parser.parse_args()    

sfm_data=args.inputSfM
dataset_type = args.datasetType
init_sfm_lm_vertices = int(args.initSfmLandmarksVertices)
lm_proj = args.landMarksProj
outputSfMData = args.outputSfMData
depthMapsFolder = args.depthMapsFolder
initMasks = bool(args.initMasks)
maskFolder=args.maskFolder
mesh = args.mesh
meshDisplay = args.meshDisplay
lm_proj_display=args.landMarksProjDisplay


print("*LoadDataset Starting")

print("**Importing data")
# Load SFM data from JSON file 
sfm_data = json.load(open(sfm_data, "r"))
#load datset data (may update sfm_data!)
gt_data, sfm_data = load_dataset(sfm_data, dataset_type)

# Load meshroom ids
extrinsics_id = [v["poseId"] for v in sfm_data["views"]]
instrinsics_id = [v["intrinsicId"] for v in sfm_data["views"]]
views_id = [v["viewId"] for v in sfm_data["views"]]

print("**Exporting data")
#Generate SFM data from matrices
if not (len(gt_data["intrinsics"]) == len(gt_data["extrinsics"]) ==  len(gt_data["image_sizes"])):
    raise RuntimeError("Mismatching number of parameters for the sfmData ")
#note: will copy sfm_data
gt_sfm_data = sfm_data_from_matrices(gt_data["extrinsics"], gt_data["intrinsics"], extrinsics_id, instrinsics_id, 
                                        gt_data["image_sizes"], sfm_data, sensor_width=gt_data["sensor_size"])

#Add dummy resection id (for display)
for i, v in enumerate(gt_sfm_data["views"]):
    gt_sfm_data["views"][i]["resectionId"]=str(i)

#Exports
if  init_sfm_lm_vertices != 0: 
    print("**Initialising random SfM landmarks from geometry")
    if "structure" in gt_sfm_data:
        raise RuntimeError("Landmarks already in sfmData")
    if gt_data["mesh"] is None:
        raise RuntimeError("Cannot initialise landmarks with no geometry")
    
    vertices_lm = gt_data["mesh"].vertices.copy()
    #meshes in meshroom are in the CG cs, landmarks are CV
    vertices_lm=transform_cg_cv(vertices_lm)

    #sampling from mesh or or point cloud
    if isinstance(gt_data["mesh"], trimesh.PointCloud) :
        vertices_indxs = np.random.choice(list(range(vertices_lm.shape[0])), init_sfm_lm_vertices)
        vertices_lm = vertices_lm[vertices_indxs]
    else:
        vertices_lm =  random_sample_points_mesh_2([vertices_lm, gt_data["mesh"].faces],
                                                init_sfm_lm_vertices)
    #compute projections
    vertices_projections = [camera_projection(vertices_lm, gt_data["extrinsics"][oi], gt_data["intrinsics"][oi]) for oi in range(len(views_id))]

    if lm_proj:
        print("**Exporting %d SfM landmarks projections"%(vertices_lm.shape[0]))
        os.makedirs(os.path.dirname(lm_proj_display), exist_ok=True)
        size_lm=int(np.ceil(gt_data["image_sizes"][0][0]/800))
        lm_color = np.random.random_integers(low=0, high=255, size=[vertices_lm.shape[0], 3])
        for projs, view in zip(vertices_projections, gt_sfm_data["views"]):
            prj_img = open_image(view["path"], to_srgb=True)
            for i, (x,y) in enumerate(projs[0]):
                x=int(x)
                y=int(y)
                if x-size_lm<0 or y-size_lm<0 or x+size_lm >= gt_data["image_sizes"][0][0] or y+size_lm >= gt_data["image_sizes"][0][1]:
                    continue
                prj_img[y-size_lm:y+size_lm,x-size_lm:x+size_lm,0] = lm_color[i,0]
                prj_img[y-size_lm:y+size_lm,x-size_lm:x+size_lm,1] = lm_color[i,1]
                prj_img[y-size_lm:y+size_lm,x-size_lm:x+size_lm,2] = lm_color[i,2]
            output_image = os.path.join(os.path.dirname(lm_proj_display), view["viewId"]+".png")
            save_image(output_image, prj_img)

    print("**Exporting %d SfM landmarks"%(vertices_lm.shape[0]))
    structure = []
    for vi, v in enumerate(vertices_lm):#FIXME: slow  
        landmark = {}
        landmark["landmarkId"] = str(vi)
        landmark["descType"] = "unknown" 
        landmark["color"] = ["255", "0", "0"]
        landmark["X"] = [str(x) for x in v]
        landmark["observations"] = []
        #create dummy obs in all views 
        for oi, i in enumerate(views_id):
            #sanity check, the landmark is visible in the view
            x,y=vertices_projections[oi][0][vi]
            if x<0 or y<0 or x>gt_data["image_sizes"][0][0] or y > gt_data["image_sizes"][0][1]:
                continue
            obs =  {"observationId": str(i),
                    "featureId": str(oi),
                    "x": [str(x),str(y)]}
            landmark["observations"].append(obs)
        structure.append(landmark)
    gt_sfm_data["structure"] = structure

# Save the generated SFM data to JSON file
print("**Writting sfm")
with open(os.path.join(outputSfMData), 'w') as f:
    json.dump(gt_sfm_data, f, indent=4)

# Save depth maps if any
if "depth_maps" in gt_data:
    print("**Writting depth maps")
    os.makedirs(depthMapsFolder, exist_ok=True)
    for view_id, depth_map, gt_extrinsic, gt_intrinsic in \
        zip(views_id, gt_data["depth_maps"], gt_data["extrinsics"], gt_data["intrinsics"]):
        if os.path.exists(depth_map):
            depth_map_gt = open_depth_map(depth_map)
        else:
            continue
        #FIXME: move to IO?
        #add flags to the depth map for display
        camera_center = gt_extrinsic[0:3, 3]
        inverse_intr_rot = np.linalg.inv(
            gt_intrinsic @ np.linalg.inv(gt_extrinsic[0:3, 0:3]))
        #https://openimageio.readthedocs.io/en/v2.4.6.1/imageoutput.html
        depth_meta = {
            "AliceVision:CArr": camera_center,
            "AliceVision:iCamArr": inverse_intr_rot,
            "AliceVision:downscale": 1
        }
        save_exr(depth_map_gt, os.path.join(depthMapsFolder, 
                str(view_id) + "_depthMap.exr"), custom_header=depth_meta)

if "masks" not in gt_data and initMasks :
    from concurrent.futures import ThreadPoolExecutor
    from threading import Thread
    #try to see if image has alpha
    image = open_image(gt_sfm_data["views"][0]["path"])
    if image.shape[-1] == 4:
        print("**Init masks from images")
        #note: process is io bound
        def open_mask(view):
            return 255*(open_image(view["path"])[:,:,3]>0)
        #FIXME: this blocks main thread
        with ThreadPoolExecutor() as threadpool:#auto max worker
            gt_data["masks"]=[r for r in threadpool.map(open_mask, gt_sfm_data["views"])]

        print("**Done init masks from images")    
    #else try to see if image has depth maps
    elif "depth_maps" in gt_data:
        print("**Init masks from depth maps")
        def open_mask(view):
            return 255*(open_depth_map(depth_map)>0)
        #FIXME: this blocks main thread
        with ThreadPoolExecutor() as threadpool:#auto max worker
            gt_data["masks"]=[r for r in threadpool.map(open_mask, gt_sfm_data["views"])]
    else:
        raise RuntimeError("Could not initialise masks from image or depth maps")

#Save image masks if any
if "masks" in gt_data:
    print("**Writting masks")
    os.makedirs(maskFolder, exist_ok=True)
    for mask, view_id in zip(gt_data["masks"], views_id) :
        #if we have a list of image, open them
        if isinstance(mask, str):
            mask=open_image(mask)
        save_image(os.path.join(maskFolder, str(view_id) + ".png"), mask)


#Save ground truth mesh as obj if any
if "mesh" in gt_data :
    print("**Writting mesh")
    gt_data["mesh"].export(mesh)    
    
    #create ply if the mesh is a point cloud (poitn cloud display not supported...)
    if isinstance(gt_data["mesh"], trimesh.PointCloud) or len(gt_data["mesh"].faces) == 0:
        print("***Writting point cloud preview")

        #We have a special viewer for point cloud in ply
        new_display_filename = meshDisplay.value.split(".")[0]+".pc.ply"
        gt_data["mesh"].export(new_display_filename)
        meshDisplay.value=new_display_filename


    else:
        gt_data["mesh"].export(meshDisplay)

print("*LoadDataset ends")

