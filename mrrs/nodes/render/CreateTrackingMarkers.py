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

def filter_landmarks_per_tile(landmarks, nb_voxels, nb_landmarks_per_voxels, min_landmark_per_voxel):
    """
    Will filter out landmarks such that we only keep the first nb_landmarks_per_voxels landmark per voxel.
    Assumes the landmarks are sorted with first landmarks to keep.
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
                if len(landmarks_inside) > min_landmark_per_voxel:
                    final_landmarks_list += list(landmarks_inside[:min(nb_landmarks_per_voxels, len(landmarks_inside))])
    return final_landmarks_list

def get_landmarks_from_sfm_data(sfm_data, sort_mode):
    """
    Get landmarks (sorted by track length)
    """
    landmarks = []
    landmarks_track_length = []
    landmarks_track_mean_scale = []
    for landmark in sfm_data["structure"]:
        landmarks_track_length.append(len(landmark["observations"]))
        landmarks_track_mean_scale.append(np.mean([float(l["scale"]) for l in landmark["observations"]], axis=0))
        landmarks.append(landmark["X"])
    landmarks_track_length = np.asarray(landmarks_track_length, dtype=np.float32)
    landmarks = np.asarray(landmarks, dtype=np.float32)
    landmarks_track_mean_scale = np.asarray(landmarks_track_mean_scale, dtype=np.float32)

    if sort_mode == "longest":
        order = landmarks_track_length.argsort()
    elif sort_mode == "scale":
        mean_scale = np.asarray(landmarks_track_mean_scale)
        order = mean_scale.argsort()
    else:
        raise RuntimeError("Unrecognised sort mode")

    landmarks_sorted = landmarks[order]
    return landmarks_sorted

def display_track_cones(landmarks, landmarks_per_voxel=1, scene_tiles=3, min_landmark_per_voxel=0):
    """
    Will return point coordinates corresponding to the longest landmarks.
    Also make sure the points are uniformly distributed, in the scene:
    will only display n points per voxels.
    """
    landmarks = filter_landmarks_per_tile(landmarks, scene_tiles, landmarks_per_voxel, min_landmark_per_voxel)
    cones = []
    for landmark_index, landmark in enumerate(landmarks):
        cone = {"type": "cone",
                "name": "landmark_"+str(landmark_index),
                "coordinates": landmark.tolist()}
        cones.append(cone)
    return cones

def draw_on_images(json_display, views_id, views_path, extrinsics_all_cams,
                    intrinsics_all_cam, pixel_sizes_all_cams, output_folder):
    """
    Plot the projection of 3D landmarks onto an image. Used for debug mostly.
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
            name='track_mode',
            label='Track Mode',
            description='''Mode to display over the images''',
            value='display_track_cones',
            values=['display_track_cones'],
            exclusive=True,
            uid=[0],
        ),

        desc.ChoiceParam(
            name='track_param_sort_mode',
            label='Sorting Mode',
            description='''Sort Mode to display Track Cones''',
            value='longest',
            values=['longest', 'scale'],
            uid=[0],
            enabled=lambda node: node.track_mode.value=='display_track_cones',
            exclusive=True
        ),

        #! order important for parameters
        desc.IntParam(
            name='param_markers_per_voxel',
            label='Markers per voxels',
            description=''' ''',
            value=1,
            range=(0, 10000, 1),
            uid=[0],
            enabled=lambda node: node.track_mode.value=='display_track_cones'
        ),

        desc.IntParam(
            name='param_voxel_grid_size',
            label='Voxel Grid Size',
            description='''Grid size to be used. Will only keep N landmarks per voxel.''',
            value=10,
            range=(0, 10000, 1),
            uid=[0],
            enabled=lambda node: node.track_mode.value=='display_track_cones'
        ),

        desc.IntParam(
            name='param_min_landmark_per_voxel',
            label='Minimum landmark per voxel',
            description='''Will only display landmarks if the voxel as this amount of ttal landmarks''',
            value=10,
            range=(0, 10000, 1),
            uid=[0],
            enabled=lambda node: node.track_mode.value=='display_track_cones'
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
            landmarks = get_landmarks_from_sfm_data(sfm_data, chunk.node.track_param_sort_mode.value)
            # generate json corresponding to the method
            display_function = eval(chunk.node.track_mode.value)
            display_options = [attribute._value for attribute in chunk.node.attributes
                               if attribute._enabled and attribute.name.startswith("param_")]#note: hacky but works
            json_display = display_function(landmarks, *display_options)
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

