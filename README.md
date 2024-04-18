 # ![](./assets/logo-inline.png) Meshroom Research 

Meshroom Research is a library and a plugin for [Meshroom](https://alicevision.org/#meshroom), a free, open-source 3D Reconstruction Software leveraging an easy-to-use [nodal](https://en.wikipedia.org/wiki/Node_graph_architecture) UI and architecture.
Meshroom Research focuses on making, integrating, testing and benchmarking various methods easily into Meshroom's UI.
Dependencies are kept to a bare minimum, [Conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) is used extensively instead.  
It is implemented in Python and will likely remain so.

## Features 

### Support for state-of-the-art datasets

Meshroom Research supports opening and viewing the ground truth data of the following datasets:

- [ETH3D](https://www.eth3d.net/overview)
- [DTU](https://roboimagedata.compute.dtu.dk/?page_id=36)
- [BlendedMVG](https://github.com/YoYo000/BlendedMVS)
- [Nerf synthetic](https://www.matthewtancik.com/nerf)
- [ALab synthetic dataset](https://github.com/alicevision/MeshroomResearch/tree/main/alab_dataset)
- [Tanks and Temples](https://www.tanksandtemples.org/) (TBA)
- [Skoltech3D](https://github.com/Skoltech-3D/sk3d_data) (TBA)


To do so, drag and drop the images from the dataset in Meshroom, as you would do for a normal dataset. 
Add the node LoadDataset on the camera init's output and select the dataset type.
You may now use meshroom's visualisation and nodes on the outputs. 

https://github.com/alicevision/MeshroomResearch/assets/72275161/974c2127-157c-43de-8898-26bcc9676b15

### 3D Reconstruction methods nodes

We integrated the following 3D reconstruction methods into their own node pipelines.

Classical photogrametry:
  - Meshroom
  - COLMAP

Deep-learning-based depth map estimation:
  - VIZ-mvsnet

Optimisation-based via NerfStudio  (TBA):
  - Instant-ngp
  - Gaussian Splatting

### Benchmarking

Meshroom Research provides a way to evaluate the different steps of the photograpmetry pipeline (SfM, depth map estimation and meshing).
The nodes [CalibrationComparison](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/benchmark/CalibrationComparison.py), [DepthMapComparison](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/benchmark/DepthMapComparison.py) and [MeshComparison](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/benchmark/MeshComparisonBaptise.py)

You may use the provided Meshroom project and run the benchmark with the command line interface.

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

You may also create you own evaluation pipeline with the evaluation nodes.

### 3rd party imports and exports

Meshroom Research can also import and export data from the following software:

- [COLMAP](https://colmap.github.io/)
  - Import SfM calibration (node [Colmap2MeshroomSfmConvertions](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/colmap/Colmap2MeshroomSfmConvertions.py) )
  - Import computed depth (node [ImportColmapDepthMaps](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/colmap/ImportColmapDepthMaps.py) )
  - Export SfM Calibration (node [Meshroom2ColmapSfmConvertions](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/colmap/Meshroom2ColmapSfmConvertions.py) )
- [RealityCapture](https://www.capturingreality.com/)
  - Import SfM calibration (node [ImportXMP](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/reality_capture/ImportXMP.py))
  - Export SfM Calibration (node [ExportXMP](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/nodes/reality_capture/ExportXMP.py))
- [Metashape](https://www.agisoft.com/) (TBA)

### New nodes

Meshroom research also adds a few new nodes to make it easy to play with 3D reconstruction data.
The list of added nodes can be found in [nodes](mrrs/nodes/README.md).

## Install

:warning: The installation method is a work in progress 

:warning: Working in a virtual environment (e.g. conda) is highly recommended.

Install Meshroom and alicevision  by cloning the repo and downloading the binaries following [this procedure](https://github.com/alicevision/Meshroom).

Install openimageIO and its python bindings (e.g. [from conda](https://anaconda.org/conda-forge/openimageio)).

Then clone and install Meshroom Research with pip:
```
git clone https://github.com/alicevision/MeshroomResearch.git
pip install -e MeshroomResearch
```

## Dev quickstart

You are very welcome to add your own method or dataset to Meshroom Research!

The organisation is the following:
- mrrs/core contains all the basic IOs, utils and common geometrical functions used through the library
- mrrs/pipeline contains Meshrom pipeline files
- mrrs/scripts contains all the scripts, including those used to run the benchmark
- mrrs/nodes contains the interface nodes for integration in Meshroom
- mrrs/< feature > contains code realated to the target feature.
  
Meshroom was designed to interact with a nodal GUI; this organically defines the code's structure as independent modules with distinct inputs and outputs. All the intermetiates results of each node of the graph (the pipeline) are dumped into a cache folder eponypm to the node.\
These files can be opened easily because they are in a standard format (exr, obj, abc, json, etc.).

Follow the guides on [Meshroom's repo](https://github.com/alicevision/Meshroom) to learn how to mak custom nodes.

We have a new type of node [CondaNode](https://github.com/alicevision/MeshroomResearch/blob/main/mrrs/core/CondaNode.py), inheriting command line node, but automatically building conda environments and running the code from it.
Just override the variables `env_file` or `env_path` with the path to your yaml file or the path to the built conda environments respectively. 



