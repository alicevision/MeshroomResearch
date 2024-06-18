{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2024.1.0-develop",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "CameraInit": "9.0",
            "LoadDataset": "3.0"
        }
    },
    "graph": {
        "LoadDataset_1": {
            "nodeType": "LoadDataset",
            "position": [
                -205,
                100
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 410,
                "split": 1
            },
            "uids": {
                "0": "42eeb3380c8def49f2ba4cb3d1f3ba0a1eac0989"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_2.output}",
                "datasetType": "blendedMVG",
                "initSfmLandmarks": 0.0001,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputSfMData": "{cache}/{nodeType}/{uid0}/sfm.sfm",
                "depthMapsFolder": "{cache}/{nodeType}/{uid0}/depth_maps",
                "mesh": "{cache}/{nodeType}/{uid0}/mesh.ply",
                "maskFolder": "{cache}/{nodeType}/{uid0}/masks",
                "depthmaps": "{cache}/{nodeType}/{uid0}/depth_maps/<VIEW_ID>_depthMap.exr"
            }
        },
        "CameraInit_2": {
            "nodeType": "CameraInit",
            "position": [
                -442,
                127
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 410,
                "split": 1
            },
            "uids": {
                "0": "41025ecb4ccc7f1b7a259411818fa7abbdd57c09"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 922725,
                        "poseId": 922725,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000331.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 4540318,
                        "poseId": 4540318,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000200.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 14405468,
                        "poseId": 14405468,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000101.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 15925245,
                        "poseId": 15925245,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000078.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 31221963,
                        "poseId": 31221963,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000153.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 31464017,
                        "poseId": 31464017,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000003.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 35849083,
                        "poseId": 35849083,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000309.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 37190527,
                        "poseId": 37190527,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000137.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 45246783,
                        "poseId": 45246783,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000110.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 60562662,
                        "poseId": 60562662,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000347.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 62181430,
                        "poseId": 62181430,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000350.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 62487103,
                        "poseId": 62487103,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000299.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 76578556,
                        "poseId": 76578556,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000223.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 83122024,
                        "poseId": 83122024,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000087.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 101793660,
                        "poseId": 101793660,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000117.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 104236408,
                        "poseId": 104236408,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000398.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 109410131,
                        "poseId": 109410131,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000238.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 112314201,
                        "poseId": 112314201,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000202.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 117547668,
                        "poseId": 117547668,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000274.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 118078081,
                        "poseId": 118078081,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000208.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 137520836,
                        "poseId": 137520836,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000405.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 141261503,
                        "poseId": 141261503,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000132.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 141624517,
                        "poseId": 141624517,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000175.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 142877604,
                        "poseId": 142877604,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000050.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 143562917,
                        "poseId": 143562917,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000176.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 145693180,
                        "poseId": 145693180,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000250.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 146711048,
                        "poseId": 146711048,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000306.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 152892988,
                        "poseId": 152892988,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000206.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 160352772,
                        "poseId": 160352772,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000254.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 167767875,
                        "poseId": 167767875,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000278.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 169092694,
                        "poseId": 169092694,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000185.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 169332138,
                        "poseId": 169332138,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000184.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 169698684,
                        "poseId": 169698684,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000257.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 175144703,
                        "poseId": 175144703,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000367.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 180321977,
                        "poseId": 180321977,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000024.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 183323180,
                        "poseId": 183323180,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000371.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 187796692,
                        "poseId": 187796692,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000286.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 189899870,
                        "poseId": 189899870,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000332.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 199428349,
                        "poseId": 199428349,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000139.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 201185144,
                        "poseId": 201185144,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000199.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 207187684,
                        "poseId": 207187684,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000169.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 208833192,
                        "poseId": 208833192,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000249.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 211999106,
                        "poseId": 211999106,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000062.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 213687669,
                        "poseId": 213687669,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000077.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 214007790,
                        "poseId": 214007790,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000373.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 216242083,
                        "poseId": 216242083,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000023.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 219192579,
                        "poseId": 219192579,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000158.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 223847965,
                        "poseId": 223847965,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000163.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 223886114,
                        "poseId": 223886114,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000075.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 234002358,
                        "poseId": 234002358,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000341.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 238373849,
                        "poseId": 238373849,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000221.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 238808754,
                        "poseId": 238808754,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000145.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 251715697,
                        "poseId": 251715697,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000092.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 256086843,
                        "poseId": 256086843,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000234.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 259840129,
                        "poseId": 259840129,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000296.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 262977141,
                        "poseId": 262977141,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000256.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 270495037,
                        "poseId": 270495037,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000154.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 283060760,
                        "poseId": 283060760,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000100.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 285187164,
                        "poseId": 285187164,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000152.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 289368453,
                        "poseId": 289368453,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000315.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 295780948,
                        "poseId": 295780948,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000324.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 295972843,
                        "poseId": 295972843,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000402.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 320591953,
                        "poseId": 320591953,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000044.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 326379277,
                        "poseId": 326379277,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000370.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 326398330,
                        "poseId": 326398330,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000340.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 331411168,
                        "poseId": 331411168,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000072.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 331976640,
                        "poseId": 331976640,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000375.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 357784437,
                        "poseId": 357784437,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000016.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 358542710,
                        "poseId": 358542710,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000129.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 360140754,
                        "poseId": 360140754,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000133.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 367353858,
                        "poseId": 367353858,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000182.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 367812046,
                        "poseId": 367812046,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000406.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 370604106,
                        "poseId": 370604106,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000042.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 371944294,
                        "poseId": 371944294,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000029.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 378887654,
                        "poseId": 378887654,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000138.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 385142986,
                        "poseId": 385142986,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000280.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 392554917,
                        "poseId": 392554917,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000126.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 394040318,
                        "poseId": 394040318,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000121.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 400545225,
                        "poseId": 400545225,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000354.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 412967876,
                        "poseId": 412967876,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000041.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 416092887,
                        "poseId": 416092887,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000379.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 418467805,
                        "poseId": 418467805,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000157.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 418981695,
                        "poseId": 418981695,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000017.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 424181870,
                        "poseId": 424181870,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000302.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 430393859,
                        "poseId": 430393859,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000269.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 436672151,
                        "poseId": 436672151,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000190.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 440816010,
                        "poseId": 440816010,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000285.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 446086525,
                        "poseId": 446086525,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000052.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 455713821,
                        "poseId": 455713821,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000053.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 466566611,
                        "poseId": 466566611,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000103.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 475337404,
                        "poseId": 475337404,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000219.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 477796688,
                        "poseId": 477796688,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000067.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 478510879,
                        "poseId": 478510879,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000363.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 480437480,
                        "poseId": 480437480,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000048.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 487627306,
                        "poseId": 487627306,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000351.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 489787862,
                        "poseId": 489787862,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000276.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 492915502,
                        "poseId": 492915502,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000270.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 497008439,
                        "poseId": 497008439,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000020.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 498394498,
                        "poseId": 498394498,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000237.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 498817134,
                        "poseId": 498817134,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000281.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 500760239,
                        "poseId": 500760239,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000026.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 506225132,
                        "poseId": 506225132,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000089.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 516776780,
                        "poseId": 516776780,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000323.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 516838922,
                        "poseId": 516838922,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000345.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 519688411,
                        "poseId": 519688411,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000027.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 520072779,
                        "poseId": 520072779,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000377.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 523437896,
                        "poseId": 523437896,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000186.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 524660526,
                        "poseId": 524660526,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000028.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 525938189,
                        "poseId": 525938189,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000308.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 531828860,
                        "poseId": 531828860,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000395.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 533231675,
                        "poseId": 533231675,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000035.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 534715341,
                        "poseId": 534715341,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000258.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 536455154,
                        "poseId": 536455154,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000085.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 538669226,
                        "poseId": 538669226,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000195.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 542657162,
                        "poseId": 542657162,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000217.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 562049661,
                        "poseId": 562049661,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000179.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 563358225,
                        "poseId": 563358225,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000174.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 574055693,
                        "poseId": 574055693,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000259.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 591832924,
                        "poseId": 591832924,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000378.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 591955169,
                        "poseId": 591955169,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000264.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 594400875,
                        "poseId": 594400875,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000021.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 595926377,
                        "poseId": 595926377,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000366.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 600886910,
                        "poseId": 600886910,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000319.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 601447024,
                        "poseId": 601447024,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000151.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 617700228,
                        "poseId": 617700228,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000390.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 633020303,
                        "poseId": 633020303,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000040.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 655596517,
                        "poseId": 655596517,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000022.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 661526100,
                        "poseId": 661526100,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000120.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 663128405,
                        "poseId": 663128405,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000181.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 666139183,
                        "poseId": 666139183,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000124.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 673944203,
                        "poseId": 673944203,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000150.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 677938313,
                        "poseId": 677938313,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000218.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 686063938,
                        "poseId": 686063938,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000265.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 694694668,
                        "poseId": 694694668,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000311.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 700304037,
                        "poseId": 700304037,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000368.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 714139678,
                        "poseId": 714139678,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000170.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 723118716,
                        "poseId": 723118716,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000019.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 724168981,
                        "poseId": 724168981,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000060.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 725559663,
                        "poseId": 725559663,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000313.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 730124976,
                        "poseId": 730124976,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000376.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 731297730,
                        "poseId": 731297730,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000130.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 748523474,
                        "poseId": 748523474,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000148.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 762947839,
                        "poseId": 762947839,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000356.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 773723409,
                        "poseId": 773723409,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000261.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 774902657,
                        "poseId": 774902657,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000000.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 779160497,
                        "poseId": 779160497,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000013.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 779466414,
                        "poseId": 779466414,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000030.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 782058354,
                        "poseId": 782058354,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000115.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 788082947,
                        "poseId": 788082947,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000197.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 788145471,
                        "poseId": 788145471,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000111.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 793295330,
                        "poseId": 793295330,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000282.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 800847391,
                        "poseId": 800847391,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000295.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 804398120,
                        "poseId": 804398120,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000084.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 807806443,
                        "poseId": 807806443,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000108.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 823637163,
                        "poseId": 823637163,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000352.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 838489442,
                        "poseId": 838489442,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000047.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 842723856,
                        "poseId": 842723856,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000156.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 855013325,
                        "poseId": 855013325,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000136.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 857432130,
                        "poseId": 857432130,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000173.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 870302467,
                        "poseId": 870302467,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000387.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 875822273,
                        "poseId": 875822273,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000233.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 882808414,
                        "poseId": 882808414,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000093.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 886167831,
                        "poseId": 886167831,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000096.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 886299666,
                        "poseId": 886299666,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000369.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 901119118,
                        "poseId": 901119118,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000372.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 903241936,
                        "poseId": 903241936,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000304.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 906011428,
                        "poseId": 906011428,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000099.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 909834551,
                        "poseId": 909834551,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000342.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 913596710,
                        "poseId": 913596710,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000271.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 915987395,
                        "poseId": 915987395,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000034.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 920876226,
                        "poseId": 920876226,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000063.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 926112589,
                        "poseId": 926112589,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000391.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 927133342,
                        "poseId": 927133342,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000046.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 934186899,
                        "poseId": 934186899,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000131.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 940342876,
                        "poseId": 940342876,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000291.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 944172696,
                        "poseId": 944172696,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000051.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 944578036,
                        "poseId": 944578036,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000061.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 950887043,
                        "poseId": 950887043,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000346.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 959986503,
                        "poseId": 959986503,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000300.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 967371315,
                        "poseId": 967371315,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000069.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 969373700,
                        "poseId": 969373700,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000002.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 969971114,
                        "poseId": 969971114,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000326.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 983259614,
                        "poseId": 983259614,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000394.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 986848688,
                        "poseId": 986848688,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000266.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 987034977,
                        "poseId": 987034977,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000109.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 987132641,
                        "poseId": 987132641,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000066.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 987969731,
                        "poseId": 987969731,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000102.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 992191851,
                        "poseId": 992191851,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000240.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 998321112,
                        "poseId": 998321112,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000364.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 998861053,
                        "poseId": 998861053,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000141.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1004953137,
                        "poseId": 1004953137,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000086.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1006220382,
                        "poseId": 1006220382,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000149.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1014216017,
                        "poseId": 1014216017,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000043.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1019043954,
                        "poseId": 1019043954,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000303.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1019083812,
                        "poseId": 1019083812,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000080.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1022978341,
                        "poseId": 1022978341,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000207.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1024990259,
                        "poseId": 1024990259,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000112.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1027308578,
                        "poseId": 1027308578,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000118.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1044559443,
                        "poseId": 1044559443,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000325.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1046764305,
                        "poseId": 1046764305,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000321.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1053368091,
                        "poseId": 1053368091,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000189.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1055551704,
                        "poseId": 1055551704,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000172.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1062334757,
                        "poseId": 1062334757,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000183.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1068415580,
                        "poseId": 1068415580,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000054.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1071037845,
                        "poseId": 1071037845,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000388.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1081382831,
                        "poseId": 1081382831,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000147.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1098380316,
                        "poseId": 1098380316,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000119.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1101111608,
                        "poseId": 1101111608,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000212.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1102434698,
                        "poseId": 1102434698,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000127.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1102918904,
                        "poseId": 1102918904,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000094.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1110945978,
                        "poseId": 1110945978,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000334.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1113080571,
                        "poseId": 1113080571,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000210.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1113696290,
                        "poseId": 1113696290,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000125.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1115449523,
                        "poseId": 1115449523,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000407.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1117019651,
                        "poseId": 1117019651,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000317.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1119152068,
                        "poseId": 1119152068,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000243.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1123063899,
                        "poseId": 1123063899,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000191.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1125913911,
                        "poseId": 1125913911,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000409.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1126880534,
                        "poseId": 1126880534,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000393.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1128497737,
                        "poseId": 1128497737,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000245.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1128535369,
                        "poseId": 1128535369,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000289.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1130932406,
                        "poseId": 1130932406,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000267.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1132619155,
                        "poseId": 1132619155,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000294.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1134316144,
                        "poseId": 1134316144,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000090.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1134377790,
                        "poseId": 1134377790,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000011.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1134610203,
                        "poseId": 1134610203,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000201.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1135196058,
                        "poseId": 1135196058,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000193.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1135645904,
                        "poseId": 1135645904,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000123.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1135751423,
                        "poseId": 1135751423,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000275.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1138110007,
                        "poseId": 1138110007,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000036.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1143888160,
                        "poseId": 1143888160,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000014.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1148701711,
                        "poseId": 1148701711,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000171.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1163416822,
                        "poseId": 1163416822,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000187.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1171568877,
                        "poseId": 1171568877,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000025.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1174719712,
                        "poseId": 1174719712,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000097.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1201835474,
                        "poseId": 1201835474,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000079.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1202475581,
                        "poseId": 1202475581,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000113.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1212659202,
                        "poseId": 1212659202,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000273.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1221267944,
                        "poseId": 1221267944,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000357.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1226125978,
                        "poseId": 1226125978,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000211.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1233489454,
                        "poseId": 1233489454,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000284.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1240255730,
                        "poseId": 1240255730,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000220.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1275765589,
                        "poseId": 1275765589,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000339.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1276085872,
                        "poseId": 1276085872,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000168.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1277276771,
                        "poseId": 1277276771,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000203.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1297479089,
                        "poseId": 1297479089,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000263.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1307988937,
                        "poseId": 1307988937,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000140.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1317051883,
                        "poseId": 1317051883,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000279.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1330663101,
                        "poseId": 1330663101,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000106.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1342251122,
                        "poseId": 1342251122,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000404.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1355301915,
                        "poseId": 1355301915,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000225.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1356257757,
                        "poseId": 1356257757,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000070.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1356266890,
                        "poseId": 1356266890,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000242.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1365582915,
                        "poseId": 1365582915,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000359.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1370125081,
                        "poseId": 1370125081,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000055.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1371894302,
                        "poseId": 1371894302,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000226.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1378596746,
                        "poseId": 1378596746,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000396.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1384390920,
                        "poseId": 1384390920,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000001.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1388651599,
                        "poseId": 1388651599,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000116.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1389601292,
                        "poseId": 1389601292,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000287.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1394182884,
                        "poseId": 1394182884,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000268.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1394985707,
                        "poseId": 1394985707,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000253.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1395168357,
                        "poseId": 1395168357,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000382.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1395477572,
                        "poseId": 1395477572,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000082.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1399397419,
                        "poseId": 1399397419,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000144.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1400979052,
                        "poseId": 1400979052,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000213.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1420327747,
                        "poseId": 1420327747,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000353.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1421731752,
                        "poseId": 1421731752,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000333.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1423322416,
                        "poseId": 1423322416,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000355.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1427448795,
                        "poseId": 1427448795,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000104.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1435945545,
                        "poseId": 1435945545,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000178.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1440116393,
                        "poseId": 1440116393,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000068.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1440269618,
                        "poseId": 1440269618,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000161.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1440543555,
                        "poseId": 1440543555,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000246.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1444064703,
                        "poseId": 1444064703,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000348.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1448598375,
                        "poseId": 1448598375,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000403.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1457068314,
                        "poseId": 1457068314,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000316.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1457083608,
                        "poseId": 1457083608,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000227.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1459524882,
                        "poseId": 1459524882,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000248.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1460688482,
                        "poseId": 1460688482,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000380.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1471897815,
                        "poseId": 1471897815,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000236.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1472160807,
                        "poseId": 1472160807,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000038.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1474639392,
                        "poseId": 1474639392,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000006.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1474665417,
                        "poseId": 1474665417,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000222.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1478504435,
                        "poseId": 1478504435,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000360.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1501224602,
                        "poseId": 1501224602,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000005.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1502854213,
                        "poseId": 1502854213,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000381.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1509998567,
                        "poseId": 1509998567,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000330.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1511993311,
                        "poseId": 1511993311,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000293.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1516127182,
                        "poseId": 1516127182,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000392.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1519136389,
                        "poseId": 1519136389,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000298.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1519433152,
                        "poseId": 1519433152,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000073.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1524200037,
                        "poseId": 1524200037,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000134.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1535067863,
                        "poseId": 1535067863,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000098.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1539684012,
                        "poseId": 1539684012,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000358.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1551202893,
                        "poseId": 1551202893,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000384.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1566304185,
                        "poseId": 1566304185,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000277.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1567571782,
                        "poseId": 1567571782,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000010.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1579388524,
                        "poseId": 1579388524,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000128.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1586503801,
                        "poseId": 1586503801,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000091.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1586728368,
                        "poseId": 1586728368,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000204.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1594229271,
                        "poseId": 1594229271,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000155.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1595878012,
                        "poseId": 1595878012,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000336.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1599186763,
                        "poseId": 1599186763,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000008.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1601824059,
                        "poseId": 1601824059,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000007.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1612577091,
                        "poseId": 1612577091,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000310.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1612878780,
                        "poseId": 1612878780,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000188.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1614786543,
                        "poseId": 1614786543,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000307.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1617381936,
                        "poseId": 1617381936,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000383.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1636801105,
                        "poseId": 1636801105,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000361.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1638811128,
                        "poseId": 1638811128,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000335.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1639113558,
                        "poseId": 1639113558,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000338.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1640873276,
                        "poseId": 1640873276,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000192.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1641026566,
                        "poseId": 1641026566,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000328.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1645055463,
                        "poseId": 1645055463,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000032.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1654002603,
                        "poseId": 1654002603,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000205.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1656297772,
                        "poseId": 1656297772,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000386.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1671975082,
                        "poseId": 1671975082,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000252.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1675114862,
                        "poseId": 1675114862,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000105.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1675145984,
                        "poseId": 1675145984,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000177.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1677036038,
                        "poseId": 1677036038,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000064.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1683582770,
                        "poseId": 1683582770,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000343.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1687242845,
                        "poseId": 1687242845,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000301.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1689191732,
                        "poseId": 1689191732,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000224.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1704023527,
                        "poseId": 1704023527,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000081.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1705029406,
                        "poseId": 1705029406,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000255.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1708353115,
                        "poseId": 1708353115,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000076.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1715561927,
                        "poseId": 1715561927,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000400.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1727552383,
                        "poseId": 1727552383,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000180.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1736710894,
                        "poseId": 1736710894,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000015.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1736721472,
                        "poseId": 1736721472,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000230.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1739466535,
                        "poseId": 1739466535,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000318.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1739517980,
                        "poseId": 1739517980,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000389.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1751566045,
                        "poseId": 1751566045,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000088.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1754493635,
                        "poseId": 1754493635,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000214.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1772059906,
                        "poseId": 1772059906,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000247.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1775854343,
                        "poseId": 1775854343,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000244.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1781375726,
                        "poseId": 1781375726,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000288.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1784739236,
                        "poseId": 1784739236,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000312.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1785685720,
                        "poseId": 1785685720,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000374.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1787128213,
                        "poseId": 1787128213,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000399.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1789743298,
                        "poseId": 1789743298,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000232.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1790794354,
                        "poseId": 1790794354,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000196.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1794261821,
                        "poseId": 1794261821,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000349.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1797502465,
                        "poseId": 1797502465,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000305.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1798393962,
                        "poseId": 1798393962,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000167.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1799573866,
                        "poseId": 1799573866,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000162.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1804924265,
                        "poseId": 1804924265,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000095.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1812942882,
                        "poseId": 1812942882,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000122.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1818486030,
                        "poseId": 1818486030,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000198.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1831072214,
                        "poseId": 1831072214,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000365.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1836078181,
                        "poseId": 1836078181,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000083.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1836110069,
                        "poseId": 1836110069,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000057.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1840256475,
                        "poseId": 1840256475,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000065.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1852202865,
                        "poseId": 1852202865,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000362.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1859078879,
                        "poseId": 1859078879,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000241.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1882208579,
                        "poseId": 1882208579,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000228.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1883190725,
                        "poseId": 1883190725,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000329.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1890354289,
                        "poseId": 1890354289,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000166.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1891651477,
                        "poseId": 1891651477,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000216.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1892319048,
                        "poseId": 1892319048,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000344.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1895652106,
                        "poseId": 1895652106,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000385.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1903154712,
                        "poseId": 1903154712,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000058.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1915646065,
                        "poseId": 1915646065,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000314.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1922073689,
                        "poseId": 1922073689,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000012.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1932654565,
                        "poseId": 1932654565,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000408.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1941632191,
                        "poseId": 1941632191,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000327.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1951863029,
                        "poseId": 1951863029,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000004.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1955022580,
                        "poseId": 1955022580,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000397.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1957790579,
                        "poseId": 1957790579,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000039.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1958406723,
                        "poseId": 1958406723,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000031.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1967954963,
                        "poseId": 1967954963,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000262.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1969719631,
                        "poseId": 1969719631,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000049.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1977348261,
                        "poseId": 1977348261,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000260.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1992536875,
                        "poseId": 1992536875,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000165.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1992891898,
                        "poseId": 1992891898,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000239.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1995769273,
                        "poseId": 1995769273,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000320.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1996131949,
                        "poseId": 1996131949,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000322.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1996550861,
                        "poseId": 1996550861,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000164.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2011496683,
                        "poseId": 2011496683,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000272.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2018716772,
                        "poseId": 2018716772,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000401.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2019274816,
                        "poseId": 2019274816,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000018.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2021651865,
                        "poseId": 2021651865,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000056.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2024995373,
                        "poseId": 2024995373,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000135.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2026444878,
                        "poseId": 2026444878,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000071.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2027215529,
                        "poseId": 2027215529,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000159.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2027458007,
                        "poseId": 2027458007,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000292.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2030441118,
                        "poseId": 2030441118,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000033.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2031942794,
                        "poseId": 2031942794,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000143.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2034312596,
                        "poseId": 2034312596,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000037.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2038894659,
                        "poseId": 2038894659,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000194.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2048199164,
                        "poseId": 2048199164,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000290.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2049188130,
                        "poseId": 2049188130,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000283.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2050839945,
                        "poseId": 2050839945,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000235.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2052639525,
                        "poseId": 2052639525,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000229.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2056447359,
                        "poseId": 2056447359,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000251.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2058660250,
                        "poseId": 2058660250,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000146.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2069917860,
                        "poseId": 2069917860,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000297.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2077551557,
                        "poseId": 2077551557,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000337.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2077595701,
                        "poseId": 2077595701,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000142.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2082110816,
                        "poseId": 2082110816,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000074.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2089039762,
                        "poseId": 2089039762,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000160.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2089573543,
                        "poseId": 2089573543,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000231.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2096200585,
                        "poseId": 2096200585,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000114.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2104471792,
                        "poseId": 2104471792,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000045.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2118945286,
                        "poseId": 2118945286,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000209.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2119722148,
                        "poseId": 2119722148,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000107.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2121643189,
                        "poseId": 2121643189,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000215.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2138964929,
                        "poseId": 2138964929,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000009.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2147360608,
                        "poseId": 2147360608,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images/00000059.jpg",
                        "intrinsicId": 4148998232,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 4148998232,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 1920,
                        "height": 1080,
                        "sensorWidth": 36.0,
                        "sensorHeight": 24.0,
                        "serialNumber": "/s/prods/mvg/_source_global/users/hogm/datasets/tank_and_temples_blendedMVS/train_set/training_input/Barn/images",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "unknown",
                        "distortionInitializationMode": "none",
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "undistortionOffset": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "undistortionParams": [],
                        "locked": false
                    }
                ],
                "sensorDatabase": "${ALICEVISION_SENSOR_DB}",
                "lensCorrectionProfileInfo": "${ALICEVISION_LENS_PROFILE_INFO}",
                "lensCorrectionProfileSearchIgnoreCameraModel": true,
                "defaultFieldOfView": 45.0,
                "groupCameraFallback": "folder",
                "allowedCameraModels": [
                    "pinhole",
                    "radial1",
                    "radial3",
                    "brown",
                    "fisheye4",
                    "fisheye1",
                    "3deanamorphic4",
                    "3deradial4",
                    "3declassicld"
                ],
                "rawColorInterpretation": "LibRawWhiteBalancing",
                "colorProfileDatabase": "${ALICEVISION_COLOR_PROFILE_DB}",
                "errorOnMissingColorProfile": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/cameraInit.sfm"
            }
        }
    }
}