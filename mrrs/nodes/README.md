
# New MeshroomResearch nodes

The following new nodes are added to Meshroom, you may find them by right click on the graph > MRRS.

## Benchmark and data nodes

### BlendedMVSDataset
This node will open the [BlendedMVS](https://github.com/YoYo000/BlendedMVS) dataset and convert it to Meshroom .sfm format.\
You might want to rescale and recenter the calibration and ground truth depth since they might not be in the same coordinate system as the output of the sfm.

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



## New features nodes

### Segmentation
A node to perform segmentation on any kind of input images.

The following segmentation methods are available :
- Instance segmentation with [Mask R-CNN](https://arxiv.org/abs/1703.06870)
- Semantic segmentation with [FcnResnet50](http://pytorch.org/vision/master/models/generated/torchvision.models.segmentation.fcn_resnet50.html)

While this node uses pre-train ONNX models - called with Python OpenCV, by looking through each module you may determine how it was exported, in case retraining is necessary.\
This will ouptut an EXR file with each channel containing a mask per class (255 for True), the class name is the channel name.\
Optionally, you may specify one or several classes to be used as a mask in the rest of the pipeline.


#### DeepMVS
This node will call deep multiview stereo methods: it will take images and calibration as input ands will return corresponding depth maps.
TBA

### DeepDepthRefinement
This node will call deep depth map refinement methods: it will take depths maps and corresponding images as input and will return a refined depth maps.
.
TBA

## Colmap Nodes

You may use Colmap Nodes to run [Colmap](https://github.com/colmap/colmap) inside of Meshroom.
For this, you need to add colmap to your path.

TBA convertions
TBA list nodes
