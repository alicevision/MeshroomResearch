import os
import argparse
import numpy as np

import sklearn.neighbors as skln
import matplotlib.pyplot as plt
import csv
import trimesh

from utils import *

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--input_path', type=str, default='')
    parser.add_argument('--mode', type=str, default='')
    parser.add_argument('--gt_path', type=str, default='')
    parser.add_argument('--output_dir', type=str, default='')
    args = parser.parse_args()

    # Parameters
    INPUT_PATH = args.input_path
    MODE = args.mode
    GT_PATH = args.gt_path
    OUTPUT_DIR = args.output_dir
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)

    # Load ground-truth point cloud
    gt_mesh = trimesh.load(GT_PATH)
    gt_pcd = gt_mesh.vertices
    min_vertex = np.min(gt_pcd, axis=0)
    max_vertex = np.max(gt_pcd, axis=0)
    scene_size = np.linalg.norm(max_vertex - min_vertex)
    thresh = scene_size / 1200

    # Load input mesh or point cloud
    if MODE == 'mesh':
        # Read mesh
        input_mesh = trimesh.load(INPUT_PATH)
        vertices = input_mesh.vertices
        faces = input_mesh.faces.astype(np.int32)

        # Upsample mesh to create point cloud
        tri_vert = vertices[faces]
        input_pcd = upsampling_mesh(tri_vert, thresh)
        input_pcd = np.concatenate((input_pcd, vertices), axis=0)

        # Remove points that are too close to each other
        nn_engine = skln.NearestNeighbors(n_neighbors=1, radius=thresh, algorithm='kd_tree', n_jobs=-1)
        nn_engine.fit(input_pcd)
        rnn_idxs = nn_engine.radius_neighbors(input_pcd, radius=thresh, return_distance=False)
        mask = np.ones(input_pcd.shape[0], dtype=np.bool_)
        for curr, idxs in enumerate(rnn_idxs):
            if mask[curr]:
                mask[idxs] = 0
                mask[curr] = 1
        input_pcd = input_pcd[mask]

    elif MODE == 'pcd':
        input_mesh = trimesh.load(INPUT_PATH)
        input_pcd = input_mesh.vertices

    # Remove NaNs
    input_pcd = input_pcd[~np.isnan(input_pcd).any(axis=1),:]

    # Shuffle points
    shuffle_rng = np.random.default_rng()
    shuffle_rng.shuffle(input_pcd, axis=0)

    # Compute distances from data point cloud to ground-truth point cloud
    nn_engine = skln.NearestNeighbors(n_neighbors=1, algorithm='kd_tree', n_jobs=-1)
    nn_engine.fit(gt_pcd)
    dist_data2gt, _ = nn_engine.kneighbors(input_pcd, n_neighbors=1, return_distance=True)

    # Compute distances from ground-truth point cloud to data point cloud
    nn_engine.fit(input_pcd)
    dist_gt2data, _ = nn_engine.kneighbors(gt_pcd, n_neighbors=1, return_distance=True)

    # Compute chamfer distance
    chamfer_dist_1 = np.mean(dist_data2gt)
    chamfer_dist_2 = np.mean(dist_gt2data)
    chamfer_dist = (chamfer_dist_1 + chamfer_dist_2) / 2

    # Write the data to a CSV file
    with open(f'{OUTPUT_DIR}/chamfer_distance.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['data2gt', 'gt2data', 'mean'])
        writer.writerow([chamfer_dist_1, chamfer_dist_2, chamfer_dist])

    # Compute precision, recall and F-score
    values_dist = np.linspace(0.001, 1.5, 1000)
    precisions = np.zeros(len(values_dist))
    recalls = np.zeros(len(values_dist))
    fscores = np.zeros(len(values_dist))

    for i, value_dist in enumerate(values_dist):
        sum_good_reconstruction_data2gt = np.sum(dist_data2gt < value_dist)
        sum_good_reconstruction_gt2data = np.sum(dist_gt2data < value_dist)
        precision = sum_good_reconstruction_data2gt / len(dist_data2gt)
        recall = sum_good_reconstruction_gt2data / len(dist_gt2data)
        fscore = 2 * precision * recall / (precision + recall)

        # Store the values
        precisions[i] = precision
        recalls[i] = recall
        fscores[i] = fscore

    # Write the data to a CSV file
    with open(f'{OUTPUT_DIR}/results.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(values_dist)
        writer.writerow(precisions)
        writer.writerow(recalls)
        writer.writerow(fscores)

    # Generate a visualization mesh of the distance, map the distance to the jet colormap
    vis_dist = chamfer_dist
    data_color = np.zeros(input_pcd.shape)
    data_alpha = dist_data2gt.clip(max=vis_dist) / vis_dist
    data_color = plt.cm.jet(data_alpha)[:,0,:3]
    write_vis_pcd(f'{OUTPUT_DIR}/vis_data2gt.ply', input_pcd, data_color)
    gt_color = np.zeros(gt_pcd.shape)
    gt_alpha = dist_gt2data.clip(max=vis_dist) / vis_dist
    gt_color = plt.cm.jet(gt_alpha)[:,0,:3]
    write_vis_pcd(f'{OUTPUT_DIR}/vis_gt2data.ply', gt_pcd, gt_color)
    