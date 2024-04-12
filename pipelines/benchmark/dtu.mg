{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2024.1.0-develop",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "DepthMap": "5.0",
            "LoadDataset": "3.0",
            "FeatureExtraction": "1.3",
            "MeshFiltering": "3.0",
            "ExportXMP": "3.0",
            "ImageMatching": "2.0",
            "DepthMapTransform": "3.0",
            "ImportXMP": "3.0",
            "Meshing": "7.0",
            "CameraInit": "9.0",
            "Texturing": "6.0",
            "DepthMapFilter": "4.0",
            "PrepareDenseScene": "3.1",
            "ColmapFeatureExtraction": "1.1",
            "PoissonMesher": "2.0",
            "ColmapFeatureMatching": "2.0",
            "StereoFusion": "2.0",
            "ColmapMapper": "2.0",
            "ColmapImageUndistorder": "1.1",
            "Meshroom2ColmapSfmConvertions": "2.0",
            "StructureFromMotion": "3.3",
            "PatchMatchStereo": "2.0",
            "VizMVSNet": "0.0",
            "FeatureMatching": "2.0"
        }
    },
    "graph": {
        "ImportXMP_1": {
            "nodeType": "ImportXMP",
            "position": [
                628,
                175
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c4f64366461803d0bbcbd05a468a977469538525"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "",
                "xmpData": "",
                "meshData": "",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "ImportRealityCapture",
                "color": "#00aaff"
            },
            "outputs": {
                "outputSfMData": "{cache}/{nodeType}/{uid0}/outputSfMData.sfm"
            }
        },
        "ColmapImageUndistorder_1": {
            "nodeType": "ColmapImageUndistorder",
            "position": [
                24,
                31
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "832041ec57a30d041ab01e6a47234dbf12114bd8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "image_path": "{Meshroom2ColmapSfmConvertions_1.imageDirectory}",
                "input_path": "{Meshroom2ColmapSfmConvertions_1.sparseDirectory}",
                "max_image_size": "2000"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                -21,
                -465
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 49,
                "split": 3
            },
            "uids": {
                "0": "226d5019890256a52a4a42b5b6db5f0f736fd485"
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
                "color": "#0000FF"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "DepthMapTransform_1": {
            "nodeType": "DepthMapTransform",
            "position": [
                29,
                320
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "80908342cdc716604a6929a7815cb0cc82081b4d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{VizMVSNet_1.inputSfMData}",
                "depthMapsFolder": "{VizMVSNet_1.outputFolder}",
                "transform": "meshroom2normal",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#005500"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr"
            }
        },
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                -221,
                -465
            ],
            "parallelization": {
                "blockSize": 12,
                "size": 49,
                "split": 5
            },
            "uids": {
                "0": "aedb0809dfcba6496d478991ae599526bb58ae40"
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
                "color": "#0000FF"
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
        "ExportXMP_1": {
            "nodeType": "ExportXMP",
            "position": [
                -172,
                183
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4bc58b54fdef10202133ebd224a30f9aa2ee48a8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "targetXMP": "export_reality_capture",
                "sfmData": "{LoadDataset_1.outputSfMData}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "ExportRealityCapture",
                "color": "#00aaff"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                379,
                -465
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "8c004553dd9b45953e2598121492530159faa9f5"
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
                "color": "#0000FF"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                179,
                -465
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "279a581e09cad39bb9978b2dba1186d8a6770c88"
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
                "color": "#0000FF"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "Meshroom2ColmapSfmConvertions_1": {
            "nodeType": "Meshroom2ColmapSfmConvertions",
            "position": [
                -174,
                27
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 49,
                "split": 1
            },
            "uids": {
                "0": "e3ddab2448a3961b53ff904d707cd35572c5217e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{LoadDataset_1.outputSfMData}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#aa55ff"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "imageDirectory": "{cache}/{nodeType}/{uid0}/images",
                "sparseDirectory": "{cache}/{nodeType}/{uid0}/sparse"
            }
        },
        "PatchMatchStereo_1": {
            "nodeType": "PatchMatchStereo",
            "position": [
                216,
                27
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "89f9a35cc832112ecde75187adfe23a7b72ffbb9"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_folder": "{ColmapImageUndistorder_1.output_path}"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#aa55ff"
            },
            "outputs": {
                "workspace_path": "{cache}/{nodeType}/{uid0}/workspace"
            }
        },
        "PoissonMesher_1": {
            "nodeType": "PoissonMesher",
            "position": [
                633,
                26
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "000c8bc03b746daf607a1fdcfbd2e19f2b9c0ee1"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_path": "{StereoFusion_1.output_path}",
                "trim": 0.0
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#aa55ff"
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/mesh_poisson.ply"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                -421,
                -465
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 49,
                "split": 2
            },
            "uids": {
                "0": "9e668f08f14af9dc59aa870b84301f0ca5926d2e"
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
                "color": "#0000FF"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "undistorted": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.{outputFileTypeValue}"
            }
        },
        "StereoFusion_1": {
            "nodeType": "StereoFusion",
            "position": [
                432,
                25
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c277628e70a6d9f184e118fbc318dcbe8e794411"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_folder": "{PatchMatchStereo_1.workspace_path}"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#aa55ff"
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/workspace/fused.ply",
                "workspace_path": "{cache}/{nodeType}/{uid0}/workspace"
            }
        },
        "VizMVSNet_1": {
            "nodeType": "VizMVSNet",
            "position": [
                -175,
                318
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4375983435f5cdfe12e0fc139ce68c4dd60f387f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfMData": "{LoadDataset_1.outputSfMData}",
                "viewPairs": "",
                "minD": 0.0,
                "stepsD": 256,
                "maxD": 10.0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#005500"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "sizeParam": "",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                1403,
                -746
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "e5737e8c29941190de4fbe260fd3c3e1205074bf"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_3.output}",
                "imagesFolder": "{DepthMap_2.imagesFolder}",
                "inputMesh": "{MeshFiltering_2.outputMesh}",
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
                -197,
                -746
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 49,
                "split": 1
            },
            "uids": {
                "0": "981c4abef4d7cd9ce8dd12c86d348736ced01977"
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
                -432,
                -752
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 49,
                "split": 2
            },
            "uids": {
                "0": "02a7157aaa2a7aa4855f645a385b21cfe55295c0"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{LoadDataset_1.outputSfMData}",
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
                203,
                -746
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 49,
                "split": 1
            },
            "uids": {
                "0": "1b0c274af74b3ca9916bc4f5fc276fd47bd1f58a"
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
                3,
                -746
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 49,
                "split": 3
            },
            "uids": {
                "0": "b3f64c871ac5a9b1df88b13b157253ce4ed4d9f2"
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
        "LoadDataset_1": {
            "nodeType": "LoadDataset",
            "position": [
                -596,
                -2
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 49,
                "split": 1
            },
            "uids": {
                "0": "d1cd208caeb7b957dc40c7b1a1320ba310e9dced"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_2.output}",
                "datasetType": "DTU",
                "initSfmLandmarksVertices": 1000,
                "initMasks": false,
                "landMarksProj": true,
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
                "depthmapsDisplay": "{cache}/{nodeType}/{uid0}/depth_maps/<VIEW_ID>_depthMap.exr",
                "masksDisplay": "{cache}/{nodeType}/{uid0}/masks/<VIEW_ID>.png",
                "landMarksProjDisplay": "{cache}/{nodeType}/{uid0}/lm_projs/<VIEW_ID>.png",
                "meshDisplay": "{cache}/{nodeType}/{uid0}/mesh_display.ply"
            }
        },
        "CameraInit_2": {
            "nodeType": "CameraInit",
            "position": [
                -783,
                19
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 49,
                "split": 1
            },
            "uids": {
                "0": "1816cdbed69b125521d53cf9b624cab54448f1a5"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 40268677,
                        "poseId": 40268677,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000039.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:08:47\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 82861068,
                        "poseId": 82861068,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000043.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:58\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 106202883,
                        "poseId": 106202883,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000008.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:51\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 133279082,
                        "poseId": 133279082,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000020.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:42\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 167469321,
                        "poseId": 167469321,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000013.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:40\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 202760876,
                        "poseId": 202760876,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000004.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:15\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 237919392,
                        "poseId": 237919392,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000036.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:05\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 240372485,
                        "poseId": 240372485,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000041.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:03\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 326406810,
                        "poseId": 326406810,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000032.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:53\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 406813559,
                        "poseId": 406813559,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000031.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:08:45\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 460287128,
                        "poseId": 460287128,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000040.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:55\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 510688733,
                        "poseId": 510688733,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000011.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:20\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 535724082,
                        "poseId": 535724082,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000009.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:00\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 568565927,
                        "poseId": 568565927,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000021.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:50\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 725250703,
                        "poseId": 725250703,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000005.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:25\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 753748880,
                        "poseId": 753748880,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000006.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:36\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 797932829,
                        "poseId": 797932829,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000045.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:52\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 799896409,
                        "poseId": 799896409,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000030.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:20\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 821661429,
                        "poseId": 821661429,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000046.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:10:12\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 840397534,
                        "poseId": 840397534,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000027.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:56\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 868839994,
                        "poseId": 868839994,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000038.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:21\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 942825739,
                        "poseId": 942825739,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000025.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:38\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 961825639,
                        "poseId": 961825639,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000012.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:31\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 974163012,
                        "poseId": 974163012,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000023.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:06\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1021561672,
                        "poseId": 1021561672,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000044.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:05\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1030018405,
                        "poseId": 1030018405,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000033.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:02\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1105533006,
                        "poseId": 1105533006,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000003.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:05\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1178362468,
                        "poseId": 1178362468,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000048.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:10:11\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1216057868,
                        "poseId": 1216057868,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000019.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:33\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1342695163,
                        "poseId": 1342695163,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000026.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:47\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1379361672,
                        "poseId": 1379361672,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000024.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:13\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1399342047,
                        "poseId": 1399342047,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000029.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:13\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1411519242,
                        "poseId": 1411519242,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000028.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:04\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1495908591,
                        "poseId": 1495908591,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000007.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:45\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1502746159,
                        "poseId": 1502746159,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000047.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:10:48\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1504154005,
                        "poseId": 1504154005,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000016.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:07\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1615829873,
                        "poseId": 1615829873,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000017.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:16\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1626246017,
                        "poseId": 1626246017,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000018.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:05:26\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1704264264,
                        "poseId": 1704264264,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000002.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:56\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1722464903,
                        "poseId": 1722464903,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000014.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:50\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1728608483,
                        "poseId": 1728608483,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000000.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:36\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1730979906,
                        "poseId": 1730979906,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000034.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:09\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1735254857,
                        "poseId": 1735254857,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000035.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:58\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1886537543,
                        "poseId": 1886537543,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000042.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:53\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1959411163,
                        "poseId": 1959411163,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000037.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:08:14\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1994742676,
                        "poseId": 1994742676,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000010.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:05:10\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2014009122,
                        "poseId": 2014009122,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000022.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:57\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2098197410,
                        "poseId": 2098197410,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000015.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:59\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2144867824,
                        "poseId": 2144867824,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image/000001.png",
                        "intrinsicId": 3277137958,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:05:46\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 3277137958,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 1600,
                        "height": 1200,
                        "sensorWidth": 36.0,
                        "sensorHeight": 24.0,
                        "serialNumber": "/s/prods/mvg/_source_global/users/hogm/datasets/dtu/scan24/image",
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
        "ColmapFeatureExtraction_2": {
            "nodeType": "ColmapFeatureExtraction",
            "position": [
                -435,
                -191
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "64af00bc96aab53b2607c9293f725bbabfb5c858"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_sfm": "{LoadDataset_1.outputSfMData}",
                "use_gpu": false,
                "singleCam": true
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "database_path": "{cache}/{nodeType}/{uid0}/colmap_database.db",
                "image_list_path": "{cache}/{nodeType}/{uid0}/used_images.txt",
                "image_path": "{cache}/{nodeType}/{uid0}/images"
            }
        },
        "ColmapFeatureMatching_2": {
            "nodeType": "ColmapFeatureMatching",
            "position": [
                -193,
                -194
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "e995c172f9e0e1261d77803fcb3d3800b2677666"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_database_path": "{ColmapFeatureExtraction_2.database_path}",
                "use_gpu": false
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "database_path": "{cache}/{nodeType}/{uid0}/colmap_database_matches.db"
            }
        },
        "ColmapImageUndistorder_2": {
            "nodeType": "ColmapImageUndistorder",
            "position": [
                224,
                -193
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0dfa05c16db5c076dbbefd8fc493abffec065538"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "image_path": "{ColmapMapper_2.image_path}",
                "input_path": "{ColmapMapper_2.output_path0}",
                "max_image_size": "2000"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "ColmapMapper_2": {
            "nodeType": "ColmapMapper",
            "position": [
                14,
                -203
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0d3b0decd9e28410f11ddee69e9044dc5b7f4141"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_database_path": "{ColmapFeatureMatching_2.database_path}",
                "image_path": "{ColmapFeatureExtraction_2.image_path}"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/",
                "output_path0": "{cache}/{nodeType}/{uid0}/0",
                "database_path": "{cache}/{nodeType}/{uid0}/colmap_database_mapper.db"
            }
        },
        "DepthMapFilter_2": {
            "nodeType": "DepthMapFilter",
            "position": [
                240,
                315
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "323c1580ec27dc3ab2746c521f2b043380fdecad"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapTransform_1.inputSfM}",
                "depthMapsFolder": "{DepthMapTransform_1.output}",
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
                "color": "#005500"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "Meshing_2": {
            "nodeType": "Meshing",
            "position": [
                433,
                318
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5e7688ff67d821311b68bedbb6c129e7eeb65966"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_2.input}",
                "depthMapsFolder": "{DepthMapFilter_2.output}",
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
                "color": "#005500"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "PatchMatchStereo_2": {
            "nodeType": "PatchMatchStereo",
            "position": [
                431,
                -193
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f2e4952f78c8575a0e19c038dc2fc1210d5f4fb2"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_folder": "{ColmapImageUndistorder_2.output_path}"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "workspace_path": "{cache}/{nodeType}/{uid0}/workspace"
            }
        },
        "PoissonMesher_2": {
            "nodeType": "PoissonMesher",
            "position": [
                848,
                -194
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "fd10bc8ecc4f7c0a7f382998eef2dcd4983d23d7"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_path": "{StereoFusion_2.output_path}",
                "trim": 0.0
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
        "StereoFusion_2": {
            "nodeType": "StereoFusion",
            "position": [
                647,
                -195
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "28521660c20f24e5b52580b499ddf5dabec4b8a2"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input_folder": "{PatchMatchStereo_2.workspace_path}"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output_path": "{cache}/{nodeType}/{uid0}/workspace/fused.ply",
                "workspace_path": "{cache}/{nodeType}/{uid0}/workspace"
            }
        },
        "PrepareDenseScene_2": {
            "nodeType": "PrepareDenseScene",
            "position": [
                403,
                -746
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 49,
                "split": 2
            },
            "uids": {
                "0": "28d2626535bbbbce21f7c5737fe30eab3caa8d59"
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
        "DepthMap_2": {
            "nodeType": "DepthMap",
            "position": [
                603,
                -746
            ],
            "parallelization": {
                "blockSize": 12,
                "size": 49,
                "split": 5
            },
            "uids": {
                "0": "716635876f62b504c07ae960048342497720db65"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_2.input}",
                "imagesFolder": "{PrepareDenseScene_2.output}",
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
        "MeshFiltering_2": {
            "nodeType": "MeshFiltering",
            "position": [
                1203,
                -746
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0ec53b0ab13afbb5cb90d306320de51361133b5d"
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
        "Meshing_3": {
            "nodeType": "Meshing",
            "position": [
                1003,
                -746
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "8f613ad6cea0e0396bb68ff05ee21fec5ff92881"
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
        "DepthMapFilter_3": {
            "nodeType": "DepthMapFilter",
            "position": [
                803,
                -746
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 49,
                "split": 3
            },
            "uids": {
                "0": "46c546d1ed2ae8550308bce10f78c50ebeb3a3aa"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_2.input}",
                "depthMapsFolder": "{DepthMap_2.output}",
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
        }
    }
}