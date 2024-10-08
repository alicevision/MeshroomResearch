__version__ = "3.0"

import logging
import os
import json
import numpy as np

from meshroom.core import desc

from mrrs.core.ios import open_depth_map, save_exr
from mrrs.metrics.metrics import compute_depth_metric

class DepthMapComparison(desc.Node):

    # size = desc.DynamicNodeSize('inputSfM')
    category = 'Meshroom Research'

    documentation = '''For each camera, compare its depth maps to a given ground truth.
The names of the original inputSfM file is used to retrieve the GT file, therefore must match.
The depth maps are assumed to be estimated with the same inputSfM poses.
Autorescale may be used otherwise but it is far from ideal.
'''

    inputs = [
        desc.File(
            name='inputSfM',
            label='SfMData',
            description='SfMData file.',
            value='',
        ),

        desc.File(
            name="depthMapsFolder",
            label="DepthMaps Folder",
            description="Input depth maps folder.",
            value="",
        ),

        desc.File(
            name="depthMapsFolderGT",
            label="GT DepthMaps Folder",
            description="Input ground truth depth maps folder.",
            value="",
        ),

        desc.ChoiceParam(
            name='metrics',
            label='Metrics',
            description='Metrics to be used in the comparison.',
            value=['RMSE', 'MAE', 'validity_ratio'],
            values=['RMSE', 'MAE', 'validity_ratio'],
            exclusive=False,
            joinChar=',',
        ),

        desc.BoolParam(
            name='autoRescale',
            label='Auto Rescale',
            description='''Will attempt to find a scale factor between GT depth maps and estimated depth maps. To be used when the depth maps have not been estimated from the same camera coordinate system.''',
            value=False,
        ),

        desc.StringParam(
            name='maskValue',
            label='Mask Value',
            description='''If this is not None, will mask the pixels with value bellow this (in gt and estimated).''',
            value='0',
        ),

        desc.StringParam(
            name='csv_name',
            label='CsvName',
            description='Name for the csv file to be used.',
            value="depth_map_comparison.csv",
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''Verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='output',
            label='Output',
            description='Output folder for generated results.',
            value=desc.Node.internalFolder,
        ),
        desc.File(
            name='outputCsv',
            label='Output Csv',
            description='Output file to generated results.',
            value=lambda attr: os.path.join(desc.Node.internalFolder, attr.node.csv_name.value),
        )
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputSfM.value:
            chunk.logger.warning('No inputSfM in node DepthMapComparison, skipping')
            return False
        if not chunk.node.depthMapsFolder.value:
            chunk.logger.warning('No depthMapsFolder in node DepthMapComparison, skipping')
            return False
        if not chunk.node.depthMapsFolderGT.value:
            chunk.logger.warning('No depthMapsFolderGT in node DepthMapComparison, skipping')
            return False
        return True

    def parse_inputs(self, chunk):
        """
        Opens the necessary files and folders.
        """
        sfm_data=json.load(open(chunk.node.inputSfM.value,"r"))
        views_ids = [view["viewId"] for view in sfm_data["views"]]
        depth_folder = chunk.node.depthMapsFolder.value
        depth_files = [os.path.join(depth_folder, str(views_id)+"_depthMap.exr") for views_id in views_ids]#FIXME: hardcoded filename
        #open from folder (needs to have matching file names)
        depth_gt_files = [os.path.join(chunk.node.depthMapsFolderGT.value, view_id+"_depthMap.exr")
                             for view_id in views_ids]
  
        if len(depth_files) != len(depth_gt_files):
            raise BaseException("Mismatching number of depth maps in source and ground truth folders (%d vs %d"%(len(depth_files), len(depth_gt_files)))

        return views_ids, depth_files, depth_gt_files, [view["path"] for view in sfm_data["views"]]


    def processChunk(self, chunk):
        """
        Computes the different metrics on the inputSfM and groud truth depth maps.
        """
    
        chunk.logManager.start(chunk.node.verboseLevel.value)
        #open inputs
        if not self.check_inputs(chunk):
            return
        views_ids, depth_files, depth_gt_files, view_path = self.parse_inputs(chunk)
        chunk.logger.info('Computing metrics for %d depths maps'%len(depth_files))
        metrics = chunk.node.metrics.value
        auto_rescale = chunk.node.autoRescale.value
        mask_value=chunk.node.maskValue.value
        if (mask_value == "") or (mask_value is None):
            mask_value = None
        else:
            mask_value = float(mask_value)
            chunk.logger.info('Will ignore depth values <%f'%mask_value)

        #compute metrics
        computed_metric_values = []
        for index, (view_id, depth_file, depth_gt_file, vp) in enumerate(zip(views_ids, depth_files, depth_gt_files, view_path)):
            chunk.logger.info('Computing metrics for depth maps %d/%d: %s and %s'%(index, len(depth_files), depth_file, depth_gt_file))

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
                    save_exr(metric_per_pixel, os.path.join(chunk.node.output.value, view_id+"_distance_"+metric+"_depthMap.exr"))
            computed_metric_values.append(metric_values)

        #stack up and compute average on dataset
        computed_metric_values = np.asarray(computed_metric_values)
        average_metric_values = np.mean(computed_metric_values, axis=0)
        median_metric_values = np.median(computed_metric_values, axis=0)
        #write output file
        os.makedirs(chunk.node.output.value, exist_ok=True)
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

        chunk.logger.info('Depth map comparison end')


