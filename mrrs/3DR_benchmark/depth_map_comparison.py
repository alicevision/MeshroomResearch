import json
import logging
import argparse
import os

from mrrs.core.ios import open_depth_map, save_exr
from metrics.metrics import compute_depth_metric

import numpy as np

parser = argparse.ArgumentParser()
parser.add_argument(
    '-i', '--inputSfM',
    help="",
)
parser.add_argument(
    '-f', '--depthMapsFolder',
    help="", 
)
parser.add_argument(
    '-g', '--depthMapsFolderGT',
    help="", 
)
parser.add_argument(
    '-m', '--metrics',
    help="", 
)

parser.add_argument(
    '-r', '--autoRescale',
    help="", 
)

parser.add_argument(
    '-k', '--maskValue',
    help="", 
)

parser.add_argument(
    '-o', '--outputCsv',
    help="", 
)

parser.add_argument(
    '-v', '--verboseLevel',
    help="Verbose level",
)

args = parser.parse_args()    

input_sfm=args.inputSfM
depth_folder = args.depthMapsFolder
depth_folder_gt = args.depthMapsFolderGT
metrics = args.metrics.split(",")
outputCsv = args.outputCsv
auto_rescale = bool(args.autoRescale)
mask_value = args.maskValue

sfm_data=json.load(open(input_sfm,"r"))
views_ids = [view["viewId"] for view in sfm_data["views"]]

depth_files = [os.path.join(depth_folder, str(views_id)+"_depthMap.exr") for views_id in views_ids]#FIXME: hardcoded filename
#open from folder (needs to have matching file names)
depth_gt_files = [os.path.join(depth_folder_gt, view_id+"_depthMap.exr")
                        for view_id in views_ids]

if len(depth_files) != len(depth_gt_files):
    raise BaseException("Mismatching number of depth maps in source and ground truth folders (%d vs %d"%(len(depth_files), len(depth_gt_files)))

view_path = [view["path"] for view in sfm_data["views"]]

print('Computing metrics for %d depths maps'%len(depth_files))


if (mask_value == "") or (mask_value is None):
    mask_value = None
else:
    mask_value = float(mask_value)
    print('Will ignore depth values <%f'%mask_value)

#compute metrics
computed_metric_values = []
for index, (view_id, depth_file, depth_gt_file, vp) in enumerate(zip(views_ids, depth_files, depth_gt_files, view_path)):
    print('Computing metrics for depth maps %d/%d: %s and %s'%(index, len(depth_files), depth_file, depth_gt_file))

    if not os.path.exists(depth_file):
        logging.warning("Depth map for view "+view_id+" was not computed (likely because the SfM was not able to compute a pose)")
        computed_metric_values.append([np.nan for _ in metrics])
        continue
    depth_map = open_depth_map(depth_file)
    depth_map_gt = open_depth_map(depth_gt_file)

    #metric computation
    metric_values = []
    for metric in metrics:
        metric_value, metric_per_pixel, processed_depth_map_gt = compute_depth_metric(depth_map, depth_map_gt, metric,
                                                                                        auto_resize=True, auto_rescale=auto_rescale, mask_value=mask_value)#FIXME: need to make sure the depth is at the same scale
        metric_values.append(metric_value)
        #usefull display
        if metric_per_pixel is not None:
            save_exr(metric_per_pixel, os.path.join(os.path.dirname(outputCsv), view_id+"_distance_"+metric+"_depthMap.exr"))
    computed_metric_values.append(metric_values)

#stack up and compute average on dataset
computed_metric_values = np.asarray(computed_metric_values)
average_metric_values = np.mean(computed_metric_values, axis=0)
median_metric_values = np.median(computed_metric_values, axis=0)
#write output file
os.makedirs(os.path.dirname(outputCsv), exist_ok=True)
with open(outputCsv, "w") as csv_file:
    #header
    csv_file.write("View,")
    for metric in metrics:
        csv_file.write(metric+",")
    csv_file.write("\n")
    #values
    for view_id, metric_values in zip(views_ids, computed_metric_values):
        csv_file.write(view_id+",")
        for metric_value in metric_values:
            csv_file.write("%f,"%metric_value)
        csv_file.write("\n")
    #average and median value
    csv_file.write("average,")
    for average_metric_value in average_metric_values:
        csv_file.write("%f,"%average_metric_value)
    csv_file.write("\n")
    csv_file.write("median,")
    for median_metric_value in median_metric_values:
        csv_file.write("%f,"%median_metric_value)

print('Depth map comparison end')


