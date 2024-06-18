"""
This is meant to be run thru blender
"""
cameras = []
for camera in bpy.data.objects: #On recupere tous les objets de la scene commençant par "Camera_"
    if "cam_render_" in camera.name:
        cameras.append(camera)
 
camera_dict = {} #On stocke les objets dans un dictionnaire pour pouvoir les trier numériquement
for camera in cameras :
    camera_dict[int(camera.name.replace("cam_render_", ""))] = camera
sorted_dict = dict(sorted(camera_dict.items()))
 
keys = sorted_dict.keys() #On repasse à une simple liste
index = 0
for k in keys:
    cameras[index] = sorted_dict[k]
    index += 1
 
mat_convert = mathutils.Matrix.Identity(4)
mat_convert[1][1] = -1
mat_convert[2][2] = -1

counter = frame_start-1
 
for camera in cameras:
    mat = mat_convert @ camera.matrix_world @ mat_convert.transposed()
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
    poses.append({'poseId': get_pose_id(counter), 'pose': pose})
    counter = counter + frame_step
    print(camera.name)
 
rs = bpy.data.scenes[0].render
