"""
Clean an input mesh by closing it and removing parts with low ambiant oclusion
"""

import os
import argparse
import numpy as np

if __name__ == '__main__':
    import open3d as o3d
    import igl

    # Input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('--input_mesh', type=str, default='', help='Path to the input mesh')
    parser.add_argument('--output_dir', type=str, required=True, default='', help='Path to the output directory')
    args = parser.parse_args()

    if not os.path.exists(args.output_dir):
        os.makedirs(args.output_dir)

    # Read mesh
    data_mesh = o3d.io.read_triangle_mesh(args.input_mesh)
    vertices_non_manifold = data_mesh.get_non_manifold_vertices()
    data_mesh.remove_vertices_by_index(vertices_non_manifold)
    mesh = o3d.t.geometry.TriangleMesh.from_legacy(data_mesh)

    # Close mesh
    filled = mesh.fill_holes().to_legacy()
    vertices = np.asarray(filled.vertices)
    triangles = np.asarray(filled.triangles)
    # o3d.io.write_triangle_mesh(os.path.join(args.output_dir, 'closed_mesh.ply'), filled)

    # Compute ambient occlusion
    n = igl.per_vertex_normals(vertices, triangles)
    ao = igl.ambient_occlusion(vertices, triangles, vertices, n, 128)
    ao = 1 - ao

    # Remove vertices with low AO
    mask = ao < 0.06
    filled.remove_vertices_by_mask(mask)
    o3d.io.write_triangle_mesh(os.path.join(args.output_dir, 'cleaned_mesh.ply'), filled)
