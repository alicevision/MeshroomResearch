# Meshroom Research ![](./assets/logo-inline.png)

Meshroom Research is a library and a plugin for Meshroom.\
It focuses on making, integrating, testing and benchmarking various methods easily into Meshroom.\
Dependencies are kept to a bare minimum. To re-train/export model(s), you may have to do more complex install (cf each module).\
It is implemented in Python and will likely remain so.

The organisation is the following:
- mrrs/core contains all the basic IOs, utils and common geometrical functions used through the library
- mrrs/pipeline contains Meshrom pipeline files
- mrrs/scripts contains all the scripts used to run the benchmark
- mrrs/nodes contains the interface nodes for integraton in Meshroom
- mrrs/< feature > contains code realated to the target feature. If several methods are solving the feature task, all methods inside MUST have the same IOs. An interface/abstract class should describe this. Each feature folder should be ideally associated to a Meshroom node.

## Install

Install Meshroom: https://alicevision.org/#meshroom (or build it by yourself).

Clone this repo :
```
git clone https://github.com/alicevision/MeshroomResearch
```
Then install Meshroom Research with pip :
```
cd MRRS
pip install -e . [< optional features >]
```
< optional features > may be ONNX to install the ONNX runtime, meshcomparison to install the dependencies required to handle meshes.

On Mikros machines:
```
rez env meshroom mrrs
```

## New MeshroomResearch nodes

The following new nodes are added to Meshroom, you may find them by right click on the graph > MRRS.

### Segmentation
A node to perform segmentation on any kind of input images.

The following segmentation methods are available :
- Instance segmentation with [Mask R-CNN](https://arxiv.org/abs/1703.06870)
- Semantic segmentation with [FcnResnet50](http://pytorch.org/vision/master/models/generated/torchvision.models.segmentation.fcn_resnet50.html)

While this node uses pre-train ONNX models - called with Python OpenCV, by looking through each module you may determine how it was exported, in case retraining is necessary.\
This will ouptut an EXR file with each channel containing a mask per class (255 for True), the class name is the channel name.\
Optionally, you may specify one or several classes to be used as a mask in the rest of the pipeline.

### BlendedMVSDataset
This node will open the [BlendedMVS](https://github.com/YoYo000/BlendedMVS) dataset and convert it to Meshroom .sfm format.\
You might want to rescale and recenter the calibration and ground truth depth since they might not be in the same coordinate system as the output of the sfm.

### InjectSFMData
Meshroom relies internally on feature points from the SfM to initialise the depth estimation. Use this node with te option 'structure' to copy them into a ground truth .sfm.\
You can also use this node to overwrite some fields in the .sfm.

### TransformDepth
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

### DeepDepthRefinement
This node will call deep depth map refinement methods: it will take depths maps and corresponding images as input and will return a refined depth maps.
.
TBA

### DeepMVS
This node will call deep multiview stereo methods: it will take images and calibration as input ands will return corresponding depth maps.
TBA

## Colmap Nodes

You may use Colmap Nodes to run [Colmap](https://github.com/colmap/colmap) inside of Meshroom.
For this, you need to add colmap to your path.

TBA convertions
TBA list nodes


## Tools&Pipeline

### Run the benchmark
Download the benchmark data for [blendedMVS](https://github.com/YoYo000/BlendedMVS).
Run the benchmark with the command line interface

```
Usage: python -m benchmark run [OPTIONS] DATASET_PATH

  Will run the passed pipeline on the passed dataset.

Options:
  -o, --output_folder TEXT        Output folder to generate results into.
  -p, --pipeline TEXT             Path to the benchmark pipeline.
  -r, --remove_folders            Force clean the content of outputs folder.
  -t, --dataset_type [blendedMVS]
  -c, --compute                   Runs the computation. Will just create
                                  project otherwise.
  -r, --resume                    Resumes computation if a folder exists, will
                                  skip folder otherwise.
  -s, --submit                    Will submit the computation on the grid.
  -u, --up_to_node TEXT           If computation is enabled, will compute up
                                  to the passed node.
  -e, --environnement TEXT        Runs in the specified environnement
  --help                          Show this message and exit.
```
You need to set your environnement variables as if you are runing Meshroom and MeshroomResearch.
You may then aggregate the result with
```
Usage: python -m benchmark report [OPTIONS] COMPUTED_OUTPUTS_PATH

  Generate a report from a computed benchmark.

Options:
  -o, --output_folder TEXT  Output folder to generate reports into.
  --help                    Show this message and exit.
```

## Meshroom Dev quickstart

Meshroom was designed to interact with a nodal GUI; this organically defines the code's structure as independent modules with distinct inputs and outputs. All the intermetiates results of each node of the graph (the pipeline) are dumped into a cache folder eponypm to the node.\
These files can be opened easily because they are in a standard format (exr, obj, abc, json, etc.).

### Adding a Meshroom node

The best way to implement a new feature is to create a new node.\
For this, one must create a new class inheritng `CliNode` or `Node` (`from meshroom.core.desc`), for a system call or a python node respectively.\
Inputs and ouptuts are simply set by populating the lists `inputs` and `outputs` with ...tba \
The function `processChunk(self, chunk)` is used for the callback of when a node needs to be computed.
`chunk` is ...

Custom nodes can be added to Meshroom by setting the environement variable `MESHROOM_NODES_PATH`.
Don't forget to add the `__init__.py` in the node folder.


tips:
plugin QT_DEBUG_PLUGINS=1 to debug


### Camera .sfm format

Each view is assigned an id, a pose id and intrisinc id\

TBA\

## Depth map format

TBA
