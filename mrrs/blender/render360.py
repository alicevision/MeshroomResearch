import math
import bpy
import sys, os
from math import *
from mathutils import *

# Command line arguments
argv = sys.argv[sys.argv.index('--')+1:]
object_filepath = argv[0]
output_folder = argv[1]
num_steps = int(argv[2])

#render setup
bpy.context.scene.render.image_settings.file_format = 'PNG'
bpy.context.scene.render.resolution_x = 512
bpy.context.scene.render.resolution_y = 512
# bpy.context.scene.render.alpha_mode = 'SKY' # in ['TRANSPARENT', 'SKY']
bpy.context.scene.render.film_transparent=True
bpy.data.objects.remove(bpy.data.objects['Cube'], do_unlink=True)

#load obj
bpy.ops.wm.obj_import(filepath=object_filepath) 
imported_object = bpy.context.selected_objects[0]

#move to 0 0 0
bpy.ops.object.origin_set(type='ORIGIN_CENTER_OF_MASS', center='MEDIAN')
imported_object.location.x=0
imported_object.location.y=0
imported_object.location.z=0
scale=max(imported_object.dimensions.x, imported_object.dimensions.z, imported_object.dimensions.y)
bpy.ops.transform.resize(value=(8/scale, 8/scale, 8/scale))

#settup scene
print("Target:", imported_object)
target = imported_object
cam = bpy.data.objects['Camera']
t_loc_x = target.location.x
t_loc_y = target.location.y
cam_loc_x = cam.location.x
cam_loc_y = cam.location.y
# cam.location.z=imported_object.dimensions.z/2

#dist = sqrt((t_loc_x-cam_loc_x)**2+(t_loc_y-cam_loc_y)**2)
dist = (target.location.xy-cam.location.xy).length
#ugly fix to get the initial angle right
init_angle  = (1-2*bool((cam_loc_y-t_loc_y)<0))*acos((cam_loc_x-t_loc_x)/dist)-2*pi*bool((cam_loc_y-t_loc_y)<0)

for x in range(num_steps):
    alpha = init_angle + (x+1)*2*pi/num_steps
    cam.rotation_euler[2] = pi/2+alpha
    cam.location.x = t_loc_x+cos(alpha)*dist
    cam.location.y = t_loc_y+sin(alpha)*dist
    bpy.context.scene.render.filepath = os.path.abspath(output_folder + '/%05d'%x)
    bpy.ops.render.render( write_still=True ) 