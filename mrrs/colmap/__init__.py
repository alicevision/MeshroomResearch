import os
from sys import platform

from shutil import which

if which('colmap') is None:
    print("[warning] mrrs: 'colmap' command not found, colmap nodes cannot be computed: \n")

COLMAP=""
if platform == "linux" or platform == "linux2":
    if 'REZ_ENV' in os.environ:
        COLMAP="rez env colmap-faca -- colmap "
    else:
        COLMAP="colmap"
elif platform == "darwin":
    raise RuntimeError("Apple should not be legal")
elif platform == "win32":
    COLMAP="colmap.bat"
else:
    raise RuntimeError("Os not recognised")
