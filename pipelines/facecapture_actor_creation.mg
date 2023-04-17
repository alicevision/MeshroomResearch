{
    "header": {
        "nodesVersions": {
            "DepthMap": "3.0",
            "DepthMapFilter": "3.0",
            "ProjectLandmarksToMesh": "3.0",
            "ConvertSfMFormat": "2.0",
            "Texturing": "6.0",
            "MeshFiltering": "3.0",
            "CopyData": "3.0",
            "FaceDetect2D": "1.0",
            "ConvertSeqToVideo": "1.0",
            "ImageMatching": "2.0",
            "FaceCaptureInitMonoCam": "1.0",
            "Render360": "1.1",
            "ConvertImages": "3.0",
            "StructureFromMotion": "2.0",
            "CreateTrackingMarkers": "3.0",
            "CameraInit": "9.0",
            "RetopoFace": "3.0",
            "FeatureExtraction": "1.1",
            "SfMTransform": "3.0",
            "FaceRender": "1.1",
            "Meshing": "7.0",
            "PrepareDenseScene": "3.0",
            "Segmentation": "3.0",
            "FeatureMatching": "2.0",
            "FaceInit3D": "1.1"
        },
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "template": false
    },
    "graph": {
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                -690,
                678
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "c9a07d723953b53228f2baec4b0d1a7f4311cecc"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 185297234,
                        "poseId": 185297234,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8736.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"129\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"116\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:53\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:53\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:53\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"69\", \"Exif:SubsecTimeDigitized\": \"69\", \"Exif:SubsecTimeOriginal\": \"69\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 204179494,
                        "poseId": 204179494,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8741.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"136\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"212\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:07\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:07\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:07\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"81\", \"Exif:SubsecTimeDigitized\": \"81\", \"Exif:SubsecTimeOriginal\": \"81\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 247565388,
                        "poseId": 247565388,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8742.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"172\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"130\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"160\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:11\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:11\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:11\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"83\", \"Exif:SubsecTimeDigitized\": \"83\", \"Exif:SubsecTimeOriginal\": \"83\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 332669871,
                        "poseId": 332669871,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8740.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"135\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"204\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:04\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:04\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:04\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"87\", \"Exif:SubsecTimeDigitized\": \"87\", \"Exif:SubsecTimeOriginal\": \"87\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 358982419,
                        "poseId": 358982419,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8732.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"133\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"188\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:42\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:42\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:42\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"78\", \"Exif:SubsecTimeDigitized\": \"78\", \"Exif:SubsecTimeOriginal\": \"78\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1166275838,
                        "poseId": 1166275838,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8745.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"127\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"132\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:20\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:20\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:20\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"70\", \"Exif:SubsecTimeDigitized\": \"70\", \"Exif:SubsecTimeOriginal\": \"70\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1341431955,
                        "poseId": 1341431955,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8731.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"172\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"133\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"176\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:40\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:40\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:40\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"44\", \"Exif:SubsecTimeDigitized\": \"44\", \"Exif:SubsecTimeOriginal\": \"44\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1452347399,
                        "poseId": 1452347399,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8734.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"173\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"128\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"144\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:48\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:48\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:48\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"48\", \"Exif:SubsecTimeDigitized\": \"48\", \"Exif:SubsecTimeOriginal\": \"48\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1558630037,
                        "poseId": 1558630037,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8746.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"172\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"127\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"104\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:24\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:24\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:24\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"02\", \"Exif:SubsecTimeDigitized\": \"02\", \"Exif:SubsecTimeOriginal\": \"02\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1620248253,
                        "poseId": 1620248253,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8735.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"129\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"120\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:51\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:51\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:51\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"17\", \"Exif:SubsecTimeDigitized\": \"17\", \"Exif:SubsecTimeOriginal\": \"17\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1664408150,
                        "poseId": 1664408150,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8737.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"130\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"168\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:56\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:56\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:56\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"76\", \"Exif:SubsecTimeDigitized\": \"76\", \"Exif:SubsecTimeOriginal\": \"76\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1716647275,
                        "poseId": 1716647275,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8744.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"172\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"127\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"148\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:17\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:17\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:17\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"63\", \"Exif:SubsecTimeDigitized\": \"63\", \"Exif:SubsecTimeOriginal\": \"63\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1772663516,
                        "poseId": 1772663516,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8738.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"131\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"176\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:59\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:59\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:59\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"07\", \"Exif:SubsecTimeDigitized\": \"07\", \"Exif:SubsecTimeOriginal\": \"07\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1882471670,
                        "poseId": 1882471670,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8733.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"172\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"130\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"164\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:02:45\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:02:45\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:02:45\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"53\", \"Exif:SubsecTimeDigitized\": \"53\", \"Exif:SubsecTimeOriginal\": \"53\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1978961430,
                        "poseId": 1978961430,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8739.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"171\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"132\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"184\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:02\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:02\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:02\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"07\", \"Exif:SubsecTimeDigitized\": \"07\", \"Exif:SubsecTimeOriginal\": \"07\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2021185162,
                        "poseId": 2021185162,
                        "path": "/s/prods/mvg/_source_global/footage/deli/B/IMG_8743.JPG",
                        "intrinsicId": 3829294388,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"22.300000\", \"AliceVision:VignParam1\": \"-1.238341\", \"AliceVision:VignParam2\": \"10.041841\", \"AliceVision:VignParam3\": \"-24.172686\", \"AliceVision:VignParamCenterX\": \"0.500000\", \"AliceVision:VignParamCenterY\": \"0.500000\", \"AliceVision:VignParamFocX\": \"1.024650\", \"AliceVision:VignParamFocY\": \"1.024650\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"-1\", \"Canon:BaseISO\": \"256\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"32767\", \"Canon:CameraTemperature\": \"172\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"0\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"0\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"0\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"129\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.9\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"0\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"23\", \"Canon:FocalPlaneXSize\": \"8902\", \"Canon:FocalPlaneYSize\": \"19690\", \"Canon:FocalType\": \"0\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"0\", \"Canon:FocusMode\": \"3\", \"Canon:FocusRange\": \"2\", \"Canon:ImageSize\": \"0\", \"Canon:ImageType\": \"Canon EOS 550D\", \"Canon:LensModel\": \"EF-S18-55mm f/3.5-5.6 IS\", \"Canon:LensType\": \"48\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"116\", \"Canon:MaxFocalLength\": \"55\", \"Canon:MeasuredEV\": \"152\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"3\", \"Canon:MinAperture\": \"288\", \"Canon:MinFocalLength\": \"18\", \"Canon:ModelID\": \"2147484272\", \"Canon:NDFilter\": \"-1\", \"Canon:OpticalZoomCode\": \"8\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"3511\", \"Canon:SensorHeight\": \"3516\", \"Canon:SensorLeftBorder\": \"152\", \"Canon:SensorRightBorder\": \"5335\", \"Canon:SensorTopBorder\": \"56\", \"Canon:SensorWidth\": \"5344\", \"Canon:SequenceNumber\": \"0\", \"Canon:SerialNumber\": \"1131510629\", \"Canon:SerialNumberFormat\": \"2684354560\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 7, 112\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2017:07:20 11:03:15\", \"Exif:ApertureValue\": \"6\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2017:07:20 11:03:15\", \"Exif:DateTimeOriginal\": \"2017:07:20 11:03:15\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"16\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"23\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"5728.18\", \"Exif:FocalPlaneYResolution\": \"5808.4\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"800\", \"Exif:PixelXDimension\": \"5184\", \"Exif:PixelYDimension\": \"3456\", \"Exif:SceneCaptureType\": \"0\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"34\", \"Exif:SubsecTimeDigitized\": \"34\", \"Exif:SubsecTimeOriginal\": \"34\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"Make\": \"Canon\", \"Model\": \"Canon EOS 550D\", \"Orientation\": \"8\", \"ResolutionUnit\": \"none\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 3829294388,
                        "initialFocalLength": 22.999999999999996,
                        "focalLength": 22.999999999999996,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 5184,
                        "height": 3456,
                        "sensorWidth": 22.3,
                        "sensorHeight": 14.866666666666667,
                        "serialNumber": "1131510629",
                        "principalPoint": {
                            "x": -44.86377716064453,
                            "y": 9.378670692443848
                        },
                        "initializationMode": "estimated",
                        "distortionInitializationMode": "estimated",
                        "distortionParams": [
                            -0.1349198967218399,
                            0.09274404495954514,
                            0.14479905366897583
                        ],
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
                "rawColorInterpretation": "DCPLinearProcessing",
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
        "FaceRender_1": {
            "nodeType": "FaceRender",
            "position": [
                361,
                531
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "31120bb933178bda1d897a4054aff2698ab3f898"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "projectFolder": "{FaceInit3D_2.outputProjectFolder}",
                "tubeRigFiles": "{FaceInit3D_2.outputRigFile}",
                "tubeName": "face",
                "maxPixelCount": [],
                "template": "landmarks",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputRenderFolderName": "{cache}/{nodeType}/{uid0}/",
                "outputImages": "{cache}/{nodeType}/{uid0}/*.png"
            }
        },
        "ProjectLandmarksToMesh_1": {
            "nodeType": "ProjectLandmarksToMesh",
            "position": [
                565,
                576
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "efd44e4f6fbd4aa1e3d79d6e5c4cdc23911386ca"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{FaceInit3D_2.outputProjectFolder}",
                "inputMesh": "{Meshing_4.outputMesh}",
                "inputSfM": "{ConvertSfMFormat_2.output}",
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
                "outputCorrespondances": "{cache}/{nodeType}/{uid0}/landmarks.json"
            }
        },
        "RetopoFace_1": {
            "nodeType": "RetopoFace",
            "position": [
                786,
                566
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "3446e468a118037cd3bd277005ca3597566a18a3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{ProjectLandmarksToMesh_1.inputMesh}",
                "landmarksCorrespondances": "{ProjectLandmarksToMesh_1.outputCorrespondances}",
                "input3DMMFolder": "/s/apps/users/multiview/faceCaptureData/develop/runtime_data/topologies/mpc/mpcHumanFemale_ICT_alb3_fine2",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "CreateTrackingMarkers_1": {
            "nodeType": "CreateTrackingMarkers",
            "position": [
                1897,
                890
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "6d10f4a1fbcdb6d6aefab543b9cb9e14bf5de246"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmData": "{Meshing_4.input}",
                "objFile": "{Meshing_4.outputMesh}",
                "track_mode": "display_no_tracks",
                "track_param_sort_mode": "longest",
                "param_markers_per_voxel": 1,
                "param_voxel_grid_size": 10,
                "param_min_landmark_per_voxel": 10,
                "render": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFile": "{cache}/{nodeType}/{uid0}/track_objects.json",
                "outputImages": "{cache}/{nodeType}/{uid0}/*.png"
            }
        },
        "ConvertImages_2": {
            "nodeType": "ConvertImages",
            "position": [
                -476,
                680
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "e15e86ee679ef1d57f67dd76f03288038d2b0318"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_1.output}",
                "outputFormat": ".png",
                "resampleX": 1,
                "maxWidth": 2024,
                "rotateLeft": false,
                "renameSequence": true,
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
                "outputSfMData": "{cache}/{nodeType}/{uid0}/sfm.sfm"
            }
        },
        "FaceCaptureInitMonoCam_2": {
            "nodeType": "FaceCaptureInitMonoCam",
            "position": [
                -234,
                630
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "8d46c235bd26119e66c2a0cb4ae28bb34efa148f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "framesFolders": [
                    "{ConvertImages_2.outputFolder}"
                ],
                "frameRangeGroup": {
                    "customFrameRange": false,
                    "firstFrameIndex": 0,
                    "frameCount": 0,
                    "firstFrameIndices": []
                },
                "multicamRigidityConstraints": true,
                "cameraFocals": 23.0,
                "sensorWidth": 14.87,
                "filePatterns": [],
                "gamma": 2.2,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "projectFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "FaceDetect2D_2": {
            "nodeType": "FaceDetect2D",
            "position": [
                -50,
                646
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "b400b920c567fe4221d51a16ed31405c9a7af8b5"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "projectFolder": "{FaceCaptureInitMonoCam_2.projectFolder}",
                "detectorName": "sfd",
                "minimumScore": 0.85,
                "minFaceWidth": 128,
                "minFaceHeight": 128,
                "tracker": "Kalman",
                "minTubeLength": 2,
                "mergeMethod": "single",
                "mergeThreshold": 0.5,
                "segmentorName": "sadr",
                "refineThreshold": 0.1,
                "smoothMethod": "none",
                "smoothWindow": 11,
                "smoothMaxDiff": 0.1,
                "batchSize": 100,
                "maxPixelCount": 1048576,
                "threadCount": 4,
                "frameCache": "enabled",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputProjectFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "FaceInit3D_2": {
            "nodeType": "FaceInit3D",
            "position": [
                138,
                616
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "549ddb22c8e1904f4f1a9f983bcc569c24d4f997"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "projectFolder": "{FaceDetect2D_2.outputProjectFolder}",
                "actorName": "mpc/mpcHumanFemale_ICT_alb3_fine2",
                "tubeName": "face",
                "threadCount": 4,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputProjectFolder": "{cache}/{nodeType}/{uid0}/",
                "outputRigFile": "{cache}/{nodeType}/{uid0}/animatedFace.msgpack"
            }
        },
        "ConvertSfMFormat_2": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                712,
                770
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "43a499e43f7ee449a7b22e84f214bbdc68cb7482"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{SfMTransform_3.output}",
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
        "FeatureExtraction_3": {
            "nodeType": "FeatureExtraction",
            "position": [
                -237,
                756
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "d0b10b502bbf82efd8ee8062e99bed2e0e255419"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ConvertImages_2.outputSfMData}",
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
        "FeatureMatching_3": {
            "nodeType": "FeatureMatching",
            "position": [
                163,
                756
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "54bf1e820ec37ea12f2236b9ae40dc93bff6e772"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ImageMatching_3.input}",
                "featuresFolders": "{ImageMatching_3.featuresFolders}",
                "imagePairsList": "{ImageMatching_3.output}",
                "describerTypes": "{FeatureExtraction_3.describerTypes}",
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
        "ImageMatching_3": {
            "nodeType": "ImageMatching",
            "position": [
                -37,
                756
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "75aab5ec9166b8b7e33b663cefd343a42db641f7"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureExtraction_3.input}",
                "featuresFolders": [
                    "{FeatureExtraction_3.output}"
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
        "Segmentation_3": {
            "nodeType": "Segmentation",
            "position": [
                896,
                768
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "94d616275afdf55ca6b12f20de985f212344f15c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ConvertSfMFormat_2.output}",
                "segmentationMethod": "SemanticSegmentationFcnResnet50",
                "createMask": [
                    "person"
                ],
                "inverseClassmask": false,
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
                "outputMask": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "SfMTransform_3": {
            "nodeType": "SfMTransform",
            "position": [
                545,
                770
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "ae3ea9f5254ba4b303698233f6078e4412ad7b0b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_3.output}",
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
        "StructureFromMotion_3": {
            "nodeType": "StructureFromMotion",
            "position": [
                363,
                756
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "04a82dc3dd844b557a97a66a8a00634502d8863e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureMatching_3.input}",
                "featuresFolders": "{FeatureMatching_3.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_3.output}"
                ],
                "describerTypes": "{FeatureMatching_3.describerTypes}",
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
        "DepthMapFilter_4": {
            "nodeType": "DepthMapFilter",
            "position": [
                1463,
                743
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 16,
                "split": 2
            },
            "uids": {
                "0": "2e552e3ad51da234ec9d92941c7bdbbc538d9abf"
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
        "DepthMap_4": {
            "nodeType": "DepthMap",
            "position": [
                1278,
                722
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 16,
                "split": 6
            },
            "uids": {
                "0": "dcf57981bcef65f02416c7d583551b923706a629"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_4.input}",
                "imagesFolder": "{PrepareDenseScene_4.output}",
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
                    "sgmGammaC": 5.5,
                    "sgmGammaP": 8.0,
                    "sgmP1": 10.0,
                    "sgmP2Weighting": 100.0,
                    "sgmMaxDepths": 1500,
                    "sgmFilteringAxes": "YX",
                    "sgmDepthListPerTile": true
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
                    "refineGammaP": 8.0
                },
                "colorOptimization": {
                    "colorOptimizationEnabled": true,
                    "colorOptimizationNbIterations": 100
                },
                "intermediateResults": {
                    "exportIntermediateDepthSimMaps": false,
                    "exportIntermediateVolumes": false,
                    "exportIntermediateCrossVolumes": false,
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
                "depthSgm": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_scale2_sgm.exr",
                "depthSgmUpscaled": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_sgmUpscaled.exr",
                "depthRefined": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_refinedFused.exr"
            }
        },
        "MeshFiltering_4": {
            "nodeType": "MeshFiltering",
            "position": [
                1832,
                755
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "725f7b9ad7694e60ba17566c09418d1397605d8f"
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
        "Meshing_4": {
            "nodeType": "Meshing",
            "position": [
                1653,
                748
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "ee2716188e1d5f6211f63ac1df53a8b38e9f9d6e"
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
                "maxPoints": 50000,
                "maxPointsPerVoxel": 1000000,
                "minStep": 2,
                "partitioning": "singleBlock",
                "repartition": "multiResolution",
                "angleFactor": 15.0,
                "simFactor": 15.0,
                "pixSizeMarginInitCoef": 2.0,
                "pixSizeMarginFinalCoef": 4.0,
                "voteMarginFactor": 2.0,
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
        "PrepareDenseScene_4": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1081,
                751
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 16,
                "split": 1
            },
            "uids": {
                "0": "979e76081a877e64f4a4d2b4800c271cafdd6869"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Segmentation_3.input}",
                "imagesFolders": [],
                "masksFolders": [
                    "{Segmentation_3.outputMask}"
                ],
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
        "Texturing_4": {
            "nodeType": "Texturing",
            "position": [
                2027,
                723
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "11221dae324e87befc4dbccc4d7a6266cd1fae72"
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
                "workingColorSpace": "sRGB",
                "outputColorSpace": "AUTO",
                "correctEV": false,
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
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.png"
            }
        },
        "Render360_5": {
            "nodeType": "Render360",
            "position": [
                2204,
                751
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "dd559c7e87751753c344b5a96faecb8dc01bab38"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "script": "/s/apps/users/multiview/mrrs/develop/MeshroomResearch/mrrs/blender/render360.py",
                "objectFile": "{Texturing_4.outputMesh}",
                "renderSteps": 64
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFolder": "{cache}/{nodeType}/{uid0}/",
                "outputImages": "{cache}/{nodeType}/{uid0}/*.png"
            }
        },
        "ConvertSeqToVideo_5": {
            "nodeType": "ConvertSeqToVideo",
            "position": [
                2390,
                750
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "657b635e3aeaa13cfd0e3148df1a5955d9ece213"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "images": "{Render360_5.outputImages}",
                "framerate": 25.0
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputVideo": "{cache}/{nodeType}/{uid0}/video.mp4"
            }
        },
        "CopyData_8": {
            "nodeType": "CopyData",
            "position": [
                2582,
                731
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "1485da831b46ea4dba9ded3ceeb393226c1c40d7"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{ConvertSeqToVideo_5.outputVideo}",
                "inputFile": "video.mp4",
                "outputName": "meshroom.mp4",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFile": "{cache}/{nodeType}/{uid0}/meshroom.mp4"
            }
        }
    }
}