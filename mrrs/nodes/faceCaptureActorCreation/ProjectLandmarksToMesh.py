"""
Copy data that is not exposed from line_point_0 node output folder.
Usefull for exposing intermediate data.
"""
__version__ = "3.0"


import os
import json
import yaml
from yaml.loader import SafeLoader
import numpy as np
from trimesh import load

from meshroom.core import desc

from mrrs.core.geometry import camera_deprojection, distance_point_to_line
from mrrs.core.ios import matrices_from_sfm_data

DEBUG = False

class ProjectLandmarksToMesh(desc.Node):
    category = 'Meshroom Research'

    documentation = '''This nodes projects landmarks from facecapture into the closest mesh vertex.'''

    inputs = [
        desc.File(
            name='inputFolder',
            label='Input FC Project Folder',
            description='''Folder from facecapture''',
            value='',
            uid=[0],
        ),

        desc.File(
            name='inputMesh',
            label='Input Mesh',
            description='''Input Mesh''',
            value='',
            uid=[0],
        ),

        desc.File(
            name='inputSfM',
            label='Input SfM',
            description='''Input SfM''',
            value='',
            uid=[0],
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output Folder',
            description='Path to the output folder',
            value=desc.Node.internalFolder,
            uid=[],
        ),

        desc.File(
            name='outputCorrespondances',
            label='Output Correspondances',
            description='Path to the output Correspondances',
            value=os.path.join(desc.Node.internalFolder, "landmarks.json"),
            uid=[],
        ),
    ]

    def processChunk(self, chunk):
        try:
            ##Loading
            #load sfm data
            with open(chunk.node.inputSfM.value,"r") as json_file:
                sfm_data = json.load(json_file)
            extrinsics, intrinsics, _, _, _, pixel_sizes = matrices_from_sfm_data(sfm_data)
            images = [view["path"] for view in sfm_data["views"]]

            #load yaml for bounding box for tube folder 
            with open(os.path.join(chunk.node.inputFolder.value,"tubes.yaml"), "r") as f :
                frames = yaml.load(f, Loader=SafeLoader)["tubes"]["face"]["frames"]
                rects = [f['rect'] for f in frames[0]]
            scale = 2 #note in FC, the scale is harcoded to 2
            scale = 0.5 * (scale - 1)
            origins = []
            for rect in rects:
                width = rect[2] - rect[0]
                height = rect[3] - rect[1]
                rect[0] -= width * scale
                rect[1] -= height * scale
                if rect[0] < 0: rect[0] = 0
                if rect[1] < 0: rect[1] = 0
                origins.append(rect[0:2])

            #load json landmark from folder
            landmark_folder = os.path.join(chunk.node.inputFolder.value, "tubes/face/cache/landmarks/fan3d/cam0/" )#FIXME: hardcoded 
            landmarks=[]
            nb_landmarks=-1
            for image, origin in zip(images, origins):
                landmark_file = os.path.join(landmark_folder,os.path.basename(image).split(".")[0]+".json")
                landmark=None
                try:
                    with open(landmark_file, "r") as lm_content:
                        lm_data = json.load(lm_content)
                        landmark = lm_data["landmarks"]["values"]
                    if nb_landmarks == -1:
                        nb_landmarks=len(landmark)
                    elif nb_landmarks!=len(landmark):
                        raise RuntimeError("Inconsitent number of flandmarks")
                    landmark = [ [int(l[0]+origin[0]), int(l[1]+origin[1]), l[2]] for l in landmark]#apply offset from bb
                except Exception as e:
                    chunk.logger.warning('Something whent wrong with file '+landmark_file+" skipping:"+str(e))
                landmarks.append(landmark)
                # if DEBUG:
                #     from PIL import Image
                #     image_size = Image.open(image).size
                #     im = np.asarray(Image.open(image))
                #     for lm in landmark:
                #         if lm[0]>0 and lm[0] < image_size[0] and lm[1]>0 and lm[1] < image_size[1]:
                #             im[lm[1]-5:lm[1]+5, lm[0]-5:lm[0]+5]=(255,0,0)
                #     Image.fromarray(im).save(chunk.node.outputFolder.value+"/"+os.path.basename(image))
            
            #load mesh 
            mesh = load(chunk.node.inputMesh.value)
            vertices = mesh.vertices
            #rotate because MR export meshed in CG vs CV for sfm
            transform_mat = np.asarray([[1,0,0],[0,-1,0],[0,0,-1]])
            vertices=np.transpose(transform_mat@np.transpose(vertices))

            ##Compute equivalence
            #compute the vertices in the mesh closest to the ray
            # closest_per_view = [] #FIXME: save distances instead? and take the argmin at the end
            ray_vertices_total_distance = np.zeros((nb_landmarks, vertices.shape[0]))
            FAR_AWAY = 10
            for lms, extrinsic, intrinsic, px_size, image  in zip(landmarks, extrinsics, intrinsics, pixel_sizes, images):
                print("Image "+image)
                if extrinsic is None:
                    print("No calibration for "+image+" skipping")
                    continue
                if lms is None:
                    print("No landmarks for "+image+" skipping")
                    continue
                origin = extrinsic[0:3,3]
                lms = np.asarray(lms)
                point_1m = camera_deprojection(np.transpose(lms[:,0:2]), np.asarray([FAR_AWAY]), 
                           extrinsic, intrinsic, px_size)#fixme: could get line direclty
                for li,l in enumerate(point_1m):
                    print("Computing distances for landmark %02d/%02d"%(li, point_1m.shape[0]), end="\r")
                    ray_vertices_total_distance[li,:] += distance_point_to_line(vertices,origin, l)
                if DEBUG:
                    with open(chunk.node.outputFolder.value+"/"+os.path.basename(image)+".obj", "w") as f:
                        f.write("v %f %f %f\n"%(origin[0],origin[1],origin[2]))
                        for li,l in enumerate(point_1m):
                            f.write("v %f %f %f\n"%(l[0], l[1], l[2]))
                        for li,l in enumerate(point_1m):
                            f.write("l %d %d\n"%(1, li+2))

            closest_idx= np.argmin(ray_vertices_total_distance, axis=-1)
            if DEBUG:
                with open(chunk.node.outputFolder.value+"/"+os.path.basename(image)+".obj", "w") as f:
                    for c in closest_idx:
                        f.write("v %f %f %f 0 0 255\n"%(vertices[c][0], vertices[c][1], vertices[c][2]))

            ##Save results
            print("Saving")
            with open(chunk.node.outputCorrespondances.value, "w") as f:
                f.write(json.dumps({"idx_to_landmark_verts":closest_idx.tolist()}))
            if DEBUG:
                #debug export mesh
                mesh.vertices = vertices
                mesh.export(chunk.node.outputFolder.value+"/mesh.obj")
                #debug export landmarks vertices
                with open(chunk.node.outputFolder.value+"/corresp.obj", "w") as f:
                    for v in vertices[closest_idx]:
                        f.write("v %f %f %f 1 0 0\n"%(v[0], v[1], v[2]))
            print('DONE')
        finally:
            chunk.logManager.end()



