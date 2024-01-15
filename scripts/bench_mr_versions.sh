
# Script to run a benchmark on different meshroom versions

#params
#ptut
project='/s/prods/mvg/_source_global/users/hogm/test_runs/ptut_template.mg'
dataset_folder='/s/prods/mvg/_source_global/users/hogm/datasets/ptut/'
output_folder='/s/prods/mvg/_source_global/users/hogm/test_runs/bench_versions'
submit="--submit"
# compute="yes"

#scanning for envs
#note: meshroom-2023.2.0 has an issue fixed in older v, 
list_env="meshroom-2023.1.0 meshroom-2023.3.0"
# list_env=`rez search meshroom | grep meshroom-2023.*`
list_dataset=`ls $dataset_folder`
echo "Versions: " $list_env
echo "Datasets: " $list_dataset
echo "-------"

# #loop on vertions
# for v in $list_env
#     do  
#     echo -e " \033[0;32m testing env: \033[0m" $v
#     if ! rez env $v mrrs-develop -- echo " checking env"; 
#         then
#         echo -e " \033[0;31m /!\\" $v " failed, skipping \033[0m"
#         continue    
#         fi 
#     echo -e " \033[0;32m ok \033[0m"
#     echo -e " \033[0;32m Running bench \033[0m"
#     #loop on dataset
#     for f in $list_dataset
#         do  
#         echo "  Testing on dataset:" $f
#         #creating ouput folder
#         mkdir -p "$output_folder/$v/$f/"
#         #running projetc
#         input_folder="$dataset_folder/$f/img/beauty"
#         #echo $input_folder
#         output_project="$output_folder/$v/$f/project.mg"
#         rez env $v mrrs-develop -- meshroom_batch $submit -p $project --input $input_folder --output $output_folder/$v/$f --save $output_project 
#         #--compute $compute
#         #create the script to open the project easily
#         echo "rez env $v mrrs-develop -- meshroom " $output_project > $output_folder/$v/$f/open.sh
#         done
#     done

#aggregating results
echo "Make sure the computation is done and press any key to continue" 
read is_ready
csv_timeline=""
for v in $list_env
    do  
    echo -e " \033[0;32m reporting for env: \033[0m" $v
    rez env mrrs-develop -- benchmark report "$output_folder/$v" -n "calibration_comparison.csv" -r "$v.csv"
    csv_timeline+="$output_folder/$v/$v.csv "
    done
echo "Timeliming for :" $csv_timeline
rez env mrrs-develop -- benchmark timeline $csv_timeline
