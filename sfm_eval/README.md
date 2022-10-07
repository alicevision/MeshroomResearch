# Sfm Evaluation

This directory contains several files used to evaluate the quality of the CameraTracking pipeline in Meshroom with synthetic datasets generated from 3D scenes made in Blender.

**Warning**: Windows only for now

## Dataset generation

To generate a synthetic dataset, one must first create a Blender file with a scene named "Scene" and a camera named "Camera" (which are the default names when creating a new project).
In the output properties, set the image dimension to 1920x1080 (which is also the default).

Once this is done, run the `make_dataset.bat` script.
This script will do 2 things: 
- extract all the necessary data from the Blender scene and output 2 .sfm files (`gt.sfm` and `gt_no_pose.sfm`)
- render the animation created in the Blender file.

## Quality evaluation

This process is manual for now but will be automated later: 
- launch Meshroom and open `sfmEvaluation.mg`
- in the SfmData attribute of the FeatureExtraction and DistortionCalibration nodes, write the path to the `gt_no_pose.sfm` file
- in the Reference attribute of the SfmAlignment node and in the GtSfmData attribute of the CalibrationComparison node, write the path to the `gt.sfm` file
- launch the graph calculation
- the evaluation results are in the `calibration_comparison.csv` file produced by the CalibrationComparison node.
