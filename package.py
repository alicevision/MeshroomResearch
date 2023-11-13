S"""
Package.py to install MRRS on the grid
can use rez env meshroom-develop mrrs -- meshroom
package and repo in /s/apps/users/multiview/mrrs/hogm/mrrs
"""
name='mrrs'
version='0.0'

requires=[
    'python-3.7',
    'Pillow-8.4.0',
    'pyopencv-4.7.0',
    'pyoiio-2.4.13',
    'trimesh',
    'click', #needed for clis otherwise optional
    ]

def commands():
    """
    Setups mrrs path and meshroom node path env variable
    """
    env.PATH.append('/s/apps/users/hogm/miniconda/bin')#add conda to path
    source("/s/apps/users/hogm/miniconda/etc/profile.d/conda.sh")
    env.PYTHONPATH.append('{root}/MeshroomResearch')
    env.MESHROOM_NODES_PATH.append('{root}/MeshroomResearch/mrrs/nodes')
    for p in ['benchmark', 'colmap']:
        env.MESHROOM_PIPELINE_TEMPLATES_PATH.append('{root}/MeshroomResearch/pipelines/' + p)

