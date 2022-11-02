# C:\Dev>colmap mapper -h

#   -h [ --help ]
#   --random_seed arg (=0)
#   --log_to_stderr arg (=0)
#   --log_level arg (=2)
#   --project_path arg
#   --database_path arg
#   --image_path arg
#   --input_path arg
#   --output_path arg
#   --image_list_path arg
#   --Mapper.min_num_matches arg (=15)
#   --Mapper.ignore_watermarks arg (=0)
#   --Mapper.multiple_models arg (=1)
#   --Mapper.max_num_models arg (=50)
#   --Mapper.max_model_overlap arg (=20)
#   --Mapper.min_model_size arg (=10)
#   --Mapper.init_image_id1 arg (=-1)
#   --Mapper.init_image_id2 arg (=-1)
#   --Mapper.init_num_trials arg (=200)
#   --Mapper.extract_colors arg (=1)
#   --Mapper.num_threads arg (=-1)
#   --Mapper.min_focal_length_ratio arg (=0.10000000000000001)
#   --Mapper.max_focal_length_ratio arg (=10)
#   --Mapper.max_extra_param arg (=1)
#   --Mapper.ba_refine_focal_length arg (=1)
#   --Mapper.ba_refine_principal_point arg (=0)
#   --Mapper.ba_refine_extra_params arg (=1)
#   --Mapper.ba_min_num_residuals_for_multi_threading arg (=50000)
#   --Mapper.ba_local_num_images arg (=6)
#   --Mapper.ba_local_function_tolerance arg (=0)
#   --Mapper.ba_local_max_num_iterations arg (=25)
#   --Mapper.ba_global_use_pba arg (=0)
#   --Mapper.ba_global_pba_gpu_index arg (=-1)
#   --Mapper.ba_global_images_ratio arg (=1.1000000000000001)
#   --Mapper.ba_global_points_ratio arg (=1.1000000000000001)
#   --Mapper.ba_global_images_freq arg (=500)
#   --Mapper.ba_global_points_freq arg (=250000)
#   --Mapper.ba_global_function_tolerance arg (=0)
#   --Mapper.ba_global_max_num_iterations arg (=50)
#   --Mapper.ba_global_max_refinements arg (=5)
#   --Mapper.ba_global_max_refinement_change arg (=0.00050000000000000001)
#   --Mapper.ba_local_max_refinements arg (=2)
#   --Mapper.ba_local_max_refinement_change arg (=0.001)
#   --Mapper.snapshot_path arg
#   --Mapper.snapshot_images_freq arg (=0)
#   --Mapper.fix_existing_images arg (=0)
#   --Mapper.init_min_num_inliers arg (=100)
#   --Mapper.init_max_error arg (=4)
#   --Mapper.init_max_forward_motion arg (=0.94999999999999996)
#   --Mapper.init_min_tri_angle arg (=16)
#   --Mapper.init_max_reg_trials arg (=2)
#   --Mapper.abs_pose_max_error arg (=12)
#   --Mapper.abs_pose_min_num_inliers arg (=30)
#   --Mapper.abs_pose_min_inlier_ratio arg (=0.25)
#   --Mapper.filter_max_reproj_error arg (=4)
#   --Mapper.filter_min_tri_angle arg (=1.5)
#   --Mapper.max_reg_trials arg (=3)
#   --Mapper.local_ba_min_tri_angle arg (=6)
#   --Mapper.tri_max_transitivity arg (=1)
#   --Mapper.tri_create_max_angle_error arg (=2)
#   --Mapper.tri_continue_max_angle_error arg (=2)
#   --Mapper.tri_merge_max_reproj_error arg (=4)
#   --Mapper.tri_complete_max_reproj_error arg (=4)
#   --Mapper.tri_complete_max_transitivity arg (=5)
#   --Mapper.tri_re_max_angle_error arg (=5)
#   --Mapper.tri_re_min_ratio arg (=0.20000000000000001)
#   --Mapper.tri_re_max_trials arg (=1)
#   --Mapper.tri_min_angle arg (=1.5)
#   --Mapper.tri_ignore_two_view_tracks arg (=1)

__version__ = "2.0"

from meshroom.core import desc

import os
import shutil


class ColmapMapper(desc.CommandLineNode):
    commandLine = 'colmap.bat mapper {allParams}'#  --output_type TXT

    category = 'Colmap'
    documentation = ''''''

    inputs = [
        desc.File(
            name='input_database_path',
            label='InputDatabase',
            description='Input database path',
            value='',
            uid=[0],
            group='',
        ),
        desc.File(
            name='image_path',
            label='Image Directory',
            description='''Path to images.''',
            value='',
            uid=[0],
        ),
    ]

    outputs = [
        desc.File(
            name='output_path',
            label='BaseOutputPath',
            description='Base Output path',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        desc.File(
            name='output_path0',
            label='OutputPath0',
            description='Output path 0',
            value=os.path.join(desc.Node.internalFolder, "0"),
            uid=[],
            group=""
        ),
        # desc.File(
        #     name='cameras',
        #     label='Cameras',
        #     description='Ouptut camera file',
        #     value=os.path.join(desc.Node.internalFolder, "0", "cameras.bin"),
        #     uid=[],
        #     group=""
        # ),
        desc.File(
            name='database_path',
            label='OutputDatabasePath',
            description='Output database path',
            value=os.path.join(desc.Node.internalFolder, 'colmap_database_mapper.db'),
            uid=[],
        ),

    ]

    def processChunk(self, chunk):
        shutil.copy2(chunk.node.input_database_path.value, chunk.node.database_path.value)
        desc.CommandLineNode.processChunk(self, chunk)
