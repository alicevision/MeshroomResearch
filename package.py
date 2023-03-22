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
    'pyoiio-2.4.7.0',
    'trimesh', 
    'click', #needed for clis otherwise optional
    #'annoy', #no package send mail
    'matplotlib-3.4.2' #needed for?
    ]

def commands():
    """
    Setups mrrs path and meshroom node path env variable
    """
    env.PYTHONPATH.append('{root}/MeshroomResearch')
    env.MESHROOM_NODES_PATH.append('{root}/MeshroomResearch/mrrs/nodes')

