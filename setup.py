"""
Installer for the core module of mrrs. so it can be used in other plugins.
"""
from setuptools import setup

setup(
    name='MRRSCore',
    version='0.0.0',
    author='Matthieu Hog',
    author_email='matthieu.hog@technicolor.com',
    packages=['mrrs.core'],
    #scripts=['bin/script1','bin/script2'],
    url='https://github.com/alicevision/MeshroomResearch/',
    license='LICENSE-MPL2.md',
    description='Meshroom Research Core functions',
    long_description=open('README.md').read(),
    install_requires=["numpy", "pillow",
                      "opencv-python-headless",
                      "trimesh", "click"],
                     # "oiio-python" py-openimageio], #FIXME: no pypy pacjages! need conda env or external install
    ) 