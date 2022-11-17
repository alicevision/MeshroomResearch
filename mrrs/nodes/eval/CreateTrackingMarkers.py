"""
This node creates 3d markers from a given set of 3d landmarks.
Usefull to test cam track.
To be paired with an sfm transform that "straigthen" everything.
"""
__version__ = "3.0"

import json
import os

from meshroom.core import desc
from mrrs.core.geometry import *
from mrrs.core.ios import *


def filter_landmarks_per_tile(landmarks, nb_voxels, nb_landmarks_per_voxels):
    """
    Will filter out landmarks such that we only have one landmark n per voxel.
    Will select the longest track by default.
    Assumes landmarks sorted by trakc length.
    """
    sfm_range = (np.amin(landmarks, axis=0), np.amax(landmarks, axis=0))
    sfm_step = (sfm_range[1]-sfm_range[0])/nb_voxels
    final_landmarks_list = []
    for voxel_x in np.arange(sfm_range[0][0], sfm_range[1][0], sfm_step[0]):
        for voxel_y in np.arange(sfm_range[0][1], sfm_range[1][1], sfm_step[1]):
            for voxel_z in np.arange(sfm_range[0][2], sfm_range[1][2], sfm_step[2]):
                print("Filtering for voxel %f-%f %f-%f %f-%f"%(voxel_x, voxel_x+sfm_step[0],
                                                               voxel_y, voxel_y+sfm_step[1],
                                                               voxel_z, voxel_z+sfm_step[2]))
                landmarks_inside = landmarks[     (voxel_x<=landmarks[:, 0])&(landmarks[:, 0]<voxel_x+sfm_step[0])
                                                & (voxel_y<=landmarks[:, 1])&(landmarks[:, 1]<voxel_y+sfm_step[1])
                                                & (voxel_z<=landmarks[:, 2])&(landmarks[:, 2]<voxel_z+sfm_step[2])
                                            ]
                print("%d landmarks found"%len(landmarks_inside))
                if len(landmarks_inside) > 0:
                    final_landmarks_list += list(landmarks_inside[:min(nb_landmarks_per_voxels, len(landmarks_inside))])
    return final_landmarks_list


def get_landmarks_from_sfm_data(sfm_data):
    """
    Get landmarks (sorted by track length)
    """
    landmarks = []
    landmarks_track_length = []
    for landmark in sfm_data["structure"]:
        landmarks_track_length.append(len(landmark["observations"]))
        landmarks.append(landmark["X"])
    landmarks = np.asarray(landmarks, dtype=np.float32)
    landmarks_track_length = np.asarray(landmarks_track_length, dtype=np.int32)
    landmark_index_sort = np.argsort(landmarks_track_length)[::-1]
    landmarks_track_length = landmarks_track_length[landmark_index_sort]
    landmarks = landmarks[landmark_index_sort]
    return landmarks


def display_track_cones(landmarks, n=1, scene_tiles=3):
    """
    Will return point coordinates corresponding to the longest landmarks.
    Also make sure the points are uniformly distributed, in the scene:
    will only display n points per voxels.
    """
    if scene_tiles is not None:
        landmarks = filter_landmarks_per_tile(landmarks, scene_tiles, n)
    else:
        landmarks = landmarks[:n]
    cones = []
    for landmark_index, landmark in enumerate(landmarks):
        cone = {"type": "cone",
                "name": "landmark_"+str(landmark_index),#FIXME: actual index
                "coordinates": landmark.tolist()}#coordinate is the point coordinates here
        cones.append(cone)
    return cones


def display_track_box(landmarks, n_planes=10):
    """
    Display boxes on dominant planes
    """
    pass


def draw_on_images(json_display, views_id, views_path, extrinsics_all_cams,
                    intrinsics_all_cam, pixel_sizes_all_cams, output_folder):
    """
    Plot the projection of 3D landmarks onto an image
    """
    object_colors = (np.random.random([len(json_display), 3])*255).astype(np.int32)
    for view_id, view_path, extrinsic, intrinsic in zip(views_id, views_path, extrinsics_all_cams, intrinsics_all_cam):
        image = open_image(view_path)
        # get the projection
        for display_object, object_color in zip(json_display, object_colors):
            if display_object["type"] == "point":
                coordinates = display_object["coordinates"]
                # landmark_projected
                point_on_cam, z = camera_projection(np.asarray([coordinates], np.float32), extrinsic, intrinsic, pixel_sizes_all_cams[0])
                point_on_cam = point_on_cam[0]
                # discard unseen pointss
                if point_on_cam[0]<0 or point_on_cam[1]<0:
                    continue
                if point_on_cam[0] >= image.shape[1] or point_on_cam[1] >= image.shape[0]:
                    continue
                if z[0] <= 0:
                    continue
                image[point_on_cam[1]-5:point_on_cam[1]+5, point_on_cam[0]-5:point_on_cam[0]+5] = object_color
            elif display_object["type"] == "cone":
                coordinates = display_object["coordinates"]
                point_on_cam, z = camera_projection(np.asarray(coordinates, np.float32), extrinsic, intrinsic, pixel_sizes_all_cams[0])
                # discard unseen pointss
                if np.any(point_on_cam[:,0]<0) or np.any(point_on_cam[:,1]<0):
                    continue
                if np.any(point_on_cam[:,0]>=image.shape[1]) or np.any(point_on_cam[:,1]>=image.shape[0]):
                    continue
                if np.any(z<=0):
                    continue
                image[point_on_cam[0,1]-5:point_on_cam[0,1]+5, point_on_cam[0,0]-5:point_on_cam[0,0]+5] = object_color
            else:
                raise RuntimeError("Object vizualisation not supported yet")

        save_image(os.path.join(output_folder, view_id+".png"), image)


class CreateTrackingMarkers(desc.Node):

    category = 'Evaluation'

    documentation = '''This node places some objects in the scene using the landmarks of the sfm.'''

    inputs = [

        desc.File(
            name='sfmData',
            label='SfmData',
            description='Input sfm file.',
            value=desc.Node.internalFolder,
            uid=[],
        ),


        desc.ChoiceParam(
            name='mode',
            label='Display Mode',
            description='''Mode to display over the images''',
            value='display_track_cones',
            values=['display_track_cones'],#TODO: optional paramers
            exclusive=True,
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
            name='outputFile',
            label='Output Json',
            description='Output file to place track info to',
            value=os.path.join(desc.Node.internalFolder, "track_objects.json"),
            uid=[],
        ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.sfmData.value:
            chunk.logger.warning('No input sfmData in node InjectSfmData, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Opens the dataset data.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            # check inputs
            if not self.check_inputs(chunk):
                return
            chunk.logger.info("Starts to make vizualisation")
            with open(chunk.node.sfmData.value,"r") as json_file:
                sfm_data = json.load(json_file)
            # get landmarks (sorted by track length)
            landmarks = get_landmarks_from_sfm_data(sfm_data)
            # generate json corresponding to the method
            display_function = eval(chunk.node.mode.value)
            json_display = display_function(landmarks)
            # write json
            with open(chunk.node.outputFile.value, "w") as json_file:
                json_file.write(json.dumps(json_display, indent=4))

            # debug
            #(extrinsics_all_cams, intrinsics_all_cams, views_id,
            #_, _, pixel_sizes_all_cams) = matrices_from_sfm_data(sfm_data)
            #views_path = [view["path"] for view in sfm_data["views"]]
            #draw_on_images(json_display, views_id, views_path, extrinsics_all_cams,
            #                        intrinsics_all_cams, pixel_sizes_all_cams, os.path.dirname(chunk.node.outputFile.value))

            # #get calib

            #
            # print("Method "+chunk.node.mode.value)
            # vizualisation_function = eval(chunk.node.mode.value)
            # vizualisation_function(landmarks, views_id, views_path,
            #                         extrinsics_all_cams, intrinsics_all_cams, pixel_sizes_all_cams,
            #                         chunk.node.outputFolder.value,
            #                         parameters=1000)

            #


            # #test plot landmarks
            # for view, vid, extrinsic, intrinsic in zip(sfm_data["views"], views_id, extrinsics_all_cams, intrinsics_all_cams):

            #     if int(vid) != int(view["viewId"]):
            #         raise RuntimeError("Id mismatch")

            #     image = open_image(view["path"])
            #     #get the projection
            #     for landmark in landmarks:
            #         # landmark_projected
            #         point_on_cam, z = camera_projection(np.asarray([landmark], np.float32), extrinsic, intrinsic, pixel_sizes_all_cams[0])
            #         point_on_cam = point_on_cam[0]
            #         if point_on_cam[0]<0 or point_on_cam[1]<0:
            #             continue
            #         if point_on_cam[0]>=image.shape[1] or point_on_cam[1]>=image.shape[0]:
            #             continue
            #         if z[0]<=0:
            #             continue
            #         image[point_on_cam[1]-5:point_on_cam[1]+5, point_on_cam[0]-5:point_on_cam[0]+5] = [0,0,255]
            #     save_image(os.path.join(chunk.node.outputFolder.value, view["viewId"]+".png"), image)

            # #ransac plane detection

            # def ransac_plane(xyz, threshold=0.05, iterations=1000):
            #     inliers=[]
            #     n_points=len(xyz)
            #     i=1
            #     equation=None
            #     while i<iterations:
            #         #randomly sample 3 pts in pc
            #         idx_samples = random.sample(range(n_points), 3)
            #         pts = xyz[idx_samples]
            #         #get normal to plane defined by 3 pts
            #         vecA = pts[1] - pts[0]
            #         vecB = pts[2] - pts[0]
            #         normal = np.cross(vecA, vecB)
            #         #compute distance of all points to plane (with threshold to robust outlier)
            #         a,b,c = normal / np.linalg.norm(normal)
            #         d=-np.sum(normal*pts[1])
            #         distance = (a * xyz[:,0] + b * xyz[:,1] + c * xyz[:,2] + d
            #                     ) / np.sqrt(a ** 2 + b ** 2 + c ** 2)
            #         idx_candidates = np.where(np.abs(distance) <= threshold)[0]
            #         #if best plane candidate so far, save
            #         if len(idx_candidates) > len(inliers):
            #             equation = [a,b,c,d]
            #             inliers = idx_candidates
            #         i+=1
            #     return equation, inliers

            # eq, idx_inliers=ransac_plane(landmarks,0.01)
            # inliers=landmarks[idx_inliers]
            # #save plane and inliers to debug
            # with open("all_landmarks.obj", "w") as obj_file:
            #     for landmark in landmarks:
            #         obj_file.write("v "+"%f %f %f\n"%(landmark[0], landmark[1], landmark[2]))

            # with open("plane.obj", "w") as obj_file:
            #     for inlier in inliers:
            #         obj_file.write("v "+"%f %f %f\n"%(inlier[0], inlier[1], inlier[2]))

            # #create plane to display:
            # with open("plane.obj", "w") as obj_file:
            #     obj_file.write("v "+"%f %f %f\n"%(mean_plane_landmark[0], mean_plane_landmark[1], mean_plane_landmark[2]))
            #     obj_file.write("v "+"%f %f %f\n"%(p0[0], p0[1], p0[2]))
            #     obj_file.write("v "+"%f %f %f\n"%(p1[0], p1[1], p1[2]))
            #     obj_file.write("v "+"%f %f %f\n"%(p2[0], p2[1], p2[2]))
            #     obj_file.write("v "+"%f %f %f\n"%(p3[0], p3[1], p3[2]))

            #     # obj_file.write("f "+"1 2 3\n")
            #     # obj_file.write("f "+"1 3 4\n")
            #     # obj_file.write("f "+"1 4 5\n")
            #     # obj_file.write("f "+"1 5 2\n")
            #     # obj_  file.write("f "+"2 3 4\n")
            #     # obj_file.write("f "+"2 5 4\n")

            chunk.logger.info('Vizualisation done')
        finally:
            chunk.logManager.end()




# # #idea, use track length, texture, clustering, also viz normal and plane, planetlet
# def build_knn_landmarks(landmarks, N):
#     """
#     Knn for landmarks, make the nn model and returns a matrix containing the nn indices
#     """
#     from annoy import AnnoyIndex
#     f = 3  # Length of item vector that will be indexed
#     t = AnnoyIndex(f, 'euclidean')
#     for i, landmark in enumerate(landmarks):
#         t.add_item(i, landmark)
#     t.build(10) # 10 trees
#     #N nn
#     neareast_ns =[]
#     for i, landmark in enumerate(landmarks):
#         neareast_ns.append(t.get_nns_by_item(i, N, search_k=-1, include_distances=False))
#     return neareast_ns, t

