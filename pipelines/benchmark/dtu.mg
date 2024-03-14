{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2024.1.0-develop",
        "fileVersion": "1.1",
        "nodesVersions": {
            "DepthMap": "5.0",
            "ColmapMapper": "2.0",
            "DepthMapTransform": "3.0",
            "CameraInit": "9.0",
            "PoissonMesher": "2.0",
            "StereoFusion": "2.0",
            "DepthMapFilter": "4.0",
            "Meshing": "7.0",
            "MeshFiltering": "3.0",
            "ImportXMP": "3.0",
            "Meshroom2ColmapSfmConvertions": "2.0",
            "VizMVSNet": "0.0",
            "LoadDataset": "3.0",
            "ColmapFeatureExtraction": "1.1",
            "ColmapFeatureMatching": "2.0",
            "ExportXMP": "3.0",
            "ColmapImageUndistorder": "1.1",
            "PatchMatchStereo": "2.0",
            "PrepareDenseScene": "3.1"
        },
        "template": false
    },
    "graph": {
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                615,
                -337
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "04c01ea56683c211b55df891e84d52e468103bc2"
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
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                415,
                -337
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 49,
                "split": 3
            },
            "uids": {
                "0": "980dfb94e2251f853546b2c17557e42ab10428c4"
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
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                15,
                -337
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 49,
                "split": 2
            },
            "uids": {
                "0": "f118e65840a6e480ac06ba0b766fece0597cef7b"
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
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                215,
                -337
            ],
            "parallelization": {
                "blockSize": 12,
                "size": 49,
                "split": 5
            },
            "uids": {
                "0": "96a7ec2f99cb5d308da1a3ea4eb10f1a17b7aee8"
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
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                815,
                -337
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "1c841430b118e1384a63d2ce1e6fe7be26ddb25d"
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
        "LoadDataset_1": {
            "nodeType": "LoadDataset",
            "position": [
                -596,
                2
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 49,
                "split": 1
            },
            "uids": {
                "0": "9d6ac66a0544122f60e7fbf6401a75808800fc8f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_2.output}",
                "datasetType": "DTU",
                "initSfmLandmarks": 0.0001,
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
        "VizMVSNet_1": {
            "nodeType": "VizMVSNet",
            "position": [
                27,
                337
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "17d4f4f629817373383101b698759a555ded89cd"
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
        "DepthMapTransform_1": {
            "nodeType": "DepthMapTransform",
            "position": [
                231,
                339
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f205560b39444111278686ffe53a793d1a10585d"
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
                "0": "0310317e9e3145995325df8ef13f5dc46269af9f"
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
                "0": "4a1216629c0ad69894953d299eb179f00b15fc87"
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
                "0": "2906f634efce93f7aa64dcd30c67ea33d8f1ade4"
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
        "ImportXMP_1": {
            "nodeType": "ImportXMP",
            "position": [
                624,
                186
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9e0c7818e6af8046a49b3878677a24219a485c9b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "",
                "xmpData": "",
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
        "ExportXMP_1": {
            "nodeType": "ExportXMP",
            "position": [
                -168,
                181
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4e3d165ff040ca06056bfe936847f7f435bd09a7"
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
                "0": "36ca3c535338bb38f4f405900b2a22d93c54f7cc"
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
                "0": "af8158dab714fab1c193bea9f6075efdcf33c21a"
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
        "Meshing_2": {
            "nodeType": "Meshing",
            "position": [
                635,
                337
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "e9e8f99bde9a3d65e133291d429ce2466cf8f6d8"
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
        "ColmapFeatureExtraction_2": {
            "nodeType": "ColmapFeatureExtraction",
            "position": [
                702,
                -129
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "7d2e7a37e7cd1427b5d1ac61de92e0f601137950"
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
                944,
                -132
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "e1fcb5340158fc31991e309bceab1f389ef02c98"
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
                1361,
                -131
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "23afaffecbc031ddc27a95f1231b784b87f67b4a"
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
                1151,
                -141
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c6961002604c99925c6f1004e6e8b14ad0f4d647"
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
        "PatchMatchStereo_2": {
            "nodeType": "PatchMatchStereo",
            "position": [
                1568,
                -131
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5be91ec8bc4b400307b0012930729a8756aa7774"
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
                1985,
                -132
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4a7ddea5d36fb50be700bdc5b8747953482541bd"
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
                1784,
                -133
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "208273cd0e0f9540fa8c44c9aae118c9af46dbaa"
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
        "DepthMapFilter_2": {
            "nodeType": "DepthMapFilter",
            "position": [
                442,
                334
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "2bf54993bb03ab465f32bde4e99925a2c925b75f"
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
        }
    }
}