{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2023.3.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "NeRFStudio": "0.0",
            "ExportXMP": "3.0",
            "MeshFiltering": "3.0",
            "ColmapFeatureExtraction": "1.1",
            "CameraInit": "9.0",
            "DepthMap": "5.0",
            "NeRFStudioExport": "0.0",
            "PoissonMesher": "2.0",
            "ColmapFeatureMatching": "2.0",
            "StereoFusion": "2.0",
            "ColmapMapper": "2.0",
            "ColmapImageUndistorder": "1.1",
            "ImportXMP": "3.0",
            "Meshroom2ColmapSfmConvertions": "2.0",
            "PatchMatchStereo": "2.0",
            "DepthMapTransform": "3.0",
            "VizMVSNet": "0.0",
            "DepthMapFilter": "4.0",
            "Meshing": "7.0",
            "PrepareDenseScene": "3.1",
            "LoadDataset": "3.0"
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
                "0": "d838cb345ce0d27ba1d57c51b4709b85c8953d48"
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
                "0": "0778d88e29c9565b53963fe9dedc41b88228fc6a"
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
                "0": "eabc7a50d11ab947cdb01b964f77cb512c4740e8"
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
                "0": "bc84f7165ca551a0796d1d1c2544761e6894f6e8"
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
                "0": "b8dddc8ec66fd9143866943732cc1bc952501cb3"
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
                "0": "39b60c0fd3d6f5052fb6fb68b2bcdb510b60f644"
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
                "0": "5d541feee74a122d6d2eac6bf96f1440550dc06e"
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
                "0": "1980188d7ffbad5761019932c877d2d37f468680"
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
                "0": "2ae28643d31059b4c9181883c7a25d7845c8eb57"
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
                "0": "f3bb87deef845dd57c3beb2592f8bff05263df78"
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
                "0": "09379c6b85cd8b411015592c7cbb08f19f01b5f8"
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
                "0": "f06b4f3789526b7a20ccdd4841b2032cdfb20969"
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
                "0": "ec9eca47a4c6e46a2889d548544dba1ec4b4b497"
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
                "0": "5b0c8cbd766f2305eb2f9d9afc0301a623c29bd8"
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
                "depthmapsDisplay": "{cache}/{nodeType}/{uid0}/depth_maps/<VIEW_ID>_depthMap.exr",
                "masksDisplay": "{cache}/{nodeType}/{uid0}/masks/<VIEW_ID>.png",
                "meshDisplay": "{cache}/{nodeType}/{uid0}/mesh_gt.abc"
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
        "NeRFStudio_1": {
            "nodeType": "NeRFStudio",
            "position": [
                -165,
                498
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "44ad0b0d6f440616215c85c7f2836f583877b2a9"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfMData": "{LoadDataset_1.outputSfMData}",
                "method": "nerfacto",
                "max-num-iterations": 100,
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
        "NeRFStudioExport_1": {
            "nodeType": "NeRFStudioExport",
            "position": [
                89,
                513
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "e819da3cd1cdcff87935d54acf41c7de5b4576f6"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{NeRFStudio_1.output}",
                "method": "poisson",
                "numPoints": 1000000,
                "removeOutliers": true,
                "reorientNormals": true,
                "normalMethod": "open3d",
                "downscaleFactor": 1,
                "resolution": 256,
                "isosurface-threshold": 0.0,
                "simplify-mesh": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output-dir": "{cache}/{nodeType}/{uid0}/"
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
                "0": "fd71a48635ec6834f96496febf3203773e9a0a95"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 45085819,
                        "poseId": 45085819,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000021.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:50\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 70326946,
                        "poseId": 70326946,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000044.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:05\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 150999255,
                        "poseId": 150999255,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000018.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:05:26\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 151152014,
                        "poseId": 151152014,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000036.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:05\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 179666763,
                        "poseId": 179666763,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000047.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:10:48\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 183938442,
                        "poseId": 183938442,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000031.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:08:45\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 248805568,
                        "poseId": 248805568,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000042.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:53\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 257334569,
                        "poseId": 257334569,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000023.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:06\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 300491415,
                        "poseId": 300491415,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000034.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:09\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 330431205,
                        "poseId": 330431205,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000025.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:38\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 359262726,
                        "poseId": 359262726,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000033.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:02\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 476304856,
                        "poseId": 476304856,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000043.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:58\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 515107190,
                        "poseId": 515107190,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000006.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:36\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 554309828,
                        "poseId": 554309828,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000045.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:52\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 694746052,
                        "poseId": 694746052,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000000.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:36\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 750765413,
                        "poseId": 750765413,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000032.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:53\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 781436137,
                        "poseId": 781436137,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000048.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:10:11\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 801786271,
                        "poseId": 801786271,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000012.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:31\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 856832600,
                        "poseId": 856832600,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000026.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:47\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 880452698,
                        "poseId": 880452698,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000009.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:00\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 938859404,
                        "poseId": 938859404,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000019.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:33\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 954966145,
                        "poseId": 954966145,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000024.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:13\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1037647549,
                        "poseId": 1037647549,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000027.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:56\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1057517035,
                        "poseId": 1057517035,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000002.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:56\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1101558153,
                        "poseId": 1101558153,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000040.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:55\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1130795884,
                        "poseId": 1130795884,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000016.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:07\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1230640010,
                        "poseId": 1230640010,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000015.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:59\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1241484141,
                        "poseId": 1241484141,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000005.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:25\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1247128944,
                        "poseId": 1247128944,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000001.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:05:46\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1275354233,
                        "poseId": 1275354233,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000010.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:05:10\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1299758411,
                        "poseId": 1299758411,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000041.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:03\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1387973256,
                        "poseId": 1387973256,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000037.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:08:14\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1423509114,
                        "poseId": 1423509114,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000022.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:57\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1471149744,
                        "poseId": 1471149744,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000030.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:20\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1542061841,
                        "poseId": 1542061841,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000014.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:50\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1582488192,
                        "poseId": 1582488192,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000020.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:42\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1632949724,
                        "poseId": 1632949724,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000013.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:40\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1642935163,
                        "poseId": 1642935163,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000028.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:02:04\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1666575656,
                        "poseId": 1666575656,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000017.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:16\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1677434882,
                        "poseId": 1677434882,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000004.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:03:15\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1692011131,
                        "poseId": 1692011131,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000011.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:20\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1705752229,
                        "poseId": 1705752229,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000039.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:08:47\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1920461391,
                        "poseId": 1920461391,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000003.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:04:05\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1920896094,
                        "poseId": 1920896094,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000046.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:10:12\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2001397352,
                        "poseId": 2001397352,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000008.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:06:51\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2027709952,
                        "poseId": 2027709952,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000007.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:00:45\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2062994802,
                        "poseId": 2062994802,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000038.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:07:21\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2072347487,
                        "poseId": 2072347487,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000035.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:09:58\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2073549621,
                        "poseId": 2073549621,
                        "path": "/home/bbrument/Datasets/DTU_main/scan24/image/000029.png",
                        "intrinsicId": 2627282641,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"DateTime\": \"2014:05:13 23:01:13\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 2627282641,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 1600,
                        "height": 1200,
                        "sensorWidth": 36.0,
                        "sensorHeight": 24.0,
                        "serialNumber": "/home/bbrument/Datasets/DTU_main/scan24/image",
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
                "0": "2d8447f572f1cea773eb0a15bf941d654b67206e"
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
                "0": "97e238d47078ec6d206cc4357020ba80233ae23c"
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
                "0": "d85b53d1d84f1511db4275bcebf9df115147e9e2"
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
                "0": "eb8560e041ed33a55d954f054b4a966818ea18b1"
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
                "0": "09c247644009d4baf6440842845c5f7c9f1ac9e1"
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
                "0": "71937f5bf3f136b25d7b7c55fdeca149b4a46d78"
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
                "0": "e12481ad3989ceefdf95849c794573d04d80cb83"
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
                "0": "f6f5acb2193d779f86ce7017a15bdba1f7c3f3df"
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
                "0": "2c5e1199e59b904bad78be282538f72eb863f666"
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