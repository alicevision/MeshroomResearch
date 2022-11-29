echo "Hello"

#rez env meshroom-develop mrrs colmap

#input_folder=/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/
#output_folder=/s/prods/mvg/_source_global/users/hogm/meshroom_benchmark_outputs_test

input_folder=/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/low_res/BlendedMVS
output_folder=/s/prods/mvg/_source_global/users/hogm/meshroom_benchmark_outputs

#submit="-s"
submit="-s"

#init projects
#python ../clis/benchmark.py run $input_folder -o $output_folder  -r -c -s -u BlendedMVGDataset_1

#all branch gt
#python ../clis/benchmark.py run $input_folder -o $output_folder  -r -c -s -u Texturing_2
#meshrooms
#python ../clis/benchmark.py run $input_folder -o $output_folder -r -c -s -u Texturing_4
#python ../clis/benchmark.py run $input_folder -o $output_folder -r -c -s -u Texturing_6
#colmap sfm
#python ../clis/benchmark.py run $input_folder -o $output_folder -r -c -s -u ColmapMapper

#run comparisons and publish
#python ../clis/benchmark.py run $input_folder -o $output_folder -r -c $submit -u Publish

#generate report
python ../clis/benchmark.py report $output_folder -o $output_folder/meshroom_results
python ../clis/benchmark.py report $output_folder -o $output_folder/colmap_results -n "calibration_comparison_colmap.csv"
