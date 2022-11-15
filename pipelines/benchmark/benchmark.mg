{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "DepthMap": "2.0",
            "FeatureMatching": "2.0",
            "ColmapFeatureExtraction": "1.1",
            "Publish": "1.2",
            "ImageMatching": "2.0",
            "ColmapImageUndistorder": "1.1",
            "ConvertSfMFormat": "2.0",
            "BlendedMVGDataset": "3.0",
            "StructureFromMotion": "2.0",
            "FeatureExtraction": "1.1",
            "ColmapMapper": "2.0",
            "MeshFiltering": "3.0",
            "InjectSfmData": "3.0",
            "SfMAlignment": "2.0",
            "DepthMapComparison": "3.0",
            "CalibrationComparison": "3.0",
            "Meshing": "7.0",
            "PatchMatchStereo": "2.0",
            "Texturing": "6.0",
            "DepthMapFilter": "3.0",
            "PrepareDenseScene": "3.0",
            "DepthMapTransform": "3.0",
            "ColmapFeatureMatching": "2.0",
            "StereoFusion": "2.0",
            "PoissonMesher": "2.0",
            "CameraInit": "8.0",
            "Colmap2MeshroomSfmConvertion": "2.0"
        },
        "template": true
    },
    "graph": {
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                380,
                -76
            ],
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "VocabularyTree",
                "tree": "/s/prods/mvg/_source_global/bank/generic_voctree/vlfeat_K80L3.SIFT.tree",
                "nbMatches": 50,
                "nbNeighbors": 50
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                761,
                -114
            ],
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}",
                "observationConstraint": "Basic"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                190,
                -73
            ],
            "inputs": {
                "input": "{BlendedMVGDataset_1.outputSfMDataCameraInit}",
                "describerTypes": [
                    "sift"
                ]
            }
        },
        "SfMAlignment_1": {
            "nodeType": "SfMAlignment",
            "position": [
                980,
                -97
            ],
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "reference": "{BlendedMVGDataset_1.outputSfMData}"
            }
        },
        "InjectSfmData_1": {
            "nodeType": "InjectSfmData",
            "position": [
                1179,
                39
            ],
            "inputs": {
                "sourceSfmData": "{ConvertSfMFormat_2.output}",
                "targetSfmData": "{BlendedMVGDataset_1.outputSfMData}",
                "exportedFields": [
                    "structure",
                    "featuresFolders",
                    "matchesFolders"
                ]
            }
        },
        "Publish_1": {
            "nodeType": "Publish",
            "position": [
                2872,
                127
            ],
            "inputs": {
                "inputFiles": [
                    "{CalibrationComparison_1.outputCsv}",
                    "{DepthMapComparison_1.outputCsv}",
                    "{Texturing_2.outputMesh}",
                    "{Texturing_6.outputMesh}",
                    "{Texturing_4.outputMesh}",
                    "{PoissonMesher_1.output_path}"
                ]
            }
        },
        "CalibrationComparison_1": {
            "nodeType": "CalibrationComparison",
            "position": [
                707,
                179
            ],
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_2.output}",
                "inputSfMGT": "{BlendedMVGDataset_1.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations"
                ]
            }
        },
        "BlendedMVGDataset_1": {
            "nodeType": "BlendedMVGDataset",
            "position": [
                12,
                167
            ],
            "inputs": {
                "sfmData": "{CameraInit_1.output}",
                "initIntrinsics": true
            }
        },
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                -193,
                194
            ],
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 202303598,
                        "poseId": 202303598,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000008.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 208587566,
                        "poseId": 208587566,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000009.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 216579329,
                        "poseId": 216579329,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000004.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 218914715,
                        "poseId": 218914715,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000005.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 229406600,
                        "poseId": 229406600,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000006.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 232341184,
                        "poseId": 232341184,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000007.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 578496603,
                        "poseId": 578496603,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000015.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 581355225,
                        "poseId": 581355225,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000014.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 597233910,
                        "poseId": 597233910,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000013.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 600073058,
                        "poseId": 600073058,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000012.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 600806697,
                        "poseId": 600806697,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000010.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 602556050,
                        "poseId": 602556050,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000011.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1297308600,
                        "poseId": 1297308600,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000000.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1303301372,
                        "poseId": 1303301372,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000001.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1312236258,
                        "poseId": 1312236258,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000002.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1314734285,
                        "poseId": 1314734285,
                        "path": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images/00000003.jpg",
                        "intrinsicId": 199173745,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"1\", \"YResolution\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 199173745,
                        "initialFocalLength": 0.0013020833333333333,
                        "focalLength": -1.2071067811865475,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "pinhole",
                        "width": 768,
                        "height": 576,
                        "sensorWidth": -1.0,
                        "sensorHeight": -0.75,
                        "serialNumber": "C:/data/blended_MVSV_bugs/5aa0f9d7a9efce63548c69a1/blended_images",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "unknown",
                        "distortionParams": [],
                        "locked": false
                    }
                ],
                "sensorDatabase": "",
                "allowedCameraModels": [
                    "pinhole"
                ]
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                570,
                -78
            ],
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}"
            }
        },
        "DepthMapComparison_1": {
            "nodeType": "DepthMapComparison",
            "position": [
                1104,
                165
            ],
            "inputs": {
                "inputSfM": "{DepthMapTransform_2.inputSfM}",
                "inputSfMGT": "{BlendedMVGDataset_1.outputSfMData}",
                "depthMapsFolder": "{DepthMapTransform_2.output}",
                "maskValue": "0"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                2033,
                373
            ],
            "inputs": {
                "input": "{Meshing_3.input}"
            }
        },
        "DepthMapTransform_1": {
            "nodeType": "DepthMapTransform",
            "position": [
                1557,
                274
            ],
            "inputs": {
                "inputSfM": "{BlendedMVGDataset_1.outputSfMData}",
                "depthMapsFolder": "{BlendedMVGDataset_1.outputGroundTruthdepthMapsFolder}",
                "transform": "normal2meshroom"
            }
        },
        "ColmapFeatureMatching_1": {
            "nodeType": "ColmapFeatureMatching",
            "position": [
                306,
                529
            ],
            "inputs": {
                "input_database_path": "{ColmapFeatureExtraction_1.database_path}"
            }
        },
        "ColmapMapper_1": {
            "nodeType": "ColmapMapper",
            "position": [
                490,
                542
            ],
            "inputs": {
                "input_database_path": "{ColmapFeatureMatching_1.database_path}",
                "image_path": "{ColmapFeatureExtraction_1.image_path}"
            }
        },
        "PatchMatchStereo_1": {
            "nodeType": "PatchMatchStereo",
            "position": [
                867,
                552
            ],
            "inputs": {
                "input_folder": "{ColmapImageUndistorder_1.output_path}"
            }
        },
        "PoissonMesher_1": {
            "nodeType": "PoissonMesher",
            "position": [
                1262,
                552
            ],
            "inputs": {
                "input_path": "{StereoFusion_1.output_path}"
            }
        },
        "ColmapImageUndistorder_1": {
            "nodeType": "ColmapImageUndistorder",
            "position": [
                682,
                544
            ],
            "inputs": {
                "image_path": "{ColmapMapper_1.image_path}",
                "input_path": "{ColmapMapper_1.output_path0}"
            }
        },
        "Colmap2MeshroomSfmConvertion_1": {
            "nodeType": "Colmap2MeshroomSfmConvertion",
            "position": [
                333,
                385
            ],
            "inputs": {
                "input": "{ColmapMapper_1.output_path0}",
                "inputSfm": "{BlendedMVGDataset_1.outputSfMData}",
                "imageFolder": "{ColmapFeatureExtraction_1.image_path}"
            }
        },
        "StereoFusion_1": {
            "nodeType": "StereoFusion",
            "position": [
                1061,
                553
            ],
            "inputs": {
                "input_folder": "{PatchMatchStereo_1.workspace_path}"
            }
        },
        "ConvertSfMFormat_1": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                709,
                390
            ],
            "inputs": {
                "input": "{SfMAlignment_2.output}",
                "fileExt": "sfm"
            }
        },
        "ColmapFeatureExtraction_1": {
            "nodeType": "ColmapFeatureExtraction",
            "position": [
                112,
                559
            ],
            "inputs": {
                "input_sfm": "{BlendedMVGDataset_1.outputSfMData}"
            }
        },
        "Texturing_2": {
            "nodeType": "Texturing",
            "position": [
                2297,
                238
            ],
            "inputs": {
                "input": "{Meshing_3.output}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
                "inputMesh": "{MeshFiltering_2.outputMesh}",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
                }
            }
        },
        "MeshFiltering_2": {
            "nodeType": "MeshFiltering",
            "position": [
                2023,
                269
            ],
            "inputs": {
                "inputMesh": "{Meshing_3.outputMesh}"
            }
        },
        "ConvertSfMFormat_2": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                992,
                43
            ],
            "inputs": {
                "input": "{SfMAlignment_1.output}",
                "fileExt": "sfm",
                "describerTypes": [
                    "sift"
                ]
            }
        },
        "DepthMapTransform_2": {
            "nodeType": "DepthMapTransform",
            "position": [
                901,
                177
            ],
            "inputs": {
                "inputSfM": "{DepthMap_5.input}",
                "depthMapsFolder": "{DepthMap_5.output}"
            }
        },
        "CalibrationComparison_2": {
            "nodeType": "CalibrationComparison",
            "position": [
                925,
                378
            ],
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_1.output}",
                "inputSfMGT": "{BlendedMVGDataset_1.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations"
                ]
            }
        },
        "SfMAlignment_2": {
            "nodeType": "SfMAlignment",
            "position": [
                533,
                367
            ],
            "inputs": {
                "input": "{Colmap2MeshroomSfmConvertion_1.outputSfm}",
                "reference": "{BlendedMVGDataset_1.outputSfMData}"
            }
        },
        "Meshing_3": {
            "nodeType": "Meshing",
            "position": [
                1794,
                290
            ],
            "inputs": {
                "input": "{DepthMapTransform_1.inputSfM}",
                "depthMapsFolder": "{DepthMapTransform_1.output}",
                "estimateSpaceFromSfM": false,
                "saveRawDensePointCloud": true
            }
        },
        "DepthMapFilter_3": {
            "nodeType": "DepthMapFilter",
            "position": [
                1719,
                -100
            ],
            "inputs": {
                "input": "{DepthMap_3.input}",
                "depthMapsFolder": "{DepthMap_3.output}"
            }
        },
        "DepthMap_3": {
            "nodeType": "DepthMap",
            "position": [
                1539,
                -96
            ],
            "inputs": {
                "input": "{PrepareDenseScene_3.input}",
                "imagesFolder": "{PrepareDenseScene_3.output}"
            }
        },
        "PrepareDenseScene_3": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1356,
                -110
            ],
            "inputs": {
                "input": "{SfMAlignment_1.output}"
            }
        },
        "Meshing_4": {
            "nodeType": "Meshing",
            "position": [
                1911,
                -117
            ],
            "inputs": {
                "input": "{DepthMapFilter_3.input}",
                "depthMapsFolder": "{DepthMapFilter_3.output}"
            }
        },
        "MeshFiltering_4": {
            "nodeType": "MeshFiltering",
            "position": [
                2092,
                -104
            ],
            "inputs": {
                "inputMesh": "{Meshing_4.outputMesh}"
            }
        },
        "Texturing_4": {
            "nodeType": "Texturing",
            "position": [
                2295,
                -155
            ],
            "inputs": {
                "input": "{Meshing_4.output}",
                "imagesFolder": "{DepthMap_3.imagesFolder}",
                "inputMesh": "{MeshFiltering_4.outputMesh}",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
                }
            }
        },
        "DepthMapFilter_5": {
            "nodeType": "DepthMapFilter",
            "position": [
                1716,
                48
            ],
            "inputs": {
                "input": "{DepthMap_5.input}",
                "depthMapsFolder": "{DepthMap_5.output}"
            }
        },
        "DepthMap_5": {
            "nodeType": "DepthMap",
            "position": [
                1534,
                51
            ],
            "inputs": {
                "input": "{PrepareDenseScene_5.input}",
                "imagesFolder": "{PrepareDenseScene_5.output}",
                "exportIntermediateResults": true
            }
        },
        "PrepareDenseScene_5": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1348,
                41
            ],
            "inputs": {
                "input": "{InjectSfmData_1.outputSfMData}"
            }
        },
        "Meshing_6": {
            "nodeType": "Meshing",
            "position": [
                1905,
                38
            ],
            "inputs": {
                "input": "{DepthMapFilter_5.input}",
                "depthMapsFolder": "{DepthMapFilter_5.output}",
                "saveRawDensePointCloud": true
            }
        },
        "MeshFiltering_6": {
            "nodeType": "MeshFiltering",
            "position": [
                2079,
                51
            ],
            "inputs": {
                "inputMesh": "{Meshing_6.outputMesh}"
            }
        },
        "Texturing_6": {
            "nodeType": "Texturing",
            "position": [
                2297,
                35
            ],
            "inputs": {
                "input": "{Meshing_6.output}",
                "imagesFolder": "{DepthMap_5.imagesFolder}",
                "inputMesh": "{MeshFiltering_6.outputMesh}",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
                }
            }
        }
    }
}