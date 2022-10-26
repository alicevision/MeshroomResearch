# Meshroom Research ![](./assets/logo-inline.png)

Meshroom Research is a library and a plugin for meshroom.\
It focuses on making, integrating, testing and benchmarking various methods easily into meshroom.\
Dependencies are kept to a minia, to retrain/export model you may have to do more complex install (cf each module).\
It is implemented in python and will likely remain so.

The organisation is the following:
- mrrs/core contains all the basic ios, utils and common geometrical functions used throught the library
- mrrs/pipeline contains meshrom pipeline files
- mrrs/scripts contains all the script used to run the benchmark
- mrrs/nodes contains the nodes interfaces for integraton in meshroom
- mrrs/< feature > contains code realated to the target feature. If several methods are solving the feature task, all methods inside MUST have the same IOs. An interface/abstract class should describe this. Each feature folder should be ideally associated to a meshroom Node.

## Install

Install meshroom: https://alicevision.org/#meshroom (or build it for yourself).

Clone this repo :
```
git clone https://github.com/alicevision/MeshroomResearch
```
Then install Meshroom Research with pip :
```
cd MRRS
pip install -e . [< optional features >]
```
< optional features > may be onnx to install the onnx runtime, meshcomparison to install the dependencies required to handle meshes.

On mikros machines:
```
rez env meshroom mrrs
```

## New MeshroomResearch nodes

The following new nodes are added to meshroom, you may find them by right click on the graph > MRRS.

### Segmentation
Node to perform segmentation on any kind on input images.

The following segmentations methods are available :
- Instance segmentation with [Mask R-CNN](https://arxiv.org/abs/1703.06870)
- Semantic segmentation with [FcnResnet50](http://pytorch.org/vision/master/models/generated/torchvision.models.segmentation.fcn_resnet50.html)

While this node uses pre-train onnx models called with python opencv, you may check how it was exported by looking in each module, in case retraining is necessary.\
This will ouptut an exr with each channel containing a mask per class (255 for the True), the class name is the channel name.\
Optionally, you may specify one or several classes to be used as a mask in the rest of the pipeline.

### BlendedMVSDataset
Will open the [BlendedMVS](https://github.com/YoYo000/BlendedMVS) dataset and convert it to the meshroom .sfm format.\
The calibration and groud truth depth may not be in the same coordinate system as the output of the sfm so you may want to rescale and recenter them.

### InjectSFMData
Meshroom relies internally on points in the sfm to initialise the depth estimation. Use this node with te option 'structure' to copy them into a groud truth .sfm.\
You can also uwe this node to overwrite some fields in the .sfm.

### TransformDepth
Meshroom does not represent the depth map using a conventional representation.\
It uses instead the ray unit vectors*depth to get a point distance from camera.\
This node passes from one representation to another.

### DepthMapComparison
Node to benchmark the estimated depth based on a ground truth depth.\
Will ouptut a .csv with the requested statistics.\
Calls the core.metric package.

### CalibrationComparison
Node to benchmark the estimated calib based on a ground truth calib.\
Will ouptut a .csv with the requested statistics.\
Calls the core.metric package.

### MeshComparison
Node to benchmark the estimated mesh based on a ground truth mesh.\
It will run n times the chamfer distance, using ramdom point sampled on the surface of the mesh.\
Calls the core.metric package.

### DeepDepthRefinement
Call deep depth map refinement methods: takes depths maps and corresponding images as input and returns a refined depth map.
TBA

### DeepMVS
Call deep multiview stereo methods methods: takes images and calibration as input ands return corresponding depth maps.
TBA

## Colmap Nodes

You may use colmap nodes to run colmap inside of meshroom.
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
You need to set your environnement variables as if you are runing meshroom and MeshroomResearch.
You may then aggregate the result with
```
Usage: python -m benchmark report [OPTIONS] COMPUTED_OUTPUTS_PATH

  Generate a report from a computed benchmark.

Options:
  -o, --output_folder TEXT  Output folder to generate reports into.
  --help                    Show this message and exit.
```

## Meshroom Dev quickstart

Meshroom is made to work with a nodal GUI; this organically define the structure of the code as intependent module with clear inputs and outputs. All the intermetiates results of a graph (pipeline) are dumped into a cache folder eponypm to the node.\
These files are in standard format (exr, obj, abc, json...) to be able to open them easily.

### Adding a meshoom node

The best way to implement a new feature is to create a new node.\
For this, one must create a new class inheritng `CliNode` or `Node` (`from meshroom.core.desc`), for a system call or a python node respectively.\
Inputs and ouptuts are simply set by populatinf the lists `inputs` and `outputs` with ...tba \
The function `processChunk(self, chunk)` is used for the callback of when a node needs to be computed.
`chunk` is ...

Custom nodes can be added to Meshroom by setting the environement variable `MESHROOM_NODES_PATH`.
Dont forget the `__init__.py` in the node folder.


tips:
plugin QT_DEBUG_PLUGINS=1 to debug


### Camera .sfm format

Each view is assigned an id, a pose id and intrisinc id\

TBA\

## Depth map format

TBA
