
import bpy
import sys
import os
import json
import mathutils

# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
abc_path = argv[0]
output_file = argv[1]

#import the abc into the scene
bpy.ops.wm.alembic_import(filepath=abc_path, as_background_job=False)

#saves
# save blend
# bpy.ops.wm.save_mainfile()
# save as
bpy.ops.wm.save_as_mainfile(filepath=output_file)