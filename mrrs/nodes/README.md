
# New MeshroomResearch nodes

The following new nodes are added to Meshroom, you may find them by right click on the graph > Meshroom Research.

## Benchmark and data nodes

### LoadDataset
This node uses the relative path of the input images to load available ground truth data.
The dataset type parameter must match the input dataset.
You may use this node to initialise fake landmarks or masks from a ground truth mesh, if any.

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

## Colmap Nodes

You may use Colmap Nodes to run [Colmap](https://github.com/colmap/colmap) inside of Meshroom.
For this, you need to add colmap to your path.

## Reality Capture Nodes

Use ExportXMP or ImportXMP to export and import XMP calibration data to and from reality capture.
Place the exported XMP in the image folder and it should be imported into reality capture.
Beware that the poses may be refined by reality capture 3D reconstruction.

## Depth Map
VizMVSNet  is integrated in the eponym node. You may use meshroom's node "SelectConnectedViews" to generate a list of views to match.
(TBA)

## Render
This node uses blender to render a mesh from cameras defined in a .sfmdata.
(TBA)

## Utility Nodes

We also provide a list of utilisty nodes routinely used.

### InjectSFMData
Meshroom relies internally on feature points from the SfM to initialise the depth estimation. Use this node with te option 'structure' to copy them into a ground truth .sfm.\
You can also use this node to overwrite some fields in the .sfm.

### CalibTransform 
Applies a transform to the input poses.


### CopyData 
Copy and exposes data from an input folder. Convenient to expose debuging data that are not node attributes.

### CutSfm 
Will extract only a part of the input view.

### DepthMapTransform
Will perform an operation on input depth maps. Used to convert the depth maps to and from meshroom's format.


