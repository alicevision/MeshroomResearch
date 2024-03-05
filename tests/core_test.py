import unittest
import json
import os
import numpy as np

from mrrs.core.ios import matrices_from_sfm_data, sfm_data_from_matrices 
from mrrs.core.geometry import EPSILON

TEST_SFM_FILE = os.path.join(os.path.dirname(__file__), "data", "cameras.sfm")
GT_SFM_FILE = os.path.join(os.path.dirname(__file__), "data", "cameras.npz")

def assert_almost_equal(a,b):
    if isinstance(a, str) or isinstance(b, str):
        if a!=b:
            raise AssertionError(a+" "+b+" not equal")
    else:
        if abs(float(a)-float(b))>EPSILON:
            raise AssertionError(f"{a} and {b} not equal within {EPSILON}")

def assert_almost_equal_json(assert_fc, object_1, object_2, to_ignore=[]):
    """
    Function that recursively test elements of a json.
    """
    if isinstance(object_1, dict) and isinstance(object_2, dict): 
        for key_1, key_2 in zip(object_1, object_2):
            if (key_1 in to_ignore) or (key_2 in to_ignore):
                continue
            assert_fc(key_1, key_2)
            assert_almost_equal_json(assert_fc, object_1[key_1], object_2[key_2], to_ignore)
    elif isinstance(object_1, list) and isinstance(object_2, list): 
        for element_1, element_2 in zip(object_1, object_2):
            assert_almost_equal_json(assert_fc, element_1, element_2, to_ignore)
    else:
        #try to convert to float for numerical values
        try:
            object_1=float(object_1) 
            object_2=float(object_2)
        except:
            pass
        assert_fc(object_1, object_2)
 
class TestIos(unittest.TestCase):
    """"
    Test loading and export from and to meshroom sfm formats
    """
    
    def setUp(self):
        #open the test file in json format
        with open(TEST_SFM_FILE, "r") as json_file:
            self.gt_sfm_data_json = json.load(json_file)
        #open the corresponding values in npy format
        self.gt_sfm_data = np.load(GT_SFM_FILE)

    def test_matrices_from_sfm_data(self):
        #test loading sfm data
        (extrinsics, intrinsics, views_id, poses_id, intrinsics_id, 
        pixel_sizes, image_sizes) = matrices_from_sfm_data(self.gt_sfm_data_json, return_image_sizes=True)
        # np.savez_compressed(GT_SFM_FILE, gt_extrinsics = extrinsics, gt_intrinsics = intrinsics, gt_views_id=views_id, 
        #                     gt_poses_id=poses_id, gt_intrinsics_id=intrinsics_id, gt_pixel_sizes=pixel_sizes, gt_image_sizes=image_sizes)
        np.testing.assert_almost_equal(extrinsics, self.gt_sfm_data["gt_extrinsics"])
        np.testing.assert_almost_equal(intrinsics, self.gt_sfm_data["gt_intrinsics"])
        np.testing.assert_equal(views_id, self.gt_sfm_data["gt_views_id"])
        np.testing.assert_equal(poses_id, self.gt_sfm_data["gt_poses_id"])
        np.testing.assert_equal(intrinsics_id, self.gt_sfm_data["gt_intrinsics_id"])
        np.testing.assert_equal(pixel_sizes, self.gt_sfm_data["gt_pixel_sizes"])
        np.testing.assert_equal(image_sizes, self.gt_sfm_data["gt_image_sizes"])

    def test_sfm_data_from_matrices(self):
        #test saving sfm data
        self.gt_sfm_data = np.load(GT_SFM_FILE)
        extrinsics      =   self.gt_sfm_data["gt_extrinsics"]
        intrinsics      =   self.gt_sfm_data["gt_intrinsics"]
        views_id        =   self.gt_sfm_data["gt_views_id"]
        poses_id        =   self.gt_sfm_data["gt_poses_id"]
        intrinsics_id   =   self.gt_sfm_data["gt_intrinsics_id"]
        pixel_sizes     =   self.gt_sfm_data["gt_pixel_sizes"]
        image_sizes     =   self.gt_sfm_data["gt_image_sizes"]

        #convert focal and pp from m to px
        intrinsics = intrinsics/np.expand_dims(np.expand_dims(pixel_sizes, axis=-1), axis=-1)
        intrinsics[:,2,2] = 1

        # compute sensor_width
        sensor_width = image_sizes[0][0]*pixel_sizes[0]

        #make the json
        sfm_data_json = sfm_data_from_matrices(extrinsics, intrinsics, poses_id,
                                              intrinsics_id, image_sizes, sfm_data = self.gt_sfm_data_json, 
                                              sensor_width = sensor_width)

        # with open("/s/apps/users/multiview/mrrs/develop/MeshroomResearch/pipelines/reconstruction/MeshroomCache/StructureFromMotion/797c0df1a0c178b3cbc58db5366de6a9d31038ca/sfm_data_json.json", "w") as f :
        #     f.write(json.dumps(sfm_data_json, indent=4))

        # with open("/s/apps/users/multiview/mrrs/develop/MeshroomResearch/pipelines/reconstruction/MeshroomCache/StructureFromMotion/797c0df1a0c178b3cbc58db5366de6a9d31038ca/gt_sfm_data_json.json", "w") as f :
        #     f.write(json.dumps(self.gt_sfm_data_json, indent=4))

        #list of dict elements we ignore on purpose
        to_ignore = ["serialNumber", "initializationMode", "type", "initialFocalLength", "pixelRatio", "pixelRatioLocked", "distortionParams", "locked"]
        assert_almost_equal_json(assert_almost_equal, sfm_data_json, self.gt_sfm_data_json, to_ignore)
          
if __name__=="__main__":
    unittest.main()