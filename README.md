# ![](./assets/logo-inline.png) Meshroom Research 

Meshroom-Research is a set of plugins for [Meshroom](https://alicevision.org/#meshroom), a free, open-source 3D Reconstruction Software that features an easy-to-use [nodal](https://en.wikipedia.org/wiki/Node_graph_architecture) UI and architecture.
Meshroom-Research focuses on easily integrating, testing, and benchmarking various methods into Meshroom's UI.
It is implemented in Python and the dependencies are managed using  [Conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html).

## Features 

### Support for state-of-the-art datasets

Meshroom-Research supports opening and viewing the ground truth data of the following datasets:

- [ETH3D](https://www.eth3d.net/overview)
- [DTU](https://roboimagedata.compute.dtu.dk/?page_id=36)
- [BlendedMVG](https://github.com/YoYo000/BlendedMVS)
- [Nerf synthetic](https://www.matthewtancik.com/nerf)
- [ALab synthetic dataset](alab_dataset)
- [Tanks and Temples](https://www.tanksandtemples.org/) (TBA)
- [Skoltech3D](https://github.com/Skoltech-3D/sk3d_data) (TBA)


Drag and drop the images from the dataset in Meshroom as usual. Add the node LoadDataset on the camera init's output and select the dataset type. You could now use Meshroom's visualization and connect nodes on the outputs. 

https://github.com/alicevision/MeshroomResearch/assets/72275161/974c2127-157c-43de-8898-26bcc9676b15

### 3D Reconstruction methods nodes

We integrated the following 3D reconstruction methods into their own node pipelines.

Classical photogrammetry:
  - Meshroom
  - COLMAP

Deep-learning-based depth map estimation:
  - VIZ-mvsnet

Optimisation-based via NerfStudio (TBA):
  - Instant-ngp
  - 3D Gaussian Splatting

### Benchmarking

Meshroom-Research provides a way to evaluate the different steps of the photogrammetry pipeline (SfM, depth map estimation and meshing).
The nodes [CalibrationComparison](mrrs/nodes/benchmark/CalibrationComparison.py), [DepthMapComparison](/mrrs/nodes/benchmark/DepthMapComparison.py) and [MeshComparison](mrrs/nodes/benchmark/MeshComparisonBaptise.py)

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
You need to set your environment variables as if you are running Meshroom and Meshroom-Research.
You may then aggregate the result with
```
Usage: python -m benchmark report [OPTIONS] COMPUTED_OUTPUTS_PATH

  Generate a report from a computed benchmark.

Options:
  -o, --output_folder TEXT  Output folder to generate reports into.
  --help                    Show this message and exit.
```

You could also create your own evaluation pipeline with the evaluation nodes.

### 3rd party imports and exports

With Meshroom-Research, you can also import and export data from the following software:

- [COLMAP](https://colmap.github.io/)
  - Import SfM calibration (node [Colmap2MeshroomSfmConvertions](mrrs/nodes/colmap/Colmap2MeshroomSfmConvertions.py) )
  - Import computed depth (node [ImportColmapDepthMaps](mrrs/nodes/colmap/ImportColmapDepthMaps.py) )
  - Export SfM Calibration (node [Meshroom2ColmapSfmConvertions](mrrs/nodes/colmap/Meshroom2ColmapSfmConvertions.py) )
- [RealityCapture](https://www.capturingreality.com/)
  - Import SfM calibration (node [ImportXMP](mrrs/nodes/reality_capture/ImportXMP.py))
  - Export SfM Calibration (node [ExportXMP](mrrs/nodes/reality_capture/ExportXMP.py))
- [Metashape](https://www.agisoft.com/) (TBA)

### New nodes

Meshroom-Research also adds a few new nodes to make it easy to play with 3D reconstruction data.
The list of added nodes can be found in [nodes](mrrs/nodes/README.md).

## Install

Working in a virtual environment (e.g. Conda) is highly recommended.

Install Meshroom and AliceVision by cloning the repo and downloading the binaries following [this procedure](https://github.com/alicevision/Meshroom).

Install openimageIO and its Python bindings (e.g. [from conda](https://anaconda.org/conda-forge/openimageio)).

Then clone and install Meshroom-Research with pip:
```
git clone https://github.com/alicevision/MeshroomResearch.git
pip install -e ./MeshroomResearch
```

## Dev quickstart

You are very welcome to add your own method or dataset to Meshroom-Research!

The organization is the following:
- `mrrs/core` contains all the basic IOs, utils and common geometrical functions used through the library
- `mrrs/pipeline` contains Meshrom pipeline files
- `mrrs/scripts` contains all the scripts, including those used to run the benchmark
- `mrrs/nodes` contains the interface nodes for integration in Meshroom
- `mrrs/< feature >` contains code related to the target feature.
  
Meshroom was designed to interact with a nodal UI; this organically defines the code's structure as independent modules with distinct inputs and outputs. All the intermediate results of each node of the graph (the pipeline) are dumped into a cache folder with the name of the node.\
These files can be opened easily because they are in a standard format (exr, obj, abc, json, etc.).

Follow the guides on [Meshroom's repo](https://github.com/alicevision/Meshroom) to learn how to make custom nodes.

We have a new type of node [CondaNode](mrrs/core/CondaNode.py), inheriting command line node, but automatically building Conda environments and running the code from it.
Just override the variables `env_file` or `env_path` with the path to your yaml file or the path to the built Conda environments respectively. 


