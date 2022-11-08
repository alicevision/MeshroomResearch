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
## New nodes

The list of added nodes can be found in [nodes](mrrs/nodes/README.md).
For now it mainly adds nodes for:
- Benchmarking and dataset imports
- Experimental features sur as segmentation, deep depth refinement and deep MVS
- Support to run COLMAP

## Tools&Pipeline

You may find the following command line tools useful.

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

### Pipelines

TAB

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
