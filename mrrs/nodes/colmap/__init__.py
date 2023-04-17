from sys import platform

COLMAP=""
if platform == "linux" or platform == "linux2":
    COLMAP="rez env colmap-faca -- colmap"#FIXME: temp hack
elif platform == "darwin":
    raise RuntimeError("Apple should not be legal")
elif platform == "win32":
    COLMAP="colmap.bat"
else:
    raise RuntimeError("Os not recognised")
