{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "Colmap2MeshroomSfmConvertion": "2.0",
            "InjectSfmData": "3.0",
            "DepthMap": "2.0",
            "PrepareDenseScene": "3.0",
            "ColmapMapper": "2.0",
            "StereoFusion": "2.0",
            "ImageMatching": "2.0",
            "ColmapFeatureMatching": "2.0",
            "Texturing": "6.0",
            "FeatureExtraction": "1.1",
            "CalibrationComparison": "3.0",
            "PoissonMesher": "2.0",
            "MeshFiltering": "3.0",
            "Dataset": "3.0",
            "PatchMatchStereo": "2.0",
            "Publish": "1.2",
            "SfMAlignment": "2.0",
            "ConvertSfMFormat": "2.0",
            "ImplicitMesh": "3.0",
            "ColmapImageUndistorder": "1.1",
            "StructureFromMotion": "2.0",
            "Meshing": "7.0",
            "FeatureMatching": "2.0",
            "DepthMapTransform": "3.0",
            "DepthMapComparison": "3.0",
            "DeepMVS": "3.0",
            "CameraInit": "8.0",
            "ColmapFeatureExtraction": "1.1",
            "DepthMapFilter": "3.0"
        },
        "template": false
    },
    "graph": {
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                380,
                -76
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "fa48293c8149c29ba2bcea78c8a8972ce8579c9d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "VocabularyTree",
                "tree": "/s/prods/mvg/_source_global/bank/generic_voctree/vlfeat_K80L3.SIFT.tree",
                "weights": "",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 50,
                "nbNeighbors": 50,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/imageMatches.txt"
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                761,
                -114
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "d94eea168fa2f5e9e9c20b70d1ffce26c1706874"
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
                "observationConstraint": "Basic",
                "localizerEstimatorMaxIterations": 4096,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
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
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.abc",
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm",
                "extraInfoFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                190,
                -73
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "87c960d659de0914b3009b46c881a3f05e8ef114"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Dataset_1.outputSfMDataCameraInit}",
                "masksFolder": "",
                "describerTypes": [
                    "sift"
                ],
                "describerPreset": "normal",
                "maxNbFeatures": 0,
                "describerQuality": "normal",
                "contrastFiltering": "GridSort",
                "relativePeakThreshold": 0.01,
                "gridFiltering": true,
                "forceCpuExtraction": true,
                "maxThreads": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "SfMAlignment_1": {
            "nodeType": "SfMAlignment",
            "position": [
                980,
                -97
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "b1b0bd93804e613225f2162b09cf9ea79b1c01c4"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "reference": "{Dataset_1.outputSfMData}",
                "method": "from_cameras_viewid",
                "fileMatchingPattern": ".*\\/(.*?)\\.\\w{3}",
                "metadataMatchingList": [],
                "applyScale": true,
                "applyRotation": true,
                "applyTranslation": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.abc",
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm"
            }
        },
        "InjectSfmData_1": {
            "nodeType": "InjectSfmData",
            "position": [
                1179,
                39
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "868f535074425f37665ca5d961c63f92a77870df"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sourceSfmData": "{ConvertSfMFormat_2.output}",
                "targetSfmData": "{Dataset_1.outputSfMData}",
                "exportedFields": [
                    "structure",
                    "featuresFolders",
                    "matchesFolders"
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "outputSfMData": "{cache}/{nodeType}/{uid0}/sfm.sfm"
            }
        },
        "Publish_1": {
            "nodeType": "Publish",
            "position": [
                2872,
                127
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 6,
                "split": 1
            },
            "uids": {
                "0": "8b015c2f10df8dbe434dc2d69999d839620d2429"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFiles": [
                    "{CalibrationComparison_1.outputCsv}",
                    "{DepthMapComparison_1.outputCsv}",
                    "{Texturing_2.outputMesh}",
                    "{Texturing_6.outputMesh}",
                    "{Texturing_4.outputMesh}",
                    "{CalibrationComparison_2.outputCsv}"
                ],
                "output": "",
                "verboseLevel": "info"
            },
            "outputs": {}
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                570,
                -78
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "366ee5f0aa955b4b07aa17342a9087c1826884ae"
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
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                2033,
                373
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "79c042ef147ba1b3e31bc2ba8e5096841d775070"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_3.input}",
                "imagesFolders": [],
                "masksFolders": [],
                "outputFileType": "exr",
                "saveMetadata": true,
                "saveMatricesTxtFiles": false,
                "evCorrection": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "undistorted": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.{outputFileTypeValue}"
            }
        },
        "DepthMapTransform_1": {
            "nodeType": "DepthMapTransform",
            "position": [
                1557,
                274
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "d1048a572a4781a80f0d94620ae96157fbdcab1c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{Dataset_1.outputSfMData}",
                "depthMapsFolder": "{Dataset_1.outputGroundTruthdepthMapsFolder}",
                "transform": "normal2meshroom",
                "processDepthMap": [
                    "folder"
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthmap.exr"
            }
        },
        "ColmapFeatureMatching_1": {
            "nodeType": "ColmapFeatureMatching",
            "position": [
                306,
                529
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9aee61424f9b1c0dca651e088301c0e365655af1"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_database_path": "{ColmapFeatureExtraction_1.database_path}",
                "use_gpu": false
            },
            "outputs": {
                "database_path": "{cache}/{nodeType}/{uid0}/colmap_database_matches.db"
            }
        },
        "ColmapMapper_1": {
            "nodeType": "ColmapMapper",
            "position": [
                490,
                542
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "d34fb763ff3dc358b4bcbb44be48bd9019f6d29f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_database_path": "{ColmapFeatureMatching_1.database_path}",
                "image_path": "{ColmapFeatureExtraction_1.image_path}"
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/",
                "output_path0": "{cache}/{nodeType}/{uid0}/0",
                "database_path": "{cache}/{nodeType}/{uid0}/colmap_database_mapper.db"
            }
        },
        "PatchMatchStereo_1": {
            "nodeType": "PatchMatchStereo",
            "position": [
                867,
                552
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "810cd8dc4b0371d97c523d75e45d806b440ada95"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_folder": "{ColmapImageUndistorder_1.output_path}"
            },
            "outputs": {
                "workspace_path": "{cache}/{nodeType}/{uid0}/workspace"
            }
        },
        "ColmapImageUndistorder_1": {
            "nodeType": "ColmapImageUndistorder",
            "position": [
                682,
                544
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f676757cdee5021be95bf4cf540e54c7079aefef"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "image_path": "{ColmapMapper_1.image_path}",
                "input_path": "{ColmapMapper_1.output_path0}",
                "max_image_size": "2000"
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Colmap2MeshroomSfmConvertion_1": {
            "nodeType": "Colmap2MeshroomSfmConvertion",
            "position": [
                333,
                385
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "42872766420a711f1cf2f2f1f01562a0e4699592"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ColmapMapper_1.output_path0}",
                "inputSfm": "{Dataset_1.outputSfMData}",
                "imageFolder": "{ColmapFeatureExtraction_1.image_path}",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputSfm": "{cache}/{nodeType}/{uid0}/sfmdata.sfm"
            }
        },
        "StereoFusion_1": {
            "nodeType": "StereoFusion",
            "position": [
                1061,
                553
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "2ee4acf8981139f77364524fb9f9b8c46d96472e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_folder": "{PatchMatchStereo_1.workspace_path}"
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/workspace\\fused.ply",
                "workspace_path": "{cache}/{nodeType}/{uid0}/workspace"
            }
        },
        "ConvertSfMFormat_1": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                709,
                390
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "00920d2ca3a77fe5496c1ddee2cb9e43e985385c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMAlignment_2.output}",
                "fileExt": "sfm",
                "describerTypes": [
                    "dspsift"
                ],
                "imageWhiteList": [],
                "views": true,
                "intrinsics": true,
                "extrinsics": true,
                "structure": true,
                "observations": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.{fileExtValue}"
            }
        },
        "CalibrationComparison_1": {
            "nodeType": "CalibrationComparison",
            "position": [
                695,
                175
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4ad39699aed3fb19670a98bf3f0a9ee01b810c34"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_2.output}",
                "inputSfMGT": "{Dataset_1.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations",
                    "validCams"
                ],
                "csv_name": "calibration_comparison.csv",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "outputCsv": "{cache}/{nodeType}/{uid0}/calibration_comparison.csv"
            }
        },
        "ColmapFeatureExtraction_1": {
            "nodeType": "ColmapFeatureExtraction",
            "position": [
                112,
                559
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "78c06d16cb531c3b41df235d41f10fb29604a6d9"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_sfm": "{Dataset_1.outputSfMData}",
                "use_gpu": false
            },
            "outputs": {
                "database_path": "{cache}/{nodeType}/{uid0}/colmap_database.db",
                "image_list_path": "{cache}/{nodeType}/{uid0}/used_images.txt",
                "image_path": "{cache}/{nodeType}/{uid0}/images"
            }
        },
        "DepthMapComparison_1": {
            "nodeType": "DepthMapComparison",
            "position": [
                1097,
                177
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "fba8f2dc92af0c77e95730037a662e11ea6b6433"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{DepthMapTransform_2.inputSfM}",
                "inputSfMGT": "{Dataset_1.outputSfMData}",
                "depthMapsFolder": "{DepthMapTransform_2.output}",
                "depthMapsFolderGT": "",
                "metrics": [
                    "RMSE",
                    "MAE",
                    "validity_ratio"
                ],
                "autoRescale": false,
                "maskValue": "0",
                "csv_name": "depth_map_comparison.csv",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputCsv": "{cache}/{nodeType}/{uid0}/depth_map_comparison.csv"
            }
        },
        "PoissonMesher_1": {
            "nodeType": "PoissonMesher",
            "position": [
                1262,
                552
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "bfcae4073d48f65a83912083447fe15fe5061797"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_path": "{StereoFusion_1.output_path}",
                "trim": 0.0
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/mesh_poisson.ply"
            }
        },
        "Dataset_1": {
            "nodeType": "Dataset",
            "position": [
                12,
                167
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "f9c329ed0bd8349ff3bef8c65648e4698ab3caa3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_1.output}",
                "datasetType": "blendedMVG",
                "initIntrinsics": true,
                "permutationMatrix": "[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]",
                "focalOverwrite": -1.0,
                "inverse": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputSfMDataCameraInit": "{cache}/{nodeType}/{uid0}/sfm_camerainit.sfm",
                "outputSfMData": "{cache}/{nodeType}/{uid0}/sfm.sfm",
                "outputGroundTruthdepthMapsFolder": "{cache}/{nodeType}/{uid0}/depth_maps",
                "depthmaps": "{cache}/{nodeType}/{uid0}/depth_maps<VIEW_ID>_depthMap.exr"
            }
        },
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                -193,
                194
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "9f7912b02ff1be9cf0027d53a695dbfe623f421f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 95931756,
                        "poseId": 95931756,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000010.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 172308259,
                        "poseId": 172308259,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000013.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 173767749,
                        "poseId": 173767749,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000011.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 173790143,
                        "poseId": 173790143,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000012.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 188300942,
                        "poseId": 188300942,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000014.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 197578742,
                        "poseId": 197578742,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000015.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 541749801,
                        "poseId": 541749801,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000007.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 544295899,
                        "poseId": 544295899,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000006.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 546801641,
                        "poseId": 546801641,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000004.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 548557453,
                        "poseId": 548557453,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000005.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 568626937,
                        "poseId": 568626937,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000009.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 570137753,
                        "poseId": 570137753,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000008.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1610648207,
                        "poseId": 1610648207,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000002.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1613948207,
                        "poseId": 1613948207,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000001.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1614110299,
                        "poseId": 1614110299,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000000.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1671674650,
                        "poseId": 1671674650,
                        "path": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images/00000003.jpg",
                        "intrinsicId": 993703311,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:rawColorInterpretation\": \"librawwhitebalancing\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 993703311,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "pinhole",
                        "width": 768,
                        "height": 576,
                        "sensorWidth": 36.0,
                        "sensorHeight": 27.0,
                        "serialNumber": "C:/data/blended_mvg_test_sets/5aa0f9d7a9efce63548c69a1/blended_images",
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
                "colorProfileDatabase": "${ALICEVISION_COLOR_PROFILE_DB}",
                "defaultFieldOfView": 45.0,
                "groupCameraFallback": "folder",
                "allowedCameraModels": [
                    "pinhole"
                ],
                "rawColorInterpretation": "LibRawWhiteBalancing",
                "errorOnMissingColorProfile": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/cameraInit.sfm"
            }
        },
        "ImplicitMesh_1": {
            "nodeType": "ImplicitMesh",
            "position": [
                168,
                -337
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "502b8626b5596c010521eef241af83c326a94352"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfmData": "{Dataset_1.outputSfMData}",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.ply",
                "nerfFile": "{cache}/{nodeType}/{uid0}/transforms.json",
                "poseTransform": "{cache}/{nodeType}/{uid0}/poseTransform.json"
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                821,
                -236
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5f7c7bab7d4565fbae5769406daddcd336c8cdd3"
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
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                538,
                -213
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "88e5b3196e177f5bf1d3eed5c8ea837aa4cb835e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DeepMVS_1.inputSfmData}",
                "depthMapsFolder": "{DepthMapTransform_3.output}",
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
                "saveRawDensePointCloud": true,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                1024,
                -287
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "7c3a0eeff4b76dc62393ae633cdea55271e24f65"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_1.output}",
                "imagesFolder": "",
                "inputMesh": "{MeshFiltering_1.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
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
                "processColorspace": "sRGB",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.png"
            }
        },
        "DeepMVS_1": {
            "nodeType": "DeepMVS",
            "position": [
                165,
                -203
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "502b8626b5596c010521eef241af83c326a94352"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfmData": "{Dataset_1.outputSfMData}",
                "model": "RMVD",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputDepthMapsFolder": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr"
            }
        },
        "Texturing_2": {
            "nodeType": "Texturing",
            "position": [
                2297,
                238
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "ad9e9b6403f55271a0c3efbf156c1e14a43d9cce"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_3.output}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
                "inputMesh": "{MeshFiltering_2.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
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
                "processColorspace": "sRGB",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.png"
            }
        },
        "MeshFiltering_2": {
            "nodeType": "MeshFiltering",
            "position": [
                2023,
                269
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c5412b562e4a7f79003e576e6308ca532b94de36"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{Meshing_3.outputMesh}",
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
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "ConvertSfMFormat_2": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                992,
                43
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "bf3e9d0d65bcc76bd88eaafae1919972e45ff356"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMAlignment_1.output}",
                "fileExt": "sfm",
                "describerTypes": [
                    "sift"
                ],
                "imageWhiteList": [],
                "views": true,
                "intrinsics": true,
                "extrinsics": true,
                "structure": true,
                "observations": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.{fileExtValue}"
            }
        },
        "DepthMapTransform_2": {
            "nodeType": "DepthMapTransform",
            "position": [
                901,
                177
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "b404a839014b2fd44f41313617e6595411d8dc03"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{DepthMap_5.input}",
                "depthMapsFolder": "{DepthMap_5.output}",
                "transform": "meshroom2normal",
                "processDepthMap": [
                    "folder"
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthmap.exr"
            }
        },
        "SfMAlignment_2": {
            "nodeType": "SfMAlignment",
            "position": [
                533,
                367
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "58692d809e288760f15cfa66487571efdc3eb207"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Colmap2MeshroomSfmConvertion_1.outputSfm}",
                "reference": "{Dataset_1.outputSfMData}",
                "method": "from_cameras_viewid",
                "fileMatchingPattern": ".*\\/(.*?)\\.\\w{3}",
                "metadataMatchingList": [],
                "applyScale": true,
                "applyRotation": true,
                "applyTranslation": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfmdata.abc",
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm"
            }
        },
        "CalibrationComparison_2": {
            "nodeType": "CalibrationComparison",
            "position": [
                925,
                378
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "36e9b24d70f6d545bdc468a70e8bd578ef520484"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_1.output}",
                "inputSfMGT": "{Dataset_1.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations",
                    "MSEFocal",
                    "MSEPrincipalPoint"
                ],
                "csv_name": "calibration_comparison_colmap.csv",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "outputCsv": "{cache}/{nodeType}/{uid0}/calibration_comparison_colmap.csv"
            }
        },
        "Meshing_3": {
            "nodeType": "Meshing",
            "position": [
                1794,
                290
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f4fb57888f70472dc1eef3cfbf20c355f40d4652"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapTransform_1.inputSfM}",
                "depthMapsFolder": "{DepthMapTransform_1.output}",
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
                "estimateSpaceFromSfM": false,
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
                "saveRawDensePointCloud": true,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "DepthMapFilter_3": {
            "nodeType": "DepthMapFilter",
            "position": [
                1719,
                -108
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 16,
                "split": 2
            },
            "uids": {
                "0": "d71975419e541ed9b59a549a96f60b6c8d9303a6"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_3.input}",
                "depthMapsFolder": "{DepthMap_3.output}",
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "nNearestCams": 10,
                "minNumOfConsistentCams": 3,
                "minNumOfConsistentCamsWithLowSimilarity": 4,
                "pixToleranceFactor": 2.0,
                "pixSizeBall": 0,
                "pixSizeBallWithLowSimilarity": 0,
                "computeNormalMaps": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "DepthMap_3": {
            "nodeType": "DepthMap",
            "position": [
                1539,
                -96
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 16,
                "split": 6
            },
            "uids": {
                "0": "597d231fc2cfffe387e609bc107496b248a5fde8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_3.input}",
                "imagesFolder": "{PrepareDenseScene_3.output}",
                "downscale": 2,
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "sgmScale": -1,
                "sgmStepXY": -1,
                "sgmStepZ": -1,
                "sgmMaxSideXY": 700,
                "sgmMaxTCams": 10,
                "sgmWSH": 4,
                "sgmGammaC": 5.5,
                "sgmGammaP": 8.0,
                "sgmP1": 10.0,
                "sgmP2": 100.0,
                "sgmMaxDepths": 3000,
                "sgmMaxDepthsPerTc": 1500,
                "sgmUseSfmSeeds": true,
                "sgmFilteringAxes": "YX",
                "refineMaxTCams": 6,
                "refineNSamplesHalf": 150,
                "refineNDepthsToRefine": 31,
                "refineNiters": 100,
                "refineWSH": 3,
                "refineSigma": 15.0,
                "refineGammaC": 15.5,
                "refineGammaP": 8.0,
                "refineUseTcOrRcPixSize": false,
                "exportIntermediateResults": false,
                "nbGPUs": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "PrepareDenseScene_3": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1356,
                -110
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "3b858ad2ec60757ddd1b2714c6d2940061be5705"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMAlignment_1.output}",
                "imagesFolders": [],
                "masksFolders": [],
                "outputFileType": "exr",
                "saveMetadata": true,
                "saveMatricesTxtFiles": false,
                "evCorrection": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "undistorted": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.{outputFileTypeValue}"
            }
        },
        "DepthMapTransform_3": {
            "nodeType": "DepthMapTransform",
            "position": [
                357,
                -213
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "422d3fad9a3affb54a55abc49204e5ab43f8a93b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{DeepMVS_1.inputSfmData}",
                "depthMapsFolder": "{DeepMVS_1.outputDepthMapsFolder}",
                "transform": "normal2meshroom",
                "processDepthMap": [
                    "folder"
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthmap.exr"
            }
        },
        "Meshing_4": {
            "nodeType": "Meshing",
            "position": [
                1911,
                -117
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "37194cf73af92cbc23b083091f11a9a4f732ad42"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_3.input}",
                "depthMapsFolder": "{DepthMapFilter_3.output}",
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
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "MeshFiltering_4": {
            "nodeType": "MeshFiltering",
            "position": [
                2092,
                -104
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4e5178977daa24bfd13e039606cdd0a1589e2939"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{Meshing_4.outputMesh}",
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
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "Texturing_4": {
            "nodeType": "Texturing",
            "position": [
                2295,
                -155
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "39e96b4cd1df72b57c6b6a447cc2ae53e50f5f37"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_4.output}",
                "imagesFolder": "{DepthMap_3.imagesFolder}",
                "inputMesh": "{MeshFiltering_4.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
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
                "processColorspace": "sRGB",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.png"
            }
        },
        "DepthMapFilter_5": {
            "nodeType": "DepthMapFilter",
            "position": [
                1716,
                48
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 16,
                "split": 2
            },
            "uids": {
                "0": "15b6ff6c64f439bbd21def17652d30750edd16c7"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_5.input}",
                "depthMapsFolder": "{DepthMap_5.output}",
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "nNearestCams": 10,
                "minNumOfConsistentCams": 3,
                "minNumOfConsistentCamsWithLowSimilarity": 4,
                "pixToleranceFactor": 2.0,
                "pixSizeBall": 0,
                "pixSizeBallWithLowSimilarity": 0,
                "computeNormalMaps": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "DepthMap_5": {
            "nodeType": "DepthMap",
            "position": [
                1534,
                51
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 16,
                "split": 6
            },
            "uids": {
                "0": "a624010f45427040102325b8b6598b3431584b2b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_5.input}",
                "imagesFolder": "{PrepareDenseScene_5.output}",
                "downscale": 2,
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "sgmScale": -1,
                "sgmStepXY": -1,
                "sgmStepZ": -1,
                "sgmMaxSideXY": 700,
                "sgmMaxTCams": 10,
                "sgmWSH": 4,
                "sgmGammaC": 5.5,
                "sgmGammaP": 8.0,
                "sgmP1": 10.0,
                "sgmP2": 100.0,
                "sgmMaxDepths": 3000,
                "sgmMaxDepthsPerTc": 1500,
                "sgmUseSfmSeeds": true,
                "sgmFilteringAxes": "YX",
                "refineMaxTCams": 6,
                "refineNSamplesHalf": 150,
                "refineNDepthsToRefine": 31,
                "refineNiters": 100,
                "refineWSH": 3,
                "refineSigma": 15.0,
                "refineGammaC": 15.5,
                "refineGammaP": 8.0,
                "refineUseTcOrRcPixSize": false,
                "exportIntermediateResults": true,
                "nbGPUs": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "PrepareDenseScene_5": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1348,
                41
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "4422c1c8f2c81432a9081c0db4ecd47f9b31f679"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{InjectSfmData_1.outputSfMData}",
                "imagesFolders": [],
                "masksFolders": [],
                "outputFileType": "exr",
                "saveMetadata": true,
                "saveMatricesTxtFiles": false,
                "evCorrection": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "undistorted": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.{outputFileTypeValue}"
            }
        },
        "Meshing_6": {
            "nodeType": "Meshing",
            "position": [
                1905,
                38
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5b987f8ef7bfe4a0ce450a83578a0e632f77defd"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_5.input}",
                "depthMapsFolder": "{DepthMapFilter_5.output}",
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
                "saveRawDensePointCloud": true,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "MeshFiltering_6": {
            "nodeType": "MeshFiltering",
            "position": [
                2079,
                51
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "2757197ec1815a1ce284ac442893f4dc443470b4"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{Meshing_6.outputMesh}",
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
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "Texturing_6": {
            "nodeType": "Texturing",
            "position": [
                2297,
                35
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "8ab9a1cf76dddb9bfd6c666b6ffde795a174063d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_6.output}",
                "imagesFolder": "{DepthMap_5.imagesFolder}",
                "inputMesh": "{MeshFiltering_6.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
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
                "processColorspace": "sRGB",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.png"
            }
        }
    }
}