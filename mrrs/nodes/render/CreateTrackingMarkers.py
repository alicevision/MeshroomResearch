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
    landmarks_color = []
    landmarks_track_length = []
    landmarks_track_mean_scale = []
    for landmark in sfm_data["structure"]:
        landmarks_track_length.append(len(landmark["observations"]))
        landmarks_track_mean_scale.append(np.mean([float(l["scale"]) for l in landmark["observations"]], axis=0))
        landmarks.append(landmark["X"])
        landmarks_color.append(landmark["color"])
    landmarks_track_length = np.asarray(landmarks_track_length, dtype=np.float32)
    landmarks = np.asarray(landmarks, dtype=np.float32)
    landmarks_track_mean_scale = np.asarray(landmarks_track_mean_scale, dtype=np.float32)
    landmarks_color = np.asarray(landmarks, dtype=np.uint8)

    if sort_mode == "longest":
        order = landmarks_track_length.argsort()
    elif sort_mode == "scale":
        mean_scale = np.asarray(landmarks_track_mean_scale)
        order = mean_scale.argsort()
    else:
        raise RuntimeError("Unrecognised sort mode")

    landmarks_sorted = landmarks[order]
    landmarks_color = landmarks_color[order]
    return landmarks_sorted, landmarks_color

def display_track_obj(obj_type, landmarks, landmarks_color, landmarks_per_voxel, scene_tiles, min_landmark_per_voxel):
    """
    Will return point coordinates corresponding to the longest landmarks.
    Also make sure the points are uniformly distributed, in the scene:
    will only display n points per voxels.
    """
    landmarks = filter_landmarks_per_tile(landmarks, scene_tiles, landmarks_per_voxel, min_landmark_per_voxel)
    objs = []
    for landmark_index, landmark in enumerate(landmarks):
        obj = {"type": obj_type,
                "name": "landmark_"+str(landmark_index),
                "coordinates": landmark.tolist(),
                "color": landmarks_color[landmark_index].tolist()}
        objs.append(obj)
    return objs

def display_track_cones(landmarks, landmarks_color, landmarks_per_voxel=1, scene_tiles=3, min_landmark_per_voxel=0):
    return display_track_obj("cone", landmarks, landmarks_color, landmarks_per_voxel, scene_tiles, min_landmark_per_voxel)

def display_track_spheres(landmarks, landmarks_color, landmarks_per_voxel=1, scene_tiles=3, min_landmark_per_voxel=0):
    return display_track_obj("sphere", landmarks, landmarks_color, landmarks_per_voxel, scene_tiles, min_landmark_per_voxel)

# def display_landmarks(landmarks, landmarks_color, output_obj):
#     """
    
#     """
#     #create obj from sfm data
#     with open(output_obj, "w"):
#         for lm, lm_color in zip(landmarks, landmarks_color):
#             output_obj = "v %d %d %d %d %d %d"%(*lm, *lm_color)
#     return [{"type": "obj", "name": "sfm_landmarks", "file_path":output_obj}]

def draw_on_images(json_display, views_id, views_path, extrinsics_all_cams,
                    intrinsics_all_cam, pixel_sizes_all_cams, output_folder):
    """
    Plot the projection of 3D landmarks onto an image. Used for debug mostly.
    """
    POINT_THINKESS = 5
    object_colors = (np.random.random([len(json_display), 3]))
    color_min = 0
    color_max = 1
    for view_id, view_path, extrinsic, intrinsic in zip(views_id, views_path, extrinsics_all_cams, intrinsics_all_cam):
        image = open_image(view_path)
        color_min = np.amin(image)
        color_max = np.amax(image)
        # get the projection
        for display_object, object_color in zip(json_display, object_colors):
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
            image[point_on_cam[1]-POINT_THINKESS:point_on_cam[1]+POINT_THINKESS, point_on_cam[0]-POINT_THINKESS:point_on_cam[0]+POINT_THINKESS] = object_color*(color_max-color_min)-color_min
        image_extention = view_path.split(".")[-1]
        save_image(os.path.join(output_folder, view_id+"."+image_extention), image)

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
            values=['display_track_cones', 'display_track_spheres'],
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
            enabled=lambda node: node.track_mode.value=='display_track_cones' or node.track_mode.value=='display_track_spheres',
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
            enabled=lambda node: node.track_mode.value=='display_track_cones' or node.track_mode.value=='display_track_spheres'
        ),

        desc.IntParam(
            name='param_voxel_grid_size',
            label='Voxel Grid Size',
            description='''Grid size to be used. Will only keep N landmarks per voxel.''',
            value=10,
            range=(0, 10000, 1),
            uid=[0],
            enabled=lambda node: node.track_mode.value=='display_track_cones' or node.track_mode.value=='display_track_spheres'
        ),

        desc.IntParam(
            name='param_min_landmark_per_voxel',
            label='Minimum landmark per voxel',
            description='''Will only display landmarks if the voxel as this amount of ttal landmarks''',
            value=10,
            range=(0, 10000, 1),
            uid=[0],
            enabled=lambda node: node.track_mode.value=='display_track_cones' or node.track_mode.value=='display_track_spheres'
        ),

        desc.BoolParam(
            name="render",
            label = "Generate 2D renders",
            description='''Will render the markers directly on frames ''',
            value=False,
            uid=[0],
            group='',
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
            landmarks, landmarks_color = get_landmarks_from_sfm_data(sfm_data, chunk.node.track_param_sort_mode.value)
            # generate json corresponding to the method
            display_function = eval(chunk.node.track_mode.value)
            display_options = [attribute._value for attribute in chunk.node.attributes
                               if attribute._enabled and attribute.name.startswith("param_")]#note: hacky but works
            json_display = display_function(landmarks, landmarks_color, *display_options)
            # write json
            with open(chunk.node.outputFile.value, "w") as json_file:
                json_file.write(json.dumps(json_display, indent=4))

            if chunk.node.render.value:
                #sort images by shot date to be able to sort by creation date in the viewer
                frame_ids = [view["frameId"] for view in sfm_data["views"]]
                (extrinsics_all_cams, intrinsics_all_cams, _,
                _, _, pixel_sizes_all_cams) = matrices_from_sfm_data(sfm_data)
                views_path = [view["path"] for view in sfm_data["views"]]
                draw_on_images(json_display, frame_ids, views_path, extrinsics_all_cams,
                               intrinsics_all_cams, pixel_sizes_all_cams, os.path.dirname(chunk.node.outputFile.value))

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

