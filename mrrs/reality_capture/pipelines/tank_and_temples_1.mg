{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "CalibrationComparison": "3.0",
            "MeshFiltering": "3.0",
            "Meshing": "7.0",
            "FeatureMatching": "2.0",
            "SfMAlignment": "2.0",
            "InjectSfmData": "3.0",
            "ExportXMP": "3.0",
            "ConvertSfMFormat": "2.0",
            "FeatureExtraction": "1.1",
            "StructureFromMotion": "2.0",
            "Dataset": "3.0",
            "DepthMapFilter": "3.0",
            "Publish": "1.2",
            "CameraInit": "8.0",
            "Texturing": "6.0",
            "PrepareDenseScene": "3.0",
            "ImageMatching": "2.0",
            "DepthMap": "2.0"
        }
    },
    "graph": {
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                2108,
                -324
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "11dbbb9c7a0ebfc82fe1a268ab6a6620e72fea19"
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
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.exr"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                1735,
                -325
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5f11cc13b73a9d5205f055e136765a3b79daa847"
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
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                1535,
                -325
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 152,
                "split": 16
            },
            "uids": {
                "0": "3863f2639bfacfc666b287b7c5fd0054757857db"
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
                "computeNormalMaps": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                346,
                -309
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "ec88689f04b08884e7eaebbcd8fb2393aa7ac34a"
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
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/imageMatches.txt"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                146,
                -309
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 152,
                "split": 4
            },
            "uids": {
                "0": "60b800492510b6ceeac9363ca57d91d820ca33b8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Dataset_2.outputSfMDataCameraInit}",
                "masksFolder": "",
                "describerTypes": [
                    "dspsift"
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
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                760,
                -340
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "90f3c8c034a75c1b88a363349332c8e853a65701"
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
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1135,
                -325
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 152,
                "split": 4
            },
            "uids": {
                "0": "34b5e7a382f84632b9d887f749612311f78b5495"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMAlignment_2.output}",
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
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                1335,
                -325
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 152,
                "split": 51
            },
            "uids": {
                "0": "6fb38cfae6bd025bcb7f3839a89a464fd2ec6e22"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_1.input}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
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
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                1922,
                -321
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "a317b1cd7503c223e44e416a702b6afb12db529c"
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
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                546,
                -309
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 152,
                "split": 8
            },
            "uids": {
                "0": "922b8fec851a1671bad11f6e1a23140dfcb60a12"
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
        "SfMAlignment_1": {
            "nodeType": "SfMAlignment",
            "position": [
                507,
                196
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "413a4000392098ec89e58c0b353d8265af6ede62"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Dataset_1.outputSfMData}",
                "reference": "{Dataset_2.outputSfMData}",
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
        "ExportXMP_1": {
            "nodeType": "ExportXMP",
            "position": [
                -309,
                163
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "2cf9d1b4d818dea22b5b6e5dc74d0956da718c13"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "targetXMP": "export_reality_capture",
                "sfmData": "{Dataset_1.outputSfMData}",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "InjectSfmData_1": {
            "nodeType": "InjectSfmData",
            "position": [
                1082,
                161
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "bd8ca2358915b57eebeec4a835d14656704104eb"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sourceSfmData": "{ConvertSfMFormat_1.output}",
                "targetSfmData": "{ConvertSfMFormat_4.output}",
                "exportedFields": [
                    "structure"
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "outputSfMData": "{cache}/{nodeType}/{uid0}/sfm.sfm"
            }
        },
        "ConvertSfMFormat_1": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                811,
                -122
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "e387abc591efdd60824c28c68063bee792a60ce3"
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
        "Dataset_1": {
            "nodeType": "Dataset",
            "position": [
                31,
                161
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "5082e6c52b95858e673329c446fde2e4396b5122"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_1.output}",
                "datasetType": "realityCapture",
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
        "CalibrationComparison_1": {
            "nodeType": "CalibrationComparison",
            "position": [
                464,
                -80
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "917afcdd2c918c965e0aaba565e257b3f699ad31"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_1.output}",
                "inputSfMGT": "{Dataset_2.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations"
                ],
                "csv_name": "calibration_comparison_mr.csv",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "outputCsv": "{cache}/{nodeType}/{uid0}/calibration_comparison_mr.csv"
            }
        },
        "Publish_1": {
            "nodeType": "Publish",
            "position": [
                729,
                45
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 2,
                "split": 1
            },
            "uids": {
                "0": "1e7876f8fbf41db6b47b9e678fd5c397c9a4ae02"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFiles": [
                    "{CalibrationComparison_1.outputCsv}",
                    "{CalibrationComparison_2.outputCsv}"
                ],
                "output": "",
                "verboseLevel": "info"
            },
            "outputs": {}
        },
        "SfMAlignment_2": {
            "nodeType": "SfMAlignment",
            "position": [
                955,
                -280
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "4c6f5801ddd3e143e034950a5ab7ea8b7a9fe8d0"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "reference": "{ConvertSfMFormat_5.input}",
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
        "InjectSfmData_2": {
            "nodeType": "InjectSfmData",
            "position": [
                996,
                -27
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "58fa204b4ad4b08487c8fe90fa3cdfceefaad922"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sourceSfmData": "{ConvertSfMFormat_1.output}",
                "targetSfmData": "{Dataset_2.outputSfMData}",
                "exportedFields": [
                    "structure"
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "outputSfMData": "{cache}/{nodeType}/{uid0}/sfm.sfm"
            }
        },
        "Dataset_2": {
            "nodeType": "Dataset",
            "position": [
                -17,
                -24
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "760f2f4595d166ce343a9872b53a86893b006e88"
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
        "CalibrationComparison_2": {
            "nodeType": "CalibrationComparison",
            "position": [
                461,
                63
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c417fe7602792f664f5a2e707ba9e94357ad53f8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_4.output}",
                "inputSfMGT": "{Dataset_2.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations"
                ],
                "csv_name": "calibration_comparison_rc.csv",
                "verboseLevel": "info"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "outputCsv": "{cache}/{nodeType}/{uid0}/calibration_comparison_rc.csv"
            }
        },
        "Texturing_3": {
            "nodeType": "Texturing",
            "position": [
                2337,
                181
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "48dfd5d6911e4e06ffe7da05ee54c424476dfb17"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_3.output}",
                "imagesFolder": "{DepthMap_3.imagesFolder}",
                "inputMesh": "{MeshFiltering_3.outputMesh}",
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
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.exr"
            }
        },
        "Meshing_3": {
            "nodeType": "Meshing",
            "position": [
                1937,
                181
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "be5ffe01eb86537c038ca3bff20b32bb1d64f959"
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
        "DepthMapFilter_3": {
            "nodeType": "DepthMapFilter",
            "position": [
                1737,
                181
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 152,
                "split": 16
            },
            "uids": {
                "0": "d25e0292229ea41823155e048e0142f412725a23"
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
        "PrepareDenseScene_3": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1337,
                181
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 152,
                "split": 4
            },
            "uids": {
                "0": "18887bbe3fdae747b478ccf276383e554383081f"
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
        "DepthMap_3": {
            "nodeType": "DepthMap",
            "position": [
                1537,
                181
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 152,
                "split": 51
            },
            "uids": {
                "0": "2e9071dc561e77e09d98a114dcef3a5a4bb290b0"
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
        "MeshFiltering_3": {
            "nodeType": "MeshFiltering",
            "position": [
                2137,
                181
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "314e26c1ec94c4cd831d1fb290f7e58b83f09ab8"
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
        "ConvertSfMFormat_4": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                883,
                177
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "38a15b2736f53ac8a3b90bde0133ae9466c8666d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMAlignment_1.output}",
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
        "DepthMapFilter_4": {
            "nodeType": "DepthMapFilter",
            "position": [
                1612,
                -51
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 152,
                "split": 16
            },
            "uids": {
                "0": "73812c503224d6ce65ca3447d53919cd0c61482e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_4.input}",
                "depthMapsFolder": "{DepthMap_4.output}",
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
        "DepthMap_4": {
            "nodeType": "DepthMap",
            "position": [
                1412,
                -51
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 152,
                "split": 51
            },
            "uids": {
                "0": "9d649ed1f262f9e83baae89b6b743301f258d063"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_4.input}",
                "imagesFolder": "{PrepareDenseScene_4.output}",
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
        "MeshFiltering_4": {
            "nodeType": "MeshFiltering",
            "position": [
                1999,
                -47
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9a27db51a8b566dfbb597567dfda1853133336c6"
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
        "Meshing_4": {
            "nodeType": "Meshing",
            "position": [
                1812,
                -51
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "bfed3e4d49295faa086eb65324b715e44990f309"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_4.input}",
                "depthMapsFolder": "{DepthMapFilter_4.output}",
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
        "PrepareDenseScene_4": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1212,
                -51
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 152,
                "split": 4
            },
            "uids": {
                "0": "b563e8e415f48e00b61bd86b30680d81818fe565"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{InjectSfmData_2.outputSfMData}",
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
        "Texturing_4": {
            "nodeType": "Texturing",
            "position": [
                2185,
                -50
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "345e775937d6933175a7d299912adce8c2e70c62"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_4.output}",
                "imagesFolder": "{DepthMap_4.imagesFolder}",
                "inputMesh": "{MeshFiltering_4.outputMesh}",
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
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.exr"
            }
        },
        "ConvertSfMFormat_5": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                183,
                -156
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "30fa011f6431864c549dd8657b1f3fa80256f107"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Dataset_2.outputSfMData}",
                "fileExt": "abc",
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
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                -195,
                -67
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 152,
                "split": 1
            },
            "uids": {
                "0": "493906fbaa108e9ba06dcbd2d3b0a3ed135aecc3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 92727450,
                        "poseId": 92727450,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000132.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 95769165,
                        "poseId": 95769165,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000130.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 97675825,
                        "poseId": 97675825,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000131.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 143542492,
                        "poseId": 143542492,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000094.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 178334540,
                        "poseId": 178334540,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000051.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 178612744,
                        "poseId": 178612744,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000050.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 179179239,
                        "poseId": 179179239,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000052.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 190926343,
                        "poseId": 190926343,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000059.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 199145045,
                        "poseId": 199145045,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000058.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 278789502,
                        "poseId": 278789502,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000095.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 279540751,
                        "poseId": 279540751,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000096.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 279975703,
                        "poseId": 279975703,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000090.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 287412263,
                        "poseId": 287412263,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000093.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 290511479,
                        "poseId": 290511479,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000091.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 292923351,
                        "poseId": 292923351,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000092.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 303266580,
                        "poseId": 303266580,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000100.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 304357218,
                        "poseId": 304357218,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000104.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 305260500,
                        "poseId": 305260500,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000105.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 309663996,
                        "poseId": 309663996,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000103.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 317393980,
                        "poseId": 317393980,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000102.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 336241518,
                        "poseId": 336241518,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000148.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 338531072,
                        "poseId": 338531072,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000149.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 403307995,
                        "poseId": 403307995,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000150.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 403842140,
                        "poseId": 403842140,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000039.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 406334714,
                        "poseId": 406334714,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000038.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 413326117,
                        "poseId": 413326117,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000056.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 414963679,
                        "poseId": 414963679,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000053.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 415584579,
                        "poseId": 415584579,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000055.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 418984797,
                        "poseId": 418984797,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000054.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 420442457,
                        "poseId": 420442457,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000057.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 449356250,
                        "poseId": 449356250,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000031.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 451604408,
                        "poseId": 451604408,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000030.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 452456769,
                        "poseId": 452456769,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000033.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 452487747,
                        "poseId": 452487747,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000032.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 453372266,
                        "poseId": 453372266,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000036.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 456734395,
                        "poseId": 456734395,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000151.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 457801834,
                        "poseId": 457801834,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000034.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 458546848,
                        "poseId": 458546848,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000035.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 460131434,
                        "poseId": 460131434,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000037.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 479976637,
                        "poseId": 479976637,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000107.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 482242949,
                        "poseId": 482242949,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000108.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 486040903,
                        "poseId": 486040903,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000106.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 488219478,
                        "poseId": 488219478,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000008.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 490943248,
                        "poseId": 490943248,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000004.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 492136901,
                        "poseId": 492136901,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000109.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 493372328,
                        "poseId": 493372328,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000006.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 495857516,
                        "poseId": 495857516,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000009.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 496837098,
                        "poseId": 496837098,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000007.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 497870902,
                        "poseId": 497870902,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000005.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 498881050,
                        "poseId": 498881050,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000101.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 499750283,
                        "poseId": 499750283,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000000.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 500005119,
                        "poseId": 500005119,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000001.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 500901743,
                        "poseId": 500901743,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000002.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 503150874,
                        "poseId": 503150874,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000003.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 621152460,
                        "poseId": 621152460,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000048.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 623625006,
                        "poseId": 623625006,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000049.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 625983944,
                        "poseId": 625983944,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000044.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 628866750,
                        "poseId": 628866750,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000045.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 630160421,
                        "poseId": 630160421,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000043.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 708768702,
                        "poseId": 708768702,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000046.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 719145182,
                        "poseId": 719145182,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000047.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 719844935,
                        "poseId": 719844935,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000042.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 720092112,
                        "poseId": 720092112,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000041.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 720637118,
                        "poseId": 720637118,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000040.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 811600451,
                        "poseId": 811600451,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000014.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 812223007,
                        "poseId": 812223007,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000015.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 844118379,
                        "poseId": 844118379,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000016.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 852818842,
                        "poseId": 852818842,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000013.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853171946,
                        "poseId": 853171946,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000011.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853489560,
                        "poseId": 853489560,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000012.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853679335,
                        "poseId": 853679335,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000017.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 853867215,
                        "poseId": 853867215,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000010.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 865218133,
                        "poseId": 865218133,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000019.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 867845985,
                        "poseId": 867845985,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000018.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 892123354,
                        "poseId": 892123354,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000145.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 892368924,
                        "poseId": 892368924,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000144.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 894737330,
                        "poseId": 894737330,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000147.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 896548124,
                        "poseId": 896548124,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000146.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899620278,
                        "poseId": 899620278,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000141.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899999784,
                        "poseId": 899999784,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000140.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 902405701,
                        "poseId": 902405701,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000143.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 904860505,
                        "poseId": 904860505,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000142.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 952872460,
                        "poseId": 952872460,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000111.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 953573352,
                        "poseId": 953573352,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000113.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 953593728,
                        "poseId": 953593728,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000110.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 958230226,
                        "poseId": 958230226,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000115.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 960716391,
                        "poseId": 960716391,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000114.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 969901938,
                        "poseId": 969901938,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000112.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1044248309,
                        "poseId": 1044248309,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000119.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1045969559,
                        "poseId": 1045969559,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000116.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1047526903,
                        "poseId": 1047526903,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000118.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1047999799,
                        "poseId": 1047999799,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000117.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1082847351,
                        "poseId": 1082847351,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000066.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1095222346,
                        "poseId": 1095222346,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000082.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1095337378,
                        "poseId": 1095337378,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000080.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1098528316,
                        "poseId": 1098528316,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000083.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1100154527,
                        "poseId": 1100154527,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000089.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1101800224,
                        "poseId": 1101800224,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000081.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1103498624,
                        "poseId": 1103498624,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000085.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1104667747,
                        "poseId": 1104667747,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000087.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1105461111,
                        "poseId": 1105461111,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000086.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1106326051,
                        "poseId": 1106326051,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000088.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1109731746,
                        "poseId": 1109731746,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000084.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1185078819,
                        "poseId": 1185078819,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000068.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1186765687,
                        "poseId": 1186765687,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000069.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1192666515,
                        "poseId": 1192666515,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000067.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1193558067,
                        "poseId": 1193558067,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000064.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1204122458,
                        "poseId": 1204122458,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000065.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1204699197,
                        "poseId": 1204699197,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000029.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1204960952,
                        "poseId": 1204960952,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000028.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1205226442,
                        "poseId": 1205226442,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000063.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1354642580,
                        "poseId": 1354642580,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000137.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1354865921,
                        "poseId": 1354865921,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000133.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1362755106,
                        "poseId": 1362755106,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000134.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1364852164,
                        "poseId": 1364852164,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000135.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1367304730,
                        "poseId": 1367304730,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000136.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1369980854,
                        "poseId": 1369980854,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000139.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1370145960,
                        "poseId": 1370145960,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000138.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1376295226,
                        "poseId": 1376295226,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000027.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1378596564,
                        "poseId": 1378596564,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000026.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1381386154,
                        "poseId": 1381386154,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000021.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1383517911,
                        "poseId": 1383517911,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000025.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1386038431,
                        "poseId": 1386038431,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000024.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1476596150,
                        "poseId": 1476596150,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000023.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1502676552,
                        "poseId": 1502676552,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000022.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1508583884,
                        "poseId": 1508583884,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000020.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1749526425,
                        "poseId": 1749526425,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000078.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1750271301,
                        "poseId": 1750271301,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000079.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1769381473,
                        "poseId": 1769381473,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000077.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1769783029,
                        "poseId": 1769783029,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000076.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1774407272,
                        "poseId": 1774407272,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000074.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1776301942,
                        "poseId": 1776301942,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000075.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1826324887,
                        "poseId": 1826324887,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000099.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1835888194,
                        "poseId": 1835888194,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000098.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1854766126,
                        "poseId": 1854766126,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000073.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1854960024,
                        "poseId": 1854960024,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000070.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1855500470,
                        "poseId": 1855500470,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000071.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1860950124,
                        "poseId": 1860950124,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000072.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1928230908,
                        "poseId": 1928230908,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000127.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1928248794,
                        "poseId": 1928248794,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000126.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1930038010,
                        "poseId": 1930038010,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000125.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1931887534,
                        "poseId": 1931887534,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000124.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1935173102,
                        "poseId": 1935173102,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000123.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1937139656,
                        "poseId": 1937139656,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000122.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1972891840,
                        "poseId": 1972891840,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000097.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2015087173,
                        "poseId": 2015087173,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000060.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2018335299,
                        "poseId": 2018335299,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000062.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2018418234,
                        "poseId": 2018418234,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000128.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2019204151,
                        "poseId": 2019204151,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000061.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2020740058,
                        "poseId": 2020740058,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000129.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2072376675,
                        "poseId": 2072376675,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000121.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2073412545,
                        "poseId": 2073412545,
                        "path": "C:/data/tankandtemples_mvsnet/intermediate/Family/images/00000120.jpg",
                        "intrinsicId": 3448933362,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
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
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "locked": false
                    }
                ],
                "sensorDatabase": "${ALICEVISION_SENSOR_DB}",
                "colorProfileDatabase": "${ALICEVISION_COLOR_PROFILE_DB}",
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
                "errorOnMissingColorProfile": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/cameraInit.sfm"
            }
        }
    }
}