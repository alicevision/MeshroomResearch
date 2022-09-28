"""
Package.py to install MRRS on the grid
can use rez env meshroom-develop mrrs -- meshroom
package and repo in /s/apps/users/multiview/mrrs/hogm/mrrs
"""
name='mrrs'
version='0.0'

requires=[
    'python-3.7',
    'Pillow-8.4.0',
    'msgpack_numpy-0.4.7.1',
    'opencv_python-4.5.4.60',
    #'openexr-3.1.4', #no python binding, we have an oiio mode
    'pyoiio-2.3.14.0'
    'trimesh', #needed for meshcompare but technically optional
    #'annoy', #no package send mail
    ]

def commands():
    """
    Setups mrrs path and meshroom node path env variable
    """
    env.PYTHONPATH.append('{root}/mrrs')
    env.MESHROOM_NODES_PATH.append('{root}/mrrs/mrrs/nodes')

