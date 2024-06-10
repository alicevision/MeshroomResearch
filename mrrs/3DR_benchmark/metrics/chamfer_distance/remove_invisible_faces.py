"""

"""
import argparse
import os
import numpy as np
import trimesh

from mrrs.core.ios import open_image
from mrrs.core.utils import listdir_fullpath

if __name__ == '__main__':
    """
    Removes invisbiles faces according to a folder of rendered images of faces indices
    """
 
    # Input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('--input_mesh', type=str, default='', help='Path to the input mesh')
    parser.add_argument('--face_index_images_folder', type=str, default='', help='Path to imagtes of face index')
    parser.add_argument('--output_mesh', type=str, required=True, default='./mesh.obj', help='Path to the output mesh')
    args = parser.parse_args()


    # Read mesh
    print('Reading mesh')
    mesh = trimesh.load(args.input_mesh, force="mesh" )
    nb_faces = mesh.faces.shape[0]

    #read images
    print('Reading images')
    is_face_visible = np.zeros([nb_faces+1], dtype=np.bool)#note: face 0 used for background 
    face_index_images = listdir_fullpath(args.face_index_images_folder, lambda x: x.endswith(".exr"))
    for i in face_index_images:
        face_image = ((nb_faces+1)*open_image(i)/255.0).astype(int)
        faces_indices = np.unique(face_image)
        is_face_visible[faces_indices] = True
    
    #remove unuset faces
    print("Found %d invisibles faces"%(nb_faces-np.count_nonzero(is_face_visible)))
    mesh.update_faces(is_face_visible[1:])#note, discard face index 0 because used for background

    print('Saving')
    mesh.export(args.output_mesh)
