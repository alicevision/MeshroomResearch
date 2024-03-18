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

#import the abc into the scene
if mode == "abc2obj":
    bpy.ops.wm.alembic_import(filepath=filename, as_background_job=False)

    #saves project (for depbug)
    bpy.ops.wm.save_as_mainfile(filepath=os.path.dirname(output_mesh)+"/project.blend")

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
    if filename.lower().endswith('.obj'):
        print("obj")
        bpy.ops.import_scene.obj(filepath=filename, axis_forward='Y', axis_up='Z')
    elif filename.lower().endswith('.ply'):
        bpy.ops.import_mesh.ply(filepath=filename)
    else:
        raise ValueError('Model file not supported')
    print("ec")
    bpy.ops.wm.alembic_export(filepath=output_mesh)
else:
    raise ValueError('Wrong mode')