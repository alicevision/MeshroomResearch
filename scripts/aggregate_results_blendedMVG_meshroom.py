#TODO: make this a CLI tool
import os
import numpy as np

if os.name == 'nt':
    RUN_OUTPUT_FOLDER = r"C:\\runs"
else:
    RUN_OUTPUT_FOLDER = "/s/prods/mvg/_source_global/users/hogm/meshroom_benchmark_outputs/"#"/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/low_res/meshroom_out"

sequences = [directory for directory in os.listdir(RUN_OUTPUT_FOLDER) if os.path.isdir(os.path.join(RUN_OUTPUT_FOLDER, directory))]

def agregate_results(csv_name):
    results_avg = []
    results_median = []
    header = "No valid csv"
    sequences_skipped = []
    for sequence in sequences:
        csv_file_path = os.path.join(RUN_OUTPUT_FOLDER, sequence, csv_name)
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
        data_calib = result[1:-2, 1:-1].astype(np.float32)#FIXME: second -1 shyould not be there?
        # avg = result[-2,1:-1].astype(np.float32)
        # med = result[-1:,1:-1].astype(np.float32) #FIXME: last ,?
        avg = np.nanmean(data_calib, axis =0)
        med =  np.nanmedian(data_calib, axis =0)
        if np.all(np.isnan(avg)) or np.all(np.isnan(med)):
            raise BaseException("Nan")
        #save only average
        results_avg.append(avg)
        results_median.append(med)
    return results_avg, results_median, header, sequences_skipped

def make_plot(csv_name):
    from matplotlib import pyplot as plt
    header = "No valid csv"
    sequences_skipped = []
  
    data_per_metric = None
    valid_sequences = []
    for sequence in sequences:
        csv_file_path = os.path.join(RUN_OUTPUT_FOLDER, sequence, csv_name)
        #make sure the computation when trhu
        if not os.path.exists(csv_file_path):
            print("Issue with sequence "+sequence+" file "+csv_file_path+" skipping")
            continue
        result = np.loadtxt(csv_file_path, dtype=str, delimiter=",")
        #split average/med from the  rest
        header = result[0,1:-1]
        if data_per_metric is None:
            data_per_metric = [[] for _ in header]
        data_calib = result[1:-2, 1:-1].astype(np.float32)#FIXME: second -1 shyould not be there?
        views = result[1:-2:, 0]
        for metric, metric_data, data in zip(header, data_per_metric, np.transpose(data_calib)):
            metric_data.append(data)
            # fig, ax = plt.subplots(figsize=(10, 10)) #
            # ax.boxplot([data])#, labels=[views])
            # ax.set_title(sequence+"_"+metric+'.png')
            # fig.savefig(os.path.join(RUN_OUTPUT_FOLDER, sequence+"_"+metric+'.png') )
        valid_sequences.append(sequence)

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
        MAX_MISSING = np.max(nb_missing_views)
        color_barplot = [ [n/MAX_MISSING,1-n/MAX_MISSING,0] for n in nb_missing_views]
        plotbox = ax.boxplot(valid_metric_data, 
                             labels=valid_sequences,
                             patch_artist=True)#, 
        for patch, color in zip(plotbox['boxes'], color_barplot):
            patch.set_facecolor(color)
        fig.savefig(os.path.join(RUN_OUTPUT_FOLDER, metric+'.png') )

        # fig.canvas.draw()
        # image_from_plot = np.frombuffer(fig.canvas.tostring_rgb(), dtype=np.uint8)
        # image_from_plot = image_from_plot.reshape(fig.canvas.get_width_height()[::-1] + (3,))
        # figures.append(image_from_plot)

    return figures, header, sequences_skipped

def save_results(csv_filename, header, results_avg, results_meds):
    with open(os.path.join(RUN_OUTPUT_FOLDER, csv_filename), 'w') as csv_file:
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

# make_plot("calibration_comparison.csv")
make_plot("depth_maps_comparison.csv")


calibs_results_avg, calibs_results_med, header_calib, sequences_skipped_calib = agregate_results("calibration_comparison.csv")
print("%d sequences skiped:"%len(sequences_skipped_calib))
print(sequences_skipped_calib)
depth_results_avg, depth_results_med, header_depth, sequences_skipped_depth = agregate_results("depth_maps_comparison.csv")
print("%d sequences skiped:"%len(sequences_skipped_depth))
print(sequences_skipped_depth)

save_results('all_calibration_comparison.csv', header_calib, calibs_results_avg, calibs_results_med)
save_results('all_depth_comparison.csv', header_depth, depth_results_avg, depth_results_med)
