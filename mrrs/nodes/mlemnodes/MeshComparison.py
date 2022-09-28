__version__ = "1.0"
import os
import numpy as np
from meshroom.core import desc
from mrrs.core.geometry import random_sample_points_mesh
from mrrs.core.ios import open_mesh
from mrrs.core.utils import time_it
from mrrs.metrics.metrics import chamfer_distance

def CHAMFER(mesh_0, mesh_1, iterations=10, target_nb_samples=100000):
    """
    Compares two mesh by randomly sampling points on the surfaces and computing the champfer distance bewteen two ploint cloud
    """
    chamfer_distances = []
    for _ in range(iterations):
        with time_it() as t:
            points_mesh_0 = random_sample_points_mesh(mesh_0, target_nb_samples)
        print("Point sampling done in %fs"%t)
        with time_it() as t:
            points_mesh_1 = random_sample_points_mesh(mesh_1, target_nb_samples)
        print("Point sampling done in %fs"%t)
        #debug
        # import os
        # with open(os.path.join("test_mesh0.obj"), 'w') as f:
        #     for p in points_mesh_0:
        #         f.write("v "+' '.join(map(str, p))+"\n")
        # with open(os.path.join("test_mesh1.obj"), 'w') as f:
        #     for p in points_mesh_1:
        #         f.write("v "+' '.join(map(str, p))+"\n")
        with time_it() as t:
            chamfer_distances.append(chamfer_distance(points_mesh_0, points_mesh_1))
        print("Champfer distance done in %fs"%t)
    return chamfer_distances#np.mean(chamfer_distances)

def compare_meshes(metric, mesh_0, mesh_1):
    return eval(metric)(mesh_0, mesh_1)

class MeshComparison(desc.Node):
    category = 'Meshroom Research'

    documentation = '''Compares two meshes with the champfer distance'''

    inputs = [
        desc.File(
            name="inputMesh0",
            label='Input Mesh 0',
            description='First mesh to be compared, ideally the generated mesh',
            value='',
            uid=[0],
            ),
        desc.File(
            name="inputMesh1",
            label='Input Mesh 1',
            description='Second mesh to be compared, ideally the ground truth',
            value='',
            uid=[0],
            ),

        #for chamfer
        desc.IntParam(
            name='nbSamples',
            label='Number of Samples',
            description='Fixed number of output vertices.',
            value=100000,
            range=(0, 1000000, 1),
            uid=[0],
        ),

        desc.IntParam(
            name='nbIterations',
            label='Number of Iterations',
            description='Fixed number of output vertices.',
            value=10,
            range=(0, 1000, 1),
            uid=[0],
        ),

        # desc.BoolParam(
        #     name='Bounding Box from GT',
        #     label='bbFromGT',
        #     description='Will remove the vertices and faces outside of the bounding box defined from the GT',
        #     value=False,
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
            name="outputFolder",
            label="Output Folder",
            description="Output folder to place to comparison results.",
            value=desc.Node.internalFolder,
            uid=[],
            ),
    ]

    def check_inputs(self, chunk):
        """
        Checks that all inputs are properly set.
        """
        if not chunk.node.inputMesh0.value:
            chunk.logger.warning('No inputMesh0 in node MeshComparison, skipping')
            return False
        if not chunk.node.inputMesh1.value:
            chunk.logger.warning('No inputMesh1 in node MeshComparison, skipping')
            return False
        return True

    def processChunk(self, chunk):
        """
        Computes the different metrics on the input and groud truth depth maps.
        """
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)

            mesh_path_0 = chunk.node.inputMesh0.value
            mesh_path_1 = chunk.node.inputMesh1.value
            mesh_0 = open_mesh(mesh_path_0)
            mesh_1 = open_mesh(mesh_path_1)

            chunk.logger.info('Computing metric between mesh %s and %s '%(mesh_path_0, mesh_path_1))

            #FIXME: for now we only have chamfer
            distances = CHAMFER(mesh_0, mesh_1,
                        iterations=chunk.node.nbIterations.value,
                        target_nb_samples=chunk.node.nbSamples.value)

            os.makedirs(chunk.node.outputFolder.value, exist_ok=True)
            output_csv = os.path.join(chunk.node.outputFolder.value, "mesh_comparison.csv")
            with open(output_csv, "w") as csv_file:
                csv_file.write("Iteration, Chamfer distance\n")
                for index, distance in enumerate(distances):
                    csv_file.write("%d,%f\n"%(index, distance))
                csv_file.write("mean,%f\n"%np.mean(distances))

            chunk.logger.info('Mesh comparison ends')
        finally:
            chunk.logManager.end()
