"""
This node runs comparison between two input calibration.
"""
__version__ = "3.0"

import os
import json

from meshroom.core import desc

from mrrs.core.ios import *
from mrrs.metrics.metrics import *

class CalibrationComparison(desc.Node):
    category = 'Meshroom Research'

    documentation = '''For each camera, compare its estimated parameters with a given groud truth.'''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.File(
            name='inputSfMGT',
            label='GtSfMData',
            description='Ground Truth SfMData file.',
            value='',
        ),

        desc.ChoiceParam(
            name='metrics',
            label='Metrics',
            description='Metrics to be used in the comparison.',
            value=['MSECameraCenter'],
            values=['MSECameraCenter','AngleBetweenRotations','MSEFocal', 'MSEPrincipalPoint', 'validCams'],
            exclusive=False,
            joinChar=',',
        ),

         desc.StringParam(
            name='csv_name',
            label='CsvName',
            description='Name for the csv file to be used.',
            value="calibration_comparison.csv",
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='Output Folder',
            description='Output folder for generated results.',
            value="{nodeCacheFolder}",
        ),
        desc.File(
            name='outputCsv',
            label='Output Csv',
            description='Output file to generated results.',
            value=lambda attr: os.path.join("{nodeCacheFolder}", attr.node.csv_name.value),
        )
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputSfM.value:
            chunk.logger.warning('No inputSfM in node DepthMapComparison, skipping')
            return False
        if not chunk.node.inputSfMGT.value:
            chunk.logger.warning('No inputSfMGT in node DepthMapComparison, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Computes the different metrics on the input and groud truth depth maps.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            #open inputs
            if not self.check_inputs(chunk):
                return

            sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
            sfm_data_gt=json.load(open(chunk.node.inputSfMGT.value,"r"))
            views_ids = [view["viewId"] for view in sfm_data["views"]]
            views_ids_gt = [view["viewId"] for view in sfm_data_gt["views"]]
            if len(views_ids_gt) != len(views_ids):
                raise RuntimeError("Mismatching number of views (%d vs %d"%(len(views_ids), len(views_ids_gt)))
            #getting calib in matrix form (along with id)
            extrinsics, intrinsics, poses_id, intrinsics_id, _, _ = matrices_from_sfm_data(sfm_data)
            extrinsics_gt, intrinsics_gt, poses_id_gt, intrinsics_id_gt, _, _ = matrices_from_sfm_data(sfm_data_gt)

            chunk.logger.info('Computing metrics for %d calibrations'%len(sfm_data['views']))
            metrics = chunk.node.metrics.value
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
                # chunk.logger.info('Computing metrics for view %d/%d (%s,%s)'%(index, len(views_ids),view_id,views_ids_gt[index_gt[0][0]]))
                index_gt = index_gt[0][0]#FIXME: sanity check more than 1
                extrinsic_gt = extrinsics_gt[index_gt]
                intrinsic_gt = intrinsics_gt[index_gt]
                #metric computation
                metric_values = []
                for metric in metrics:
                    chunk.logger.info("Computing "+metric)
                    metric_value = compute_calib_metric(metric, extrinsic, intrinsic, extrinsic_gt, intrinsic_gt)
                    chunk.logger.info(str(metric_value))
                    metric_values.append(metric_value)
                computed_metric_values.append(metric_values)
            #stack up and compute average on dataset
            computed_metric_values = np.asarray(computed_metric_values)
            average_metric_values = np.nanmean(computed_metric_values, axis=0)
            median_metric_values = np.nanmedian(computed_metric_values, axis=0)
            #write output file
            os.makedirs(chunk.node.outputFolder.value, exist_ok=True)

            with open(chunk.node.outputCsv.value, "w") as csv_file:
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
            chunk.logger.info('Calib comparison ends')
        finally:
            chunk.logManager.end()
