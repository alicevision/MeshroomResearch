
# New MeshroomResearch nodes

The following new nodes are added to Meshroom, you may find them by right click on the graph > MRRS.

## Benchmark and data nodes

### LoadDataset
TODO

### InjectSFMData
Meshroom relies internally on feature points from the SfM to initialise the depth estimation. Use this node with te option 'structure' to copy them into a ground truth .sfm.\
You can also use this node to overwrite some fields in the .sfm.

### DepthMapTransform
Meshroom does not represent the depth map using a conventional representation.\
It uses instead the ray unit vectors*depth to get a point distance from camera.\
This node passes from one representation to another.

### DepthMapComparison
This node can be used to benchmark the estimated depth based on a ground truth depth.\
This will ouptut a .csv file with the requested statistics.\
This calls the core.metric package.

### CalibrationComparison
This node can be used to benchmark the estimated calibration based on a ground truth calib.\
This will ouptut a .csv file with the requested statistics.\
This calls the core.metric package.

### MeshComparison
This node can be used to benchmark the estimated mesh based on a ground truth mesh.\
It will run n times the chamfer distance, using ramdom points sampled on the surface of the mesh.\
This calls the core.metric package.

## CleanMesh

TBA

## Colmap Nodes

You may use Colmap Nodes to run [Colmap](https://github.com/colmap/colmap) inside of Meshroom.
For this, you need to add colmap to your path.

TBA convertions
TBA list nodes

## Reality Capture Nodes

TODO

## Render

##

