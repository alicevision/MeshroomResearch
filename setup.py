"""
Installer for MRRS. Will handle dependencies and will add modules to meshroom.
"""
import os
import pathlib
from setuptools import setup

#Setting env variable
#FIXME: check env
MLEM_path = os.path.join(str(pathlib.Path(__file__).parent.resolve()), "mrrs", "nodes")
print("MRRS path "+MLEM_path)
os.environ['MESHROOM_NODES_PATH'] = MLEM_path

setup(
    name='MRRS',
    version='0.0.0',
    author='Matthieu Hog',
    author_email='matthieu.hog@technicolor.com',
    packages=['mrrs'],#
    #scripts=['bin/script1','bin/script2'],
    #url='http://pypi.python.org/pypi/PackageName/',
    #license='LICENSE.txt',
    description='Meshroom Research plugin and library.',
    long_description=open('README.md').read(),
    install_requires=["numpy", "opencv-python", "pillow"],#all of this sould be in the mr env
                     #trimesh for mesh comparison optional for meshcomparsion
                     # optional annoy for knn? for meshcomparsion
                     # "openexr-python"],#note add mode meshroom? with oiio
                     # onnxruntime
    extras_require= {
                    # "openexr-python need conda
                    "onnx": ["onnxruntime"],#for depth map refinement
                    "meshcomparison": ["annoy", "trimesh"],
                    # "training": "tensorflow==2.4"#need conda
                    },
    )