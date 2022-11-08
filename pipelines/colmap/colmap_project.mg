{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "template": true,
        "nodesVersions": {
            "ColmapMapper": "2.0",
            "ColmapFeatureExtraction": "1.1",
            "Texturing": "6.0",
            "SfMAlignment": "2.0",
            "ImageMatching": "2.0",
            "PatchMatchStereo": "2.0",
            "PrepareDenseScene": "3.0",
            "DepthMapFilter": "3.0",
            "Meshroom2ColmapSfmConvertions": "2.0",
            "MeshFiltering": "3.0",
            "DelaunayMesher": "2.0",
            "FeatureMatching": "2.0",
            "DepthMap": "2.0",
            "CameraInit": "8.0",
            "ColmapFeatureMatching": "2.0",
            "StereoFusion": "2.0",
            "BlendedMVGDataset": "3.0",
            "ColmapImageUndistorder": "1.1",
            "PoissonMesher": "2.0",
            "StructureFromMotion": "2.0",
            "InjectSfmData": "3.0",
            "Colmap2MeshroomSfmConvertion": "2.0",
            "ColmapAutomaticReconstructor": "4.0",
            "ConvertSfMFormat": "2.0",
            "Meshing": "7.0",
            "FeatureExtraction": "1.1"
        }
    },
    "graph": {
        "ColmapAutomaticReconstructor_1": {
            "nodeType": "ColmapAutomaticReconstructor",
            "position": [
                -131,
                594
            ],
            "inputs": {
                "image_path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images"
            }
        },
        "DelaunayMesher_1": {
            "nodeType": "DelaunayMesher",
            "position": [
                1849,
                584
            ],
            "inputs": {}
        },
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                -64,
                8
            ],
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 202303598,
                        "poseId": 202303598,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000008.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 208587566,
                        "poseId": 208587566,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000009.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 216579329,
                        "poseId": 216579329,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000004.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 218914715,
                        "poseId": 218914715,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000005.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 229406600,
                        "poseId": 229406600,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000006.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 232341184,
                        "poseId": 232341184,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000007.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 578496603,
                        "poseId": 578496603,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000015.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 581355225,
                        "poseId": 581355225,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000014.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 597233910,
                        "poseId": 597233910,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000013.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 600073058,
                        "poseId": 600073058,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000012.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 600806697,
                        "poseId": 600806697,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000010.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 602556050,
                        "poseId": 602556050,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000011.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1297308600,
                        "poseId": 1297308600,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000000.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1303301372,
                        "poseId": 1303301372,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000001.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1312236258,
                        "poseId": 1312236258,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000002.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1314734285,
                        "poseId": 1314734285,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000003.jpg",
                        "intrinsicId": 1837349851,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 1837349851,
                        "initialFocalLength": -1.0,
                        "focalLength": 0.82,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial1",
                        "width": 768,
                        "height": 576,
                        "sensorWidth": 1.0,
                        "sensorHeight": 0.75,
                        "serialNumber": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "unknown",
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "locked": false
                    }
                ],
                "allowedCameraModels": [
                    "pinhole",
                    "radial1"
                ]
            }
        },
        "ColmapFeatureExtraction_1": {
            "nodeType": "ColmapFeatureExtraction",
            "position": [
                49,
                607
            ],
            "inputs": {
                "image_path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images",
                "input_sfm": "{CameraInit_1.output}"
            }
        },
        "ColmapFeatureMatching_1": {
            "nodeType": "ColmapFeatureMatching",
            "position": [
                238,
                611
            ],
            "inputs": {
                "input_database_path": "{ColmapFeatureExtraction_1.database_path}"
            }
        },
        "ColmapMapper_1": {
            "nodeType": "ColmapMapper",
            "position": [
                430,
                582
            ],
            "inputs": {
                "input_database_path": "{ColmapFeatureMatching_1.database_path}",
                "image_path": "{ColmapFeatureExtraction_1.image_path}"
            }
        },
        "ColmapImageUndistorder_1": {
            "nodeType": "ColmapImageUndistorder",
            "position": [
                999,
                585
            ],
            "inputs": {
                "image_path": "{ColmapMapper_1.image_path}",
                "input_path": "{ColmapMapper_1.output_path0}"
            }
        },
        "PatchMatchStereo_1": {
            "nodeType": "PatchMatchStereo",
            "position": [
                1170,
                613
            ],
            "inputs": {
                "input_folder": "{ColmapImageUndistorder_1.output_path}"
            }
        },
        "StereoFusion_1": {
            "nodeType": "StereoFusion",
            "position": [
                1347,
                611
            ],
            "inputs": {
                "input_folder": "{PatchMatchStereo_1.workspace_path}"
            }
        },
        "PoissonMesher_1": {
            "nodeType": "PoissonMesher",
            "position": [
                1527,
                614
            ],
            "inputs": {
                "input_path": "{StereoFusion_1.output_path}"
            }
        },
        "Colmap2MeshroomSfmConvertion_1": {
            "nodeType": "Colmap2MeshroomSfmConvertion",
            "position": [
                241,
                249
            ],
            "inputs": {
                "input": "{ColmapMapper_1.output_path0}",
                "inputSfm": "{ColmapFeatureExtraction_1.input_sfm}"
            }
        },
        "SfMAlignment_1": {
            "nodeType": "SfMAlignment",
            "position": [
                432,
                229
            ],
            "inputs": {
                "input": "{Colmap2MeshroomSfmConvertion_1.outputSfm}",
                "reference": "{StructureFromMotion_1.output}"
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                800,
                0
            ],
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1000,
                0
            ],
            "inputs": {
                "input": "{StructureFromMotion_1.output}"
            }
        },
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                1200,
                0
            ],
            "inputs": {
                "input": "{PrepareDenseScene_1.input}",
                "imagesFolder": "{PrepareDenseScene_1.output}"
            }
        },
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                1400,
                0
            ],
            "inputs": {
                "input": "{DepthMap_1.input}",
                "depthMapsFolder": "{DepthMap_1.output}"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                1600,
                0
            ],
            "inputs": {
                "input": "{DepthMapFilter_1.input}",
                "depthMapsFolder": "{DepthMapFilter_1.output}",
                "estimateSpaceMinObservations": 0,
                "helperPointsGridSize": 50,
                "saveRawDensePointCloud": true
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                1800,
                0
            ],
            "inputs": {
                "inputMesh": "{Meshing_1.outputMesh}"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                2000,
                0
            ],
            "inputs": {
                "input": "{Meshing_1.output}",
                "imagesFolder": "{DepthMap_1.imagesFolder}",
                "inputMesh": "{MeshFiltering_1.outputMesh}"
            }
        },
        "Meshroom2ColmapSfmConvertions_1": {
            "nodeType": "Meshroom2ColmapSfmConvertions",
            "position": [
                820,
                446
            ],
            "inputs": {
                "input": "{StructureFromMotion_1.output}"
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                400,
                0
            ],
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ]
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                600,
                0
            ],
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                200,
                0
            ],
            "inputs": {
                "input": "{CameraInit_1.output}"
            }
        },
        "BlendedMVGDataset_1": {
            "nodeType": "BlendedMVGDataset",
            "position": [
                202,
                -180
            ],
            "inputs": {
                "sfmData": "{CameraInit_1.output}"
            }
        },
        "InjectSfmData_1": {
            "nodeType": "InjectSfmData",
            "position": [
                815,
                241
            ],
            "inputs": {
                "sourceSfmData": "{ConvertSfMFormat_3.output}",
                "targetSfmData": "{ConvertSfMFormat_2.output}",
                "exportedFields": [
                    "structure",
                    "matchesFolders",
                    "featuresFolders"
                ]
            }
        },
        "ConvertSfMFormat_2": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                627,
                241
            ],
            "inputs": {
                "input": "{SfMAlignment_1.output}",
                "fileExt": "sfm"
            }
        },
        "Meshing_2": {
            "nodeType": "Meshing",
            "position": [
                1600,
                277
            ],
            "inputs": {
                "input": "{DepthMapFilter_2.input}",
                "depthMapsFolder": "{DepthMapFilter_2.output}",
                "estimateSpaceMinObservations": 0,
                "helperPointsGridSize": 50,
                "saveRawDensePointCloud": true
            }
        },
        "Texturing_2": {
            "nodeType": "Texturing",
            "position": [
                2000,
                277
            ],
            "inputs": {
                "input": "{Meshing_2.output}",
                "imagesFolder": "{DepthMap_2.imagesFolder}",
                "inputMesh": "{MeshFiltering_2.outputMesh}"
            }
        },
        "MeshFiltering_2": {
            "nodeType": "MeshFiltering",
            "position": [
                1800,
                277
            ],
            "inputs": {
                "inputMesh": "{Meshing_2.outputMesh}"
            }
        },
        "DepthMap_2": {
            "nodeType": "DepthMap",
            "position": [
                1200,
                277
            ],
            "inputs": {
                "input": "{PrepareDenseScene_2.input}",
                "imagesFolder": "{PrepareDenseScene_2.output}"
            }
        },
        "DepthMapFilter_2": {
            "nodeType": "DepthMapFilter",
            "position": [
                1400,
                277
            ],
            "inputs": {
                "input": "{DepthMap_2.input}",
                "depthMapsFolder": "{DepthMap_2.output}"
            }
        },
        "PrepareDenseScene_2": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1000,
                277
            ],
            "inputs": {
                "input": "{InjectSfmData_1.outputSfMData}"
            }
        },
        "SfMAlignment_2": {
            "nodeType": "SfMAlignment",
            "position": [
                406,
                -184
            ],
            "inputs": {
                "input": "{BlendedMVGDataset_1.outputSfMData}",
                "reference": "{StructureFromMotion_1.output}"
            }
        },
        "ColmapImageUndistorder_2": {
            "nodeType": "ColmapImageUndistorder",
            "position": [
                1005,
                452
            ],
            "inputs": {
                "image_path": "{ColmapFeatureExtraction_1.image_path}",
                "input_path": "{Meshroom2ColmapSfmConvertions_1.output0}"
            }
        },
        "PatchMatchStereo_2": {
            "nodeType": "PatchMatchStereo",
            "position": [
                1203,
                486
            ],
            "inputs": {
                "input_folder": "{ColmapImageUndistorder_2.output_path}"
            }
        },
        "StereoFusion_2": {
            "nodeType": "StereoFusion",
            "position": [
                1380,
                484
            ],
            "inputs": {
                "input_folder": "{PatchMatchStereo_2.workspace_path}"
            }
        },
        "PoissonMesher_2": {
            "nodeType": "PoissonMesher",
            "position": [
                1569,
                489
            ],
            "inputs": {
                "input_path": "{StereoFusion_2.output_path}"
            }
        },
        "ConvertSfMFormat_3": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                993,
                146
            ],
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "fileExt": "sfm"
            }
        }
    }
}