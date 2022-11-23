"""
Runs benchmark.
"""
import os
import shutil
import glob
import subprocess

import numpy as np
import click

#Setup command line
meshroom_batch_cl = "meshroom_batch"
MESHROOM_ROOT = os.getenv("MESHROOM_INSTALL_DIR")
if MESHROOM_ROOT is not None:
    print("MESHROOM_INSTALL_DIR set, will use it")
    meshroom_batch_cl = "python "+MESHROOM_ROOT+"/bin/meshroom_batch"
else:
    print("Will call meshroom_batch directly")

#Auto detect and set paths
this_file_path = os.path.abspath(__file__)
DEFAULT_MESHROOM_PIPELINE = os.path.abspath(os.path.join(this_file_path, "../../pipelines/benchmark/benchmark.mg"))
#no need, should be setup by user
# MESHROOM_NODES_PATH = os.path.abspath(os.path.join(this_file_path, "../../mrrs/nodes/"))

#cli group
@click.group()#chain=True)
def cli():
    print('Hello!')


#run the bench
@cli.command()
@click.option('--output_folder','-o', default="./", help='Output folder to generate results into.')
@click.option('--pipeline', '-p', default=DEFAULT_MESHROOM_PIPELINE, help='Path to the benchmark pipeline.')
@click.option('--delete_folders', '-d', is_flag=True, help='Force clean the content of outputs folder.')
@click.option('--dataset_type', '-t',  type=click.Choice(['blendedMVS'], case_sensitive=False), default= "blendedMVS")
@click.option('--compute', '-c', is_flag=True, help='Runs the computation. Will just create project otherwise.')
@click.option('--resume', '-r', is_flag=True, help='Resumes computation if a folder exists, will skip folder otherwise.')
@click.option('--submit', '-s', is_flag=True, help='Will submit the computation on the grid.')
@click.option('--up_to_node', '-u', default="Publish", help='If computation is enabled, will compute up to the passed node.')
@click.option('--environnement', '-e', default=None, help='Runs in the specified environnement')
@click.argument('dataset_path')
def run(pipeline, output_folder,
        delete_folders, dataset_type,
        compute, resume, submit, up_to_node,
        environnement,
        dataset_path):
    """
    Will run the passed pipeline on the passed dataset.
    """
    print("Running benchmark")
    scene_folders = os.listdir(dataset_path)
    for scene_index, scene_folder in enumerate(scene_folders):
        print("Running meshroom for scene %s %d/%d"%(scene_folder, scene_index, len(scene_folders)))
        #data preparation for specific datasets
        if dataset_type=="blendedMVS":
            input_folder = os.path.join(dataset_path, scene_folder, "blended_images")
            invalid_images = list(set(glob.glob(os.path.join(input_folder, "*")))-set(glob.glob(os.path.join(input_folder, "????????.jpg"))))
            image_folder = os.path.join(input_folder, scene_folder, "other")
            os.makedirs(image_folder, exist_ok=True)
            for invalid_image in invalid_images:
                if os.path.isfile(invalid_image):
                    shutil.move(invalid_image, image_folder)
        else:
            raise RuntimeError("Unknown dataset type")
        #folder handling
        scene_output_folder = os.path.abspath(os.path.join(output_folder, scene_folder))
        if os.path.exists(scene_output_folder):
            if delete_folders:
                shutil.rmtree(scene_output_folder)
            else:
                print("Folder for "+scene_folder+"already exists:")
                if not resume:
                    print("Skipping")
                    continue
                print("Resuming")
        os.makedirs(scene_output_folder, exist_ok=True)
        #run cli # +" --forceCompute" #TODO?
        executable=""
        if environnement:
            executable+="conda activate "+environnement+" && "
        executable += meshroom_batch_cl
        arguments = " -i \""+input_folder+"\""+" -p "+pipeline \
                   +" -o \""+scene_output_folder+"\" --cache \""+scene_output_folder+"/MeshroomCache\""\
                   +" --save \""+os.path.join(scene_output_folder,"project.mg")+"\""\
                   +" --verbose trace"
        if compute:
            print("Will compute")
            arguments += " --compute 1"
        else:
            arguments += " --compute 0"
        if submit:
            arguments += " --submit "
        if up_to_node is not None:
            arguments += " --toNode "+up_to_node
        command = executable+" "+arguments#TODO: see if we cant direclty call api
        print(command)
        #os.system(command)
        subprocess.Popen(command, shell=True).wait()

#aggregate results and make report
@cli.command()
@click.option('--output_folder','-o', default=None, help='Output folder to generate reports into.')
@click.option('--csv_names','-n', multiple=True, default=["calibration_comparison.csv", "depth_maps_comparison.csv"], help='Csvs to use for reporting.')
@click.argument('computed_outputs_path')#FIXME: inherit from group?
def report(output_folder, computed_outputs_path, csv_names):
    """
    Generate a report from a computed benchmark.
    """
    print("Making report from benchmark")
    sequences = [directory for directory in os.listdir(computed_outputs_path)
                 if os.path.isdir(os.path.join(computed_outputs_path, directory))]
    if output_folder is None:
        output_folder = computed_outputs_path
    print("%d sequences found"%len(sequences))

    os.makedirs(output_folder, exist_ok=True)

    def agregate_results(csv_name):
        """
        Agregate results from a given CSV
        """
        results_avg = []
        results_median = []
        header = "No valid csv"
        sequences_skipped = []
        for sequence in sequences:
            csv_file_path = os.path.join(computed_outputs_path, sequence, csv_name)
            #make sure the computation when trhu
            if not os.path.exists(csv_file_path):
                print("Issue with sequence "+sequence+" file "+csv_file_path+" skipping")
                results_avg.append("")
                results_median.append("")
                sequences_skipped.append(sequence)
                continue
            result = np.loadtxt(csv_file_path, dtype=str, delimiter=",")
            #split average/med from the  rest
            header = result[0,:-1]
            data_calib = result[1:-2, 1:-1].astype(np.float32)
            avg = np.nanmean(data_calib, axis =0)
            med =  np.nanmedian(data_calib, axis =0)
            if np.all(np.isnan(avg)) or np.all(np.isnan(med)):
                raise BaseException("Nan")
            #save only average
            results_avg.append(avg)
            results_median.append(med)
        return results_avg, results_median, header, sequences_skipped

    def make_plot(csv_name):
        """
        Makes a mustache box from the csv.
        """
        from matplotlib import pyplot as plt #FIXME, make option to plot to justify lazy import
        header = "No valid csv"
        data_per_metric = None
        valid_sequences = []
        for sequence in sequences:
            csv_file_path = os.path.join(computed_outputs_path, sequence, csv_name)
            #make sure the computation when trhu
            if not os.path.exists(csv_file_path):
                print("Issue with sequence "+sequence+" file "+csv_file_path+" skipping")
                continue
            result = np.loadtxt(csv_file_path, dtype=str, delimiter=",")
            #split average/med from the  rest
            header = result[0,1:-1]
            if data_per_metric is None:
                data_per_metric = [[] for _ in header]
            data_calib = result[1:-2, 1:-1].astype(np.float32)
            views = result[1:-2:, 0]
            for metric, metric_data, data in zip(header, data_per_metric, np.transpose(data_calib)):
                metric_data.append(data)
                # fig, ax = plt.subplots(figsize=(10, 10)) #
                # ax.boxplot([data])#, labels=[views])
                # ax.set_title(sequence+"_"+metric+'.png')
                # fig.savefig(os.path.join(RUN_OUTPUT_FOLDER, sequence+"_"+metric+'.png') )
            valid_sequences.append(sequence)
        if data_per_metric is None:
            raise RuntimeError("No valid data was found. Check the computation.")
        figures = []
        for metric, metric_data in zip(header, data_per_metric):
            fig, ax = plt.subplots(figsize=(40, 20))
            ax.spines['top'].set_visible(False)
            ax.spines['right'].set_visible(False)
            ax.spines['left'].set_visible(False)
            ax.yaxis.set_ticks_position('none')
            ax.set_title(metric)
            plt.xticks(rotation=-90)
            ax.set_yscale('log')

            nb_missing_views = [np.count_nonzero(np.isnan(data) )for data in metric_data ]
            valid_metric_data = [data[~np.isnan(data)] for data in metric_data ]
            max_missing = np.max(nb_missing_views)
            color_barplot = [ [n/max_missing, 1-n/max_missing, 0] for n in nb_missing_views]
            plotbox = ax.boxplot(valid_metric_data,
                                labels=valid_sequences,
                                patch_artist=True)#,
            for patch, color in zip(plotbox['boxes'], color_barplot):
                patch.set_facecolor(color)
            fig.savefig(os.path.join(output_folder, metric+'.png') )

            # fig.canvas.draw()
            # image_from_plot = np.frombuffer(fig.canvas.tostring_rgb(), dtype=np.uint8)
            # image_from_plot = image_from_plot.reshape(fig.canvas.get_width_height()[::-1] + (3,))
            # figures.append(image_from_plot)

        # return figures, header, sequences_skipped

    def save_results(csv_filename, header, results_avg, results_meds):
        with open(os.path.join(output_folder, csv_filename), 'w') as csv_file:
            #header
            for metric in header:
                csv_file.write("avg "+metric+",")
            for metric in header[1:]:
                csv_file.write("med "+metric+",")
            csv_file.write('\n')
            for sequence, avgs, meds in zip(sequences, results_avg, results_meds):
                csv_file.write(sequence+",")
                for avg in avgs:
                    csv_file.write(str(avg)+",")
                for med in meds:
                    csv_file.write(str(med)+",")
                csv_file.write("\n")

    #FIXME: hardcoded nodes names

    #Save csvs
    print("Collecting numerical results for ...")
    #calibs_results_avg, calibs_results_med, header_calib, sequences_skipped_calib = agregate_results("calibration_comparison.csv")
    #print("%d sequences skiped:"%len(sequences_skipped_calib))
    #print(sequences_skipped_calib)
    depth_results_avg, depth_results_med, header_depth, sequences_skipped_depth = agregate_results("depth_maps_comparison.csv")
    #print("%d sequences skiped:"%len(sequences_skipped_depth))
    #print(sequences_skipped_depth)
    #save_results('all_calibration_comparison.csv', header_calib, calibs_results_avg, calibs_results_med)
    #save_results('all_depth_comparison.csv', header_depth, depth_results_avg, depth_results_med)
    for csv_name in csv_names:
        print("\t"+csv_name)
        results_avg, results_med, header, sequences_skipped_calib = agregate_results(csv_name)
        print("\t%d sequences skiped:"%len(sequences_skipped_calib))
        print("\t"+str(sequences_skipped_calib))
        save_results("all_"+csv_name, header, results_avg, results_med)

    #Make plots
    print("Making pretty plots for ...")
    for csv_name in csv_names:
        print("\t"+csv_name)
        make_plot(csv_name)
    #make_plot("calibration_comparison.csv")
    #make_plot("depth_maps_comparison.csv")

if __name__ == '__main__':
    cli()
