# Camera tracking evaluation

This directory contains several files used to evaluate the quality of the Camera tracking pipeline in Meshroom with synthetic datasets generated from 3D scenes made in Blender.

**Warning**: Windows only for now

## Usage

### Blender file

To generate a synthetic dataset, start by creating a Blender file with a scene named "Scene" and a camera named "Camera" (which are the default names when creating a new project).
In the output properties, set the image dimension to 1920x1080 (which is also the default).

### Evaluation script

Once this is done, open the `eval.bat` script and set `BLENDER_FILE` and `DATASET_DIR` variables.

Then, in a terminal, go to the `eval` folder and run the `eval.bat` script. 

This script will do 3 things: 
- render the images from the animation created in the Blender file (in `DATASET_DIR/render`)
- extract the views, poses and intrinsics from the Blender scene and output 2 `.sfm` files (`gt.sfm` and `gt_no_pose.sfm` in `DATASET_DIR`)
- launch the camera tracking evaluation pipeline in Meshroom using the `DATASET_DIR` as input and store the calibration comparison results in `DATASET_DIR`.
