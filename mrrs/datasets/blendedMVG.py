
def open_txt_calibration_blendedMVG(calib_file):
    '''
    Opens a text file containing the calibration for a single camera, in the form :

    extrinsic
    E00 E01 E02 E03
    E10 E11 E12 E13
    E20 E21 E22 E23
    E30 E31 E32 E33

    intrinsic
    K00 K01 K02
    K10 K11 K12
    K20 K21 K22

    see https://github.com/YoYo000/MVSNet.
    '''
    intrinsics = np.zeros((3, 3))
    extrinsics = np.zeros((4, 4))
    with open(calib_file, "r") as calib_file:
        words = calib_file.read().split()
        # read extrinsic
        for i in range(0, 4):
            for j in range(0, 4):
                extrinsic_index = 4 * i + j + 1
                extrinsics[i][j] = words[extrinsic_index]
        # read intrinsic
        for i in range(0, 3):
            for j in range(0, 3):
                intrinsic_index = 3 * i + j + 18
                intrinsics[i][j] = words[intrinsic_index]

        # #extra info about depth range (unsused for now)
        # if len(words) == 29:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = max_d
        #     intrinsics[3][3] = intrinsics[3][0] + intrinsics[3][1] * intrinsics[3][2]
        # elif len(words) == 30:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = words[29]
        #     intrinsics[3][3] = intrinsics[3][0] + intrinsics[3][1] * intrinsics[3][2]
        # elif len(words) == 31:
        #     intrinsics[3][0] = words[27]
        #     intrinsics[3][1] = float(words[28]) * interval_scale
        #     intrinsics[3][2] = words[29]
        #     intrinsics[3][3] = words[30]
        # else:
        #     intrinsics[3][0] = 0
        #     intrinsics[3][1] = 0
        #     intrinsics[3][2] = 0
        #     intrinsics[3][3] = 0

    return extrinsics, intrinsics
