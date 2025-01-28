"""
Blender script to convert an abc particleShape into vertices of an obj.
"""

import bpy
import sys
import os


# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
filename = argv[0]
output_mesh = argv[1]

mode="abc2obj"
if len(argv)>=3:
    mode = argv[2]

bpy.ops.wm.read_homefile(use_empty=True)

print("Alembic convert mode: "+mode)

#import the abc into the scene
if mode == "abc2obj":
    bpy.ops.wm.alembic_import(filepath=filename, as_background_job=False)

    # #export point cloud into ply https://docs.blender.org/api/current/bpy.ops.export_mesh.html
    #not working because no faces?
    # bpy.ops.export_mesh.ply(filepath=output_mesh+"/point_coud.ply", check_existing=False,
    #                          filter_glob="*.ply", use_ascii=False, use_selection=False, use_mesh_modifiers=True,
    #                          use_normals=True, use_uv_coords=True, use_colors=True, global_scale=1.0, axis_forward="Y", axis_up="Z")

    # export by hand the particle mesh
    obj = bpy.data.meshes["particleShape1"]
    with open(output_mesh, "w") as obj_file:
        for vertex in obj.vertices:
            obj_file.write("v "+ " ".join(map(str,vertex.co))+"\n")
elif mode == "mesh2abc":
    print("Creating hierarchy")

    #create .abc hierarchy for qtalicevision
    def create_empty(name, parent=None):
        obj=bpy.data.objects.new(name, None)
        scene = bpy.context.scene
        scene.collection.objects.link(obj)
        if parent is not None:
            obj.parent = parent
        return obj

    mvgRoot=create_empty("mvgRoot")
    mvgCloud=create_empty("mvgCloud", mvgRoot)
    mvgAncestors=create_empty("mvgAncestors", mvgRoot)
    mvgCameras=create_empty("mvgCameras", mvgRoot)
    mvgCamerasUndefined=create_empty("mvgCamerasUndefined", mvgRoot)

    #import mesh
    print("Importing")
    if filename.lower().endswith('.obj'):
        bpy.ops.import_scene.obj(filepath=filename, axis_forward='Y', axis_up='Z')
    elif filename.lower().endswith('.ply'):
        bpy.ops.import_mesh.ply(filepath=filename)
    else:
        raise ValueError('Model file not supported')
    print("Done")
    meshName = os.path.splitext(os.path.basename(filename))[0]
    obj=bpy.data.objects[meshName]
    mesh=bpy.data.meshes[meshName]
    #rename and move mesh in hierachy
    obj.name="mvgPointCloud"
    mesh.name="particleShape1"
    obj.parent=mvgCloud

    print("Saving abc to "+output_mesh)
    bpy.ops.wm.alembic_export(filepath=output_mesh)
else:
    raise ValueError('Wrong mode')
print("Convert done")
#saves project (for depbug)
print("Saving to "+os.path.dirname(output_mesh)+"/project.blend")
bpy.ops.wm.save_as_mainfile(filepath=os.path.dirname(output_mesh)+"/project.blend")
print("Bye")