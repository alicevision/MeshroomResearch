__version__ = "3.0"

import os 
import json
import numpy as np

from meshroom.core import desc
import trimesh

from mrrs.core.geometry import *
from mrrs.core.ios import *
from mrrs.datasets import load_dataset

#FIXME:move this into  a command line node?
class LoadDataset(desc.Node):
    category = 'Meshroom Research'

    documentation = '''Util node to open datasets with different data from the images in the .sfm'''

    size = desc.DynamicNodeSize('sfmData')

    inputs = [

        desc.File(
            name="sfmData",
            label="sfmData",
            description="Input sfmData",
            value="",
            uid=[0],
        ),

        desc.ChoiceParam(
            name='datasetType',
            label='Dataset Type',
            description='''Dataset type''',
            value='blendedMVG',
            values=['blendedMVG', 'DTU', 'ETH3D', 'baptiste', 'alab', 'NERF'],
            exclusive=True,
            uid=[0],
        ),

        desc.IntParam(
            name='initSfmLandmarksVertices',
            label='Init Landmarks Vertices',
            description='''Will initalise sfmLandmarks by sampling points on mesh. 0 to deactivate''',
            value=1,
            range=(0, 1000000000, 1),
            uid=[0],
            advanced=True
        ),
        

        desc.BoolParam(
            name='initMasks',
            label='Init Masks',
            description='''If no masks in dataset, will initialise the masks using the values from the depth map (<=0) or the images (alpha<=0)''',
            value=True,
            uid=[0],
            advanced=True
        ),

        desc.BoolParam(
            name='landMarksProj',
            label='Landmarks Projections',
            description='''Will display point cloud or landmarks projection''',
            value=False,
            uid=[0],
            advanced=True
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
            advanced=True
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfMData',
            label='SfM Data',
            description='Path to the output sfmdata file',
            value=desc.Node.internalFolder + 'sfm.sfm',
            uid=[],
        ),

        desc.File(
            name='depthMapsFolder',
            label='Depth map folder',
            description='Output folder for loaded depth maps',
            value=os.path.join(desc.Node.internalFolder, 'depth_maps'),
            uid=[],
            # enabled=lambda attr: (attr.node.datasetType.value=='blendedMVG'), #FIXME: does not work!! doesnt actually hides in the node
        ),

        desc.File(
            name='mesh',
            label='Mesh',
            description='Loaded mesh.',
            value=os.path.join(desc.Node.internalFolder, 'mesh.ply'),
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
            uid=[],
        ),

        desc.File(
            name='maskFolder',
            label='Mask Folder',
            description='Image mask folder. The mask describes the visibility of the object to be observed, on each view.',
            value=os.path.join(desc.Node.internalFolder,'masks'),
            uid=[],
            # enabled=lambda attr: (attr.node.datasetType.value=='DTU'),
        ),

        #used for display
        desc.File(
            name='depthmapsDisplay',
            label='DepthMapsDisplay',
            description='Generated depth maps.',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'depth_maps', '<VIEW_ID>_depthMap.exr'),
            uid=[],
            advanced=True,
        ),

        desc.File(
            name='masksDisplay',
            label='MasksDisplay',
            description='Generated masks',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'masks', '<VIEW_ID>.png'),
            uid=[],
            advanced=True
        ),

        desc.File(
            name='landMarksProjDisplay',
            label='landMarksProjDisplay',
            description='Generated images for landmarl projection',
            semantic='image',
            value=os.path.join(desc.Node.internalFolder,
                               'lm_projs', '<VIEW_ID>.png'),
            uid=[],
            advanced=True,
            enabled=lambda attr: attr.node.landMarksProj.value,
        ),

        desc.File(
            name='meshDisplay',
            label='MeshDisplay',
            description='MeshDisplay',
            semantic='3D',
            value=os.path.join(desc.Node.internalFolder,
                               'mesh_display.ply'),
            uid=[],
            advanced=True
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if chunk.node.sfmData.value == '':
            chunk.logger.warning(
                'No input InputFolder or sfmData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """

        chunk.logManager.start(chunk.node.verboseLevel.value)
        if not self.check_inputs(chunk):
            return False

        print("*LoadDataset Starting")

        print("**Importing data")
        # Load SFM data from JSON file 
        sfm_data = json.load(open(chunk.node.sfmData.value, "r"))
        #load datset data (may update sfm_data!)
        gt_data, sfm_data = load_dataset(sfm_data, chunk.node.datasetType.value)
        
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
        if  chunk.node.initSfmLandmarksVertices.value != 0: 
            print("**Initialising random SfM landmarks from geometry")
            if "landmarks" in gt_sfm_data:
                raise RuntimeError("Landmarks already in sfmData")
            if gt_data["mesh"] is None:
                raise RuntimeError("Cannot initialise landmarks with no geometry")
            
            vertices = gt_data["mesh"].vertices.copy()
            #meshes in meshroom are in the CG cs, landmarks are CV
            vertices=transform_cg_cv(vertices)

            #sampling from mesh or or point cloud
            if isinstance(gt_data["mesh"], trimesh.PointCloud) :
                vertices_indxs = np.random.choice(list(range(vertices.shape[0])), chunk.node.initSfmLandmarksVertices.value)
                vertices = vertices[vertices_indxs]
            else:
                vertices =  random_sample_points_mesh_2([vertices, gt_data["mesh"].faces],
                                                        chunk.node.initSfmLandmarksVertices.value)
            #compute projections
            vertices_projections = [camera_projection(vertices, gt_data["extrinsics"][oi], gt_data["intrinsics"][oi]) for oi in range(len(views_id))]

            if chunk.node.landMarksProj.value:
                print("**Exporting %d SfM landmarks projections"%(vertices.shape[0]))
                os.makedirs(os.path.dirname(chunk.node.landMarksProjDisplay.value), exist_ok=True)
                size_lm=int(np.ceil(gt_data["image_sizes"][0][0]/400))
                for projs, view in zip(vertices_projections, gt_sfm_data["views"]):
                    prj_img = open_image(view["path"], to_srgb=True)
                    for (x,y) in projs[0]:
                        x=int(x)
                        y=int(y)
                        if x-size_lm<0 or y-size_lm<0 or x+size_lm >= gt_data["image_sizes"][0][0] or y+size_lm >= gt_data["image_sizes"][0][1]:
                            continue
                        prj_img[y-size_lm:y+size_lm,x-size_lm:x+size_lm,1] = 255
                    output_image = os.path.join(os.path.dirname(chunk.node.landMarksProjDisplay.value), view["viewId"]+".png")
                    save_image(output_image, prj_img)

            print("**Exporting %d SfM landmarks"%(vertices.shape[0]))
            structure = []
            for vi, v in enumerate(vertices):#FIXME: slow  
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
        with open(os.path.join(chunk.node.outputSfMData.value), 'w') as f:
            json.dump(gt_sfm_data, f, indent=4)

        # Save depth maps if any
        if "depth_maps" in gt_data:
            print("**Writting depth maps")
            os.makedirs(chunk.node.depthMapsFolder.value, exist_ok=True)
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
                save_exr(depth_map_gt, os.path.join(chunk.node.depthMapsFolder.value, 
                        str(view_id) + "_depthMap.exr"), custom_header=depth_meta)

        if "masks" not in gt_data and chunk.node.initMasks.value :
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
            os.makedirs(chunk.node.maskFolder.value, exist_ok=True)
            for mask, view_id in zip(gt_data["masks"], views_id) :
                #if we have a list of image, open them
                if isinstance(mask, str):
                    mask=open_image(mask)
                save_image(os.path.join(chunk.node.maskFolder.value, str(view_id) + ".png"), mask)


        #Save ground truth mesh as obj if any
        if "mesh" in gt_data :
            print("**Writting mesh")
            gt_data["mesh"].export(chunk.node.mesh.value)    
            
            #create ply if the mesh is a point cloud (poitn cloud display not supported...)
            if isinstance(gt_data["mesh"], trimesh.PointCloud) or len(gt_data["mesh"].faces) == 0:
                print("***Writting point cloud preview")

                #We have a special viewer for point cloud in ply
                new_display_filename = chunk.node.meshDisplay.value.split(".")[0]+".pc.ply"
                gt_data["mesh"].export(new_display_filename)
                chunk.node.meshDisplay.value=new_display_filename

                #Fit spheres
                # SAMPLES = 10000

                # print("Kmeans")
                # from scipy.cluster.vq import  kmeans2
                # # centroids, labels = trimesh.points.k_means(gt_data["mesh"].vertices, SAMPLES, iter=1)
                # centroids, labels = kmeans2(gt_data["mesh"].vertices, SAMPLES, iter=1)

                # print("Creating spheres")
                # spheres = []   
                # for label in range(SAMPLES):    
                #     print("%d/%d"%(label,SAMPLES))
                #     vertices = gt_data["mesh"].vertices[labels==label] 
                #     if vertices.shape[0]>3:
                #         # center, radius, error =trimesh.nsphere.fit_nsphere(vertices)
                #         center = np.mean(vertices, axis=0)
                #         #radius is s
                #         radius = np.amin(np.amax(vertices, axis=0) - np.amin(vertices, axis=0))/2
                #         sphere = trimesh.creation.uv_sphere(radius)
                #         sphere.apply_translation(center)
                #         spheres.append(sphere)
                # display_mesh=trimesh.util.concatenate(spheres)
                # display_mesh.export(chunk.node.meshDisplay.value)

      
            else:
                gt_data["mesh"].export(chunk.node.meshDisplay.value)


     
            
        print("*LoadDataset ends")

