"""
This scripts renders objects described by a json
"""

import os
import sys
import json
import bpy
import math
import mathutils


# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
objects_filepath = argv[0]
size_factor = float(argv[1])
sfm_filepath = argv[2]
output_folder = argv[3]

print('Rendering 3D objects as overlay')
print('objects file: ' + objects_filepath)
print('SfM data file: ' + sfm_filepath)
print('Output folder: ' + output_folder)


# Remove default cube
print('Removing default cube')

bpy.data.objects.remove(bpy.data.objects['Cube'], do_unlink=True)


# Compositing setup
print('Compositing setup')
bpy.context.scene.render.image_settings.file_format = 'JPEG'
bpy.context.scene.render.film_transparent = True
bpy.context.scene.use_nodes = True
bpy.context.scene.node_tree.nodes.new(type="CompositorNodeAlphaOver")
bpy.context.scene.node_tree.nodes.new(type="CompositorNodeImage")
bpy.context.scene.node_tree.links.new(
    bpy.context.scene.node_tree.nodes['Alpha Over'].outputs['Image'],
    bpy.context.scene.node_tree.nodes['Composite'].inputs['Image'])
bpy.context.scene.node_tree.links.new(
    bpy.context.scene.node_tree.nodes['Image'].outputs['Image'],
    bpy.context.scene.node_tree.nodes['Alpha Over'].inputs[1])
bpy.context.scene.node_tree.links.new(
    bpy.context.scene.node_tree.nodes['Render Layers'].outputs['Image'],
    bpy.context.scene.node_tree.nodes['Alpha Over'].inputs[2])


# 3D objects
print('Reading objects file')
with open(os.path.abspath(objects_filepath), 'r') as file:
    objects = json.load(file)

#get lists of different objetcs to insert
cones_objects = [o for o in objects if o["type"]=="cone"]
sphere_objects = [o for o in objects if o["type"]=="sphere"]
wavefront_object = [o for o in objects if o["type"]=="obj"]

print("Detected %d cones %d spheres, %d objs"%(len(cones_objects), len(sphere_objects), len(wavefront_object)))

if len(cones_objects)>0:
    print('Computing cone size using minimal distance between objects')
    min_dist = -1
    for i in range(len(objects)-1):
        p1 = (objects[i]['coordinates'][0], objects[i]['coordinates'][1], objects[i]['coordinates'][2])
        for j in range(i+1, len(objects)):
            p2 = (objects[j]['coordinates'][0], objects[j]['coordinates'][1], objects[j]['coordinates'][2])
            dist = math.sqrt((p1[0]-p2[0])*(p1[0]-p2[0]) + (p1[1]-p2[1])*(p1[1]-p2[1]) + (p1[2]-p2[2])*(p1[2]-p2[2]))
            if min_dist < 0 or min_dist > dist:
                min_dist = dist

    cone_radius = min_dist * size_factor
    cone_length = cone_radius * 2

    print('Generating cones for objects')
    for object in cones_objects:
        bpy.ops.mesh.primitive_cone_add(vertices=4, radius1=0.0, radius2=cone_radius, depth=cone_length)
        cone = bpy.context.selected_objects[0]
        cone.name = object['name']
        cone.location = (object['coordinates'][0], object['coordinates'][1], object['coordinates'][2])
        cone.rotation_euler = (3.14*.5, 0, 0)

if len(sphere_objects)>0:
    print('Generating cones for objects')
    for object in sphere_objects:
        bpy.ops.mesh.primitive_uv_sphere_add(
                segments=16,
                ring_count=8,
                radius=size_factor
                )
        shpere = bpy.context.selected_objects[0]
        shpere.name = object['name']
        shpere.location = (object['coordinates'][0], object['coordinates'][1], object['coordinates'][2])
        shpere.rotation_euler = (3.14*.5, 0, 0)

if len("obj")>0:
    for object in wavefront_object:
        file_path = object["file_path"]
        imported_object = bpy.ops.import_scene.obj(filepath=file_path)
        sel_object = bpy.context.selected_objects[0] 
        sel_object.name = object['name']


# Overlay objects on views using estimated poses
print('Reading SfM data file')
with open(os.path.abspath(sfm_filepath), 'r') as file:
    sfm = json.load(file)

views = sfm['views']
intrinsics = sfm['intrinsics']
poses = sfm['poses']

def get_intrinsic(intrinsicId):
    for intrinsic in intrinsics:
        if int(intrinsic['intrinsicId']) == intrinsicId:
            return intrinsic
    return None

def get_pose(poseId):
    for pose in poses:
        if int(pose['poseId']) == poseId:
            return pose
    return None

cam_obj = bpy.data.objects['Camera']
cam_data = bpy.data.cameras['Camera']

mat_convert = mathutils.Matrix.Identity(4)
mat_convert[1][1] = -1
mat_convert[2][2] = -1

def camera_setup(view):
    print('Camera setup')

    intrinsic = get_intrinsic(int(view['intrinsicId']))
    if intrinsic is None:
        return False

    pose = get_pose(int(view['poseId']))
    if pose is None:
        return False

    pose = pose['pose']['transform']

    bpy.context.scene.render.resolution_x = int(intrinsic['width'])
    bpy.context.scene.render.resolution_y = int(intrinsic['height'])

    cam_data.sensor_width = float(intrinsic['sensorWidth'])
    cam_data.sensor_height = float(intrinsic['sensorHeight'])
    cam_data.lens = float(intrinsic['focalLength'])

    tr = mathutils.Matrix.Identity(4)
    tr[0][0] = float(pose['rotation'][0])
    tr[0][1] = float(pose['rotation'][1])
    tr[0][2] = float(pose['rotation'][2])
    tr[1][0] = float(pose['rotation'][3])
    tr[1][1] = float(pose['rotation'][4])
    tr[1][2] = float(pose['rotation'][5])
    tr[2][0] = float(pose['rotation'][6])
    tr[2][1] = float(pose['rotation'][7])
    tr[2][2] = float(pose['rotation'][8])
    tr[0][3] = float(pose['center'][0])
    tr[1][3] = float(pose['center'][1])
    tr[2][3] = float(pose['center'][2])
    tr = tr @ mat_convert
    cam_obj.matrix_world = tr

    return True

def render_setup(view):
    print('Render setup')

    # save using the uid
    # rendered_image =  view['viewId'] + ".jpg"

    # save using the original filename
    # rendered_image = os.path.basename(view['path'])+".jpg"

    # save by frame id
    rendered_image =  view['frameId'] + ".jpg"

    bpy.context.scene.render.filepath = os.path.abspath(output_folder + '/' + rendered_image)
    img_name = os.path.basename(view['path'])
    bpy.context.scene.node_tree.nodes["Image"].image = bpy.data.images[img_name]

    return True


for view in views:
    print('Computing overlay for view ' + view['viewId']+": "+view['path'])

    img_path = os.path.abspath(view['path'])
    bpy.ops.image.open(filepath=img_path)

    if not camera_setup(view):
        continue

    if not render_setup(view):
        continue

    bpy.ops.render.render(write_still=True)

