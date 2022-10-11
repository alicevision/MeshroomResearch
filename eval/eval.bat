REM Camera tracking evaluation steps

REM Variables
set BLENDER_FILE=C:\path\to\blender\file.blend
set DATASET_DIR=C:\path\to\dataset\folder

REM Render images
blender -b %BLENDER_FILE% -o %DATASET_DIR%\\render\\frame_ -F EXR -x 1 -a

REM Extract views, intrinsics and poses
blender -b %BLENDER_FILE% -P extract_ground_truth.py -- %DATASET_DIR%

REM Meshroom environment variables
set MESHROOM_DIR=C:\dev\meshroom
set PYTHONPATH=%MESHROOM_DIR%
set PATH=C:\dev\AliceVision\build\Windows-AMD64\Release;C:\dev\vcpkg\installed\x64-windows\bin;%PATH%
set ALICEVISION_ROOT=C:\dev\AliceVision
set MESHROOM_NODES_PATH=C:\dev\MeshroomResearch\mrrs\nodes;C:\dev\MeshroomResearch\eval

REM Launch camera tracking evaluation pipeline
python %MESHROOM_DIR%\bin\meshroom_batch -i %DATASET_DIR% -p cameraTrackingEvaluation.mg -o %DATASET_DIR%
