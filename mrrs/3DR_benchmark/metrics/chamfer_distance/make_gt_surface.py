"""
Makes a point cloud from a meshroom mesh and the coresponding .sfm.
Uwses an octree to discard the vertices that are not visible.
"""
import os
import argparse
import multiprocessing as mp
import numpy as np

import trimesh
from pyoctree import pyoctree as ot
import sklearn.neighbors as skln

from .utils import read_sfm

def ray_intersection(ray):
    intersections = octree.rayIntersection(ray)
    return intersections

def get_rays_intersections_mp(rays):
    with mp.Pool(10) as mp_pool:
        # Use map to parallelize the computation
        intersections = mp_pool.map(ray_intersection, [rays[i,:,:] for i in range(rays.shape[0])], chunksize=1024)
    return intersections

def get_rays_intersections(rays):
    intersections = []
    for i in range(rays.shape[0]):
        intersections.append(ray_intersection(rays[i,:,:]))
    return intersections


if __name__ == '__main__':
    mp.freeze_support()

    # Input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('--input_mesh', type=str, default='', help='Path to the input mesh')
    parser.add_argument('--sfm_path', type=str, default='', help='Path to the SFM file')
    args = parser.parse_args()

    INPUT_MESH_PATH = args.input_mesh
    SFM_PATH = args.sfm_path

    # Read mesh
    print('Reading mesh and creating octree...')
    mesh = trimesh.load(INPUT_MESH_PATH)
    vertices = mesh.vertices
    faces = mesh.faces.astype(np.int32)
    octree = ot.PyOctree(vertices, faces)

    # Read SFM
    print('Reading SFM...')
    _, c2w_poses, intrinsics = read_sfm(SFM_PATH)

    # Upsample mesh to create point cloud
    min_vertex = np.min(vertices, axis=0)
    max_vertex = np.max(vertices, axis=0)
    scene_size = np.linalg.norm(max_vertex - min_vertex)
    thresh = scene_size / 1200
    print(f'Upsampling mesh with thresh={thresh:.4f}...')
    tri_vert = vertices[faces]
    pcd = upsampling_mesh(tri_vert, thresh)
    pcd = np.concatenate((pcd, vertices), axis=0)
    nn_engine = skln.NearestNeighbors(n_neighbors=1, radius=thresh, algorithm='kd_tree', n_jobs=-1)
    nn_engine.fit(pcd)
    rnn_idxs = nn_engine.radius_neighbors(pcd, radius=thresh, return_distance=False)
    mask = np.ones(pcd.shape[0], dtype=np.bool_)
    for curr, idxs in enumerate(rnn_idxs):
        if mask[curr]:
            mask[idxs] = 0
            mask[curr] = 1
    pcd = pcd[mask]
    write_vis_pcd(os.path.splitext(INPUT_MESH_PATH)[0] + '_pcd.ply', pcd, 255*np.ones(pcd.shape))
    print(f'Point cloud size: {pcd.shape[0]}')

    # Create rays
    print('Creating rays and finding intersections...')
    # pcd = vertices
    is_visible = np.zeros(len(pcd), dtype=np.bool_)
    rays = np.empty((len(pcd), 2, 3), dtype=np.float32)
    rays[:, 0, :] = pcd
    for ind_pose, c2w_pose in enumerate(c2w_poses):
        print(f'Pose {ind_pose+1}/{len(c2w_poses)}')
        rays[:, 1, :] = c2w_pose[:3, 3].reshape(1, 3)
        intersections = get_rays_intersections_mp(rays)
        intersections_len = np.array([len(intersections[i]) for i in range(len(intersections))]).astype(np.int32).reshape(-1)
        intersections_visible = np.array([np.all(np.array([i.s for i in inter]) < 1e-6) for inter in intersections]).astype(np.bool_).reshape(-1)
        is_visible_cam = np.logical_or(intersections_len == 0, np.logical_and(intersections_len > 0, intersections_visible))
        is_visible = np.logical_or(is_visible, is_visible_cam)
    np.save(os.path.join(os.path.dirname(INPUT_MESH_PATH), 'is_visible.npy'), is_visible)

    # Save a pcd file with the visible vertices
    print("Saving pcd files...")
    pcd_visible = pcd[is_visible]
    write_vis_pcd(os.path.splitext(INPUT_MESH_PATH)[0] + '_pcd_visible.ply', pcd_visible, 255*np.ones(pcd_visible.shape))

    # Save a pcd file with the invisible vertices
    pcd_invisible = pcd[np.logical_not(is_visible)]
    colors = np.tile(np.array([255, 0, 0]), (len(pcd_invisible), 1))
    write_vis_pcd(os.path.splitext(INPUT_MESH_PATH)[0] + '_pcd_invisible.ply', pcd_invisible, colors)

    # Update mesh
    print('Updating mesh...')
    OUTPUT_MESH_PATH = os.path.splitext(INPUT_MESH_PATH)[0] + '_cleaned.ply'
    mesh.update_vertices(is_visible)
    mesh.export(OUTPUT_MESH_PATH)