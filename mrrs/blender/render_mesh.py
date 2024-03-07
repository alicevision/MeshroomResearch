"""
This script is made to render an input mesh using cameras from thje input sfm.
Several render modes are possible, bu default a simple mesh is rendered.
"""

import bpy
import os
import mathutils
import math
import sys
import argparse
import json


def create_parser():
    '''Create command line interface.'''
    # When --help or no args are given, print this help
    usage_text = (
        "Run blender in background mode with this script:"
        "  blender --background --python " + __file__ + " -- [options]"
    )

    parser = argparse.ArgumentParser(description=usage_text)

    parser.add_argument(
        "--cameras", metavar='FILE', required=True,
        help="sfmData with the animated camera.",
    )
    parser.add_argument(
        "--model", metavar='FILE', required=True,
        help="Point Cloud or Mesh used in the rendering.",
    )
    parser.add_argument(
        "--output", metavar='FILE', required=True,
        help="Render an image to the specified path",
    )
    parser.add_argument(
        "--renderMode", type=str, required=False, default="FACES", choices=["MESH", "FACES", "DEPTH"],
        help="Choose the rendering mode, MESH: mesh with no light, FACES: face index",
    )
    parser.add_argument(
        "--resolutionMultiplier", type=int, required=False, default=5,
        help="Uses a multiplier to increase the resolution",
    )
    parser.add_argument(
        "--rangeStart", type=int, required=False, default=-1,
        help="Range start for processing views. Set to -1 to process all views.",
    )
    parser.add_argument(
        "--rangeSize", type=int, required=False, default=0,
        help="Range size for processing views.",
    )
    return parser


def parse_sfm_camera_file(filepath):
    '''Retrieve cameras from SfM file in json format.'''
    with open(os.path.abspath(filepath), 'r') as file:
        sfm = json.load(file)
    views = sfm['views']
    intrinsics = sfm['intrinsics']
    poses = sfm['poses']
    return views, intrinsics, poses


def get_from_id(data, key, identifier):
    '''Utility function to retrieve view, intrinsic or pose using their IDs.'''
    for item in data:
        if item[key] == identifier:
            return item
    return None


def setup_camera(intrinsic, pose, resolution_multiplier=1):
    '''Setup Blender camera to match the given SfM camera.'''
    camObj = bpy.data.objects['Camera']
    camData = bpy.data.cameras['Camera']

    bpy.context.scene.render.resolution_x = resolution_multiplier*int(intrinsic['width'])
    bpy.context.scene.render.resolution_y = resolution_multiplier*int(intrinsic['height'])
    bpy.context.scene.render.pixel_aspect_x = float(intrinsic['pixelRatio'])

    camData.sensor_width = float(intrinsic['sensorWidth'])
    camData.lens = float(intrinsic['focalLength'])

    tr = pose['pose']['transform']
    matPose = mathutils.Matrix.Identity(4)
    matPose[0][0] = float(tr['rotation'][0])
    matPose[0][1] = float(tr['rotation'][1])
    matPose[0][2] = float(tr['rotation'][2])
    matPose[1][0] = float(tr['rotation'][3])
    matPose[1][1] = float(tr['rotation'][4])
    matPose[1][2] = float(tr['rotation'][5])
    matPose[2][0] = float(tr['rotation'][6])
    matPose[2][1] = float(tr['rotation'][7])
    matPose[2][2] = float(tr['rotation'][8])
    matPose[0][3] = float(tr['center'][0])
    matPose[1][3] = float(tr['center'][1])
    matPose[2][3] = float(tr['center'][2])

    matConvert = mathutils.Matrix.Identity(4)
    matConvert[1][1] = -1
    matConvert[2][2] = -1

    camObj.matrix_world = matConvert @ matPose @ matConvert


def init_scene():
    '''Initialize Blender scene.'''
    # Clear current scene (keep default camera)
    bpy.data.objects.remove(bpy.data.objects['Cube'])
    bpy.data.objects.remove(bpy.data.objects['Light'])
    # Set output format
    bpy.context.scene.render.image_settings.file_format = 'OPEN_EXR'
    #black baground
    bpy.context.scene.render.film_transparent = True
    # deatcivate AA
    bpy.context.scene.render.filter_size = 0
    # print(bpy.context.scene.render.engine)#EEVEE

def load_model(filename):
    '''Load model in Alembic of OBJ format. Make sure orientation matches camera orientation.'''
    if filename.lower().endswith('.obj'):
        bpy.ops.import_scene.obj(filepath=filename, axis_forward='Y', axis_up='Z')
        meshName = os.path.splitext(os.path.basename(filename))[0]
        return bpy.data.objects[meshName], bpy.data.meshes[meshName]
    elif filename.lower().endswith('.abc'):
        bpy.ops.wm.alembic_import(filepath=filename)
        root = bpy.data.objects['mvgRoot']
        root.rotation_euler.rotate_axis('X', math.radians(-90.0))
        return bpy.data.objects['mvgPointCloud'], bpy.data.meshes['particleShape1']
    elif filename.lower().endswith('.ply'):
        bpy.ops.import_mesh.ply(filepath=filename)
        meshName = os.path.splitext(os.path.basename(filename))[0]
        return bpy.data.objects[meshName], bpy.data.meshes[meshName]
    else:
        raise RuntimeError("Not a valid mesh object")

def setup_face_index_shader(scene_mesh, scene_obj):

    #create function to map face index to uv values
    mesh = scene_mesh#ob.data
    uvs = [0.0] * (2 * len(mesh.loops))#make uv coords, 2 for each loop, note: loops are triangles or quads vertices
    #uv color value is index
    for poly in mesh.polygons:
        for loopi in poly.loop_indices: 
            uvs[2*loopi] = (1+poly.index)/float(1+len(mesh.polygons))#note: we only set u (hence the *2), also offset because 0 taken by background
    #add layer in render
    if 'PolyIndex' not in mesh.uv_layers:
        mesh.uv_layers.new(name='PolyIndex')
    mesh.uv_layers['PolyIndex'].data.foreach_set('uv', uvs)

    #setup shaders
    #make sure there is at least one material slot
    bpy.ops.object.material_slot_add()
    #remove all mats exept from slot 0
    for _ in range(1, len(scene_obj.material_slots)):
        with bpy.context.temp_override(object=scene_obj):
            bpy.ops.object.material_slot_remove()
    # create new material
    scene_obj.material_slots[0].material = bpy.data.materials.new("face_idx_material")
    #select and activate material 0
    material = scene_obj.material_slots[0].material
    scene_obj.active_material_index = 0
    material.use_nodes = True
    #clear all nodes in mat tree (just in case)
    material.node_tree.links.clear()
    material.node_tree.nodes.clear()


    #create new uv, separate xyz and output material
    input_uv_map_shader_node = material.node_tree.nodes.new('ShaderNodeUVMap')
    separate_XYZ_shader_node = material.node_tree.nodes.new('ShaderNodeSeparateXYZ')
    output_material_shader_node = material.node_tree.nodes.new('ShaderNodeOutputMaterial')
    #set uv values to be the one defined in the uv_layez PolyIndex
    input_uv_map_shader_node.uv_map = "PolyIndex"
    # link them
    material.node_tree.links.new(input_uv_map_shader_node.outputs[0], separate_XYZ_shader_node.inputs[0])
    material.node_tree.links.new(separate_XYZ_shader_node.outputs[0], output_material_shader_node.inputs[0])


def main():
    argv = sys.argv

    if "--" not in argv:
        argv = []  # as if no args are passed
    else:
        argv = argv[argv.index("--") + 1:]  # get all args after "--"

    parser = create_parser()
    args = parser.parse_args(argv)

    if not argv:
        parser.print_help()
        return -1

    print("Init scene")
    init_scene()

    print("Parse cameras SfM file")
    views, intrinsics, poses = parse_sfm_camera_file(args.cameras)

    print("Load scene objects")
    scene_obj, scene_mesh = load_model(args.model)

    print("Retrieve range")
    rangeStart = args.rangeStart
    rangeSize = args.rangeSize
    if rangeStart != -1:
        if rangeStart < 0 or rangeSize < 0 or rangeStart > len(views):
            print("Invalid range")
            return 0
        if rangeStart + rangeSize > len(views):
            rangeSize = len(views) - rangeStart
    else:
        rangeStart = 0
        rangeSize = len(views)

    print(args.renderMode)
    if args.renderMode=="FACES":
        print("Setup render faces idx")
        setup_face_index_shader(scene_mesh, scene_obj)
    elif args.renderMode=="DEPTH":
        print("Setup render depth maps")
        raise BaseException('depth map mode tba')
    else:
        print("Render mesh")

    print("Render viewpoints")
    for view in views[rangeStart:rangeStart+rangeSize]:
        view_id = view["viewId"]

        intrinsic = get_from_id(intrinsics, 'intrinsicId', view['intrinsicId'])
        if not intrinsic:
            continue

        pose = get_from_id(poses, 'poseId', view['poseId'])
        if not pose:
            continue

        print("Rendering view " + view['viewId'])
        
        #setup camera
        setup_camera(intrinsic, pose, args.resolutionMultiplier)
        #setup filepath
        bpy.context.scene.render.filepath = os.path.abspath(args.output + '/' + view_id + '.png')
        #run render
        bpy.ops.render.render(write_still=True)

        # if the pixel aspect ratio is not 1, reload and rescale the rendered image
        if bpy.context.scene.render.pixel_aspect_x != 1.0:
            finalImg = bpy.data.images.load(bpy.context.scene.render.filepath)
            finalImg.scale(int(bpy.context.scene.render.resolution_x * bpy.context.scene.render.pixel_aspect_x), bpy.context.scene.render.resolution_y)
            finalImg.save()
            # clear image from memory
            bpy.data.images.remove(finalImg)

    #saving project 
    bpy.ops.wm.save_as_mainfile(filepath=os.path.abspath(args.output + '/' + "project.blend"))

    print("Done")
    return 0


if __name__ == "__main__":

    err = 1
    try:
        err = main()
    except Exception as e:
        print("\n" + str(e))
        sys.exit(err)
    sys.exit(err)