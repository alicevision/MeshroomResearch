{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2023.3.0-develop",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "FeatureMatching": "2.0",
            "PoissonMesher": "2.0",
            "FeatureExtraction": "1.3",
            "DepthMapFilter": "3.0",
            "CameraInit": "9.0",
            "PrepareDenseScene": "3.1",
            "MeshTransform": "3.0",
            "StructureFromMotion": "3.1",
            "Texturing": "6.0",
            "DepthMap": "4.0",
            "CopyData": "3.0",
            "ImageMatching": "2.0",
            "MeshFiltering": "3.0",
            "Meshing": "7.0"
        }
    },
    "graph": {
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                0,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 986,
                "split": 1
            },
            "uids": {
                "0": "e7f6a01507def579c143e79f82708e4b1ef4b12f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 18373924,
                        "poseId": 18373924,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000027.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 29062991,
                        "poseId": 29062991,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000024.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 29098959,
                        "poseId": 29098959,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000025.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 31851497,
                        "poseId": 31851497,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000021.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 33192512,
                        "poseId": 33192512,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000026.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 54903734,
                        "poseId": 54903734,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000289.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 63432925,
                        "poseId": 63432925,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000284.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 65063389,
                        "poseId": 65063389,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000288.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 65314452,
                        "poseId": 65314452,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000287.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 66591803,
                        "poseId": 66591803,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000188.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 66818391,
                        "poseId": 66818391,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000189.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 79223110,
                        "poseId": 79223110,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000438.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 79621812,
                        "poseId": 79621812,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000174.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 80813897,
                        "poseId": 80813897,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000170.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 80877669,
                        "poseId": 80877669,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000171.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 82149192,
                        "poseId": 82149192,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000022.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 84105848,
                        "poseId": 84105848,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000026.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 84315626,
                        "poseId": 84315626,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000021.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 84924950,
                        "poseId": 84924950,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000177.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 87168266,
                        "poseId": 87168266,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000023.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 88373242,
                        "poseId": 88373242,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000439.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 88502673,
                        "poseId": 88502673,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000024.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 88605274,
                        "poseId": 88605274,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000175.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 90568948,
                        "poseId": 90568948,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000020.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 92727450,
                        "poseId": 92727450,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000132.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 94291210,
                        "poseId": 94291210,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000027.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 95769165,
                        "poseId": 95769165,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000130.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 97675825,
                        "poseId": 97675825,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000131.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 97726201,
                        "poseId": 97726201,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000025.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 99464094,
                        "poseId": 99464094,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000176.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 102160413,
                        "poseId": 102160413,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000028.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 102685178,
                        "poseId": 102685178,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000391.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 102988052,
                        "poseId": 102988052,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000029.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 104380828,
                        "poseId": 104380828,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000029.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 104616641,
                        "poseId": 104616641,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000028.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 104868409,
                        "poseId": 104868409,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000392.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 106615614,
                        "poseId": 106615614,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000393.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 107627618,
                        "poseId": 107627618,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000390.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 108108564,
                        "poseId": 108108564,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000239.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 117191481,
                        "poseId": 117191481,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000238.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 119095718,
                        "poseId": 119095718,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000023.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 121441012,
                        "poseId": 121441012,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000020.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 123255122,
                        "poseId": 123255122,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000022.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 123823348,
                        "poseId": 123823348,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000173.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 125196879,
                        "poseId": 125196879,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000172.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 135374133,
                        "poseId": 135374133,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000100.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 137863385,
                        "poseId": 137863385,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000103.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 139824710,
                        "poseId": 139824710,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000102.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 140637473,
                        "poseId": 140637473,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000105.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 140711023,
                        "poseId": 140711023,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000104.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 143542492,
                        "poseId": 143542492,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000094.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 151429438,
                        "poseId": 151429438,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000379.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 157385773,
                        "poseId": 157385773,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000378.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 165917822,
                        "poseId": 165917822,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000179.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 167273075,
                        "poseId": 167273075,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000101.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 167676032,
                        "poseId": 167676032,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000178.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 169639385,
                        "poseId": 169639385,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000215.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 169838979,
                        "poseId": 169838979,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000214.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 172568390,
                        "poseId": 172568390,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000217.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 176887067,
                        "poseId": 176887067,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000219.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 178334540,
                        "poseId": 178334540,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000051.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 178544253,
                        "poseId": 178544253,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000218.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 178612744,
                        "poseId": 178612744,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000050.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 179179239,
                        "poseId": 179179239,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000052.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 187287826,
                        "poseId": 187287826,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000122.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 189607981,
                        "poseId": 189607981,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000121.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 190926343,
                        "poseId": 190926343,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000059.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 193891799,
                        "poseId": 193891799,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000079.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 193966659,
                        "poseId": 193966659,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000078.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 195559426,
                        "poseId": 195559426,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000071.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 195688532,
                        "poseId": 195688532,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000126.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 195993050,
                        "poseId": 195993050,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000127.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 196593146,
                        "poseId": 196593146,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000073.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 197661872,
                        "poseId": 197661872,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000070.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 198785792,
                        "poseId": 198785792,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000072.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 199145045,
                        "poseId": 199145045,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000058.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 200573108,
                        "poseId": 200573108,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000125.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 201292414,
                        "poseId": 201292414,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000075.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 201426095,
                        "poseId": 201426095,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000120.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 203586820,
                        "poseId": 203586820,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000074.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 206752128,
                        "poseId": 206752128,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000128.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 207601367,
                        "poseId": 207601367,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000077.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 208525283,
                        "poseId": 208525283,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000076.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 208642820,
                        "poseId": 208642820,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000129.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 211186428,
                        "poseId": 211186428,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000123.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 211435540,
                        "poseId": 211435540,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000124.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 212117471,
                        "poseId": 212117471,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000491.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 212217771,
                        "poseId": 212217771,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000329.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 218881648,
                        "poseId": 218881648,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000196.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 220320782,
                        "poseId": 220320782,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000197.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 226742953,
                        "poseId": 226742953,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000211.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 227499499,
                        "poseId": 227499499,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000216.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 230804780,
                        "poseId": 230804780,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000213.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 233254131,
                        "poseId": 233254131,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000210.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 234679375,
                        "poseId": 234679375,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000212.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 239964421,
                        "poseId": 239964421,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000191.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 240866183,
                        "poseId": 240866183,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000190.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 243972270,
                        "poseId": 243972270,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000195.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 245375464,
                        "poseId": 245375464,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000193.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 246255824,
                        "poseId": 246255824,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000160.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 247414438,
                        "poseId": 247414438,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000192.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 248885838,
                        "poseId": 248885838,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000194.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 252803121,
                        "poseId": 252803121,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000494.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 253074232,
                        "poseId": 253074232,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000497.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 254784456,
                        "poseId": 254784456,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000496.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 255602070,
                        "poseId": 255602070,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000493.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 255960205,
                        "poseId": 255960205,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000328.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 256182971,
                        "poseId": 256182971,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000162.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 256837055,
                        "poseId": 256837055,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000490.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 257527795,
                        "poseId": 257527795,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000161.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 259104139,
                        "poseId": 259104139,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000163.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 260066357,
                        "poseId": 260066357,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000321.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 260430929,
                        "poseId": 260430929,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000455.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 260468444,
                        "poseId": 260468444,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000456.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 260723811,
                        "poseId": 260723811,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000454.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 260745970,
                        "poseId": 260745970,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000198.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 262051045,
                        "poseId": 262051045,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000499.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 263000538,
                        "poseId": 263000538,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000199.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 263290055,
                        "poseId": 263290055,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000450.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 263930912,
                        "poseId": 263930912,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000457.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 265438039,
                        "poseId": 265438039,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000325.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 265586934,
                        "poseId": 265586934,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000495.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 266447518,
                        "poseId": 266447518,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000492.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 267403632,
                        "poseId": 267403632,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000498.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 267683192,
                        "poseId": 267683192,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000451.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 268239529,
                        "poseId": 268239529,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000326.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 268307492,
                        "poseId": 268307492,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000327.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 268395529,
                        "poseId": 268395529,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000324.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 270719208,
                        "poseId": 270719208,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000453.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 271240888,
                        "poseId": 271240888,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000452.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 272461624,
                        "poseId": 272461624,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000164.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 278789502,
                        "poseId": 278789502,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000095.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 279540751,
                        "poseId": 279540751,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000096.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 279975703,
                        "poseId": 279975703,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000090.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 282850098,
                        "poseId": 282850098,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000165.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 284005056,
                        "poseId": 284005056,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000043.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 286758319,
                        "poseId": 286758319,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000049.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 286905403,
                        "poseId": 286905403,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000164.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 287412263,
                        "poseId": 287412263,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000093.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 290511479,
                        "poseId": 290511479,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000091.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 292875753,
                        "poseId": 292875753,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000048.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 292923351,
                        "poseId": 292923351,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000092.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 297364595,
                        "poseId": 297364595,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000169.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 299265317,
                        "poseId": 299265317,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000046.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 299414892,
                        "poseId": 299414892,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000168.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 301076810,
                        "poseId": 301076810,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000047.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 303266580,
                        "poseId": 303266580,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000100.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 303748127,
                        "poseId": 303748127,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000322.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 304357218,
                        "poseId": 304357218,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000104.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 305260500,
                        "poseId": 305260500,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000105.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 306694898,
                        "poseId": 306694898,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000070.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 307888847,
                        "poseId": 307888847,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000072.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 308186931,
                        "poseId": 308186931,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000320.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 308214900,
                        "poseId": 308214900,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000073.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 308998198,
                        "poseId": 308998198,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000071.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 309663996,
                        "poseId": 309663996,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000103.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 309862864,
                        "poseId": 309862864,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000323.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 312178139,
                        "poseId": 312178139,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000366.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 313646313,
                        "poseId": 313646313,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000077.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 313893017,
                        "poseId": 313893017,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000076.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 316786182,
                        "poseId": 316786182,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000367.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 317393980,
                        "poseId": 317393980,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000102.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 317529663,
                        "poseId": 317529663,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000364.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 319803236,
                        "poseId": 319803236,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000074.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 321455624,
                        "poseId": 321455624,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000075.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 327287208,
                        "poseId": 327287208,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000079.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 328835376,
                        "poseId": 328835376,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000078.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 336241518,
                        "poseId": 336241518,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000148.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 338531072,
                        "poseId": 338531072,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000149.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 369520820,
                        "poseId": 369520820,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000085.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 370470624,
                        "poseId": 370470624,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000088.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 371876799,
                        "poseId": 371876799,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000086.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 372586568,
                        "poseId": 372586568,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000089.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 375793410,
                        "poseId": 375793410,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000080.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 375878422,
                        "poseId": 375878422,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000081.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 376811832,
                        "poseId": 376811832,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000178.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 376996644,
                        "poseId": 376996644,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000082.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 377609182,
                        "poseId": 377609182,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000107.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 377839674,
                        "poseId": 377839674,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000175.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 378842501,
                        "poseId": 378842501,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000176.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 379106996,
                        "poseId": 379106996,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000106.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 381816918,
                        "poseId": 381816918,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000174.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 383492973,
                        "poseId": 383492973,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000109.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 383931152,
                        "poseId": 383931152,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000084.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 385017855,
                        "poseId": 385017855,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000087.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 385527563,
                        "poseId": 385527563,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000108.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 386190789,
                        "poseId": 386190789,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000514.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 386287341,
                        "poseId": 386287341,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000511.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 387457896,
                        "poseId": 387457896,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000517.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 387625892,
                        "poseId": 387625892,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000516.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 388421680,
                        "poseId": 388421680,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000510.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 388669429,
                        "poseId": 388669429,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000515.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 393279858,
                        "poseId": 393279858,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000513.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 395649478,
                        "poseId": 395649478,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000512.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 395718105,
                        "poseId": 395718105,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000083.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 396568719,
                        "poseId": 396568719,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000518.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 398745376,
                        "poseId": 398745376,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000519.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 399748256,
                        "poseId": 399748256,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000179.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 403307995,
                        "poseId": 403307995,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000150.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 403842140,
                        "poseId": 403842140,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000039.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 405161366,
                        "poseId": 405161366,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000337.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 405579054,
                        "poseId": 405579054,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000336.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 406334714,
                        "poseId": 406334714,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000038.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 407463446,
                        "poseId": 407463446,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000177.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 413326117,
                        "poseId": 413326117,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000056.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 414963679,
                        "poseId": 414963679,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000053.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 415584579,
                        "poseId": 415584579,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000055.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 415702711,
                        "poseId": 415702711,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000334.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 418810618,
                        "poseId": 418810618,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000335.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 418984797,
                        "poseId": 418984797,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000054.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 419811118,
                        "poseId": 419811118,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000170.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 420442457,
                        "poseId": 420442457,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000057.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 420965679,
                        "poseId": 420965679,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000172.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 421940306,
                        "poseId": 421940306,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000397.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 423177070,
                        "poseId": 423177070,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000171.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 425925742,
                        "poseId": 425925742,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000173.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 425992160,
                        "poseId": 425992160,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000338.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 428611766,
                        "poseId": 428611766,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000394.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 433519843,
                        "poseId": 433519843,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000396.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 435885586,
                        "poseId": 435885586,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000395.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 446778188,
                        "poseId": 446778188,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000399.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 449356250,
                        "poseId": 449356250,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000031.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 451604408,
                        "poseId": 451604408,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000030.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 452456769,
                        "poseId": 452456769,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000033.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 452487747,
                        "poseId": 452487747,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000032.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 453372266,
                        "poseId": 453372266,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000036.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 456191957,
                        "poseId": 456191957,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000459.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 456626474,
                        "poseId": 456626474,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000458.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 456734395,
                        "poseId": 456734395,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000151.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 457801834,
                        "poseId": 457801834,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000034.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 458546848,
                        "poseId": 458546848,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000035.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 459039900,
                        "poseId": 459039900,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000398.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 460131434,
                        "poseId": 460131434,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000037.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 470666348,
                        "poseId": 470666348,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000292.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 470999557,
                        "poseId": 470999557,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000480.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 472694699,
                        "poseId": 472694699,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000481.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 476261677,
                        "poseId": 476261677,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000298.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 476948271,
                        "poseId": 476948271,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000488.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 477827666,
                        "poseId": 477827666,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000293.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 478413679,
                        "poseId": 478413679,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000224.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 478557579,
                        "poseId": 478557579,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000291.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 479323169,
                        "poseId": 479323169,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000225.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 479976637,
                        "poseId": 479976637,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000107.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 480483414,
                        "poseId": 480483414,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000223.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 480673069,
                        "poseId": 480673069,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000290.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 481026718,
                        "poseId": 481026718,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000296.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 481295943,
                        "poseId": 481295943,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000222.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 482242949,
                        "poseId": 482242949,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000108.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 483669550,
                        "poseId": 483669550,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000227.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 485585254,
                        "poseId": 485585254,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000226.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 486040903,
                        "poseId": 486040903,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000106.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 486555267,
                        "poseId": 486555267,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000295.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 488219478,
                        "poseId": 488219478,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000008.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 488490661,
                        "poseId": 488490661,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000294.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 490943248,
                        "poseId": 490943248,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000004.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 492136901,
                        "poseId": 492136901,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000109.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 492637437,
                        "poseId": 492637437,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000486.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 493372328,
                        "poseId": 493372328,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000006.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 493914457,
                        "poseId": 493914457,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000297.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 494508034,
                        "poseId": 494508034,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000487.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 495857516,
                        "poseId": 495857516,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000009.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 496604821,
                        "poseId": 496604821,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000299.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 496837098,
                        "poseId": 496837098,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000007.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 497870902,
                        "poseId": 497870902,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000005.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 498015983,
                        "poseId": 498015983,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000484.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 498881050,
                        "poseId": 498881050,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000101.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 499146322,
                        "poseId": 499146322,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000482.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 499750283,
                        "poseId": 499750283,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000000.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 499909673,
                        "poseId": 499909673,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000485.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 500005119,
                        "poseId": 500005119,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000001.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 500901743,
                        "poseId": 500901743,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000002.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 503116888,
                        "poseId": 503116888,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000483.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 503150874,
                        "poseId": 503150874,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000003.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 503540795,
                        "poseId": 503540795,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000220.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 504165861,
                        "poseId": 504165861,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000040.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 505829842,
                        "poseId": 505829842,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000042.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 506641731,
                        "poseId": 506641731,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000041.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 507835411,
                        "poseId": 507835411,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000330.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 508475255,
                        "poseId": 508475255,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000162.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 509298997,
                        "poseId": 509298997,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000163.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 509786003,
                        "poseId": 509786003,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000160.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 509913581,
                        "poseId": 509913581,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000221.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 510088952,
                        "poseId": 510088952,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000331.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 510560896,
                        "poseId": 510560896,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000161.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 511997527,
                        "poseId": 511997527,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000044.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 513466089,
                        "poseId": 513466089,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000045.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 513624225,
                        "poseId": 513624225,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000167.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 515076659,
                        "poseId": 515076659,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000166.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 520059886,
                        "poseId": 520059886,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000165.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 520681855,
                        "poseId": 520681855,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000339.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 521653361,
                        "poseId": 521653361,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000489.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 522837869,
                        "poseId": 522837869,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000228.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 527281303,
                        "poseId": 527281303,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000229.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 531528504,
                        "poseId": 531528504,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000332.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 531803824,
                        "poseId": 531803824,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000333.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 541893963,
                        "poseId": 541893963,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000003.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 542189228,
                        "poseId": 542189228,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000002.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 542597715,
                        "poseId": 542597715,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000001.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 546043729,
                        "poseId": 546043729,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000004.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 555075050,
                        "poseId": 555075050,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000180.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 557199250,
                        "poseId": 557199250,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000183.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 563734001,
                        "poseId": 563734001,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000187.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 563945143,
                        "poseId": 563945143,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000184.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 566966345,
                        "poseId": 566966345,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000182.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 574276683,
                        "poseId": 574276683,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000186.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 577113847,
                        "poseId": 577113847,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000185.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 577661241,
                        "poseId": 577661241,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000180.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 595415348,
                        "poseId": 595415348,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000181.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 596629403,
                        "poseId": 596629403,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000181.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 603353456,
                        "poseId": 603353456,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000183.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 611273716,
                        "poseId": 611273716,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000005.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 611570453,
                        "poseId": 611570453,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000006.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 611912680,
                        "poseId": 611912680,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000007.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 613182687,
                        "poseId": 613182687,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000248.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 613824541,
                        "poseId": 613824541,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000249.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 618598351,
                        "poseId": 618598351,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000437.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 619095760,
                        "poseId": 619095760,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000436.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 621152460,
                        "poseId": 621152460,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000048.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 621844399,
                        "poseId": 621844399,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000185.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 623625006,
                        "poseId": 623625006,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000049.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 624871357,
                        "poseId": 624871357,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000182.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 625500853,
                        "poseId": 625500853,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000186.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 625747813,
                        "poseId": 625747813,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000433.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 625983944,
                        "poseId": 625983944,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000044.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 627184258,
                        "poseId": 627184258,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000187.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 627250145,
                        "poseId": 627250145,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000069.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 628214077,
                        "poseId": 628214077,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000184.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 628866750,
                        "poseId": 628866750,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000045.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 629702357,
                        "poseId": 629702357,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000068.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 630160421,
                        "poseId": 630160421,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000043.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 632178008,
                        "poseId": 632178008,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000430.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 633009428,
                        "poseId": 633009428,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000431.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 655332499,
                        "poseId": 655332499,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000098.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 655663817,
                        "poseId": 655663817,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000401.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 658351732,
                        "poseId": 658351732,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000434.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 659130792,
                        "poseId": 659130792,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000009.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 661644376,
                        "poseId": 661644376,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000432.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 661943716,
                        "poseId": 661943716,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000435.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 664803546,
                        "poseId": 664803546,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000406.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 665083993,
                        "poseId": 665083993,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000407.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 666058060,
                        "poseId": 666058060,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000374.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 666065643,
                        "poseId": 666065643,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000400.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 667117501,
                        "poseId": 667117501,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000405.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 667215252,
                        "poseId": 667215252,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000094.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 669065648,
                        "poseId": 669065648,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000008.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 670254254,
                        "poseId": 670254254,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000099.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 671577249,
                        "poseId": 671577249,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000092.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 674038595,
                        "poseId": 674038595,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000236.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 674319765,
                        "poseId": 674319765,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000090.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 674740721,
                        "poseId": 674740721,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000403.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 675033653,
                        "poseId": 675033653,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000097.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 675693829,
                        "poseId": 675693829,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000237.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 675826126,
                        "poseId": 675826126,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000233.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 676677001,
                        "poseId": 676677001,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000091.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 676927717,
                        "poseId": 676927717,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000096.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 677055380,
                        "poseId": 677055380,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000402.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 678420276,
                        "poseId": 678420276,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000376.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 678425738,
                        "poseId": 678425738,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000095.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 679046340,
                        "poseId": 679046340,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000377.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 680396542,
                        "poseId": 680396542,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000235.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 683780657,
                        "poseId": 683780657,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000093.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 685991684,
                        "poseId": 685991684,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000237.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 689002661,
                        "poseId": 689002661,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000375.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 689489110,
                        "poseId": 689489110,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000236.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 691669779,
                        "poseId": 691669779,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000235.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 693048496,
                        "poseId": 693048496,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000373.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 693797153,
                        "poseId": 693797153,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000371.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 699128541,
                        "poseId": 699128541,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000239.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 700321114,
                        "poseId": 700321114,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000238.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 703241292,
                        "poseId": 703241292,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000372.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 704333707,
                        "poseId": 704333707,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000370.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 705599550,
                        "poseId": 705599550,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000344.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 706035556,
                        "poseId": 706035556,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000343.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 708768702,
                        "poseId": 708768702,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000046.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 713532011,
                        "poseId": 713532011,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000341.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 714569794,
                        "poseId": 714569794,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000413.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 715516488,
                        "poseId": 715516488,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000340.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 716071670,
                        "poseId": 716071670,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000410.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 716140202,
                        "poseId": 716140202,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000414.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 717276246,
                        "poseId": 717276246,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000412.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 718058485,
                        "poseId": 718058485,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000411.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 719145182,
                        "poseId": 719145182,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000047.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 719844935,
                        "poseId": 719844935,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000042.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 720064136,
                        "poseId": 720064136,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000342.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 720092112,
                        "poseId": 720092112,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000041.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 720583429,
                        "poseId": 720583429,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000408.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 720637118,
                        "poseId": 720637118,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000040.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 721878535,
                        "poseId": 721878535,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000300.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 723732753,
                        "poseId": 723732753,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000301.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 727039971,
                        "poseId": 727039971,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000409.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 727836015,
                        "poseId": 727836015,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000404.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 739294761,
                        "poseId": 739294761,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000234.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 742383348,
                        "poseId": 742383348,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000231.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 743821292,
                        "poseId": 743821292,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000233.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 744175540,
                        "poseId": 744175540,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000232.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 744623977,
                        "poseId": 744623977,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000230.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 762936302,
                        "poseId": 762936302,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000530.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 765287346,
                        "poseId": 765287346,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000531.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 766516025,
                        "poseId": 766516025,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000532.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 805378591,
                        "poseId": 805378591,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000134.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 807916399,
                        "poseId": 807916399,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000003.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 810468738,
                        "poseId": 810468738,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000002.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 810817032,
                        "poseId": 810817032,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000000.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 811196849,
                        "poseId": 811196849,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000135.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 811212576,
                        "poseId": 811212576,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000249.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 811600451,
                        "poseId": 811600451,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000014.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 812223007,
                        "poseId": 812223007,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000015.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 813398275,
                        "poseId": 813398275,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000136.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 816417617,
                        "poseId": 816417617,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000138.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 823092119,
                        "poseId": 823092119,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000245.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 825163630,
                        "poseId": 825163630,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000244.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 826144628,
                        "poseId": 826144628,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000247.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 828848907,
                        "poseId": 828848907,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000139.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 829520786,
                        "poseId": 829520786,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000242.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 832672739,
                        "poseId": 832672739,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000248.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 836530508,
                        "poseId": 836530508,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000246.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 844110594,
                        "poseId": 844110594,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000067.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 844118379,
                        "poseId": 844118379,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000016.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 847937495,
                        "poseId": 847937495,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000062.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 848066561,
                        "poseId": 848066561,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000065.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 849910783,
                        "poseId": 849910783,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000063.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 850810292,
                        "poseId": 850810292,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000066.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 852818842,
                        "poseId": 852818842,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000013.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853171946,
                        "poseId": 853171946,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000011.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853489560,
                        "poseId": 853489560,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000012.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853679335,
                        "poseId": 853679335,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000017.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853867215,
                        "poseId": 853867215,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000010.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 855193906,
                        "poseId": 855193906,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000064.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 856359574,
                        "poseId": 856359574,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000155.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 857579757,
                        "poseId": 857579757,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000157.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 865218133,
                        "poseId": 865218133,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000019.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 866311690,
                        "poseId": 866311690,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000132.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 866561445,
                        "poseId": 866561445,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000131.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 867656250,
                        "poseId": 867656250,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000137.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 867845985,
                        "poseId": 867845985,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000018.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 868430602,
                        "poseId": 868430602,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000133.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 869539811,
                        "poseId": 869539811,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000130.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 877496573,
                        "poseId": 877496573,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000109.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 879528481,
                        "poseId": 879528481,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000107.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 880468798,
                        "poseId": 880468798,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000105.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 887570289,
                        "poseId": 887570289,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000108.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 892123354,
                        "poseId": 892123354,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000145.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 892368924,
                        "poseId": 892368924,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000144.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 894737330,
                        "poseId": 894737330,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000147.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 896548124,
                        "poseId": 896548124,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000146.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 897647596,
                        "poseId": 897647596,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000104.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 898289603,
                        "poseId": 898289603,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000106.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899620278,
                        "poseId": 899620278,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000141.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899827834,
                        "poseId": 899827834,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000103.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899999784,
                        "poseId": 899999784,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000140.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 902405701,
                        "poseId": 902405701,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000143.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 904860505,
                        "poseId": 904860505,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000142.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 914889757,
                        "poseId": 914889757,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000240.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 916366981,
                        "poseId": 916366981,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000241.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 917737810,
                        "poseId": 917737810,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000243.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 923775819,
                        "poseId": 923775819,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000061.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 925195013,
                        "poseId": 925195013,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000261.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 925261057,
                        "poseId": 925261057,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000005.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 926080041,
                        "poseId": 926080041,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000060.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 928657125,
                        "poseId": 928657125,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000260.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 931244903,
                        "poseId": 931244903,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000262.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 931866117,
                        "poseId": 931866117,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000263.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 933824366,
                        "poseId": 933824366,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000265.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 934971555,
                        "poseId": 934971555,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000006.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 935433761,
                        "poseId": 935433761,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000004.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 936329628,
                        "poseId": 936329628,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000264.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 938798270,
                        "poseId": 938798270,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000266.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 949411077,
                        "poseId": 949411077,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000215.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 951929108,
                        "poseId": 951929108,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000219.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 952524477,
                        "poseId": 952524477,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000217.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 952872460,
                        "poseId": 952872460,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000111.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 953573352,
                        "poseId": 953573352,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000113.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 953593728,
                        "poseId": 953593728,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000110.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 954252614,
                        "poseId": 954252614,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000218.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 958096188,
                        "poseId": 958096188,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000216.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 958230226,
                        "poseId": 958230226,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000115.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 959035485,
                        "poseId": 959035485,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000214.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 960716391,
                        "poseId": 960716391,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000114.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 961090616,
                        "poseId": 961090616,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000212.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 962559720,
                        "poseId": 962559720,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000210.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 965668606,
                        "poseId": 965668606,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000416.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 967401679,
                        "poseId": 967401679,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000415.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 967445039,
                        "poseId": 967445039,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000243.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 968504038,
                        "poseId": 968504038,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000240.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 968658778,
                        "poseId": 968658778,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000211.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 969185443,
                        "poseId": 969185443,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000419.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 969789289,
                        "poseId": 969789289,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000418.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 969901938,
                        "poseId": 969901938,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000112.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 970901414,
                        "poseId": 970901414,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000241.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 971909446,
                        "poseId": 971909446,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000417.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 972688390,
                        "poseId": 972688390,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000213.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 973478045,
                        "poseId": 973478045,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000246.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 974570623,
                        "poseId": 974570623,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000244.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 976247517,
                        "poseId": 976247517,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000247.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 977476229,
                        "poseId": 977476229,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000245.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 978140780,
                        "poseId": 978140780,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000299.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 979464523,
                        "poseId": 979464523,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000242.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 981985998,
                        "poseId": 981985998,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000298.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1007874050,
                        "poseId": 1007874050,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000063.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1008277922,
                        "poseId": 1008277922,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000128.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1008561072,
                        "poseId": 1008561072,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000065.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1010699917,
                        "poseId": 1010699917,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000060.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1014222467,
                        "poseId": 1014222467,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000129.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1014814255,
                        "poseId": 1014814255,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000159.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1014917650,
                        "poseId": 1014917650,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000061.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1015687524,
                        "poseId": 1015687524,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000158.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1016069149,
                        "poseId": 1016069149,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000059.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1017653012,
                        "poseId": 1017653012,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000154.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1018854952,
                        "poseId": 1018854952,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000081.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1018860137,
                        "poseId": 1018860137,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000156.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1019075254,
                        "poseId": 1019075254,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000080.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1019940737,
                        "poseId": 1019940737,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000151.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1024269020,
                        "poseId": 1024269020,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000123.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1024938105,
                        "poseId": 1024938105,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000315.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1025857757,
                        "poseId": 1025857757,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000153.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1026786894,
                        "poseId": 1026786894,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000316.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1027379617,
                        "poseId": 1027379617,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000152.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1030297488,
                        "poseId": 1030297488,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000122.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1032184787,
                        "poseId": 1032184787,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000124.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1032370567,
                        "poseId": 1032370567,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000189.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1032451869,
                        "poseId": 1032451869,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000150.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1032846737,
                        "poseId": 1032846737,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000188.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1034378496,
                        "poseId": 1034378496,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000125.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1035111244,
                        "poseId": 1035111244,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000066.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1036487284,
                        "poseId": 1036487284,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000067.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1038344409,
                        "poseId": 1038344409,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000064.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1039491370,
                        "poseId": 1039491370,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000062.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1040291480,
                        "poseId": 1040291480,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000057.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1040587777,
                        "poseId": 1040587777,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000086.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1041519313,
                        "poseId": 1041519313,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000088.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1042661380,
                        "poseId": 1042661380,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000085.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1043696853,
                        "poseId": 1043696853,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000087.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1043938641,
                        "poseId": 1043938641,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000054.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1044248309,
                        "poseId": 1044248309,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000119.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1044516843,
                        "poseId": 1044516843,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000312.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1045969559,
                        "poseId": 1045969559,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000116.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1046198726,
                        "poseId": 1046198726,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000055.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1046935246,
                        "poseId": 1046935246,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000053.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1047456640,
                        "poseId": 1047456640,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000056.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1047526903,
                        "poseId": 1047526903,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000118.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1047791815,
                        "poseId": 1047791815,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000314.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1047999799,
                        "poseId": 1047999799,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000117.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1048549386,
                        "poseId": 1048549386,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000313.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1049145749,
                        "poseId": 1049145749,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000319.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1049798089,
                        "poseId": 1049798089,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000310.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1051147607,
                        "poseId": 1051147607,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000311.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1054211587,
                        "poseId": 1054211587,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000318.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1054451888,
                        "poseId": 1054451888,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000317.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1056016528,
                        "poseId": 1056016528,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000127.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1056765944,
                        "poseId": 1056765944,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000126.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1061082106,
                        "poseId": 1061082106,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000084.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1063440619,
                        "poseId": 1063440619,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000068.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1064669843,
                        "poseId": 1064669843,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000069.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1065178128,
                        "poseId": 1065178128,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000058.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1066225960,
                        "poseId": 1066225960,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000083.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1068600670,
                        "poseId": 1068600670,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000082.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1070362255,
                        "poseId": 1070362255,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000050.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1070558551,
                        "poseId": 1070558551,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000051.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1070857973,
                        "poseId": 1070857973,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000089.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1071719166,
                        "poseId": 1071719166,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000052.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1079763141,
                        "poseId": 1079763141,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000030.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1082847351,
                        "poseId": 1082847351,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000066.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1084013215,
                        "poseId": 1084013215,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000256.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1086822285,
                        "poseId": 1086822285,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000034.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1087533209,
                        "poseId": 1087533209,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000035.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1095222346,
                        "poseId": 1095222346,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000082.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1095337378,
                        "poseId": 1095337378,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000080.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1098528316,
                        "poseId": 1098528316,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000083.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1100154527,
                        "poseId": 1100154527,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000089.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1101800224,
                        "poseId": 1101800224,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000081.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1102823161,
                        "poseId": 1102823161,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000031.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1103498624,
                        "poseId": 1103498624,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000085.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1104667747,
                        "poseId": 1104667747,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000087.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1105461111,
                        "poseId": 1105461111,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000086.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1106326051,
                        "poseId": 1106326051,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000088.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1109731746,
                        "poseId": 1109731746,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000084.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1118771556,
                        "poseId": 1118771556,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000259.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1123070602,
                        "poseId": 1123070602,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000258.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1125032338,
                        "poseId": 1125032338,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000257.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1125375984,
                        "poseId": 1125375984,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000381.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1126041313,
                        "poseId": 1126041313,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000382.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1126849986,
                        "poseId": 1126849986,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000254.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1127184729,
                        "poseId": 1127184729,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000380.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1129504994,
                        "poseId": 1129504994,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000256.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1132494899,
                        "poseId": 1132494899,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000383.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1134175978,
                        "poseId": 1134175978,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000385.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1136901269,
                        "poseId": 1136901269,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000384.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1137859491,
                        "poseId": 1137859491,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000387.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1138274033,
                        "poseId": 1138274033,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000386.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1157946457,
                        "poseId": 1157946457,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000252.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1158201174,
                        "poseId": 1158201174,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000253.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1159161773,
                        "poseId": 1159161773,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000250.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1162840742,
                        "poseId": 1162840742,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000257.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1163431575,
                        "poseId": 1163431575,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000254.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1165662825,
                        "poseId": 1165662825,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000255.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1167372297,
                        "poseId": 1167372297,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000149.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1170367371,
                        "poseId": 1170367371,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000251.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1174852811,
                        "poseId": 1174852811,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000258.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1175404684,
                        "poseId": 1175404684,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000462.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1175964496,
                        "poseId": 1175964496,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000461.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1176047133,
                        "poseId": 1176047133,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000460.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1177830156,
                        "poseId": 1177830156,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000466.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1178309069,
                        "poseId": 1178309069,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000259.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1182210323,
                        "poseId": 1182210323,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000148.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1182640576,
                        "poseId": 1182640576,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000463.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1182925736,
                        "poseId": 1182925736,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000465.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1185078819,
                        "poseId": 1185078819,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000068.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1186765687,
                        "poseId": 1186765687,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000069.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1189397207,
                        "poseId": 1189397207,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000464.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1190048588,
                        "poseId": 1190048588,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000467.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1192666515,
                        "poseId": 1192666515,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000067.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1193558067,
                        "poseId": 1193558067,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000064.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1198119716,
                        "poseId": 1198119716,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000033.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1198184830,
                        "poseId": 1198184830,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000032.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1204122458,
                        "poseId": 1204122458,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000065.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1204699197,
                        "poseId": 1204699197,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000029.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1204960952,
                        "poseId": 1204960952,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000028.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1205226442,
                        "poseId": 1205226442,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000063.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1208247316,
                        "poseId": 1208247316,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000009.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1210325206,
                        "poseId": 1210325206,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000008.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1227066618,
                        "poseId": 1227066618,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000468.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1230350536,
                        "poseId": 1230350536,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000269.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1231007586,
                        "poseId": 1231007586,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000268.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1237559043,
                        "poseId": 1237559043,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000469.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1241003971,
                        "poseId": 1241003971,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000001.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1243954438,
                        "poseId": 1243954438,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000506.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1245936653,
                        "poseId": 1245936653,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000288.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1246083074,
                        "poseId": 1246083074,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000007.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1246583497,
                        "poseId": 1246583497,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000501.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1249078799,
                        "poseId": 1249078799,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000500.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1250445597,
                        "poseId": 1250445597,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000508.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1251013187,
                        "poseId": 1251013187,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000284.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1254011323,
                        "poseId": 1254011323,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000285.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1254029142,
                        "poseId": 1254029142,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000503.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1255883108,
                        "poseId": 1255883108,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000502.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1256618932,
                        "poseId": 1256618932,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000287.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1258334241,
                        "poseId": 1258334241,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000281.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1258803840,
                        "poseId": 1258803840,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000280.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1260034458,
                        "poseId": 1260034458,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000283.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1260950267,
                        "poseId": 1260950267,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000509.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1261295544,
                        "poseId": 1261295544,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000286.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1266557982,
                        "poseId": 1266557982,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000282.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1276924856,
                        "poseId": 1276924856,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000350.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1278153096,
                        "poseId": 1278153096,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000351.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1280383491,
                        "poseId": 1280383491,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000297.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1282124211,
                        "poseId": 1282124211,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000295.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1283283531,
                        "poseId": 1283283531,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000294.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1283468139,
                        "poseId": 1283468139,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000290.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1284632066,
                        "poseId": 1284632066,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000293.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1285899779,
                        "poseId": 1285899779,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000296.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1286341523,
                        "poseId": 1286341523,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000291.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1292091849,
                        "poseId": 1292091849,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000507.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1292249965,
                        "poseId": 1292249965,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000504.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1293284051,
                        "poseId": 1293284051,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000505.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1293576504,
                        "poseId": 1293576504,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000255.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1303387975,
                        "poseId": 1303387975,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000251.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1304742121,
                        "poseId": 1304742121,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000253.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1305085131,
                        "poseId": 1305085131,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000250.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1308205848,
                        "poseId": 1308205848,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000252.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1316395558,
                        "poseId": 1316395558,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000267.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1322693393,
                        "poseId": 1322693393,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000389.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1324036092,
                        "poseId": 1324036092,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000388.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1338138165,
                        "poseId": 1338138165,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000352.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1338824628,
                        "poseId": 1338824628,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000353.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1344914124,
                        "poseId": 1344914124,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000267.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1347172423,
                        "poseId": 1347172423,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000266.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1351317798,
                        "poseId": 1351317798,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000359.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1353630011,
                        "poseId": 1353630011,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000202.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1354642580,
                        "poseId": 1354642580,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000137.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1354865921,
                        "poseId": 1354865921,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000133.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1359197148,
                        "poseId": 1359197148,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000357.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1360449311,
                        "poseId": 1360449311,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000356.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1362744142,
                        "poseId": 1362744142,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000358.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1362755106,
                        "poseId": 1362755106,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000134.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1364852164,
                        "poseId": 1364852164,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000135.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1367304730,
                        "poseId": 1367304730,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000136.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1369980854,
                        "poseId": 1369980854,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000139.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1370145960,
                        "poseId": 1370145960,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000138.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1370741984,
                        "poseId": 1370741984,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000354.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1370808460,
                        "poseId": 1370808460,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000355.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1376295226,
                        "poseId": 1376295226,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000027.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1377133355,
                        "poseId": 1377133355,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000423.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1378596564,
                        "poseId": 1378596564,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000026.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1381386154,
                        "poseId": 1381386154,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000021.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1382007576,
                        "poseId": 1382007576,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000421.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1383517911,
                        "poseId": 1383517911,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000025.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1385776495,
                        "poseId": 1385776495,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000427.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1385962721,
                        "poseId": 1385962721,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000426.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1386038431,
                        "poseId": 1386038431,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000024.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1388990093,
                        "poseId": 1388990093,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000422.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1392457800,
                        "poseId": 1392457800,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000420.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1395283032,
                        "poseId": 1395283032,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000292.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1399527360,
                        "poseId": 1399527360,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000425.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1400335757,
                        "poseId": 1400335757,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000424.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1409404901,
                        "poseId": 1409404901,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000200.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1410165926,
                        "poseId": 1410165926,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000201.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1427145246,
                        "poseId": 1427145246,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000428.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1428756153,
                        "poseId": 1428756153,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000429.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1435063731,
                        "poseId": 1435063731,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000473.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1436064488,
                        "poseId": 1436064488,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000289.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1436344246,
                        "poseId": 1436344246,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000472.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1439156158,
                        "poseId": 1439156158,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000471.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1440201391,
                        "poseId": 1440201391,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000477.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1441462766,
                        "poseId": 1441462766,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000470.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1442335552,
                        "poseId": 1442335552,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000476.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1444846722,
                        "poseId": 1444846722,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000036.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1446565965,
                        "poseId": 1446565965,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000037.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1448468799,
                        "poseId": 1448468799,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000035.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1448532737,
                        "poseId": 1448532737,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000034.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1455405480,
                        "poseId": 1455405480,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000032.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1456379882,
                        "poseId": 1456379882,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000033.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1457330813,
                        "poseId": 1457330813,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000031.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1457709275,
                        "poseId": 1457709275,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000030.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1459814665,
                        "poseId": 1459814665,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000038.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1461916351,
                        "poseId": 1461916351,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000039.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1463161524,
                        "poseId": 1463161524,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000265.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1463606508,
                        "poseId": 1463606508,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000264.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1467125196,
                        "poseId": 1467125196,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000268.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1468260315,
                        "poseId": 1468260315,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000262.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1469350190,
                        "poseId": 1469350190,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000263.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1470401018,
                        "poseId": 1470401018,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000260.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1470585314,
                        "poseId": 1470585314,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000261.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1474859424,
                        "poseId": 1474859424,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000269.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1476596150,
                        "poseId": 1476596150,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000023.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1477094433,
                        "poseId": 1477094433,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000207.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1479202529,
                        "poseId": 1479202529,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000134.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1479609261,
                        "poseId": 1479609261,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000206.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1489386721,
                        "poseId": 1489386721,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000205.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1491502493,
                        "poseId": 1491502493,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000204.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1494391696,
                        "poseId": 1494391696,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000133.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1498021684,
                        "poseId": 1498021684,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000132.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1498282547,
                        "poseId": 1498282547,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000131.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1499849555,
                        "poseId": 1499849555,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000130.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1502676552,
                        "poseId": 1502676552,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000022.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1508583884,
                        "poseId": 1508583884,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000020.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1514054892,
                        "poseId": 1514054892,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000474.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1515253644,
                        "poseId": 1515253644,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000475.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1515962120,
                        "poseId": 1515962120,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000478.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1521827588,
                        "poseId": 1521827588,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000479.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1529173375,
                        "poseId": 1529173375,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000208.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1529980387,
                        "poseId": 1529980387,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000209.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1536187257,
                        "poseId": 1536187257,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000059.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1536547891,
                        "poseId": 1536547891,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000058.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1545778574,
                        "poseId": 1545778574,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000051.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1550294548,
                        "poseId": 1550294548,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000203.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1552755297,
                        "poseId": 1552755297,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000052.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1553859117,
                        "poseId": 1553859117,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000053.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1554128574,
                        "poseId": 1554128574,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000142.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1557104078,
                        "poseId": 1557104078,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000143.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1557246150,
                        "poseId": 1557246150,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000050.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1557410019,
                        "poseId": 1557410019,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000140.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1560919831,
                        "poseId": 1560919831,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000056.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1561628997,
                        "poseId": 1561628997,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000141.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1563124301,
                        "poseId": 1563124301,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000055.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1564359614,
                        "poseId": 1564359614,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000146.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1564554219,
                        "poseId": 1564554219,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000054.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1564619845,
                        "poseId": 1564619845,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000147.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1566673769,
                        "poseId": 1566673769,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000145.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1566890727,
                        "poseId": 1566890727,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000144.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1567054255,
                        "poseId": 1567054255,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000057.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1569919764,
                        "poseId": 1569919764,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000121.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1570266282,
                        "poseId": 1570266282,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000120.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1603935515,
                        "poseId": 1603935515,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000136.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1612733833,
                        "poseId": 1612733833,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000272.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1613895389,
                        "poseId": 1613895389,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000270.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1614301869,
                        "poseId": 1614301869,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000273.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1614930546,
                        "poseId": 1614930546,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000279.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1615526077,
                        "poseId": 1615526077,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000277.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1615801104,
                        "poseId": 1615801104,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000278.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1616028587,
                        "poseId": 1616028587,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000276.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1616040178,
                        "poseId": 1616040178,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000147.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1618423130,
                        "poseId": 1618423130,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000145.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1618616884,
                        "poseId": 1618616884,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000144.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1620667184,
                        "poseId": 1620667184,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000275.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1620684934,
                        "poseId": 1620684934,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000275.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1622936392,
                        "poseId": 1622936392,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000276.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1625183469,
                        "poseId": 1625183469,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000274.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1631613492,
                        "poseId": 1631613492,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000278.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1631878614,
                        "poseId": 1631878614,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000277.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1633851574,
                        "poseId": 1633851574,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000279.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1640654504,
                        "poseId": 1640654504,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000528.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1641310011,
                        "poseId": 1641310011,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000274.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1641313105,
                        "poseId": 1641313105,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000271.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1642483405,
                        "poseId": 1642483405,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000529.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1646301188,
                        "poseId": 1646301188,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000271.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1646570937,
                        "poseId": 1646570937,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000272.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1647407847,
                        "poseId": 1647407847,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000273.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1648235061,
                        "poseId": 1648235061,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000270.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1661516477,
                        "poseId": 1661516477,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000100.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1664974537,
                        "poseId": 1664974537,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000142.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1670008906,
                        "poseId": 1670008906,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000141.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1672001296,
                        "poseId": 1672001296,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000146.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1673617372,
                        "poseId": 1673617372,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000140.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1675158381,
                        "poseId": 1675158381,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000143.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1677425965,
                        "poseId": 1677425965,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000101.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1680066899,
                        "poseId": 1680066899,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000369.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1681779109,
                        "poseId": 1681779109,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000368.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1695068480,
                        "poseId": 1695068480,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000363.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1696287553,
                        "poseId": 1696287553,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000014.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1696897807,
                        "poseId": 1696897807,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000360.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1698181661,
                        "poseId": 1698181661,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000015.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1699666317,
                        "poseId": 1699666317,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000365.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1700020933,
                        "poseId": 1700020933,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000016.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1701072361,
                        "poseId": 1701072361,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000017.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1701980471,
                        "poseId": 1701980471,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000362.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1703152962,
                        "poseId": 1703152962,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000039.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1704998288,
                        "poseId": 1704998288,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000038.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1709697849,
                        "poseId": 1709697849,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000102.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1710934781,
                        "poseId": 1710934781,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000361.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1715174288,
                        "poseId": 1715174288,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000045.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1715869562,
                        "poseId": 1715869562,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000044.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1716505319,
                        "poseId": 1716505319,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000114.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1717260923,
                        "poseId": 1717260923,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000018.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1718136187,
                        "poseId": 1718136187,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000019.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1720788797,
                        "poseId": 1720788797,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000117.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1721090768,
                        "poseId": 1721090768,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000037.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1723223204,
                        "poseId": 1723223204,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000036.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1724045685,
                        "poseId": 1724045685,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000168.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1725299605,
                        "poseId": 1725299605,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000118.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1725361471,
                        "poseId": 1725361471,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000119.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1727666697,
                        "poseId": 1727666697,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000116.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1727889003,
                        "poseId": 1727889003,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000169.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1728130592,
                        "poseId": 1728130592,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000115.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1729697510,
                        "poseId": 1729697510,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000113.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1729745862,
                        "poseId": 1729745862,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000048.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1729815542,
                        "poseId": 1729815542,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000110.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1730284808,
                        "poseId": 1730284808,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000112.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1731658606,
                        "poseId": 1731658606,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000111.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1736605425,
                        "poseId": 1736605425,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000010.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1736611517,
                        "poseId": 1736611517,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000043.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1736648660,
                        "poseId": 1736648660,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000012.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1737335598,
                        "poseId": 1737335598,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000041.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1738193785,
                        "poseId": 1738193785,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000167.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1738597322,
                        "poseId": 1738597322,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000011.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1739168884,
                        "poseId": 1739168884,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000040.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1740602839,
                        "poseId": 1740602839,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000042.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1741276100,
                        "poseId": 1741276100,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000047.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1741885106,
                        "poseId": 1741885106,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000013.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1743044408,
                        "poseId": 1743044408,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000046.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1744754073,
                        "poseId": 1744754073,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000166.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1749526425,
                        "poseId": 1749526425,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000078.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1750271301,
                        "poseId": 1750271301,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000079.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1769381473,
                        "poseId": 1769381473,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000077.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1769783029,
                        "poseId": 1769783029,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000076.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1774407272,
                        "poseId": 1774407272,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000074.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1776301942,
                        "poseId": 1776301942,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000075.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1813903113,
                        "poseId": 1813903113,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000304.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1824961842,
                        "poseId": 1824961842,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000301.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1825993832,
                        "poseId": 1825993832,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000303.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1826324887,
                        "poseId": 1826324887,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000099.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1831716606,
                        "poseId": 1831716606,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000306.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1835108243,
                        "poseId": 1835108243,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000300.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1835888194,
                        "poseId": 1835888194,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000098.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1836223728,
                        "poseId": 1836223728,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000302.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1837260830,
                        "poseId": 1837260830,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000307.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1854766126,
                        "poseId": 1854766126,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000073.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1854960024,
                        "poseId": 1854960024,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000070.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1855277685,
                        "poseId": 1855277685,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000524.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1855500470,
                        "poseId": 1855500470,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000071.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1856867838,
                        "poseId": 1856867838,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000148.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1858176338,
                        "poseId": 1858176338,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000234.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1858631126,
                        "poseId": 1858631126,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000525.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1860525439,
                        "poseId": 1860525439,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000520.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1860573119,
                        "poseId": 1860573119,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000527.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1860950124,
                        "poseId": 1860950124,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000072.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1861593801,
                        "poseId": 1861593801,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000526.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1864213807,
                        "poseId": 1864213807,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000522.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1867687097,
                        "poseId": 1867687097,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000230.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1869769886,
                        "poseId": 1869769886,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000521.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1869953665,
                        "poseId": 1869953665,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000523.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1870076441,
                        "poseId": 1870076441,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000231.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1872345505,
                        "poseId": 1872345505,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000232.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1883480040,
                        "poseId": 1883480040,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000137.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1896944552,
                        "poseId": 1896944552,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000138.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1902954762,
                        "poseId": 1902954762,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000139.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1905204202,
                        "poseId": 1905204202,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000443.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1908055029,
                        "poseId": 1908055029,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000442.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1915453588,
                        "poseId": 1915453588,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000135.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1916253142,
                        "poseId": 1916253142,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000446.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1917042359,
                        "poseId": 1917042359,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000445.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1919058649,
                        "poseId": 1919058649,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000444.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1919194247,
                        "poseId": 1919194247,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000014.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1926965647,
                        "poseId": 1926965647,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000441.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1928230908,
                        "poseId": 1928230908,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000127.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1928248794,
                        "poseId": 1928248794,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000126.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1928394865,
                        "poseId": 1928394865,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000440.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1930038010,
                        "poseId": 1930038010,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000125.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1931887534,
                        "poseId": 1931887534,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000124.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1935173102,
                        "poseId": 1935173102,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000123.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1937139656,
                        "poseId": 1937139656,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000122.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1941216087,
                        "poseId": 1941216087,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000309.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1943129442,
                        "poseId": 1943129442,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000308.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1944369273,
                        "poseId": 1944369273,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000305.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1954584408,
                        "poseId": 1954584408,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000194.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1956963620,
                        "poseId": 1956963620,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000018.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1962287463,
                        "poseId": 1962287463,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000019.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1963275861,
                        "poseId": 1963275861,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000012.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1963369762,
                        "poseId": 1963369762,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000150.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1963904523,
                        "poseId": 1963904523,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000013.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1964565749,
                        "poseId": 1964565749,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000010.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1964773502,
                        "poseId": 1964773502,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000011.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1971726990,
                        "poseId": 1971726990,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000015.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1971905577,
                        "poseId": 1971905577,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000155.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1972891840,
                        "poseId": 1972891840,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000097.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1974305770,
                        "poseId": 1974305770,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000156.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1974605427,
                        "poseId": 1974605427,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000016.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1975107714,
                        "poseId": 1975107714,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000157.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1975480847,
                        "poseId": 1975480847,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000154.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1976013981,
                        "poseId": 1976013981,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000151.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1979582773,
                        "poseId": 1979582773,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000017.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1983267099,
                        "poseId": 1983267099,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000158.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1984682197,
                        "poseId": 1984682197,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000198.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1986290822,
                        "poseId": 1986290822,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000199.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1989226212,
                        "poseId": 1989226212,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000159.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1993427190,
                        "poseId": 1993427190,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000153.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1993695906,
                        "poseId": 1993695906,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000152.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1997057677,
                        "poseId": 1997057677,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000191.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1998459416,
                        "poseId": 1998459416,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000193.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1999036238,
                        "poseId": 1999036238,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000447.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2002288277,
                        "poseId": 2002288277,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000195.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2003682711,
                        "poseId": 2003682711,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000190.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2004622284,
                        "poseId": 2004622284,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000192.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2011056817,
                        "poseId": 2011056817,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000449.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2012371955,
                        "poseId": 2012371955,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000448.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2014482078,
                        "poseId": 2014482078,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000223.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2015087173,
                        "poseId": 2015087173,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000060.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2016199210,
                        "poseId": 2016199210,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000221.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2016254980,
                        "poseId": 2016254980,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000114.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2016860512,
                        "poseId": 2016860512,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000222.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2018236172,
                        "poseId": 2018236172,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000220.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2018335299,
                        "poseId": 2018335299,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000062.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2018418234,
                        "poseId": 2018418234,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000128.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2019204151,
                        "poseId": 2019204151,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000061.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2020300903,
                        "poseId": 2020300903,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000228.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2020740058,
                        "poseId": 2020740058,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000129.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2022329536,
                        "poseId": 2022329536,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000110.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2022601915,
                        "poseId": 2022601915,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000227.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2022887443,
                        "poseId": 2022887443,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000115.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2024057251,
                        "poseId": 2024057251,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000226.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2025703103,
                        "poseId": 2025703103,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000112.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2025883048,
                        "poseId": 2025883048,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000119.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2025968618,
                        "poseId": 2025968618,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000118.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2026354446,
                        "poseId": 2026354446,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000225.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2026944616,
                        "poseId": 2026944616,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000196.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2029079920,
                        "poseId": 2029079920,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000197.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2029175200,
                        "poseId": 2029175200,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000224.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2029467864,
                        "poseId": 2029467864,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000049.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2029685897,
                        "poseId": 2029685897,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000116.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2030963463,
                        "poseId": 2030963463,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000117.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2043015683,
                        "poseId": 2043015683,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000209.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2045697342,
                        "poseId": 2045697342,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000208.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2052558380,
                        "poseId": 2052558380,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000202.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2057069500,
                        "poseId": 2057069500,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000201.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2058067424,
                        "poseId": 2058067424,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000203.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2062078277,
                        "poseId": 2062078277,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000200.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2063371528,
                        "poseId": 2063371528,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000207.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2063470960,
                        "poseId": 2063470960,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000206.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2067303767,
                        "poseId": 2067303767,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000204.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2072376675,
                        "poseId": 2072376675,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000121.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2073412545,
                        "poseId": 2073412545,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000120.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2075179945,
                        "poseId": 2075179945,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000111.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2078151945,
                        "poseId": 2078151945,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000113.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2082746689,
                        "poseId": 2082746689,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000285.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2085796392,
                        "poseId": 2085796392,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000281.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2085825988,
                        "poseId": 2085825988,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000283.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2086591530,
                        "poseId": 2086591530,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000280.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2088557570,
                        "poseId": 2088557570,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000282.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2090985102,
                        "poseId": 2090985102,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000348.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2092176490,
                        "poseId": 2092176490,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000286.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2094897046,
                        "poseId": 2094897046,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000349.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2117809841,
                        "poseId": 2117809841,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000093.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2118974019,
                        "poseId": 2118974019,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000091.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2120836243,
                        "poseId": 2120836243,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000097.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2121262319,
                        "poseId": 2121262319,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000092.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2123914246,
                        "poseId": 2123914246,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000095.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2124953742,
                        "poseId": 2124953742,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000090.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2125765461,
                        "poseId": 2125765461,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000096.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2129964968,
                        "poseId": 2129964968,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000094.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2130730544,
                        "poseId": 2130730544,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000205.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2132867485,
                        "poseId": 2132867485,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000098.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2133797151,
                        "poseId": 2133797151,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000229.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2135008307,
                        "poseId": 2135008307,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000347.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2135426158,
                        "poseId": 2135426158,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000345.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2135652209,
                        "poseId": 2135652209,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000346.jpg",
                        "intrinsicId": 686960700,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2136957996,
                        "poseId": 2136957996,
                        "path": "C:/data/eth3d_mvsnet/lakeside/images/00000099.jpg",
                        "intrinsicId": 1626085351,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2138871168,
                        "poseId": 2138871168,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images/00000149.jpg",
                        "intrinsicId": 2714580701,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 686960700,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.4558441227157,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 928,
                        "height": 511,
                        "sensorWidth": 36.0,
                        "sensorHeight": 19.823275862068968,
                        "serialNumber": "C:/data/eth3d_mvsnet/lakeside/images",
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
                    },
                    {
                        "intrinsicId": 1626085351,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271569,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 955,
                        "height": 514,
                        "sensorWidth": 36.0,
                        "sensorHeight": 19.375916230366492,
                        "serialNumber": "C:/data/eth3d_mvsnet/lakeside/images",
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
                    },
                    {
                        "intrinsicId": 2714580701,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 1920,
                        "height": 1080,
                        "sensorWidth": 36.0,
                        "sensorHeight": 20.25,
                        "serialNumber": "C:/data/tankandtemples_mvsnet/intermediate/Francis/images",
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
                    },
                    {
                        "intrinsicId": 3448933362,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 1920,
                        "height": 1080,
                        "sensorWidth": 36.0,
                        "sensorHeight": 20.25,
                        "serialNumber": "C:/data/tankandtemples_mvsnet/intermediate/Family/images",
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
        },
        "CopyData_1": {
            "nodeType": "CopyData",
            "position": [
                1380,
                169
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "1dbb064f5c74908933168d2973bdb90499ee5b37"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{Meshing_1.outputMesh}",
                "inputFile": "densePointCloud_raw.abc",
                "outputName": "",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFile": "{cache}/{nodeType}/{uid0}/densePointCloud_raw.abc"
            }
        },
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                1400,
                0
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 986,
                "split": 99
            },
            "uids": {
                "0": "add802ec9db70c905365dfa02961b29e64c5cd12"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_1.input}",
                "depthMapsFolder": "{DepthMap_1.output}",
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "nNearestCams": 10,
                "minNumOfConsistentCams": 3,
                "minNumOfConsistentCamsWithLowSimilarity": 4,
                "pixToleranceFactor": 2.0,
                "pixSizeBall": 0,
                "pixSizeBallWithLowSimilarity": 0,
                "computeNormalMaps": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                1200,
                0
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 986,
                "split": 329
            },
            "uids": {
                "0": "051701055f8bd81efb3b4d496919622a624873a3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_1.input}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
                "downscale": 2,
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "tiling": {
                    "tileBufferWidth": 1024,
                    "tileBufferHeight": 1024,
                    "tilePadding": 64,
                    "autoAdjustSmallImage": true
                },
                "chooseTCamsPerTile": true,
                "maxTCams": 10,
                "sgm": {
                    "sgmScale": 2,
                    "sgmStepXY": 2,
                    "sgmStepZ": -1,
                    "sgmMaxTCamsPerTile": 4,
                    "sgmWSH": 4,
                    "sgmUseSfmSeeds": true,
                    "sgmSeedsRangeInflate": 0.2,
                    "sgmDepthThicknessInflate": 0.0,
                    "sgmMaxSimilarity": 1.0,
                    "sgmGammaC": 5.5,
                    "sgmGammaP": 8.0,
                    "sgmP1": 10.0,
                    "sgmP2Weighting": 100.0,
                    "sgmMaxDepths": 1500,
                    "sgmFilteringAxes": "YX",
                    "sgmDepthListPerTile": true,
                    "sgmUseConsistentScale": false
                },
                "refine": {
                    "refineEnabled": true,
                    "refineScale": 1,
                    "refineStepXY": 1,
                    "refineMaxTCamsPerTile": 4,
                    "refineSubsampling": 10,
                    "refineHalfNbDepths": 15,
                    "refineWSH": 3,
                    "refineSigma": 15.0,
                    "refineGammaC": 15.5,
                    "refineGammaP": 8.0,
                    "refineInterpolateMiddleDepth": false,
                    "refineUseConsistentScale": false
                },
                "colorOptimization": {
                    "colorOptimizationEnabled": true,
                    "colorOptimizationNbIterations": 100
                },
                "customPatchPattern": {
                    "sgmUseCustomPatchPattern": false,
                    "refineUseCustomPatchPattern": false,
                    "customPatchPatternSubparts": [],
                    "customPatchPatternGroupSubpartsPerLevel": false
                },
                "intermediateResults": {
                    "exportIntermediateDepthSimMaps": false,
                    "exportIntermediateNormalMaps": false,
                    "exportIntermediateVolumes": false,
                    "exportIntermediateCrossVolumes": false,
                    "exportIntermediateTopographicCutVolumes": false,
                    "exportIntermediateVolume9pCsv": false,
                    "exportTilePattern": false
                },
                "nbGPUs": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr",
                "tilePattern": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_tilePattern.obj",
                "depthSgm": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_sgm.exr",
                "depthSgmUpscaled": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_sgmUpscaled.exr",
                "depthRefined": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_refinedFused.exr"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                200,
                0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 986,
                "split": 25
            },
            "uids": {
                "0": "aac64cc5513e868efb63d38facb2da6020c454c2"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_1.output}",
                "masksFolder": "",
                "maskExtension": "png",
                "maskInvert": false,
                "describerTypes": [
                    "dspsift"
                ],
                "describerPreset": "normal",
                "maxNbFeatures": 0,
                "describerQuality": "normal",
                "contrastFiltering": "GridSort",
                "relativePeakThreshold": 0.01,
                "gridFiltering": true,
                "workingColorSpace": "sRGB",
                "forceCpuExtraction": true,
                "maxThreads": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                600,
                0
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 986,
                "split": 50
            },
            "uids": {
                "0": "8723ffc4371c8ade16e9c674ee0fe41bc970161f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}",
                "photometricMatchingMethod": "ANN_L2",
                "geometricEstimator": "acransac",
                "geometricFilterType": "fundamental_matrix",
                "distanceRatio": 0.8,
                "maxIteration": 2048,
                "geometricError": 0.0,
                "knownPosesGeometricErrorMax": 5.0,
                "minRequired2DMotion": -1.0,
                "maxMatches": 0,
                "savePutativeMatches": false,
                "crossMatching": false,
                "guidedMatching": false,
                "matchFromKnownCameraPoses": false,
                "exportDebugFiles": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                400,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 986,
                "split": 1
            },
            "uids": {
                "0": "e12289aeb0c328f0bed33e9bdc3b18abe483aceb"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "SequentialAndVocabularyTree",
                "tree": "${ALICEVISION_VOCTREE}",
                "weights": "",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 40,
                "nbNeighbors": 5,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/imageMatches.txt"
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                1800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "813ce9c6d47dbbbcb715e0fbfc1a2fe77bacdea3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{Meshing_1.outputMesh}",
                "outputMeshFileType": "obj",
                "keepLargestMeshOnly": false,
                "smoothingSubset": "all",
                "smoothingBoundariesNeighbours": 0,
                "smoothingIterations": 5,
                "smoothingLambda": 1.0,
                "filteringSubset": "all",
                "filteringIterations": 1,
                "filterLargeTrianglesFactor": 60.0,
                "filterTrianglesRatio": 0.0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "MeshTransform_1": {
            "nodeType": "MeshTransform",
            "position": [
                1580,
                165
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9a46c271e0010196f933f6c72cc80a8e6b1c772e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{CopyData_1.outputFile}",
                "inputTransform": "",
                "flipCG_CV": false,
                "addGaussianNoise": -1.0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.obj"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                1600,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0d6b645194deaf0c6790315ab2b633a787a5cf55"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_1.input}",
                "depthMapsFolder": "{DepthMapFilter_1.output}",
                "outputMeshFileType": "obj",
                "useBoundingBox": false,
                "boundingBox": {
                    "bboxTranslation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxRotation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxScale": {
                        "x": 1.0,
                        "y": 1.0,
                        "z": 1.0
                    }
                },
                "estimateSpaceFromSfM": true,
                "estimateSpaceMinObservations": 3,
                "estimateSpaceMinObservationAngle": 10.0,
                "maxInputPoints": 50000000,
                "maxPoints": 5000000,
                "maxPointsPerVoxel": 1000000,
                "minStep": 2,
                "partitioning": "singleBlock",
                "repartition": "multiResolution",
                "angleFactor": 15.0,
                "simFactor": 15.0,
                "pixSizeMarginInitCoef": 2.0,
                "pixSizeMarginFinalCoef": 4.0,
                "voteMarginFactor": 4.0,
                "contributeMarginFactor": 2.0,
                "simGaussianSizeInit": 10.0,
                "simGaussianSize": 10.0,
                "minAngleThreshold": 1.0,
                "refineFuse": true,
                "helperPointsGridSize": 10,
                "densify": false,
                "densifyNbFront": 1,
                "densifyNbBack": 1,
                "densifyScale": 20.0,
                "nPixelSizeBehind": 4.0,
                "fullWeight": 1.0,
                "voteFilteringForWeaklySupportedSurfaces": true,
                "addLandmarksToTheDensePointCloud": false,
                "invertTetrahedronBasedOnNeighborsNbIterations": 10,
                "minSolidAngleRatio": 0.2,
                "nbSolidAngleFilteringIterations": 2,
                "colorizeOutput": false,
                "addMaskHelperPoints": false,
                "maskHelperPointsWeight": 1.0,
                "maskBorderSize": 4,
                "maxNbConnectedHelperPoints": 50,
                "saveRawDensePointCloud": false,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "PoissonMesher_1": {
            "nodeType": "PoissonMesher",
            "position": [
                1765,
                162
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "debf6d0f53fa1a7d405a0857cc96db495a67ea35"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_path": "{MeshTransform_1.outputMesh}",
                "trim": 2.0
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/mesh_poisson.ply"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1000,
                0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 986,
                "split": 25
            },
            "uids": {
                "0": "ea57b8ede1253fa22b4a9f7f14a1c8be64fbfabc"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "imagesFolders": [],
                "masksFolders": [],
                "maskExtension": "png",
                "outputFileType": "exr",
                "saveMetadata": true,
                "saveMatricesTxtFiles": false,
                "evCorrection": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "undistorted": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.{outputFileTypeValue}"
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 986,
                "split": 1
            },
            "uids": {
                "0": "52d5a253ee7787ab49738c47e54b72c781f85418"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}",
                "localizerEstimator": "acransac",
                "observationConstraint": "Scale",
                "localizerEstimatorMaxIterations": 4096,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 30,
                "maxImagesPerGroup": 30,
                "bundleAdjustmentMaxOutliers": 50,
                "maxNumberOfMatches": 0,
                "minNumberOfMatches": 0,
                "minInputTrackLength": 2,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 3.0,
                "minAngleForLandmark": 2.0,
                "maxReprojectionError": 4.0,
                "minAngleInitialPair": 5.0,
                "maxAngleInitialPair": 40.0,
                "useOnlyMatchesFromInputFolder": false,
                "useRigConstraint": true,
                "rigMinNbCamerasForCalibration": 20,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "filterTrackForks": false,
                "computeStructureColor": true,
                "initialPairA": "",
                "initialPairB": "",
                "interFileExtension": ".abc",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.abc",
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm",
                "extraInfoFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                2000,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9d4af2bbc44505373bced07104da87a796951502"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_1.output}",
                "imagesFolder": "{DepthMap_1.imagesFolder}",
                "inputMesh": "{MeshFiltering_1.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "exr"
                },
                "bumpMapping": {
                    "enable": true,
                    "bumpType": "Normal",
                    "normalFileType": "exr",
                    "heightFileType": "exr"
                },
                "displacementMapping": {
                    "enable": true,
                    "displacementMappingFileType": "exr"
                },
                "unwrapMethod": "Basic",
                "useUDIM": true,
                "fillHoles": false,
                "padding": 5,
                "multiBandDownscale": 4,
                "multiBandNbContrib": {
                    "high": 1,
                    "midHigh": 5,
                    "midLow": 10,
                    "low": 0
                },
                "useScore": true,
                "bestScoreThreshold": 0.1,
                "angleHardThreshold": 90.0,
                "workingColorSpace": "sRGB",
                "outputColorSpace": "AUTO",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.exr"
            }
        }
    }
}