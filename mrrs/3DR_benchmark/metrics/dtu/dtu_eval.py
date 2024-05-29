import os
import multiprocessing as mp
import argparse
import csv
from PIL import Image

import numpy as np
import sklearn.neighbors as skln
from tqdm import tqdm
from scipy.io import loadmat
import json

from skimage.morphology import binary_dilation
from skimage.draw import disk


mrrs_path=os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
print("mrrs path "+mrrs_path)
# FIXME: not sure why the pip install in the env does not work, maybe because of the unsets
import sys 
sys.path.insert(0, mrrs_path)

from mrrs.core.ios import matrices_from_sfm_data 
from mrrs.core.geometry import camera_projection, transform_cg_cv

# import open3d as o3d
import trimesh

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

def sample_pcd(tri_vert):
    v1 = tri_vert[:,1] - tri_vert[:,0]
    v2 = tri_vert[:,2] - tri_vert[:,0]
    l1 = np.linalg.norm(v1, axis=-1, keepdims=True)
    l2 = np.linalg.norm(v2, axis=-1, keepdims=True)
    area2 = np.linalg.norm(np.cross(v1, v2), axis=-1, keepdims=True)
    non_zero_area = np.squeeze((area2 > 0))
    l1, l2, area2, v1, v2, tri_vert = [
        arr[non_zero_area] for arr in [l1, l2, area2, v1, v2, tri_vert]
    ]

    non_zero_area = np.squeeze((area2 > 0)[:,0])
    thr = thresh * np.sqrt(l1 * l2 / area2)
    n1 = np.floor(l1 / thr)
    n2 = np.floor(l2 / thr)

    with mp.Pool() as mp_pool:
        new_pts = mp_pool.map(sample_single_tri, ((n1[i,0], n2[i,0], v1[i:i+1], v2[i:i+1], tri_vert[i:i+1,0]) for i in range(len(n1))), chunksize=1024)

    new_pts = np.concatenate(new_pts, axis=0)
    data_pcd = np.concatenate([vertices, new_pts], axis=0)
    return data_pcd

def write_vis_pcd(file, points, colors):
    # pcd = o3d.geometry.PointCloud()
    # pcd.points = o3d.utility.Vector3dVector(points)
    # pcd.colors = o3d.utility.Vector3dVector(colors)
    # o3d.io.write_point_cloud(file, pcd)
    trimesh.points.PointCloud(points, colors).export(file)

if __name__ == '__main__':
    print("DTU Bench")
    mp.freeze_support()

    parser = argparse.ArgumentParser()
    #input
    parser.add_argument('--data', type=str)#mesh or pouit cloud
    parser.add_argument('--gt_sfm', type=str)#gt sfm
    parser.add_argument('--gt_mesh', type=str)#gt mesh
    #optional input
    parser.add_argument('--obs_mask', default='', type=str)
    parser.add_argument('--ground_plane', default='', type=str)
    parser.add_argument('--mask_folder', default='', type=str)
    #optional params
    parser.add_argument('--eval_dir', type=str, default='.')#output dir
    parser.add_argument('--mode', type=str, default='mesh', choices=['mesh', 'pcd'])
    parser.add_argument('--suffix', type=str, default='')
    parser.add_argument('--downsample_density', type=float, default=0.2)
    parser.add_argument('--patch_size', type=float, default=60)
    parser.add_argument('--max_dist', type=float, default=20)
    parser.add_argument('--visualize_threshold', type=float, default=10)
    #params for mask filtering
    parser.add_argument("--dilatation_radius", type=int, default=12, help="Radius for mask dilatation (default: 12)")
    parser.add_argument("--not_main_component", type=str, choices=["True", "False"], default=False, help="Not to keep the largest main component")
    args = parser.parse_args()

    #parse the arguments from the sfm data
    print("Loading sfm")
    sfm_data = json.load(open(args.gt_sfm, "r"))

    thresh = args.downsample_density
    if args.mode == 'mesh':
        print("Mode mesh")
        pbar = tqdm(total=10)
        pbar.set_description('read data mesh')
        data_mesh = trimesh.load(args.data)#o3d.io.read_triangle_mesh(args.data)#switch to trimesh
        data_mesh.remove_unreferenced_vertices()
        extrinsics_all_cams, intrinsics_all_cams, _, _, _, pixel_sizes_all_cams = matrices_from_sfm_data(sfm_data)

        ##Added filtering from masks
        masks = []
        if args.mask_folder != '':
            print("\nFiltering")
            # Load masks
            # opens masks in the same order as the input sfm
            for view in sfm_data["views"]:
                view_number = int(os.path.basename(view["path"]).split(".")[0])
                # masks.append(os.path.join(sfm_data["groundTruthDTU"]["obsMaskFolder"],"%03d.png"%view_number))
                masks.append(os.path.join(args.mask_folder,"%03d.png"%view_number))
            nb_images = len(masks) 
        
            dilatation_radius = args.dilatation_radius
            circle_image = np.zeros((2 * dilatation_radius - 1, 2 * dilatation_radius - 1))
            circle_image[disk((dilatation_radius - 1, dilatation_radius - 1), dilatation_radius)] = 1

            # Clean mesh using masks and camera poses
            pbar.update(1)
            pbar.set_description('project points in dilated masks')
            if len(intrinsics_all_cams) != nb_images:
                raise RuntimeError("Nonmatching mask and intrinsic resolution %d vs %d"%(nb_images, len(intrinsics_all_cams)))
            
            for i in tqdm(range(nb_images)):
                # Load mask image
                mask_image_path = masks[i]
                print("\n")
                print("Opening "+mask_image_path +" view "+sfm_data["views"][i]["path"])
                mask_image = np.array(Image.open(mask_image_path))[:, :, 0] > 0  # Assuming mask is stored in the red channel
        
                # Dilate mask
                dilated_mask = binary_dilation(mask_image, circle_image)

                # # Project 3D points onto the mask
                # points = mesh.vertices
                # projected_points = trimesh.transformations.transform_points(points, worldMats[i])
                # projected_points[:, :2] /= projected_points[:, 2, np.newaxis]  # Normalize projected points
                # projected_points = projected_points[:, :2]

                vertices = transform_cg_cv(data_mesh.vertices)
                projected_points, _ = camera_projection(vertices, extrinsics_all_cams[i], 
                                                        intrinsics_all_cams[i], pixel_sizes_all_cams[i])
                #FIXME: projection issues?
                # print(data_mesh.vertices)
                # print(projected_points)
                
                # Find points inside the image bounds
                image_height, image_width = dilated_mask.shape
                valid_points = (
                    (projected_points[:, 0] >= 0) &
                    (projected_points[:, 0] < image_width) &
                    (projected_points[:, 1] >= 0) &
                    (projected_points[:, 1] < image_height)
                )
                print("%d valid points"%projected_points[valid_points].shape[0])
                img=np.array(Image.open(sfm_data["views"][i]["path"]))
                for p in projected_points[valid_points]:
                    img[p[1],p[0],:]=[255,0,0]
                Image.fromarray(img).save(f'{args.eval_dir}/%d.png'%i)
                
                # Find points inside the mask
                points_inside_mask = dilated_mask[
                    np.floor(projected_points[valid_points, 1]).astype(int),
                    np.floor(projected_points[valid_points, 0]).astype(int)
                ]
                # Ensure both arrays have the same size
                valid_points_inside_mask = np.ones_like(valid_points, dtype=bool)
                valid_points_inside_mask[valid_points] = points_inside_mask
                # Remove points and corresponding faces outside the mask
                valid_faces = np.any(valid_points_inside_mask[data_mesh.faces], axis=1)
                data_mesh = data_mesh.submesh([valid_faces])[0]

        # Ensure only one component of the mesh is kept
        pbar.update(1)
        
        if args.not_main_component == "False":
            pbar.set_description('keep only the largest component mesh')
            mesh_components = data_mesh.split(only_watertight=False)
            largest_component = max(mesh_components, key=lambda comp: len(comp.vertices))
            print("Nb vertices before %d and after %d largest component "%(data_mesh.vertices.shape[0],largest_component.vertices.shape[0] ))
            data_mesh = largest_component
        # Save cleaned mesh
        pbar.update(1)
        pbar.set_description('export cleaned mesh')
        
        data_mesh.export(f'{args.eval_dir}/cleaned_mesh.obj')

        pbar.update(1)
        pbar.set_description('done')
        pbar.close()

        mp.freeze_support()

        vertices = np.asarray(data_mesh.vertices)
        triangles = np.asarray(data_mesh.faces).astype(np.int32)
        tri_vert = vertices[triangles]

        pbar.update(1)
        pbar.set_description('sample pcd from mesh')
        data_pcd = sample_pcd(tri_vert)

    elif args.mode == 'pcd':
        print("Mode point cloud")
        pbar = tqdm(total=9)
        pbar.set_description('read data pcd')
        # data_pcd_o3d = o3d.io.read_point_cloud(args.data)
        # data_pcd = np.asarray(data_pcd_o3d.points)
        mesh=trimesh.load(args.data)
        data_pcd=mesh.vertices

    print("\nBenching")
    data_pcd = data_pcd[~np.isnan(data_pcd).any(axis=1),:]
    pbar.update(1)
    pbar.set_description('random shuffle pcd index')
    shuffle_rng = np.random.default_rng()
    shuffle_rng.shuffle(data_pcd, axis=0)

    pbar.update(1)
    nn_engine = skln.NearestNeighbors(n_neighbors=1, radius=thresh, algorithm='kd_tree', n_jobs=-1)
    nn_engine.fit(data_pcd)
   
    #rnn_idxs = nn_engine.radius_neighbors(data_pcd[0:100], radius=thresh, return_distance=False)

    if os.path.exists(f'{args.eval_dir}/data_down.ply'):#load the sampling if already computed 
        print("loading tmp file from "+'{args.eval_dir}/data_down.ply')
        data_down = trimesh.load_mesh(f'{args.eval_dir}/data_down.ply').vertices
        print("%d points loaded"%data_down.shape[0])
    else:#compute it onterhwise
        pbar.set_description('Computing neighbors for %d points'%(data_pcd.shape[0]))
        mask = np.ones(data_pcd.shape[0], dtype=np.bool_)
        #for curr, idxs in enumerate(rnn_idxs):
        CHUNKS = 100
        chunk_size= int(data_pcd.shape[0]/CHUNKS)+1
        pbar.set_description('Computing neighbors for %d points (chunksize %d)'%(data_pcd.shape[0], chunk_size))
        for chunk in range(CHUNKS):
            print("%d/%d"%(chunk, CHUNKS))
            chunk_indices=range(chunk*chunk_size, min((chunk+1)*chunk_size,data_pcd.shape[0]) )
            #select poin that have at least N neigbosr nearby? discard the neigs
            #note this returns indices in the original data, so it is safely chunkable
            rnn_idxs = nn_engine.radius_neighbors(data_pcd[chunk_indices], radius=thresh, return_distance=False)
            for curr, idxs in zip(chunk_indices, rnn_idxs):#FIXME: parralelise that
                if mask[curr]:
                    mask[idxs] = 0
                    mask[curr] = 1
            
        data_down = data_pcd[mask]
        print("saving tmp file in "+'{args.eval_dir}/data_down.ply')
        #trimesh.PointCloud(data_down).export(f'{args.eval_dir}/data_down.ply', "ply")
        trimesh.PointCloud(data_down).export(f'{args.eval_dir}/data_down.obj', "obj")

    #Masking using obesrvation mask
    data_in_obs = data_down
    data_in = data_down
    # inbound = np.one(data_down.shape[0])
    # grid_inbound =
    # in_obs = 
    if args.obs_mask != '':
        pbar.update(1)
        pbar.set_description('masking data pcd')
        obs_mask_file = loadmat(args.obs_mask) #loadmat(f'{args.dataset_dir}/ObsMask/ObsMask{args.scan}_10.mat')
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

    # added was added by Baptiste
    # ground_plane = loadmat(f'{args.dataset_dir}/ObsMask/Plane{args.scan}.mat')['P']
    # data_hom = np.concatenate([data_in_obs, np.ones_like(data_in_obs[:,:1])], -1)
    # data_above_bol = (ground_plane.reshape((1,4)) * data_hom).sum(-1) > 0
    # data_in_obs_above = data_in_obs[data_above_bol]

    pbar.update(1)
    pbar.set_description('read STL pcd')
    # stl_pcd = o3d.io.read_point_cloud(f'{args.dataset_dir}/Points/stl/stl{args.scan:03}_total.ply')
    # stl = np.asarray(stl_pcd.points)
    print(args.gt_mesh)
    sample_pcd(tri_vert)
    gt_mesh = trimesh.load(args.gt_mesh)
    if len(gt_mesh.faces) == 0:
        print("GT from point cloud")
        stl = gt_mesh.vertices
    else:#if mesh gt, then sample
        GT_vertices = np.asarray(gt_mesh.vertices)
        GT_triangles = np.asarray(gt_mesh.faces).astype(np.int32)
        gt_tri_vert = vertices[triangles]
        stl = sample_pcd(gt_tri_vert)
   
    #added by bapiste
    # stl_hom = np.concatenate([stl, np.ones_like(stl[:,:1])], -1)
    # stl_above_bol = (ground_plane.reshape((1,4)) * stl_hom).sum(-1) > 0
    # stl_above = stl[stl_above_bol]

    # stl_above_max = np.max(stl_above,axis=0)
    # stl_above_min = np.min(stl_above,axis=0)
    # stl_above_scale = np.sqrt(np.sum((stl_above_max - stl_above_min)**2,axis=0))

    pbar.update(1)
    pbar.set_description('compute data2stl')
    #modif by paptiste
    # nn_engine.fit(stl_above)
    # dist_d2s, idx_d2s = nn_engine.kneighbors(data_in_obs_above, n_neighbors=1, return_distance=True)
    nn_engine.fit(stl)
    dist_d2s, idx_d2s = nn_engine.kneighbors(data_in_obs, n_neighbors=1, return_distance=True)

    max_dist = args.max_dist
    mean_d2s = dist_d2s[dist_d2s < max_dist].mean()

    pbar.update(1)
    pbar.set_description('compute stl2data')

    ##FILTER ground plane
    stl_above=stl
    if args.ground_plane != '':
        #removed by baptiste
        ground_plane = loadmat(args.ground_plane)#loadmat(f'{args.dataset_dir}/ObsMask/Plane{args.scan}.mat')['P']
        stl_hom = np.concatenate([stl, np.ones_like(stl[:,:1])], -1)
        above = (ground_plane.reshape((1,4)) * stl_hom).sum(-1) > 0
        stl_above = stl[above]
    
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
    #modifs by baptist
    # data_color[ np.where(inbound)[0][grid_inbound][in_obs][data_above_bol] ] = R * data_alpha + W * (1-data_alpha)
    # data_color[ np.where(inbound)[0][grid_inbound][in_obs][data_above_bol][dist_d2s[:,0] >= max_dist] ] = G
    # write_vis_pcd(f'{args.eval_dir}/vis_{args.scan:03}_d2s{args.suffix}.ply', data_down, data_color)
    if args.obs_mask != '':
        data_color[ np.where(inbound)[0][grid_inbound][in_obs] ] = R * data_alpha + W * (1-data_alpha)
        data_color[ np.where(inbound)[0][grid_inbound][in_obs][dist_d2s[:,0] >= max_dist] ] = G
    else:
        data_color = R * data_alpha + W * (1-data_alpha)
        data_color[dist_d2s[:,0] >= max_dist] = G
    write_vis_pcd(f'{args.eval_dir}/vis_d2s.ply', data_down, data_color)

    
    stl_color = np.tile(B, (stl.shape[0], 1))
    stl_alpha = dist_s2d.clip(max=vis_dist) / vis_dist
    #modifs by baptise
    # stl_color[ np.where(stl_above_bol)[0] ] = R * stl_alpha + W * (1-stl_alpha)
    # stl_color[ np.where(stl_above_bol)[0][dist_s2d[:,0] >= max_dist] ] = G
    # write_vis_pcd(f'{args.eval_dir}/vis_{args.scan:03}_s2d{args.suffix}.ply', stl, stl_color)
    if args.ground_plane != '':
        stl_color[ np.where(above)[0] ] = R * stl_alpha + W * (1-stl_alpha)
        stl_color[ np.where(above)[0][dist_s2d[:,0] >= max_dist] ] = G
    else:
        stl_color= R * stl_alpha + W * (1-stl_alpha)
        stl_color[dist_s2d[:,0] >= max_dist] = G

    write_vis_pcd(f'{args.eval_dir}/vis_s2d.ply', stl, stl_color)

    #added by baptiste
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
    with open(f'{args.eval_dir}/result_{args.suffix}.csv', 'w', newline='') as file:
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

    over_all = (mean_d2s + mean_s2d) / 2
    print(mean_d2s, mean_s2d, over_all)