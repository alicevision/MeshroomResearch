# ALab Dataset

For several 3D scene reconstruction tasks, it is difficult to obtain per-pixel-accurate ground truth from real images, along with a mesh wich topology is close to production-level assets. 
We propose this photorealistic synthetic dataset created from the [Animal Logic ALab](https://dpel.aswf.io/alab/) project and rendered using blender.
[SED creator](https://github.com/Alex-665/SEDcreator_new) was used to generate the scenes

# Content

It is composed of 5 sequences for multi-view-reconstruction and 20 panorama sequences for a total of 802 frames.
Rendered frames are provided, along with ground truth camera poses and intrinsics in [meshroom](https://alicevision.org/) format.

The ground truth mesh is provided as an obj file (with and without the faces visible from the cameras)

We also give depth, curvature, roughness and transmission maps for each of these camera.
The blender project is also provided.

It can be easily loaded into meshroom using the [LoadDaset](TODO) node.

# Download

The full dataset can be dowloaded [here](TODO)

# Credits

This dataset is the result from a student project with students from [IMACS](https://www.ingenieur-imac.fr/):
  - Sara	Lafleur
  - Alexandre	Miralles
  - Léa	Touchard
  - Maxime	Verna

If you use this dadaset to publish, we kindly ask you to cite it:
xxx

# Licence
 <p xmlns:cc="http://creativecommons.org/ns#" >This work is licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1"></a></p> 
