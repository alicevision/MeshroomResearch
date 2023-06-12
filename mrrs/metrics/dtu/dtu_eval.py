import os
import numpy as np
import open3d as o3d
import sklearn.neighbors as skln
from tqdm import tqdm
from scipy.io import loadmat
import multiprocessing as mp
import argparse
import csv

def sample_single_tri(input_):
    n1, n2, v1, v2, tri_vert = input_
    c = np.mgrid[:n1+1, :n2+1]
    c += 0.5
    c[0] /= max(n1, 1e-7)
    c[1] /= max(n2, 1e-7)
    c = np.transpose(c, (1,2,0))
    k = c[c.sum(axis=-1) < 1]  # m2
    q = v1 * k[:,:1] + v2 * k[:,1:] + tri_vert
    return q

def write_vis_pcd(file, points, colors):
    pcd = o3d.geometry.PointCloud()
    pcd.points = o3d.utility.Vector3dVector(points)
    pcd.colors = o3d.utility.Vector3dVector(colors)
    o3d.io.write_point_cloud(file, pcd)

if __name__ == '__main__':
    mp.freeze_support()

    parser = argparse.ArgumentParser()
    parser.add_argument('--data', type=str, default='data_in.ply')
    parser.add_argument('--scan', type=int, default=1)
    parser.add_argument('--mode', type=str, default='mesh', choices=['mesh', 'pcd'])
    parser.add_argument('--dataset_dir', type=str, default='.')
    parser.add_argument('--eval_dir', type=str, default='.')
    parser.add_argument('--suffix', type=str, default='')
    parser.add_argument('--downsample_density', type=float, default=0.2)
    parser.add_argument('--patch_size', type=float, default=60)
    parser.add_argument('--max_dist', type=float, default=20)
    parser.add_argument('--visualize_threshold', type=float, default=10)
    args = parser.parse_args()

    thresh = args.downsample_density
    if args.mode == 'mesh':
        pbar = tqdm(total=9)
        pbar.set_description('read data mesh')
        data_mesh = o3d.io.read_triangle_mesh(args.data)
        data_mesh.remove_unreferenced_vertices()

        mp.freeze_support()

        vertices = np.asarray(data_mesh.vertices)
        triangles = np.asarray(data_mesh.triangles)
        tri_vert = vertices[triangles]

        pbar.update(1)
        pbar.set_description('sample pcd from mesh')
        v1 = tri_vert[:,1] - tri_vert[:,0]
        v2 = tri_vert[:,2] - tri_vert[:,0]
        l1 = np.linalg.norm(v1, axis=-1, keepdims=True)
        l2 = np.linalg.norm(v2, axis=-1, keepdims=True)
        area2 = np.linalg.norm(np.cross(v1, v2), axis=-1, keepdims=True)
        non_zero_area = (area2 > 0)[:,0]
        l1, l2, area2, v1, v2, tri_vert = [
            arr[non_zero_area] for arr in [l1, l2, area2, v1, v2, tri_vert]
        ]
        thr = thresh * np.sqrt(l1 * l2 / area2)
        n1 = np.floor(l1 / thr)
        n2 = np.floor(l2 / thr)

        with mp.Pool() as mp_pool:
            new_pts = mp_pool.map(sample_single_tri, ((n1[i,0], n2[i,0], v1[i:i+1], v2[i:i+1], tri_vert[i:i+1,0]) for i in range(len(n1))), chunksize=1024)

        new_pts = np.concatenate(new_pts, axis=0)
        data_pcd = np.concatenate([vertices, new_pts], axis=0)
    
    elif args.mode == 'pcd':
        pbar = tqdm(total=8)
        pbar.set_description('read data pcd')
        data_pcd_o3d = o3d.io.read_point_cloud(args.data)
        data_pcd = np.asarray(data_pcd_o3d.points)

    # ?
    data_pcd = data_pcd[~np.isnan(data_pcd).any(axis=1),:]

    pbar.update(1)
    pbar.set_description('random shuffle pcd index')
    shuffle_rng = np.random.default_rng()
    shuffle_rng.shuffle(data_pcd, axis=0)

    pbar.update(1)
    pbar.set_description('downsample pcd')
    nn_engine = skln.NearestNeighbors(n_neighbors=1, radius=thresh, algorithm='kd_tree', n_jobs=-1)
    nn_engine.fit(data_pcd)
    rnn_idxs = nn_engine.radius_neighbors(data_pcd, radius=thresh, return_distance=False)
    mask = np.ones(data_pcd.shape[0], dtype=np.bool_)
    for curr, idxs in enumerate(rnn_idxs):
        if mask[curr]:
            mask[idxs] = 0
            mask[curr] = 1
    data_down = data_pcd[mask]

    # trimesh.PointCloud(data_down).export("/tmp/tmp.ply", "ply")

    pbar.update(1)
    pbar.set_description('masking data pcd')
    obs_mask_file = loadmat(f'{args.dataset_dir}/ObsMask/ObsMask{args.scan}_10.mat')
    ObsMask, BB, Res = [obs_mask_file[attr] for attr in ['ObsMask', 'BB', 'Res']]
    BB = BB.astype(np.float32)

    patch = args.patch_size
    inbound = ((data_down >= BB[:1]-patch) & (data_down < BB[1:]+patch*2)).sum(axis=-1) ==3
    data_in = data_down[inbound]

    data_grid = np.around((data_in - BB[:1]) / Res).astype(np.int32)
    grid_inbound = ((data_grid >= 0) & (data_grid < np.expand_dims(ObsMask.shape, 0))).sum(axis=-1) ==3
    data_grid_in = data_grid[grid_inbound]
    in_obs = ObsMask[data_grid_in[:,0], data_grid_in[:,1], data_grid_in[:,2]].astype(np.bool_)
    data_in_obs = data_in[grid_inbound][in_obs]

    ground_plane = loadmat(f'{args.dataset_dir}/ObsMask/Plane{args.scan}.mat')['P']
    data_hom = np.concatenate([data_in_obs, np.ones_like(data_in_obs[:,:1])], -1)
    data_above_bol = (ground_plane.reshape((1,4)) * data_hom).sum(-1) > 0
    data_in_obs_above = data_in_obs[data_above_bol]

    pbar.update(1)
    pbar.set_description('read STL pcd')
    stl_pcd = o3d.io.read_point_cloud(f'{args.dataset_dir}/Points/stl/stl{args.scan:03}_total.ply')
    stl = np.asarray(stl_pcd.points)

    stl_hom = np.concatenate([stl, np.ones_like(stl[:,:1])], -1)
    stl_above_bol = (ground_plane.reshape((1,4)) * stl_hom).sum(-1) > 0
    stl_above = stl[stl_above_bol]

    stl_above_max = np.max(stl_above,axis=0)
    stl_above_min = np.min(stl_above,axis=0)
    stl_above_scale = np.sqrt(np.sum((stl_above_max - stl_above_min)**2,axis=0))

    pbar.update(1)
    pbar.set_description('compute data2stl')
    nn_engine.fit(stl_above)
    dist_d2s, idx_d2s = nn_engine.kneighbors(data_in_obs_above, n_neighbors=1, return_distance=True)
    max_dist = args.max_dist
    mean_d2s = dist_d2s[dist_d2s < max_dist].mean()

    pbar.update(1)
    pbar.set_description('compute stl2data')
    nn_engine.fit(data_in)
    dist_s2d, idx_s2d = nn_engine.kneighbors(stl_above, n_neighbors=1, return_distance=True)
    mean_s2d = dist_s2d[dist_s2d < max_dist].mean()

    pbar.update(1)
    pbar.set_description('visualize error')
    vis_dist = args.visualize_threshold
    R = np.array([[1,0,0]], dtype=np.float64)
    G = np.array([[0,1,0]], dtype=np.float64)
    B = np.array([[0,0,1]], dtype=np.float64)
    W = np.array([[1,1,1]], dtype=np.float64)
    data_color = np.tile(B, (data_down.shape[0], 1))
    data_alpha = dist_d2s.clip(max=vis_dist) / vis_dist
    data_color[ np.where(inbound)[0][grid_inbound][in_obs][data_above_bol] ] = R * data_alpha + W * (1-data_alpha)
    data_color[ np.where(inbound)[0][grid_inbound][in_obs][data_above_bol][dist_d2s[:,0] >= max_dist] ] = G
    write_vis_pcd(f'{args.eval_dir}/vis_{args.scan:03}_d2s{args.suffix}.ply', data_down, data_color)
    stl_color = np.tile(B, (stl.shape[0], 1))
    stl_alpha = dist_s2d.clip(max=vis_dist) / vis_dist
    stl_color[ np.where(stl_above_bol)[0] ] = R * stl_alpha + W * (1-stl_alpha)
    stl_color[ np.where(stl_above_bol)[0][dist_s2d[:,0] >= max_dist] ] = G
    write_vis_pcd(f'{args.eval_dir}/vis_{args.scan:03}_s2d{args.suffix}.ply', stl, stl_color)

    pbar.update(1)
    pbar.set_description('compute scores')
    over_all = (mean_d2s + mean_s2d) / 2
    # print(mean_d2s, mean_s2d, over_all)

    # filtering outliers
    dist_d2s_filt = dist_d2s[dist_d2s < max_dist]
    dist_s2d_filt = dist_s2d[dist_s2d < max_dist]

    # F-score
    dist_thr_mm_list = np.arange(1,11,1)
    precisions = []
    recalls = []
    fscores = []
    for ii in range(len(dist_thr_mm_list)):
        dist_thr_mm = dist_thr_mm_list[ii]

        precision = np.count_nonzero(dist_d2s_filt < dist_thr_mm) / dist_d2s_filt.size
        recall = np.count_nonzero(dist_s2d_filt < dist_thr_mm) / dist_s2d_filt.size
        fscore = 2*precision*recall/(precision+recall)

        precisions.append(precision)
        recalls.append(recall)
        fscores.append(fscore)

    scores_tab = np.zeros((len(dist_thr_mm_list),4))
    scores_tab[:,0] = dist_thr_mm_list
    scores_tab[:,1] = precisions
    scores_tab[:,2] = recalls
    scores_tab[:,3] = fscores

    if not os.path.exists(args.eval_dir):
        os.makedirs(args.eval_dir)

    # Write the data to a CSV file
    with open(f'{args.eval_dir}/result_{args.scan:03}{args.suffix}.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['data2stl','stl2data'])
        writer.writerow([mean_d2s, mean_s2d])
        writer.writerow([''])
        writer.writerow(['distance thr','precision','recall','f-score'])
        for ii in range(len(scores_tab)):
            writer.writerow(scores_tab[ii,:])
    
    pbar.update(1)
    pbar.set_description('done')
    pbar.close()