# Camera tracking evaluation steps

# Variables
export BLENDER_FILE=/path/to/blender/file.blend
export SCENE_NAME=Scene
export CAMERA_NAME=Camera
export DATASET_DIR=/path/to/dataset/folder

# Render images
blender -b ${BLENDER_FILE} -o ${DATASET_DIR}/render/frame_ -F EXR -x 1 -a

# Extract views, intrinsics and poses
blender -b ${BLENDER_FILE} -P extract_ground_truth.py -- ${DATASET_DIR} ${SCENE_NAME} ${CAMERA_NAME}

# Meshroom environment variables
export MESHROOM_DIR=/path/to/meshroom
export PYTHONPATH=/path/to/MeshroomResearch:${PYTHONPATH}
export MESHROOM_NODES_PATH=/path/to/MeshroomResearch/eval:${MESHROOM_NODES_PATH}

# Launch camera tracking evaluation pipeline
python ${MESHROOM_DIR}/bin/meshroom_batch \
	-i ${DATASET_DIR} \
	-p cameraTrackingEvaluation.mg \
	-o ${DATASET_DIR} \
	--forceCompute
