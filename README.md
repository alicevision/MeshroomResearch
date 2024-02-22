# Meshroom Research ![](./assets/logo-inline.png)

Meshroom Research is a library and a plugin for [Meshroom](https://alicevision.org/#meshroom), a free, open-source 3D Reconstruction Software leveraging an easy-to-use nodal GIU.
Meshroom Research focuses on making, integrating, testing and benchmarking various methods easily into Meshroom's GUI.
Dependencies are kept to a bare minimum, [conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) is used extensivelly instead.  
It is implemented in Python and will likely remain so.

## Features 

### State-of-the-art datasets integration

This plugin support opening and viewing the ground truth data of the following datasets:

- [ETH3D](https://www.eth3d.net/overview)
- [DTU](https://www.eth3d.net/overview)
- [BlendedMVG](https://www.eth3d.net/overview)
- [Nerf synthetic](https://www.eth3d.net/overview)
- Tank and temples TBA
- Skoltech3D TBA
- Our own synthetic dataset(s) TBA

To do so, drag and drop the images from the dataset in meshroom, as you would do for a normal dataset. 
Add the node LoadDataset on the camera init's output and select the dataset type.

You may now use meshroom's visualisation and nodes on the ouptuts. 

:warning: TODO: add gif load demo


### 3rd party imports and exports

Meshroom reasearch can also import and export data from the follwoing softwares:

- [COLMAP](https://colmap.github.io/)
- [REALITY](https://www.capturingreality.com/)
- Metashape (TBA)

:warning: TODO:  explanation and GIF

### SfM, Depth maps, Meshing benchmarking


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

:warning: TODO: explain benchmarking and cli, pipeline system etc..

### New nodes

Meshroom research adds a few new nodes to make it easy to play with 3D reconstruction data.
The list of added nodes can be found in [nodes](mrrs/nodes/README.md).

## Install

:warning: TODO: make proper install method

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
< optional features > may need other packages.

:warning: TODO: this prbaly needs to go
On Mikros machines:
```
rez env meshroom mrrs
```

## Meshroom Dev quickstart
The organisation is the following:
- mrrs/core contains all the basic IOs, utils and common geometrical functions used through the library
- mrrs/pipeline contains Meshrom pipeline files
- mrrs/scripts contains all the scripts, including those used to run the benchmark
- mrrs/nodes contains the interface nodes for integration in Meshroom
- mrrs/< feature > contains code realated to the target feature.
  
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

