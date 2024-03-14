{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2024.1.0-develop",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "CameraInit": "9.0",
            "FeatureMatching": "2.0",
            "StructureFromMotion": "3.3",
            "SfMAlignment": "2.0",
            "ImageMatching": "2.0",
            "FeatureExtraction": "1.3",
            "LoadDataset": "3.0"
        }
    },
    "graph": {
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                191,
                -51
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 38,
                "split": 1
            },
            "uids": {
                "0": "6b98ee7dd4c46845cc92af647a8df99d8348b175"
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
                -9,
                -51
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 38,
                "split": 1
            },
            "uids": {
                "0": "e0ccde1946cb59f442e643d631657d7c8f79d286"
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
                591,
                -51
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 38,
                "split": 1
            },
            "uids": {
                "0": "b1f6e14ee0274fe10f835fd333a96eb0b2bc5aac"
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
                391,
                -51
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 38,
                "split": 2
            },
            "uids": {
                "0": "f1ceb334af27166e36eb80d87ed61fb9a0a36f59"
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
        "SfMAlignment_1": {
            "nodeType": "SfMAlignment",
            "position": [
                195,
                88
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 38,
                "split": 1
            },
            "uids": {
                "0": "010128bfa17235576f6aa0076ed195abe2ef4b57"
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
        "CameraInit_2": {
            "nodeType": "CameraInit",
            "position": [
                -384,
                104
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 38,
                "split": 1
            },
            "uids": {
                "0": "d4aadecc068d65474303a65b279b9ca214c88afe"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 38857581,
                        "poseId": 38857581,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0312.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:58:00\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:58:00\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:58:00\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"24\", \"Exif:SubsecTimeDigitized\": \"24\", \"Exif:SubsecTimeOriginal\": \"24\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 82059256,
                        "poseId": 82059256,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0287.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:51:59\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:51:59\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:51:59\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"33\", \"Exif:SubsecTimeDigitized\": \"33\", \"Exif:SubsecTimeOriginal\": \"33\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 103822479,
                        "poseId": 103822479,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0288.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:52:08\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:52:08\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:52:08\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"00\", \"Exif:SubsecTimeDigitized\": \"00\", \"Exif:SubsecTimeOriginal\": \"00\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 128259617,
                        "poseId": 128259617,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0319.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 13:00:01\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 13:00:01\", \"Exif:DateTimeOriginal\": \"2016:10:29 13:00:01\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"58\", \"Exif:SubsecTimeDigitized\": \"58\", \"Exif:SubsecTimeOriginal\": \"58\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 181322680,
                        "poseId": 181322680,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0295.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:54:23\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:54:23\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:54:23\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"74\", \"Exif:SubsecTimeDigitized\": \"74\", \"Exif:SubsecTimeOriginal\": \"74\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 204594595,
                        "poseId": 204594595,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0310.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:56:59\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:56:59\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:56:59\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"83\", \"Exif:SubsecTimeDigitized\": \"83\", \"Exif:SubsecTimeOriginal\": \"83\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 207581356,
                        "poseId": 207581356,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0307.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:56:25\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:56:25\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:56:25\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"24\", \"Exif:SubsecTimeDigitized\": \"24\", \"Exif:SubsecTimeOriginal\": \"24\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 364956044,
                        "poseId": 364956044,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0304.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:55:56\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:55:56\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:55:56\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"58\", \"Exif:SubsecTimeDigitized\": \"58\", \"Exif:SubsecTimeOriginal\": \"58\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 443590299,
                        "poseId": 443590299,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0291.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:52:35\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:52:35\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:52:35\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"49\", \"Exif:SubsecTimeDigitized\": \"49\", \"Exif:SubsecTimeOriginal\": \"49\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 449534791,
                        "poseId": 449534791,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0313.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:58:15\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:58:15\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:58:15\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"25\", \"Exif:SubsecTimeDigitized\": \"25\", \"Exif:SubsecTimeOriginal\": \"25\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 483792639,
                        "poseId": 483792639,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0298.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:54:50\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:54:50\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:54:50\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"66\", \"Exif:SubsecTimeDigitized\": \"66\", \"Exif:SubsecTimeOriginal\": \"66\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0166667\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 491713449,
                        "poseId": 491713449,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0289.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:52:16\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:52:16\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:52:16\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"49\", \"Exif:SubsecTimeDigitized\": \"49\", \"Exif:SubsecTimeOriginal\": \"49\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 494060133,
                        "poseId": 494060133,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0300.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:55:07\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:55:07\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:55:07\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"66\", \"Exif:SubsecTimeDigitized\": \"66\", \"Exif:SubsecTimeOriginal\": \"66\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 535371985,
                        "poseId": 535371985,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0322.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 13:00:47\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 13:00:47\", \"Exif:DateTimeOriginal\": \"2016:10:29 13:00:47\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"24\", \"Exif:SubsecTimeDigitized\": \"24\", \"Exif:SubsecTimeOriginal\": \"24\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 621086314,
                        "poseId": 621086314,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0290.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:52:26\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:52:26\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:52:26\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"33\", \"Exif:SubsecTimeDigitized\": \"33\", \"Exif:SubsecTimeOriginal\": \"33\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 636460634,
                        "poseId": 636460634,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0292.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:52:44\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:52:44\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:52:44\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"41\", \"Exif:SubsecTimeDigitized\": \"41\", \"Exif:SubsecTimeOriginal\": \"41\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 663116653,
                        "poseId": 663116653,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0308.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:56:35\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:56:35\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:56:35\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"74\", \"Exif:SubsecTimeDigitized\": \"74\", \"Exif:SubsecTimeOriginal\": \"74\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 679172946,
                        "poseId": 679172946,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0317.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:59:22\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:59:22\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:59:22\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"08\", \"Exif:SubsecTimeDigitized\": \"08\", \"Exif:SubsecTimeOriginal\": \"08\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 755393654,
                        "poseId": 755393654,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0318.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:59:40\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:59:40\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:59:40\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"91\", \"Exif:SubsecTimeDigitized\": \"91\", \"Exif:SubsecTimeOriginal\": \"91\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 831916465,
                        "poseId": 831916465,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0303.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:55:46\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:55:46\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:55:46\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"74\", \"Exif:SubsecTimeDigitized\": \"74\", \"Exif:SubsecTimeOriginal\": \"74\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 929038849,
                        "poseId": 929038849,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0315.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:58:50\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:58:50\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:58:50\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"49\", \"Exif:SubsecTimeDigitized\": \"49\", \"Exif:SubsecTimeOriginal\": \"49\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 936634163,
                        "poseId": 936634163,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0299.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:54:59\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:54:59\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:54:59\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"08\", \"Exif:SubsecTimeDigitized\": \"08\", \"Exif:SubsecTimeOriginal\": \"08\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 949904440,
                        "poseId": 949904440,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0306.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:56:14\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:56:14\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:56:14\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"83\", \"Exif:SubsecTimeDigitized\": \"83\", \"Exif:SubsecTimeOriginal\": \"83\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 971589267,
                        "poseId": 971589267,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0323.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 13:01:04\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 13:01:04\", \"Exif:DateTimeOriginal\": \"2016:10:29 13:01:04\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"16\", \"Exif:SubsecTimeDigitized\": \"16\", \"Exif:SubsecTimeOriginal\": \"16\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.008\", \"FNumber\": \"5.6\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 993050717,
                        "poseId": 993050717,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0293.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:52:52\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:52:52\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:52:52\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"91\", \"Exif:SubsecTimeDigitized\": \"91\", \"Exif:SubsecTimeOriginal\": \"91\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 998767263,
                        "poseId": 998767263,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0316.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:59:04\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:59:04\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:59:04\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"00\", \"Exif:SubsecTimeDigitized\": \"00\", \"Exif:SubsecTimeOriginal\": \"00\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1141469084,
                        "poseId": 1141469084,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0305.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:56:05\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:56:05\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:56:05\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"33\", \"Exif:SubsecTimeDigitized\": \"33\", \"Exif:SubsecTimeOriginal\": \"33\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1148356519,
                        "poseId": 1148356519,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0314.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:58:27\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:58:27\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:58:27\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"83\", \"Exif:SubsecTimeDigitized\": \"83\", \"Exif:SubsecTimeOriginal\": \"83\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1286760721,
                        "poseId": 1286760721,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0311.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:57:44\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:57:44\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:57:44\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"74\", \"Exif:SubsecTimeDigitized\": \"74\", \"Exif:SubsecTimeOriginal\": \"74\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1294705539,
                        "poseId": 1294705539,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0321.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 13:00:32\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 13:00:32\", \"Exif:DateTimeOriginal\": \"2016:10:29 13:00:32\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"33\", \"Exif:SubsecTimeDigitized\": \"33\", \"Exif:SubsecTimeOriginal\": \"33\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1315437376,
                        "poseId": 1315437376,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0301.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:55:15\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:55:15\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:55:15\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"83\", \"Exif:SubsecTimeDigitized\": \"83\", \"Exif:SubsecTimeOriginal\": \"83\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1447169911,
                        "poseId": 1447169911,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0286.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:51:02\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:51:02\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:51:02\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"58\", \"Exif:SubsecTimeDigitized\": \"58\", \"Exif:SubsecTimeOriginal\": \"58\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1759129618,
                        "poseId": 1759129618,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0302.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:55:37\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:55:37\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:55:37\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"91\", \"Exif:SubsecTimeDigitized\": \"91\", \"Exif:SubsecTimeOriginal\": \"91\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1759232614,
                        "poseId": 1759232614,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0296.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:54:33\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:54:33\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:54:33\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"33\", \"Exif:SubsecTimeDigitized\": \"33\", \"Exif:SubsecTimeOriginal\": \"33\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0166667\", \"FNumber\": \"4\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2039937082,
                        "poseId": 2039937082,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0297.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:54:42\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:54:42\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:54:42\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"58\", \"Exif:SubsecTimeDigitized\": \"58\", \"Exif:SubsecTimeOriginal\": \"58\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0166667\", \"FNumber\": \"4\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2050512919,
                        "poseId": 2050512919,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0309.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:56:45\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:56:45\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:56:45\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"74\", \"Exif:SubsecTimeDigitized\": \"74\", \"Exif:SubsecTimeOriginal\": \"74\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2093886181,
                        "poseId": 2093886181,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0294.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 12:54:12\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 12:54:12\", \"Exif:DateTimeOriginal\": \"2016:10:29 12:54:12\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"74\", \"Exif:SubsecTimeDigitized\": \"74\", \"Exif:SubsecTimeOriginal\": \"74\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.0125\", \"FNumber\": \"4.5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2132035404,
                        "poseId": 2132035404,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images/DSC_0320.JPG",
                        "intrinsicId": 2715225201,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"35.900000\", \"Artist\": \"                                    \", \"Copyright\": \"                                                      \", \"DateTime\": \"2016:10:29 13:00:19\", \"Exif:ColorSpace\": \"1\", \"Exif:CompressedBitsPerPixel\": \"4\", \"Exif:Contrast\": \"0\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2016:10:29 13:00:19\", \"Exif:DateTimeOriginal\": \"2016:10:29 13:00:19\", \"Exif:DigitalZoomRatio\": \"1\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"20\", \"Exif:FocalLengthIn35mmFilm\": \"20\", \"Exif:GainControl\": \"0\", \"Exif:LightSource\": \"0\", \"Exif:MaxApertureValue\": \"3\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"100\", \"Exif:PixelXDimension\": \"6048\", \"Exif:PixelYDimension\": \"4032\", \"Exif:Saturation\": \"0\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:Sharpness\": \"2\", \"Exif:SubjectDistanceRange\": \"0\", \"Exif:SubsecTime\": \"41\", \"Exif:SubsecTimeDigitized\": \"41\", \"Exif:SubsecTimeOriginal\": \"41\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.01\", \"FNumber\": \"5\", \"GPS:VersionID\": \"2, 2, 0, 0\", \"Make\": \"NIKON CORPORATION\", \"Model\": \"NIKON D3X\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"Software\": \"Ver.1.01 \", \"XResolution\": \"300\", \"YResolution\": \"300\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 2715225201,
                        "initialFocalLength": 20.0,
                        "focalLength": 20.0,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 6048,
                        "height": 4032,
                        "sensorWidth": 35.9,
                        "sensorHeight": 23.933333333333334,
                        "serialNumber": "/s/prods/mvg/_source_global/users/hogm/datasets/eth3d/courtyard/images/dslr_images_NIKON CORPORATION_NIKON D3X",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "estimated",
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
        "LoadDataset_1": {
            "nodeType": "LoadDataset",
            "position": [
                -168,
                90
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 38,
                "split": 1
            },
            "uids": {
                "0": "be9df26d552d6a76127ab9fc964c81cb470c8e32"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{CameraInit_2.output}",
                "datasetType": "ETH3D",
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
        }
    }
}