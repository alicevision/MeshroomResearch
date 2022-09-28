__version__ = "1.0"

import json
from math import pi
import os
from mrrs.core.ios import matrices_from_sfm_data, open_exr, open_mesh
from mrrs.core.utils import get_label_colors
from meshroom.core import desc

from mrrs.mesh_decimation.segmentation_decimation import *

class SemanticDecimation(desc.Node):
    # cpu = desc.Level.NORMAL
    # ram = desc.Level.NORMAL

    category = 'Meshroom Research'#'Mesh Post-Processing'
    documentation = '''
This node allows to decimate the mesh using semantic segmentation.
'''

    inputs = [
        desc.File(
            name="input",
            label='Input Mesh (OBJ file format).',
            description='',
            value='',
            uid=[0],
            ),

        desc.File(
            name='inputSegmentationFolder',
            label='Input Segmentation Folder',
            description='Input folder containing the segmentation',
            value=desc.Node.internalFolder,
            uid=[],
        ),

        desc.File(
            name='inputSfmData',
            label='Input SfmData',
            description='Input sfm file containing camera calibration',
            value=desc.Node.internalFolder,
            uid=[],
        ),
        # desc.FloatParam(
        #     name='simplificationFactor',
        #     label='Simplification factor',
        #     description='Simplification factor',
        #     value=0.5,
        #     range=(0.0, 1.0, 0.01),
        #     uid=[0],
        # ),
        # desc.IntParam(
        #     name='nbVertices',
        #     label='Fixed Number of Vertices',
        #     description='Fixed number of output vertices.',
        #     value=0,
        #     range=(0, 1000000, 1),
        #     uid=[0],
        # ),
        # desc.IntParam(
        #     name='minVertices',
        #     label='Min Vertices',
        #     description='Min number of output vertices.',
        #     value=0,
        #     range=(0, 1000000, 1),
        #     uid=[0],
        # ),
        # desc.IntParam(
        #     name='maxVertices',
        #     label='Max Vertices',
        #     description='Max number of output vertices.',
        #     value=0,
        #     range=(0, 1000000, 1),
        #     uid=[0],
        # ),


        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
            uid=[],
        ),
    ]

    outputs = [
        desc.File(
            name="output",
            label="Output Folder",
            description="Output mesh forlder (OBJ file format).",
            value=desc.Node.internalFolder,
            uid=[],
            ),
    ]

    def check_inputs(self, chunk):#FIXME: todo
        if not chunk.node.input.value:
            chunk.logger.warning('No input in node SemanticDecimation, skipping')
            return False
        if not chunk.node.inputSegmentationFolder.value:
            chunk.logger.warning('No inputSegmentationFolder in node SemanticDecimation, skipping')
            return False
        # if not chunk.node.output.value:
        #     chunk.logger.warning('No outputs in node SemanticDecimation, skipping')
        #     return False
        return True

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            if not self.check_inputs(chunk):
                return
            chunk.logger.info('Starting Semantic Decimation')

            chunk.logger.info('Opening mesh')
            mesh_file = chunk.node.input.value
            mesh = open_mesh(mesh_file)
            #uv coordinates mesh.metadata['vertex_texture']
            #mesh = [mesh.vertices, mesh.faces]

            chunk.logger.info('Parsing poses')
            with open(chunk.node.inputSfmData.value,"r") as json_file:
                sfm_data= json.load(json_file)
            (extrinsics, intrinsics, views_id,
            poses_id, intrinsics_id, pixel_sizes) = matrices_from_sfm_data(sfm_data)#FIXME: intrinsics can be unique?

            chunk.logger.info('Opening segmentation')
            #FIXME: harcoded fiel name , to be moved
            segmentation_files = [os.path.join(chunk.node.inputSegmentationFolder.value,
                                  view_id+"_segmentation.exr") for view_id in views_id]
            segmentations = []
            classes_names = set(["unlabeled"])
            for segmentation_file in segmentation_files:#loading segmentation maps
                logging.info("Opening "+segmentation_file)
                segmentation_values, header = open_exr(segmentation_file)
                segmentation_labels = list(header["channels"].keys())
                classes_names.update(segmentation_labels)
                # segmentation_labels.insert(0, "unlabeled")#add a no label label (different from not observed '')
                segmentation_labels = np.asarray(segmentation_labels)
                #convert from one hot to class index (! does not suport overlapping)
                segmentation = np.argmax(segmentation_values, axis=2)
                segmentation=segmentation_labels[segmentation]#convert to string label FIXME: inneficient
                segmentations.append(segmentation)
            classes_names = list(classes_names)
            #FIXME test
            # output_face_index_buffer = rasterize_triangle_accumulation(mesh, extrinsics, intrinsics, pixel_sizes, segmentation.shape)

            chunk.logger.info('Decimating')
            def remove_all_decimation(mesh):
                vertices, faces = mesh
                return [], []
            def identity_decimation(mesh):
                return mesh

            #TODO: encode strings labels to uints or int for speed
            labels_decimation_strategies = {"person", remove_all_decimation}#FIXME should be parameter, see with fabien how we create table and have at least, identity, remove and decimation with coef

            _,_, vertices_label = hard_segmentation_decimation(mesh, segmentations, extrinsics,
                                                               intrinsics, pixel_sizes, labels_decimation_strategies,
                                                               classes_names=classes_names)
            vertices_label = np.asarray(vertices_label)
            # export result debug
            unique_labels = np.unique(vertices_label) #FIXME: use get_label_colors
            colormap = {l: np.random.rand(3) for l in  unique_labels}
            with open(os.path.join(chunk.node.output.value, "vertices_labels.obj"), 'w') as f:
                for p,l in zip(mesh[0], vertices_label.tolist()):
                    c = colormap[l]
                    f.write("v "+' '.join(map(str, p))+" "+' '.join(map(str, c))+"\n") #meshlab format support adding colors right after the vertex

            chunk.logger.info('Semantic Decimation end')
        finally:
            chunk.logManager.end()

