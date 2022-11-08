import bpy
import sys
import os
import json
import mathutils


# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
dataset_dir = argv[0]
scene_name = argv[1]
cam_name = argv[2]


# ID generation
def get_pose_id(frame):
    return str(frame)


def get_intrinsic_id():
    return str(0)


def get_view_id(frame):
    return str(frame)


def get_frame_id(frame):
    return str(frame)


# Blender data
scene = bpy.data.scenes[scene_name]
obj = bpy.data.objects[cam_name]
cam = bpy.data.cameras[cam_name]


# Poses
poses = []
mat_convert = mathutils.Matrix.Identity(4)
mat_convert[1][1] = -1
mat_convert[2][2] = -1
for frame in range(scene.frame_start, scene.frame_end+1):
    scene.frame_set(frame)
    mat = mat_convert @ obj.matrix_world @ mat_convert
    rotation = [
        str(mat[0][0]), str(mat[0][1]), str(mat[0][2]),
        str(mat[1][0]), str(mat[1][1]), str(mat[1][2]),
        str(mat[2][0]), str(mat[2][1]), str(mat[2][2]),
    ]
    center = [
        str(mat[0][3]), str(mat[1][3]), str(mat[2][3])
    ]
    pose = {
        'transform': {
            'rotation': rotation,
            'center': center
        },
        'locked': 0
    }
    poses.append({'poseId': get_pose_id(frame), 'pose': pose})


# Intrinsics
intrinsics = [
    {
        'intrinsicId': get_intrinsic_id(),
        'width': str(1920),
        'height': str(1080),
        'sensorWidth': str(cam.sensor_width),
        'sensorHeight': str(cam.sensor_height),
        'type': 'pinhole',
        'initializationMode': 'unknown',
        'initialFocalLength': '-1',
        'focalLength': str(cam.lens),
        'pixelRatio': '1',
        'pixelRatioLocked': 'true',
        'principalPoint': ['0', '0'],
        'distortionParams': '',
        'locked': 'false',
        'serialNumber': ''
    }
]


# Views
views = []
for frame in range(scene.frame_start, scene.frame_end+1):
    view = {
        'viewId': get_view_id(frame),
        'poseId': get_pose_id(frame),
        'frameId': get_frame_id(frame),
        'intrinsicId': get_intrinsic_id(),
        'path': str(os.path.abspath('{}/render/{:04d}.jpg'.format(argv[0], frame))),
        'width': str(1920),
        'height': str(1080)
    }
    views.append(view)


# Gather results
gt_no_pose = {
    'version': ['1', '2', '3'],
    'intrinsics': intrinsics,
    'views': views
}
gt = {
    'version': ['1', '2', '3'],
    'poses': poses,
    'intrinsics': intrinsics,
    'views': views
}


# Save to file
output_path = os.path.abspath('{}/gt_no_pose.sfm'.format(dataset_dir))
with open(output_path, 'w') as file:
    json.dump(gt_no_pose, file, indent=4)

output_path = os.path.abspath('{}/gt.sfm'.format(dataset_dir))
with open(output_path, 'w') as file:
    json.dump(gt, file, indent=4)
