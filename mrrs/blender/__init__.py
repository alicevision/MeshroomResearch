from shutil import which

if which('blender') is None:
    print(
        "[warning] mrrs: 'blender' command not found, the following nodes cannot be computed: \n",
        "* SyntheticDataset \n",
        "* RenderOverlay \n",
    )
