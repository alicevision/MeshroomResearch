REM Create a synthetic dataset for testing the camera tracking pipeline from a blender file

REM Usage: .\make_dataset.bat <blender_file>.blend <output_dir>

REM Extract views, intrinsics and poses
blender -b %1 -P extract_ground_truth.py -- %2

REM Render
blender -b %1 -o %CD%\\%2\\render\\frame_ -F EXR -x 1 -a
