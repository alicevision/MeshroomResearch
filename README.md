# ![Meshroom Research Logo](./assets/logo-inline.png) Meshroom Research

**Meshroom's innovation hub** for experimenting and nurturing new ideas. 

Meshroom-Research comprises a collection of plugins for [Meshroom](https://alicevision.org/#meshroom), an intuitive, open-source 3D Reconstruction Software characterized by its nodal UI and architecture.
The primary focus of Meshroom-Research lies in seamlessly integrating, testing, and benchmarking various methods within Meshroom. Implemented in Python, it manages dependencies using [Conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html).


## Features 

### Support for State-of-the-Art Datasets

Meshroom-Research facilitates the exploration of ground truth data from several prominent datasets:

- [ETH3D](https://www.eth3d.net/overview)
- [DTU](https://roboimagedata.compute.dtu.dk/?page_id=36)
- [BlendedMVG](https://github.com/YoYo000/BlendedMVS)
- [Nerf synthetic](https://www.matthewtancik.com/nerf)
- [ALab synthetic dataset](alab_dataset)
- [Tanks and Temples](https://www.tanksandtemples.org/) (Upcoming)
- [Skoltech3D](https://github.com/Skoltech-3D/sk3d_data) (Upcoming)

Simply drag and drop images from the desired dataset into Meshroom. Then, add the LoadDataset node to the camera init's output and select the dataset type. From there, leverage Meshroom's visualization capabilities and connect nodes to the outputs.

[Example](https://github.com/alicevision/MeshroomResearch/assets/72275161/974c2127-157c-43de-8898-26bcc9676b15)

### 3D Reconstruction Method Nodes

Meshroom-Research seamlessly integrates various 3D reconstruction methods into distinct node pipelines, including:

Classical photogrammetry:
  - Meshroom
  - COLMAP

Deep-learning-based depth map estimation:
  - VIZ-mvsnet

Optimization-based via NerfStudio (Upcoming):
  - Instant-ngp
  - 3D Gaussian Splatting

### Benchmarking

Evaluate different stages of the photogrammetry pipeline (SfM, depth map estimation, and meshing) with Meshroom-Research's benchmarking capabilities. Utilize nodes such as CalibrationComparison, DepthMapComparison, and MeshComparison to assess performance. You can run benchmarks via the command line interface using the provided Meshroom project.

```bash
# Example usage
python -m benchmark run [OPTIONS] DATASET_PATH
```

Aggregate results with:

```bash
# Example usage
python -m benchmark report [OPTIONS] COMPUTED_OUTPUTS_PATH
```

Customize your evaluation pipeline with the available evaluation nodes.

### 3rd Party Imports and Exports

Meshroom-Research facilitates data import and export with various software:

- [COLMAP](https://colmap.github.io/)
  - Import SfM calibration
  - Import computed depth
  - Export SfM Calibration
- [RealityCapture](https://www.capturingreality.com/)
  - Import SfM calibration
  - Export SfM Calibration
- [Metashape](https://www.agisoft.com/) (Upcoming)

### New Nodes

Enhance your 3D reconstruction workflow with additional nodes provided by Meshroom-Research. Refer to the [nodes](mrrs/nodes/README.md) directory for a comprehensive list.

## Installation

We strongly recommend working within a virtual environment (e.g., Conda).

1. Install Meshroom and AliceVision by following [this procedure](https://github.com/alicevision/Meshroom).
2. Install openimageIO and its Python bindings, e.g., [from Conda](https://anaconda.org/conda-forge/openimageio).
3. Clone and install Meshroom-Research with pip:

```bash
git clone https://github.com/alicevision/MeshroomResearch.git
pip install -e ./MeshroomResearch
```

## Developer Quickstart

Contributions to Meshroom-Research are welcomed! Here's a quick overview of the project structure:

- `mrrs/core`: The library side of MRRS, it contains basic IOs, utilities, and common geometrical functions to be used in other plugins. /!\ Your plugin needs to handle the install and the dependencies.
- `mrrs/<feature_plugin>`: Contains the code and the nodes related to a plugin feature.
- `mrrs/meshrooPlugin.json`: Contains the list of plugins in this collection.

Utilize Meshroom's nodal UI for seamless integration, and refer to the [Meshroom's repo](https://github.com/alicevision/Meshroom) for creating custom nodes. We've introduced new types of node (eg. PluginNode and DockerNode), which automates  environment management for your convenience.

See meshroom's [plugin documentation](https://github.com/alicevision/Meshroom/tree/dev/plugin_system/meshroom/core) to leanrn how to make your own plugins.

