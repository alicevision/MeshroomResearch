import json
import logging
import argparse
import os

import numpy as np

from mrrs.core.ios import matrices_from_sfm_data
from metrics.metrics import compute_calib_metric


parser = argparse.ArgumentParser()
parser.add_argument(
    '-i', '--inputSfM',
    help="",
)
parser.add_argument(
    '-g', '--inputSfMGT',
    help="", 
)
parser.add_argument(
    '-o', '--outputCsv',
    help="", 
)
parser.add_argument(
    '-m', '--metrics',
    help="", 
)

parser.add_argument(
    '-v', '--verboseLevel',
    help="Verbose level",
)
args = parser.parse_args()    


input_sfm=args.inputSfM
gt_sfm=args.inputSfMGT
metrics=args.metrics.split(",")
outputCsv=args.outputCsv

sfm_data=json.load(open(input_sfm,"r"))
sfm_data_gt=json.load(open(gt_sfm,"r"))
views_ids = [view["viewId"] for view in sfm_data["views"]]
views_ids_gt = [view["viewId"] for view in sfm_data_gt["views"]]
if len(views_ids_gt) != len(views_ids):
    raise RuntimeError("Mismatching number of views (%d vs %d"%(len(views_ids), len(views_ids_gt)))
#getting calib in matrix form (along with id)
extrinsics, intrinsics, poses_id, intrinsics_id, _, _ = matrices_from_sfm_data(sfm_data)
extrinsics_gt, intrinsics_gt, poses_id_gt, intrinsics_id_gt, _, _ = matrices_from_sfm_data(sfm_data_gt)

logging.info('Computing metrics for %d calibrations'%len(sfm_data['views']))

#compute metrics
computed_metric_values = []
for index, (view_id, extrinsic, intrinsic) in enumerate(zip(views_ids, extrinsics, intrinsics)):
    if (extrinsic is None) or (intrinsic is None):
        logging.warning("Calibration view "+view_id+" was not computed (likely because the SfM was not able to compute a pose)")
        computed_metric_values.append([0 if m=="validCams" else np.nan for m in metrics])
        continue
    #retrieve corresponding GT from id
    index_gt = np.where(view_id==np.asarray(views_ids_gt))
    if index_gt[0].size == 0:
        logging.warning("View "+view_id+" not present in groud truth sfm, skipping")
        continue
    # logging.info('Computing metrics for view %d/%d (%s,%s)'%(index, len(views_ids),view_id,views_ids_gt[index_gt[0][0]]))
    index_gt = index_gt[0][0]#FIXME: sanity check more than 1
    extrinsic_gt = extrinsics_gt[index_gt]
    intrinsic_gt = intrinsics_gt[index_gt]
    #metric computation
    metric_values = []
    for metric in metrics:
        logging.info("Computing "+metric)
        metric_value = compute_calib_metric(metric, extrinsic, intrinsic, extrinsic_gt, intrinsic_gt)
        logging.info(str(metric_value))
        metric_values.append(metric_value)
    computed_metric_values.append(metric_values)
#stack up and compute average on dataset
computed_metric_values = np.asarray(computed_metric_values)
average_metric_values = np.nanmean(computed_metric_values, axis=0)
median_metric_values = np.nanmedian(computed_metric_values, axis=0)
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
