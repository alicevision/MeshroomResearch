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

from mrrs.core.geometry import camera_deprojection, distance_point_to_line, make_unit, ray_triangles_intersect
from mrrs.core.ios import matrices_from_sfm_data

DEBUG = True
LM_CONFIDENCE_THRESHOLD = 0.1
FAR_AWAY = 10

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
        desc.File(#FIXME: used for display only
            name='outputCorrespondancesMesh',
            label='Output Correspondances Mesh',
            description='Path to the output Correspondances mesh',
            value=os.path.join(desc.Node.internalFolder, "corespondances.obj"),
            uid=[],
        )
    ]

    def processChunk(self, chunk):
        try:
            ##Loading
            #load sfm data
            with open(chunk.node.inputSfM.value,"r") as json_file:
                sfm_data = json.load(json_file)
            extrinsics, intrinsics, _, _, _, pixel_sizes = matrices_from_sfm_data(sfm_data)
            images = [view["path"] for view in sfm_data["views"]]
            #load frame list
            with open(os.path.join(chunk.node.inputFolder.value,"project.yaml"), "r") as f :
                frame_list = yaml.load(f, Loader=SafeLoader)["input"]["inputs"][0]["framesList"]
            #load yaml for bounding box for tube folder
            with open(os.path.join(chunk.node.inputFolder.value,"tubes.yaml"), "r") as f :
                frames = yaml.load(f, Loader=SafeLoader)["tubes"]["face01"]["frames"]#load nounding boxes
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
            landmark_folder = os.path.join(chunk.node.inputFolder.value, "tubes/face01/cache/landmarks/fan3d/cam0/" )#FIXME: hardcoded 
            landmarks={}
            nb_landmarks=-1
            for image, origin in zip(frame_list, origins):
                landmark_file = os.path.join(landmark_folder,os.path.basename(image).split(".")[0]+".json")
                landmarks[image]=None
                try:
                    with open(landmark_file, "r") as lm_content:
                        lm_data = json.load(lm_content)
                        landmark_data = lm_data["landmarks"]["values"]
                    if nb_landmarks == -1:
                        nb_landmarks=len(landmark_data)
                    elif nb_landmarks!=len(landmark_data):
                        raise RuntimeError("Inconsitent number of flandmarks")
                    landmarks[image] = [ [int(l[0]+origin[0]), int(l[1]+origin[1]), l[2]] for l in landmark_data]#apply offset from bb and cast to int (optional?)

                    if DEBUG:
                        from PIL import Image
                        image_size = Image.open(image).size
                        im = np.asarray(Image.open(image))
                        for lm in landmarks[image]:
                            if lm[0]>0 and lm[0] < image_size[0] and lm[1]>0 and lm[1] < image_size[1]:
                                im[lm[1]-5:lm[1]+5, lm[0]-5:lm[0]+5, :]=(255,0,0)
                        Image.fromarray(im).save(chunk.node.outputFolder.value+"/"+os.path.basename(image))
                except Exception as e:
                    chunk.logger.warning('Something whent wrong with file '+landmark_file+" skipping:"+str(e))

            #load mesh
            mesh = load(chunk.node.inputMesh.value)
            vertices = mesh.vertices
            #rotate because MR export mesh in CG vs CV for sfm
            transform_mat = np.asarray([[1,0,0],[0,-1,0],[0,0,-1]])
            vertices=np.transpose(transform_mat@np.transpose(vertices))

            # #"get ray-triangle intersections
            # triangles = vertices[mesh.faces]
            # faces_indices = np.arange(triangles.shape[0])

            # ray_vertices_total_distance = np.zeros((nb_landmarks, vertices.shape[0]))
            # for lms, extrinsic, intrinsic, px_size, image  in zip(landmarks, extrinsics, intrinsics, pixel_sizes, images):
            #     print("Image "+image)
            #     if extrinsic is None:
            #         print("No calibration for "+image+" skipping")
            #         continue
            #     if lms is None:
            #         print("No landmarks for "+image+" skipping")
            #         continue
            #     origin = extrinsic[0:3,3]
            #     lms = np.asarray(lms)
            #     lms_conf = lms[:,2]
                
            #     point_1m = camera_deprojection(np.transpose(lms[:,0:2]), np.asarray([FAR_AWAY]), 
            #                extrinsic, intrinsic, px_size)#fixme: could get line direclty
            #     for li,l in enumerate(point_1m):
            #         if lms_conf[li]<LM_CONFIDENCE_THRESHOLD:
            #             print("Unreliable landmark,  %02d/%02d skipping"%(li, point_1m.shape[0]))
            #             continue
            #         print("Computing intersections for landmark %02d/%02d"%(li, point_1m.shape[0]), end="\r")
            #         d=make_unit(origin-l)
            #         ray = np.asarray((origin, d))
            #         intersects, dists =  ray_triangles_intersect(ray,triangles)#intersection test and distance to face
            #         if not np.any(intersects):
            #             print("No intersection found for lm %d on %s"%(li,image))
            #             continue
            #         #get intersecting closest to the cam
            #         intersect_face_index=faces_indices[intersects][np.argmin(dists[intersects])]
            #         #save distance with all the points 
            #         intersect_face = mesh.faces[intersect_face_index]
            #         intersect_vertices = vertices[intersect_face]
            #         if DEBUG:
            #             with open(chunk.node.outputFolder.value+"/"+"lm_%d_"%li+os.path.basename(image)+"_intersect.obj", "w+") as f:
            #                 for v in intersect_vertices:
            #                     f.write("v %f %f %f\n"%(v[0], v[1], v[2]))
            #                 f.write("v %f %f %f\n"%(origin[0],origin[1],origin[2]))
            #                 f.write("f 1 2 3\n")
            #         #intersect_vertices_dist 
            #         ray_vertices_total_distance[li, intersect_face] += distance_point_to_line(intersect_vertices,origin, l)

            #     if DEBUG:
            #         with open(chunk.node.outputFolder.value+"/"+os.path.basename(image)+".obj", "w") as f:
            #             f.write("v %f %f %f\n"%(origin[0],origin[1],origin[2]))
            #             for li,l in enumerate(point_1m):
            #                 f.write("v %f %f %f\n"%(l[0], l[1], l[2]))
            #     ray_vertices_total_distance[ray_vertices_total_distance==0] = np.infty


            ##Compute equivalence
            #compute the vertices in the mesh closest to the ray
            ray_vertices_total_distance = np.zeros((nb_landmarks, vertices.shape[0]))
            
            for extrinsic, intrinsic, px_size, image  in zip(extrinsics, intrinsics, pixel_sizes, images):
                print("Image "+image)
                if image not in landmarks.keys():
                    print("No landmark frame named "+image+" from facecapture landmarks")
                    continue
                lms = landmarks[image]#getting corresponding lms
                if extrinsic is None:
                    print("No calibration for "+image+" skipping")
                    continue
                if lms is None:
                    print("No landmarks for "+image+" skipping")
                    continue

                origin = extrinsic[0:3,3]
                lms = np.asarray(lms)
                lms_conf = lms[:,2]
                point_1m = camera_deprojection(np.transpose(lms[:,0:2]), np.asarray([FAR_AWAY]), 
                                               extrinsic, intrinsic, px_size)#fixme: could get line direclty
                distances_frame = []#FIXME: tmp
                for li,l in enumerate(point_1m):
                    if lms_conf[li]<LM_CONFIDENCE_THRESHOLD:
                        print("Unreliable landmark,  %02d/%02d skipping"%(li, point_1m.shape[0]))
                        continue
                    print("Computing distances for landmark %02d/%02d"%(li, point_1m.shape[0]), end="\r")
                    d = distance_point_to_line(vertices,origin, l)
                    distances_frame.append(d)
                    ray_vertices_total_distance[li,:] += d
                if DEBUG:
                    with open(chunk.node.outputFolder.value+"/"+os.path.basename(image)+".obj", "w") as f:
                        f.write("v %f %f %f\n"%(origin[0],origin[1],origin[2]))
                        for li,l in enumerate(point_1m):
                            f.write("v %f %f %f\n"%(l[0], l[1], l[2]))
                        for li,l in enumerate(point_1m):
                            f.write("l %d %d\n"%(1, li+2))
                        closest_idx_frame = np.argmin(distances_frame, axis=-1)
                        for c in closest_idx_frame:
                            f.write("v %f %f %f 0 0 255\n"%(vertices[c][0], vertices[c][1], vertices[c][2]))


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
           
            with open(chunk.node.outputCorrespondancesMesh.value, "w") as f:
                for v in vertices[closest_idx]:
                    f.write("v %f %f %f 1 0 0\n"%(v[0], v[1], v[2]))
            print('DONE')
        finally:
            chunk.logManager.end()



