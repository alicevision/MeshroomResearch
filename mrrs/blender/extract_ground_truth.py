"""
Blender script to extract the ground truth calibration from a rendered scene.
"""

import bpy
import mathutils

import sys
import os
import json


# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
images_folder = argv[0]
scene_name = argv[1]
cam_name = argv[2]
frame_start = int(argv[3])
frame_end = int(argv[4])
frame_step = int(argv[5])
output_folder = argv[6]

print('Extracting ground truth data from Blender file')
print('Images folder: ' + images_folder)
print('Scene name: ' + scene_name)
print('Camera name: ' + cam_name)
print('Output folder: ' + output_folder)


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
print('Extracting poses')

poses = []
mat_convert = mathutils.Matrix.Identity(4)
mat_convert[1][1] = -1
mat_convert[2][2] = -1
for frame in range(frame_start, frame_end, frame_step):
    scene.frame_set(frame)
    mat = mat_convert @ obj.matrix_world @ mat_convert.transposed()
    mat_rot = mat.to_3x3()
    rotation = [
        str(mat_rot[0][0]), str(mat_rot[0][1]), str(mat_rot[0][2]),
        str(mat_rot[1][0]), str(mat_rot[1][1]), str(mat_rot[1][2]),
        str(mat_rot[2][0]), str(mat_rot[2][1]), str(mat_rot[2][2]),
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
print('Extracting intrinsics')

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
print('Extracting views')

views = []
for frame in range(frame_start, frame_end, frame_step):
    view = {
        'viewId': get_view_id(frame),
        'poseId': get_pose_id(frame),
        'frameId': get_frame_id(frame),
        'intrinsicId': get_intrinsic_id(),
        'path': str(os.path.abspath('{}/{:04d}.jpg'.format(images_folder, frame))),
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
print('Saving data in SfM files')

output_path = os.path.abspath('{}/gt_no_pose.sfm'.format(output_folder))
with open(output_path, 'w') as file:
    json.dump(gt_no_pose, file, indent=4)

output_path = os.path.abspath('{}/gt.sfm'.format(output_folder))
with open(output_path, 'w') as file:
    json.dump(gt, file, indent=4)

print('Done')
