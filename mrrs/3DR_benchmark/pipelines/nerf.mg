{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2024.1.0-develop",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "StructureFromMotion": "3.3",
            "PrepareDenseScene": "3.1",
            "MeshFiltering": "3.0",
            "RenderMesh": "1.1",
            "CameraInit": "9.0",
            "ConvertSfMFormat": "2.0",
            "FeatureMatching": "2.0",
            "MeshTransform": "3.0",
            "DepthMap": "5.0",
            "LoadDataset": "3.0",
            "CleanMesh": "1.0",
            "Texturing": "6.0",
            "DepthMapFilter": "4.0",
            "Meshing": "7.0",
            "SfMAlignment": "2.0",
            "ImageMatching": "2.0",
            "CalibrationComparison": "3.0",
            "FeatureExtraction": "1.3"
        }
    },
    "graph": {
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                859,
                213
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "14e93b5aeb064ea754f77fccdb46020046ce8b4d"
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
                "correctEV": true,
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
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                -300,
                -143
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 100,
                "split": 1
            },
            "uids": {
                "0": "8dbfe62714e3ecc1d1f5e571a7304361e6730683"
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
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                -500,
                -143
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 100,
                "split": 3
            },
            "uids": {
                "0": "4a305da21dc9849dc0e1f333b99e7fe9b1e05ed3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_2.output}",
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
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                100,
                -143
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 100,
                "split": 1
            },
            "uids": {
                "0": "3d7919df32b7e7965b10e3b6b4779c4e121512ce"
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
                "useAutoTransform": true,
                "initialPairA": "",
                "initialPairB": "",
                "interFileExtension": ".abc",
                "logIntermediateSteps": false,
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
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                -100,
                -143
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 100,
                "split": 5
            },
            "uids": {
                "0": "03d427170562828f1ba7feef71317ce4c1df1008"
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
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                659,
                213
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0b47f865893d4c6d81ef9a5a060b6e87c59da8f9"
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
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                59,
                213
            ],
            "parallelization": {
                "blockSize": 12,
                "size": 100,
                "split": 9
            },
            "uids": {
                "0": "6db7e665a4e0d7b128c584a203501c4629cd1ced"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_1.input}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
                "downscale": 1,
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
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                -141,
                213
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 100,
                "split": 3
            },
            "uids": {
                "0": "d974b14b4d5d3cdf0f0f7bbdd45167e9cc068287"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{LoadDataset_1.outputSfMData}",
                "imagesFolders": [],
                "masksFolders": [
                    "{LoadDataset_1.maskFolder}"
                ],
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
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                259,
                213
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 100,
                "split": 5
            },
            "uids": {
                "0": "a41dc4928d0ce50de4895926d4c1947b4ba8bfc7"
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
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                459,
                213
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "eb032a3ee5fd1ab09a55c915f14808e896f06eb0"
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
                "minVis": 2,
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
        "CalibrationComparison_1": {
            "nodeType": "CalibrationComparison",
            "position": [
                660,
                -113
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0b86fdd12904a6c88571414c7f3db05f544ea929"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ConvertSfMFormat_1.output}",
                "inputSfMGT": "{LoadDataset_1.outputSfMData}",
                "metrics": [
                    "MSECameraCenter",
                    "AngleBetweenRotations",
                    "MSEFocal",
                    "MSEPrincipalPoint",
                    "validCams"
                ],
                "csv_name": "calibration_comparison.csv",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "outputCsv": "{cache}/{nodeType}/{uid0}/calibration_comparison.csv"
            }
        },
        "ConvertSfMFormat_1": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                490,
                -95
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 100,
                "split": 1
            },
            "uids": {
                "0": "c4792907ba64490a4c43a8d4ab018825f5848d78"
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
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.{fileExtValue}"
            }
        },
        "SfMAlignment_1": {
            "nodeType": "SfMAlignment",
            "position": [
                303,
                -126
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 100,
                "split": 1
            },
            "uids": {
                "0": "9315e085bc60f1d77a771e93795788a651d31850"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "reference": "{LoadDataset_1.outputSfMData}",
                "method": "from_cameras_viewid",
                "fileMatchingPattern": ".*\\/(.*?)\\.\\w{3}",
                "metadataMatchingList": [],
                "applyScale": true,
                "applyRotation": true,
                "applyTranslation": true,
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
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm"
            }
        },
        "LoadDataset_1": {
            "nodeType": "LoadDataset",
            "position": [
                -507,
                202
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 100,
                "split": 1
            },
            "uids": {
                "0": "58ba77a788af7a49c560b6950f5737e5f9d6fed4"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_2.output}",
                "datasetType": "NERF",
                "initSfmLandmarks": 0.01,
                "initMasks": true,
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
                "depthmaps": "{cache}/{nodeType}/{uid0}/depth_maps/<VIEW_ID>_depthMap.exr",
                "masks": "{cache}/{nodeType}/{uid0}/masks/<VIEW_ID>.png"
            }
        },
        "RenderMesh_1": {
            "nodeType": "RenderMesh",
            "position": [
                535,
                20
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "980ce0e9853ae15ec15cd11c1949073471c95d43"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "script": "/s/apps/users/multiview/mrrs/develop/MeshroomResearch/mrrs/blender/render_mesh.py",
                "model": "{LoadDataset_1.mesh}",
                "cameras": "{LoadDataset_1.outputSfMData}",
                "renderMode": "FACES"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "overlay": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.exr"
            }
        },
        "MeshTransform_1": {
            "nodeType": "MeshTransform",
            "position": [
                889,
                -87
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "b229a7961bf9aea9467574c9a25eac14135ad9aa"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{cache}/{nodeType}/{uid0}/",
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
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.ply"
            }
        },
        "CameraInit_2": {
            "nodeType": "CameraInit",
            "position": [
                -767,
                71
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 100,
                "split": 1
            },
            "uids": {
                "0": "a7aa00ef20d4cbd138795fcb858e2b5aaa8072fe"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 29525583,
                        "poseId": 29525583,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_88.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:16\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.57\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.85\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.46\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 44650971,
                        "poseId": 44650971,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_77.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:13\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.90\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.21\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.78\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 59716768,
                        "poseId": 59716768,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_6.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:34\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.42\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.61\", \"samples\": \"250\", \"synchronization_time\": \"00:00.64\", \"total_time\": \"00:02.25\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 83600848,
                        "poseId": 83600848,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_87.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:10\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.13\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.49\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.06\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 148713231,
                        "poseId": 148713231,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_26.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:25\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.80\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.04\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.64\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 155834555,
                        "poseId": 155834555,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_84.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:53\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.04\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.44\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.02\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 166733216,
                        "poseId": 166733216,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_58.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:25\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.91\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.18\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.78\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 170344808,
                        "poseId": 170344808,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_52.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:50\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.82\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.15\", \"samples\": \"250\", \"synchronization_time\": \"00:00.64\", \"total_time\": \"00:02.80\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 184287700,
                        "poseId": 184287700,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_24.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:14\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.53\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.98\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.53\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 217098080,
                        "poseId": 217098080,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_31.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:52\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.77\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.09\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.67\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 229981605,
                        "poseId": 229981605,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_4.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:22\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.86\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.28\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.84\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 232285202,
                        "poseId": 232285202,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_55.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:07\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.78\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.02\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.61\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 236137586,
                        "poseId": 236137586,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_56.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:13\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.62\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.00\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.58\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 255856107,
                        "poseId": 255856107,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_93.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:44\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.52\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.71\", \"samples\": \"250\", \"synchronization_time\": \"00:00.65\", \"total_time\": \"00:02.37\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 268243611,
                        "poseId": 268243611,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_0.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:00\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.30\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.51\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.12\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 271739747,
                        "poseId": 271739747,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_49.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:33\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.39\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.63\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.22\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 309050507,
                        "poseId": 309050507,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_67.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:18\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.83\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.12\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.67\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 312326484,
                        "poseId": 312326484,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_32.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:58\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.62\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.99\", \"samples\": \"250\", \"synchronization_time\": \"00:00.53\", \"total_time\": \"00:02.52\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 354151609,
                        "poseId": 354151609,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_70.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:34\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.53\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.78\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.38\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 369220793,
                        "poseId": 369220793,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_39.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:37\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.94\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.25\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.85\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 392746406,
                        "poseId": 392746406,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_69.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:28\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.13\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.58\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.16\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 412479310,
                        "poseId": 412479310,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_5.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:28\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.64\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.02\", \"samples\": \"250\", \"synchronization_time\": \"00:00.54\", \"total_time\": \"00:02.57\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 417687627,
                        "poseId": 417687627,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_80.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:31\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.90\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.06\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.68\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 463154018,
                        "poseId": 463154018,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_98.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:55:12\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.32\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.56\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.13\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 464867596,
                        "poseId": 464867596,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_14.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:17\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.65\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.17\", \"samples\": \"250\", \"synchronization_time\": \"00:00.53\", \"total_time\": \"00:02.70\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 468864525,
                        "poseId": 468864525,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_16.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:29\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.34\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.76\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.35\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 500385635,
                        "poseId": 500385635,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_96.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:55:01\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.33\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.71\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.28\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 504463112,
                        "poseId": 504463112,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_27.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:30\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.12\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.53\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.09\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 507503288,
                        "poseId": 507503288,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_36.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:20\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.66\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.92\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.50\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 509696791,
                        "poseId": 509696791,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_86.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:05\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.16\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.58\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.20\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 512913312,
                        "poseId": 512913312,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_22.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:02\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.77\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.13\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.69\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 548382731,
                        "poseId": 548382731,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_45.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:11\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.47\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.89\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.47\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 597351702,
                        "poseId": 597351702,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_62.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:48\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.96\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.22\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.80\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 664367228,
                        "poseId": 664367228,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_35.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:14\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.33\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.72\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.29\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 724510090,
                        "poseId": 724510090,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_50.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:39\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.31\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.73\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.33\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 765846622,
                        "poseId": 765846622,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_41.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:49\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:06.07\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.34\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.91\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 803556901,
                        "poseId": 803556901,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_18.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:40\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.55\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.84\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.42\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 843297761,
                        "poseId": 843297761,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_97.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:55:06\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.58\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.98\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.55\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 845837798,
                        "poseId": 845837798,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_20.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:51\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.27\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.59\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.17\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 877861644,
                        "poseId": 877861644,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_83.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:48\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.84\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.14\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.76\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 881307387,
                        "poseId": 881307387,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_73.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:50\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.25\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.60\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.21\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899402202,
                        "poseId": 899402202,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_33.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:03\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.17\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.49\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.06\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 899543189,
                        "poseId": 899543189,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_25.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:19\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.53\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.91\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.47\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 989294840,
                        "poseId": 989294840,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_72.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:45\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.44\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.72\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.29\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1022775952,
                        "poseId": 1022775952,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_94.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:50\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.66\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.15\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.70\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1056131709,
                        "poseId": 1056131709,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_7.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:39\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.02\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.44\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.02\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1072521684,
                        "poseId": 1072521684,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_21.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:56\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.22\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.62\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.18\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1113552510,
                        "poseId": 1113552510,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_59.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:30\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.39\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.63\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.23\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1132632338,
                        "poseId": 1132632338,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_90.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:27\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.42\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.68\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.27\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1186897796,
                        "poseId": 1186897796,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_44.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:05\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.44\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.69\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.28\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1229204332,
                        "poseId": 1229204332,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_38.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:31\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.49\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.97\", \"samples\": \"250\", \"synchronization_time\": \"00:00.52\", \"total_time\": \"00:02.50\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1234513372,
                        "poseId": 1234513372,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_63.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:54\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.91\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.29\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.91\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1254072146,
                        "poseId": 1254072146,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_64.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:00\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.70\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.04\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.63\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1255418108,
                        "poseId": 1255418108,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_42.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:54\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.24\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.62\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.23\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1262925752,
                        "poseId": 1262925752,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_3.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:16\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.35\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.67\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.29\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1302903548,
                        "poseId": 1302903548,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_10.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:55\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.22\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.63\", \"samples\": \"250\", \"synchronization_time\": \"00:00.52\", \"total_time\": \"00:02.16\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1303661554,
                        "poseId": 1303661554,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_74.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:55\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.27\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.69\", \"samples\": \"250\", \"synchronization_time\": \"00:00.54\", \"total_time\": \"00:02.24\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1315236057,
                        "poseId": 1315236057,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_91.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:32\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.35\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.65\", \"samples\": \"250\", \"synchronization_time\": \"00:00.67\", \"total_time\": \"00:02.32\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1344704285,
                        "poseId": 1344704285,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_66.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:12\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.87\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.25\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.82\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1349980377,
                        "poseId": 1349980377,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_60.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:36\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.49\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.66\", \"samples\": \"250\", \"synchronization_time\": \"00:00.60\", \"total_time\": \"00:02.26\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1385546049,
                        "poseId": 1385546049,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_12.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:06\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.27\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.66\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.22\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1393073167,
                        "poseId": 1393073167,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_47.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:22\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.94\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.21\", \"samples\": \"250\", \"synchronization_time\": \"00:00.65\", \"total_time\": \"00:02.87\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1433375178,
                        "poseId": 1433375178,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_48.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:28\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.27\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.75\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.31\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1437538558,
                        "poseId": 1437538558,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_79.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:25\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.31\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.77\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.34\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1459372698,
                        "poseId": 1459372698,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_34.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:09\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.38\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.71\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.32\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1463812784,
                        "poseId": 1463812784,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_61.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:42\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.80\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.33\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.90\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1484465217,
                        "poseId": 1484465217,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_51.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:44\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.28\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.59\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.18\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1487217910,
                        "poseId": 1487217910,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_43.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:00\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.62\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.03\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.60\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1523640924,
                        "poseId": 1523640924,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_37.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:26\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.20\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.62\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.22\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1567148838,
                        "poseId": 1567148838,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_71.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:39\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.06\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.59\", \"samples\": \"250\", \"synchronization_time\": \"00:00.54\", \"total_time\": \"00:02.14\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1575090271,
                        "poseId": 1575090271,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_8.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:45\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.84\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.13\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.75\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1593184547,
                        "poseId": 1593184547,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_75.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:02\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.91\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.23\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.85\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1603348171,
                        "poseId": 1603348171,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_95.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:55\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.54\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.74\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.32\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1626687851,
                        "poseId": 1626687851,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_82.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:42\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:06.00\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.29\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.85\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1673604435,
                        "poseId": 1673604435,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_54.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:01\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.58\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.74\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.30\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1706507561,
                        "poseId": 1706507561,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_53.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:55\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.22\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.69\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.24\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1713784441,
                        "poseId": 1713784441,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_78.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:19\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.90\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.32\", \"samples\": \"250\", \"synchronization_time\": \"00:00.62\", \"total_time\": \"00:02.94\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1728758360,
                        "poseId": 1728758360,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_46.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:50:16\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.28\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.62\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.19\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1734570414,
                        "poseId": 1734570414,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_23.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:08\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.44\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.69\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.31\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1735002374,
                        "poseId": 1735002374,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_11.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:01\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.25\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.65\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.24\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1794704382,
                        "poseId": 1794704382,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_99.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:55:18\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.85\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.29\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.86\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1810420525,
                        "poseId": 1810420525,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_13.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:12\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.30\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.62\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.21\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1832994406,
                        "poseId": 1832994406,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_85.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:00\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:06.20\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.32\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.91\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1836363084,
                        "poseId": 1836363084,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_29.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:41\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.25\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.56\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.15\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1845223949,
                        "poseId": 1845223949,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_40.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:49:43\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.25\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.69\", \"samples\": \"250\", \"synchronization_time\": \"00:00.53\", \"total_time\": \"00:02.23\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1865071271,
                        "poseId": 1865071271,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_81.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:36\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.27\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.66\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.23\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1914118910,
                        "poseId": 1914118910,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_65.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:06\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.99\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.14\", \"samples\": \"250\", \"synchronization_time\": \"00:00.62\", \"total_time\": \"00:02.76\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1922779548,
                        "poseId": 1922779548,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_89.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:21\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.23\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.66\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.23\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1927554962,
                        "poseId": 1927554962,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_9.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:50\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.26\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.72\", \"samples\": \"250\", \"synchronization_time\": \"00:00.54\", \"total_time\": \"00:02.27\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1960839074,
                        "poseId": 1960839074,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_1.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:05\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.61\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.13\", \"samples\": \"250\", \"synchronization_time\": \"00:00.54\", \"total_time\": \"00:02.67\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1970319970,
                        "poseId": 1970319970,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_15.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:23\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.64\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.93\", \"samples\": \"250\", \"synchronization_time\": \"00:00.61\", \"total_time\": \"00:02.55\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2015010595,
                        "poseId": 2015010595,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_30.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:47\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.10\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.55\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.13\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2080346920,
                        "poseId": 2080346920,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_68.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:52:23\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.13\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.45\", \"samples\": \"250\", \"synchronization_time\": \"00:00.59\", \"total_time\": \"00:02.04\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2091264532,
                        "poseId": 2091264532,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_57.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:51:19\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:06.01\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.04\", \"samples\": \"250\", \"synchronization_time\": \"00:00.62\", \"total_time\": \"00:02.66\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2099419387,
                        "poseId": 2099419387,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_92.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:54:38\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.68\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.97\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.55\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2105769544,
                        "poseId": 2105769544,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_19.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:46\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.73\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.13\", \"samples\": \"250\", \"synchronization_time\": \"00:00.56\", \"total_time\": \"00:02.70\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2113001746,
                        "poseId": 2113001746,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_2.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:46:11\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.48\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.72\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.29\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2119605814,
                        "poseId": 2119605814,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_17.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:47:34\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.30\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.69\", \"samples\": \"250\", \"synchronization_time\": \"00:00.58\", \"total_time\": \"00:02.28\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2121335424,
                        "poseId": 2121335424,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_76.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:53:07\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.56\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:02.03\", \"samples\": \"250\", \"synchronization_time\": \"00:00.55\", \"total_time\": \"00:02.59\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2134138552,
                        "poseId": 2134138552,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train/r_28.png",
                        "intrinsicId": 2884507107,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"Camera\": \"Camera\", \"Date\": \"2020/02/21 09:48:36\", \"File\": \"/projects/inverse_rendering/matt/blender/chair/1D_Antique Chairs set.blend\", \"Frame\": \"102\", \"RenderTime\": \"00:05.45\", \"ResolutionUnit\": \"inch\", \"Scene\": \"Scene\", \"Time\": \"00:00:04:06\", \"XResolution\": \"72.009\", \"YResolution\": \"72.009\", \"cycles\": {\"RenderLayer\": {\"render_time\": \"00:01.71\", \"samples\": \"250\", \"synchronization_time\": \"00:00.57\", \"total_time\": \"00:02.28\"}}, \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 2884507107,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 800,
                        "height": 800,
                        "sensorWidth": 36.0,
                        "sensorHeight": 24.0,
                        "serialNumber": "/s/prods/mvg/_source_global/users/hogm/datasets/nerf_synthetic/nerf_synthetic/chair/train",
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
                    "pinhole"
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
        "CleanMesh_1": {
            "nodeType": "CleanMesh",
            "position": [
                886,
                94
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "85d2d64536036519ecd2b9b3aa0a18d259729171"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_mesh": "{LoadDataset_1.mesh}",
                "face_index_images_folder": "{RenderMesh_1.output}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output_mesh": "{cache}/{nodeType}/{uid0}/cleaned_mesh.ply"
            }
        }
    }
}