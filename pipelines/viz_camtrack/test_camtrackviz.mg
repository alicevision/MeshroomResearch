{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "SfMTransform": "3.0",
            "FeatureMatching": "2.0",
            "CameraInit": "8.0",
            "ConvertSfMFormat": "2.0",
            "FeatureExtraction": "1.1",
            "RenderOverlay": "1.1",
            "DistortionCalibration": "2.0",
            "ImageMatching": "2.0",
            "StructureFromMotion": "2.0",
            "CreateTrackingMarkers": "3.0",
            "ExportAnimatedCamera": "2.0"
        }
    },
    "graph": {
        "DistortionCalibration_1": {
            "nodeType": "DistortionCalibration",
            "position": [
                200,
                160
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 52,
                "split": 1
            },
            "uids": {
                "0": "dffd4e4219d462ecc7bb105d44d96f5598f7023b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_1.output}",
                "lensGrid": [],
                "verboseLevel": "info"
            },
            "outputs": {
                "outSfMData": "{cache}/{nodeType}/{uid0}/sfmData.sfm"
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
                "size": 52,
                "split": 1
            },
            "uids": {
                "0": "49bdccb41d1f1e40b3b05ab129d51292e7eb3fab"
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
                "nbMatches": 5,
                "nbNeighbors": 10,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/imageMatches.txt"
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
                "size": 52,
                "split": 2
            },
            "uids": {
                "0": "a8690ef4fcddc98f37d6145c05c06780987fcef0"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_1.output}",
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
                800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 52,
                "split": 1
            },
            "uids": {
                "0": "6be8c0849274e2be5c70a630aab3e910dbffaf68"
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
                "minInputTrackLength": 5,
                "minNumberOfObservationsForTriangulation": 3,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
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
        "ExportAnimatedCamera_1": {
            "nodeType": "ExportAnimatedCamera",
            "position": [
                1000,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "b6931322f493ec65050615ed9aeb358af3f2d3eb"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "sfmDataFilter": "",
                "viewFilter": "",
                "exportUVMaps": true,
                "exportUndistortedImages": false,
                "undistortedImageType": "exr",
                "exportFullROD": false,
                "correctPrincipalPoint": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputCamera": "{cache}/{nodeType}/{uid0}/camera.abc",
                "outputUndistorted": "{cache}/{nodeType}/{uid0}/undistort"
            }
        },
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                0,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 52,
                "split": 1
            },
            "uids": {
                "0": "d6434f56350cbfc7849219746a78e951082ea001"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 24693973,
                        "poseId": 24693973,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002052.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"740183315\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 57794268,
                        "poseId": 57794268,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002121.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"222139159\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 107187856,
                        "poseId": 107187856,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002181.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"2067702742\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 153485264,
                        "poseId": 153485264,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002124.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"573392999\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 210466757,
                        "poseId": 210466757,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002088.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1796416510\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 228682537,
                        "poseId": 228682537,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002139.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"427629249\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 248561940,
                        "poseId": 248561940,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002058.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1198239940\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 252841271,
                        "poseId": 252841271,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002148.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1775756697\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 257142097,
                        "poseId": 257142097,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002163.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1964890688\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 279699002,
                        "poseId": 279699002,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002175.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"331369623\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 312064065,
                        "poseId": 312064065,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002061.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1308424009\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 389304499,
                        "poseId": 389304499,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002073.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"899616521\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 392169479,
                        "poseId": 392169479,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002076.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1655991003\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 411767208,
                        "poseId": 411767208,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002142.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1300678686\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 511975409,
                        "poseId": 511975409,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002184.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"110717272\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 536584808,
                        "poseId": 536584808,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002055.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"365770900\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 545375015,
                        "poseId": 545375015,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002199.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1755539511\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 613432967,
                        "poseId": 613432967,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002172.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1918349407\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 674358635,
                        "poseId": 674358635,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002196.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1059294573\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 888702541,
                        "poseId": 888702541,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002205.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"846212774\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 968616771,
                        "poseId": 968616771,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002169.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1252939300\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 995210552,
                        "poseId": 995210552,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002136.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1192992268\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1006615026,
                        "poseId": 1006615026,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002106.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"459075527\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1121216705,
                        "poseId": 1121216705,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002079.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1272605454\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1198662930,
                        "poseId": 1198662930,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002133.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"246805766\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1202337962,
                        "poseId": 1202337962,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002178.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"453481022\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1226126326,
                        "poseId": 1226126326,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002154.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1464262244\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1265453644,
                        "poseId": 1265453644,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002070.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"264914545\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1278049151,
                        "poseId": 1278049151,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002082.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1598743483\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1279024728,
                        "poseId": 1279024728,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002067.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"394813844\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1293669428,
                        "poseId": 1293669428,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002109.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"859487668\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1337563701,
                        "poseId": 1337563701,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002091.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"290554885\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1397648169,
                        "poseId": 1397648169,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002187.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"2138340300\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1473780579,
                        "poseId": 1473780579,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002112.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"905123860\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1490293678,
                        "poseId": 1490293678,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002064.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"86333873\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1541152224,
                        "poseId": 1541152224,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002115.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"381314252\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1545670618,
                        "poseId": 1545670618,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002190.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"587577902\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1585235096,
                        "poseId": 1585235096,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002157.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1403833637\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1588687654,
                        "poseId": 1588687654,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002085.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1824005382\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1595002407,
                        "poseId": 1595002407,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002130.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1353055574\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1599379728,
                        "poseId": 1599379728,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002100.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1059970380\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1617666914,
                        "poseId": 1617666914,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002097.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"6264750\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1672838779,
                        "poseId": 1672838779,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002118.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1674244213\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1692873687,
                        "poseId": 1692873687,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002202.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"720794944\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1706456822,
                        "poseId": 1706456822,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002151.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1031725483\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1716923987,
                        "poseId": 1716923987,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002166.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1835050362\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1966105345,
                        "poseId": 1966105345,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002127.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"462590318\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2050536277,
                        "poseId": 2050536277,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002145.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1076313723\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2095178214,
                        "poseId": 2095178214,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002103.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1728374884\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2122759314,
                        "poseId": 2122759314,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002160.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"697715332\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2132714114,
                        "poseId": 2132714114,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002193.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"58721637\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2145072791,
                        "poseId": 2145072791,
                        "path": "C:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/TTT/0002094.jpg",
                        "intrinsicId": 592681259,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"1.000000\", \"AliceVision:useWhiteBalance\": \"1\", \"Exif:BodySerialNumber\": \"1044004101\", \"Exif:ColorSpace\": \"1\", \"Exif:ExifVersion\": \"0230\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"1.2\", \"Exif:ImageUniqueID\": \"1859421950\", \"Make\": \"Custom\", \"Model\": \"radial3\", \"jpeg:subsampling\": \"4:4:4\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 592681259,
                        "initialFocalLength": 1.2,
                        "focalLength": 1.2,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 1920,
                        "height": 1080,
                        "sensorWidth": 1.0,
                        "sensorHeight": 0.5625,
                        "serialNumber": "1044004101",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "estimated",
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "locked": false
                    }
                ],
                "sensorDatabase": "${ALICEVISION_SENSOR_DB}",
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
                "useInternalWhiteBalance": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/cameraInit.sfm"
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
                "size": 52,
                "split": 3
            },
            "uids": {
                "0": "d4bf31f4f3bb6967a6c2604061be1d35aff62b32"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DistortionCalibration_1.outSfMData}",
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
        "ConvertSfMFormat_1": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                1260,
                168
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 52,
                "split": 1
            },
            "uids": {
                "0": "e79089fda54b7c7a66816d66b868302d861b6271"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMTransform_1.output}",
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
        "SfMTransform_1": {
            "nodeType": "SfMTransform",
            "position": [
                1051,
                173
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 52,
                "split": 1
            },
            "uids": {
                "0": "a05760159de9b534c89d834d09bd502bbb294443"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "method": "auto_from_cameras_x_axis",
                "transformation": "",
                "manualTransform": {
                    "manualTranslation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "manualRotation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "manualScale": 1.0
                },
                "landmarksDescriberTypes": [
                    "sift",
                    "dspsift",
                    "akaze"
                ],
                "scale": 1.0,
                "markers": [],
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
        "CreateTrackingMarkers_1": {
            "nodeType": "CreateTrackingMarkers",
            "position": [
                1250,
                44
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "db042ce2338f920264183fb7ddfc1dd9519dd973"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{ConvertSfMFormat_1.output}",
                "track_mode": "display_track_cones",
                "track_param_sort_mode": "scale",
                "param_markers_per_voxel": 1,
                "param_voxel_grid_size": 100,
                "param_min_landmark_per_voxel": 30,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputFile": "{cache}/{nodeType}/{uid0}/track_objects.json"
            }
        },
        "RenderOverlay_1": {
            "nodeType": "RenderOverlay",
            "position": [
                1477,
                49
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "68baacc848319f9abdc8d436052285bcae8c926c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "script": "MeshroomResearch/mrrs/blender/render_overlay_markers.py",
                "markers": "{CreateTrackingMarkers_1.outputFile}",
                "sizeFactor": 0.5,
                "sfmData": "{CreateTrackingMarkers_1.sfmData}"
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "overlay": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.jpg"
            }
        }
    }
}