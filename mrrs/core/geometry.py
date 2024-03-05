"""
Module that contains 2D and 3D geometrical operations
"""
import numpy as np
import logging

#what is condidered a small float
EPSILON = 1e-4

GG_CV_MAT33 = np.asarray([[1,0,0],[0,-1,0],[0,0,-1]])
GG_CV_MAT44 = np.asarray([[1,0,0,0],[0,-1,0,0],[0,0,-1,0],[0,0,0,1]])

#%% vector operations
def make_homogeneous(input_array):
    """
    Makes an input matrix homogeneous
    """
    return np.concatenate([input_array, np.ones(shape=(input_array.shape[0], 1))], axis=-1)

def unmake_homogeneous(input_array):
    """
    Normalises and remove the last component
    """
    input_matrix_last = input_array[:, -1]
    for i in range(input_array.shape[-1] - 1):
        input_array[:, i] = input_array[:, i] / input_matrix_last
    return input_array[:, :-1]

def make_unit(input_array):
    """
    make unit along the last dimention
    """
    norm = np.sqrt(np.sum(np.power(input_array,2), axis=-1))
    input_array[..., :] /= np.stack([norm, norm, norm], axis=-1)  # need the stack for broadcasting
    return input_array

#%% Camera projections
def camera_projection(vertices, extrinsic, intrinsic, pixel_size):
    """
    Compute the projection of 3d points according to the pinhole camera projection model
    """
    vertices_homo = vertices
    if vertices.shape[-1] != 4:#if not homo make homo
        vertices_homo = make_homogeneous(vertices)
    # project vertices into the camera
    extrinsic = np.linalg.inv(np.concatenate([extrinsic, [[0, 0, 0, 1]]], axis=0))[0:3, 0:4]
    # vertices in camera CS
    vertices_camera_cs = extrinsic @ np.transpose(vertices_homo)
    vertices_distances_from_cam = vertices_camera_cs[2, :].copy()  # save this for visibility approx
    # projection onto the camera plane
    vertices_projected = np.transpose(intrinsic @ vertices_camera_cs)
    #normalises and reduce dim
    vertices_projected = unmake_homogeneous(vertices_projected)
    # convert into pixel coordinates
    vertices_projected = vertices_projected / pixel_size
    vertices_projected = np.round(vertices_projected).astype(np.int32)  # FIXME: this should be optional
    return vertices_projected[:, 0:2], vertices_distances_from_cam

def camera_deprojection(pixels, depth_map, extrinsic, intrinsic, pixel_size):
    """
    Compute the projection of 3d points according to the pinhole camera projection model
    """
    #flatten and convert pixels to m
    xs, ys = pixels
    xs=xs.reshape([-1])
    ys=ys.reshape([-1])
    pixels = np.stack([xs, ys], axis=-1)*pixel_size
    Zs = depth_map.flatten()
    pixel_homo = make_homogeneous(pixels)
    inv_intrinsics = np.linalg.inv(intrinsic[0:3,0:3])
    # rays in camera coordinate system
    ray_camera_cs = np.transpose(np.matmul(inv_intrinsics, np.transpose(pixel_homo)))
    #project to z plane
    XYZ_cam=ray_camera_cs*np.expand_dims(Zs, -1)
    #pass into world cs
    invextrinsic = extrinsic#np.linalg.inv(np.concatenate([extrinsic, [[0,0,0,1]]]))
    scene_points = np.transpose(np.matmul(invextrinsic[0:3,0:3],np.transpose(XYZ_cam)))+invextrinsic[0:3,3]
    return scene_points

def camera_deprojection_meshroom(pixels, depth_map, extrinsic, intrinsic, pixel_size):
    """
    Meshroom make_units the rays before deprojection.
    This assumes depth maps neutralises this beforehand.
    """
    xs, ys = pixels
    xs=xs.reshape([-1])
    ys=ys.reshape([-1])
    pixels = np.stack([xs, ys], axis=-1)*pixel_size
    Zs = depth_map.flatten()
    pixel_homo = make_homogeneous(pixels)
    inv_intrinsic = np.linalg.inv(intrinsic[0:3,0:3])
    rays = np.transpose(extrinsic[0:3,0:3]@inv_intrinsic@np.transpose(pixel_homo))
    unit_rays = make_unit(rays)
    scene_points = np.expand_dims(Zs, -1)*unit_rays+extrinsic[0:3,3]
    return scene_points

#%% Triangle operations
def compute_triangle_area(triangle):
    """
    A utility function to calculate compute_triangle_area
    of triangle T:(A:(x1, y1),B:(x2, y2),C:(x3, y3)) where x and y are vectors.
    A, B or C may be a single point or an array of points, you can try to broadcast as well.
    Triangle can be a 3xT or 3xNxT, whith N the dimention of te triangle and T the number of triangles
    """
    if isinstance(triangle, list):
        N=len(triangle[0])
    else:
        N = triangle.shape[1]
    if N == 2:  # 2D case, support multiple triangles
        (x1, y1), (x2, y2), (x3, y3) = triangle
        area = abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0)
    else:  # triangle in N dims
        A, B, C = triangle
        AB = np.transpose(np.asarray(B) - np.asarray(A))  # vector AB
        BC = np.transpose(np.asarray(C) - np.asarray(B))  # vector BC both should broadcast
        area = abs(np.sum(np.cross(AB, BC), axis=1)) / N  # ABC = 1/2 |ABxBC|
    return area

def is_point_inside_triangle(point, triangle, exclude_border=False):  # TODO: broadcasting
    """
    A function to check whether point P:(x, y)
    lies inside the triangle T:(A:(x1, y1),B:(x2, y2),C:(x3, y3)).
    The coordinates may be scalar or 1-d arrays for broadcasting (arrays 2*N and 3*2*M)
    """
    # unpack
    # (x1, y1), (x2, y2), (x3, y3) = triangle
    # x, y = point
    # to support np arrays and tuple alike
    x1 = triangle[0][0]
    y1 = triangle[0][1]
    x2 = triangle[1][0]
    y2 = triangle[1][1]
    x3 = triangle[2][0]
    y3 = triangle[2][1]
    x = point[0]
    y = point[1]
    # calculate area of triangle ABC
    A = compute_triangle_area([(x1, y1), (x2, y2), (x3, y3)])
    # calculate area of triangle PBC
    A1 = compute_triangle_area([(x, y), (x2, y2), (x3, y3)])
    # calculate area of triangle PAC
    A2 = compute_triangle_area([(x1, y1), (x, y), (x3, y3)])
    # calculate area of triangle PAB
    A3 = compute_triangle_area([(x1, y1), (x2, y2), (x, y)])
    # Check if sum of A1, A2 and A3
    # is same as A => inside triangle
    is_inside = A == np.squeeze(A1 + A2 + A3)
    if exclude_border:  # if the point is on one of the edge of the triangle <=> area very small
        is_inside &= A1 > EPSILON
        is_inside &= A2 > EPSILON
        is_inside &= A3 > EPSILON
    return is_inside

def compute_triangle_mask(triangle):
    """
    Compute a mask array corresponding to a triangle
    """
    # compute bounding box
    triangle_bb = [
        np.amin(triangle[:, 0]),
        np.amin(triangle[:, 1]),
        np.amax(triangle[:, 0]),
        np.amax(triangle[:, 1]),
    ]  # FIXME: in //
    # triangle mask
    y, x = np.meshgrid(
        np.arange(triangle_bb[1], triangle_bb[3]), np.arange(triangle_bb[0], triangle_bb[2]), indexing="ij"
    )
    points = np.stack([x.flatten(), y.flatten()], axis=0)
    triangle_mask = is_point_inside_triangle(points, triangle).reshape(x.shape)
    return triangle_bb, triangle_mask

def barycentric_to_cartesian(barycentric_coordinates, triangle):
    """
    Returns cartesian coordinates from barycentric coordinates.
    Triangle must be 3xP with P the dim of the triangle. This supports broadcasting
    """
    return np.dot(triangle, barycentric_coordinates)

#%% Ray tracing
def distance_point_to_line(points, line_point_0, line_point_1):
    """compute distance between points and the 
        defined by line_point_0 and line_point_1"""
    # make_unitd tangent vector of the line 
    line_tan_vec = np.divide(line_point_1 - line_point_0, np.linalg.norm(line_point_1 - line_point_0))
    # signed parallel distance components btw line tangeant and point-line points
    s = np.dot(line_point_0 - points, line_tan_vec)
    t = np.dot(points - line_point_1, line_tan_vec)
    # clamped parallel distance
    h = np.maximum.reduce([s, t, np.zeros_like(s)])
    # perpendicular distance component
    c = np.cross(points - line_point_0, line_tan_vec)
    #point-line distance is hypotenus
    dist = np.sqrt(h**2+np.linalg.norm(c, axis=-1)**2)
    return dist

def vdot(a,b):
    """
    Dot product along the last dim of an array.
    """
    return np.sum(a*b, axis=-1)

def ray_triangle_intersect(ray, triangle, epsilon=EPSILON):
    """
    Numpy implementation of the Möller–Trumbore intersection algorithm.
    https://www.scratchapixel.com/lessons/3d-basic-rendering/ray-tracing-rendering-a-triangle/moller-trumbore-ray-triangle-intersection
    Assumes ray direction unit.
    Supports to be called as a ufunc.

    ray is 2*3 ((x,x,x),(x,x,x)) triangle is 3*3 ((x,x,x), (x,x,x), (x,x,x))
    """
    # unpack (cast supports tuple and np array)
    ray = np.asarray(ray)
    triangle = np.asarray(triangle)
    ray_origin = ray[0, :]
    ray_direction = ray[1, :]
    face_point_0 = triangle[0, :]
    face_point_1 = triangle[1, :]
    face_point_2 = triangle[2, :]
    # compute face plane normal
    face_edge_0 = face_point_1 - face_point_0
    face_edge_1 = face_point_2 - face_point_0
    face_plane_normal = np.cross(ray_direction, face_edge_1)
    face_0_normal_determinant = np.dot(face_edge_0, face_plane_normal)
    # negative =>  triangle is backfacing
    # close to 0 => the ray misses the triangle
    if face_0_normal_determinant < epsilon:
        return np.float32(0), np.float32(-1)  # np.Infinity
    inv_face_0_normal_determinant = 1.0 / face_0_normal_determinant
    ray_origin_face_point_0_line = ray_origin - face_point_0
    u = np.dot(ray_origin_face_point_0_line, face_plane_normal) * inv_face_0_normal_determinant
    # first test with u
    if u < 0 or u > 1:
        return np.float32(0), np.float32(-1)  # np.Infinity
    qvec = np.cross(ray_origin_face_point_0_line, face_edge_0)
    v = np.dot(ray_direction, qvec) * inv_face_0_normal_determinant
    # second test with v
    if v < 0 or u + v > 1:
        return np.float32(0), np.float32(-1)  # np.Infinity
    return np.float32(1), np.float32(np.dot(face_edge_1, qvec) * inv_face_0_normal_determinant)

def ray_triangles_intersect(ray, triangles, epsilon=EPSILON):
    """
    Numpy implementation of the Möller–Trumbore intersection algorithm.
    https://www.scratchapixel.com/lessons/3d-basic-rendering/ray-tracing-rendering-a-triangle/moller-trumbore-ray-triangle-intersection
    Assumes ray direction unit.
    Supports to be called as a ufunc.

    ray is n*2*3 ((x,x,x),(x,x,x)) triangle is 3*3 ((x,x,x), (x,x,x), (x,x,x))
    """
    # unpack (cast supports tuple and np array)
    ray = np.asarray(ray)
    triangles = np.asarray(triangles)
    ray_origin = ray[0, :]
    ray_direction = ray[1, :]
    face_point_0 = triangles[:, 0, :]
    face_point_1 = triangles[:, 1, :]
    face_point_2 = triangles[:, 2, :]
    # compute face plane normal
    face_edge_0 = face_point_1 - face_point_0
    face_edge_1 = face_point_2 - face_point_0
    face_plane_normal = np.cross(ray_direction, face_edge_1)
    face_0_normal_determinant = vdot(face_edge_0,face_plane_normal)
    # negative =>  triangle is backfacing
    # close to 0 => the ray misses the triangle
    intersect = face_0_normal_determinant < epsilon
    inv_face_0_normal_determinant = 1.0 / face_0_normal_determinant
    ray_origin_face_point_0_line = ray_origin - face_point_0
    u = vdot(ray_origin_face_point_0_line,face_plane_normal) * inv_face_0_normal_determinant
    # first test with u
    intersect &= (u > 0) & (u < 1)
    qvec = np.cross(ray_origin_face_point_0_line, face_edge_0)
    v = vdot(ray_direction, qvec) * inv_face_0_normal_determinant
    # second test with v
    intersect &= (v > 0) & (u + v < 1)

    return intersect.astype(np.bool8), vdot(face_edge_1, qvec) * inv_face_0_normal_determinant

#%% Nearest n
def nearest_neighbors_single(value, array, nb_neighbors=1, distance=lambda x, y: np.sum(np.abs(x - y) ** 2, axis=-1)):
    """
    Exhaustive search of an 'value' in 'array'.
    Returns the indices of the NN and the distances
    """
    distances = distance(value, array)
    nn_indices = np.argsort(distances)[:nb_neighbors]
    return nn_indices, distances[nn_indices]

def nearest_neighbors(array_0, array_1, nb_neighbors=1, distance=lambda x, y: np.sum(np.abs(x - y) ** 2, axis=-1)):
    """
    Return the NN for each element of array_0 in array_1
    Returns the indices of the NN and the distances
    """
    all_nn_indices = []
    all_distances = []
    method = "annoy"
    try:
        from annoy import AnnoyIndex
    except:
        logging.warn("Annoy not installed, trying with exhaustive search")
        method = "exhaustive"
    if method == "annoy":
        annoy_tree = AnnoyIndex(array_0.shape[1], "euclidean")  # FIXME: distance
        for index, element in enumerate(array_0):
            annoy_tree.add_item(index, element)
        annoy_tree.build(n_trees=10, n_jobs=-1)  # FIXME: hardcoded
        for index, element in enumerate(array_1):
            nn_indices, distances = annoy_tree.get_nns_by_vector(element, nb_neighbors, include_distances=True)
            all_nn_indices.append(nn_indices)
            all_distances.append(distances)
    else:
        # Loop version this is slow and can give oom
        for index, value in enumerate(array_0):
            print("element %d/%d" % (index, array_0.shape[0]), end="\r")
            nn_indices, distances = nearest_neighbors_single(value, array_1, nb_neighbors, distance)
            all_nn_indices.append(nn_indices)
            all_distances.append(distances)

    return all_nn_indices, all_distances

#%% Meshes
def random_sample_points_mesh(mesh, target_nb_samples):
    """
    Randomly samples points on the surface of a mesh.
    Returns an array of size nb_samplesx3
    The actual number of samples might differ from  target_nb_samples
    """
    vertices, faces = mesh
    triangles = vertices[faces]
    # compute triangle area
    faces_areas = compute_triangle_area(np.transpose(triangles, [1, 2, 0]))
    # normalise
    faces_areas /= np.sum(faces_areas)
    # get nb_sample per face
    # FIXME: round makes that we might no reach target nb of vertices, might underrepresent small faces
    # ceil+random discard=> might overrepresent small faces,
    # solution: use remainer to propagate
    nb_sample_per_face = (np.round(target_nb_samples * faces_areas)).astype(np.int32)
    all_samples = []
    # loop because i dont know how to write it in a one liner FIXME: parallelize that
    for index, (triangle, nb_sample) in enumerate(zip(triangles, nb_sample_per_face)):
        print("Sampling face %d/%d" % (index, triangles.shape[0]), end="\r")
        if nb_sample == 0:
            continue
        # random barycentric coordinates for each face
        random_baryentric_coordinates = np.random.random([nb_sample, 3])
        norm = np.sum(random_baryentric_coordinates, axis=1)
        random_baryentric_coordinates = random_baryentric_coordinates / np.stack([norm, norm, norm], axis=1)  # N*3
        # pass into euclidian coordinates
        # # loop version for reference
        # samples = []
        # for barycentric_coordinates in random_baryentric_coordinates:
        #     sample = barycentric_to_cartesian(triangle, barycentric_coordinates)
        #     samples.append(sample)
        # broadcast version
        samples = barycentric_to_cartesian(triangle, random_baryentric_coordinates)
        # saveit
        all_samples.append(samples)
    all_samples = np.concatenate(all_samples, axis=0)
    return all_samples

def mesh_transform(mesh,T):
    """
    Applies transformation to a mesh.
    """
    mesh.apply_transform(T)
    return mesh

def get_icosahedron(radius=1, translation=[0,0,0]):
    ''''Returns vertices and faces of a unit icosahedron. '''
    
    # 12 principal directions in 3D space: points on an unit icosahedron
    phi = (1+np.sqrt(5))/2    
    vertices = np.array([
        [0, 1, phi], [0,-1, phi], [1, phi, 0],
        [-1, phi, 0], [phi, 0, 1], [-phi, 0, 1]])/np.sqrt(1+phi**2)
    vertices = np.r_[vertices,-vertices]
    
    # 20 faces
    faces = np.array([
        [0,5,1], [0,3,5], [0,2,3], [0,4,2], [0,1,4], 
        [1,5,8], [5,3,10], [3,2,7], [2,4,11], [4,1,9], 
        [7,11,6], [11,9,6], [9,8,6], [8,10,6], [10,7,6], 
        [2,11,7], [4,9,11], [1,8,9], [5,10,8], [3,7,10]], dtype=int)    
    
    return radius*vertices+[translation], faces

def transform_cg_cv(vertices):
    """
    Transforms vertices from computer graphics CS to computer vision space or vice versa
    """
    transform_mat = np.asarray([[1,0,0],[0,-1,0],[0,0,-1]])
    vertices=np.transpose(transform_mat@np.transpose(vertices))
    return vertices

def is_rotation_mat(R, tolerance_threshold= EPSILON):
    return (np.abs(np.transpose(R) - np.linalg.inv(R))< tolerance_threshold ).all() and abs(np.linalg.det(R)-1)<tolerance_threshold

#%% Other
def rescale_depth(source_depth_map, target_depth_map, mask):
    """
    Finds the scale factor between two depth maps, using the median of the ratios.
    """
    ratios = source_depth_map / target_depth_map
    if mask is not None:
        ratios = ratios[~mask]
    scale = np.median(ratios)
    return source_depth_map / scale, scale

def rescale_and_center_sfm(extrinsics, intrinsics, depth_maps=None, center_camera=None):
    """
    Will rescale the poses, depth maps and intrinsics such that the poses are centered around the mean pose.
    If center_camera is not not, will use a reference camera pose and rotation instead.
    """
    extrinsics = np.asarray(extrinsics)
    intrinsics = np.asarray(intrinsics)
    depth_maps = np.asarray(depth_maps)
    # Fit all cameras in a box -1 1
    min_pose = np.min(extrinsics[:, :, 3], axis=0)
    extrinsics[:, :, 3] -= min_pose#btw 0 and max
    max_pose = np.max(extrinsics[:, :, 3])
    extrinsics[:, :, 3] /= max_pose#resize with max along all dims now btw 0-1
    extrinsics[:, :, 3] = 2*extrinsics[:, :, 3]-1#pass btw -1 1
    scale = 2/max_pose
    # rescale depth and intrinsics as well
    intrinsics *= scale
    if depth_maps is not None:
        depth_maps *= scale
    # use mean or camera X as word coordinates
    if center_camera is not None:#set given camera as origin
        center = extrinsics[center_camera, :, 3]
        rotation = extrinsics[center_camera, 0:3, 0:3]
        extrinsics[:, :, 3] -= center
        extrinsics = np.linalg.inv(rotation) @ extrinsics
    return extrinsics, intrinsics, depth_maps, scale

#%% depth maps
def compute_normals(depth_map):
    """
    Computes normal from depth maps.
    Normal are expressed from the current viewpoint.
    """#TODO: pass in world cs? or compute normal with respect to the surface?
    gradients_y, gradients_x = np.gradient(np.squeeze(depth_map))  #todo: add option to blur in case on noise
    #2d normal in homogeneous coordinates
    normal = np.dstack((-gradients_x, -gradients_y, np.ones_like(depth_map)))
    #unhomogenize => normal in 3D
    normal /= np.expand_dims(np.linalg.norm(normal, axis=2), axis=-1)
    # n = np.linalg.norm(normal, axis=2)
    # normal[:, :, 0] /= n
    # normal[:, :, 1] /= n
    # normal[:, :, 2] /= n
    return normal

