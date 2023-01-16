
import bpy
import sys
import os
import json
import mathutils

# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
abc_path = argv[0]
output_mesh = argv[1]

#import the abc into the scene
bpy.ops.wm.alembic_import(filepath=abc_path, as_background_job=False)

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
