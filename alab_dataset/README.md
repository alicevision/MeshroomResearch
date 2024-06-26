# ALab-R 3D Reconstruction Dataset

Creating per-pixel-accurate ground truth from real images for various 3D scene reconstruction tasks can be challenging, especially when the mesh topology needs to be close to production-level assets. 
To address this issue, we present a photorealistic synthetic dataset created from the [Animal Logic ALab](https://dpel.aswf.io/alab/) project and rendered using Blender.
[SED creator](https://github.com/Alex-665/SEDcreator_new) was used to generate the scenes

# Content

The dataset consists of 5 sequences for multi-view reconstruction and 20 panorama sequences, for a total of 802 frames. 
Each frame comes with ground truth camera poses and intrinsics in [meshroom](https://alicevision.org/) format.

The ground truth mesh is provided as an obj file (with and without the faces visible from the cameras)

Additionally, we provide depth, curvature, roughness, and transmission maps for each camera. 
The original Blender project is also included in the dataset.

You can easily load the dataset into meshroom using the [LoadDaset](https://github.com/alicevision/MeshroomResearch/tree/main/mrrs/nodes#loaddataset) node.

# Download

The full dataset can be downloaded [here](https://zenodo.org/records/10964463?token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6IjQ0ZmZiMzBlLTczMjMtNGE3Yy1hNTZmLTU2MDdkZmUxNzNhOCIsImRhdGEiOnt9LCJyYW5kb20iOiI5Mzk2OTQ1NTdiMzVjNGEyMGQ3ZjEyM2UwMzFhZTM2NyJ9.II6TuWp5adDaji9Xeul6A5jsLwb5OS-vS4dMUlDY2VCwcZUWPGN8AlPyY7jdYt7VzS4RZW7qh6FFRw_Z7XhNaA).

# Credits

This dataset is the result of a project done by students from [IMAC](https://www.ingenieur-imac.fr/) engineering school:
  - Sara Lafleur
  - Alexandre Miralles
  - Léa Touchard
  - Maxime Verna

If you use this dataset to publish, we kindly ask you to cite it:

  ```
  @dataset{ alab_3dr,
            author       = {Lafleur, Sara and
                            Miralles, Alexandre and
                            Touchard, Léa and
                            Verna, Maxime and
                            Hog, Matthieu and
                            Castan, Fabien and
                            Meaujan, Benoit},
            title        = {ALab-R 3D Reconstruction Dataset},
            month        = apr,
            year         = 2024,
            publisher    = {Technicolor},
            version      = {0.0},
            doi          = {10.5281/zenodo.10964463},
            url          = {https://doi.org/10.5281/zenodo.10964463}
  }
  ```

# Licence for the ALab-R 3D Reconstruction Dataset
 <p xmlns:cc="http://creativecommons.org/ns#" >ALab-R assets (renders and json files) are licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1"></a></p> 

# Licence for the ALab 3D models
All 3D models and materials belong to [Animal Logic ALab](https://dpel.aswf.io/alab/) and are under the ASWF Digital Assets License v1.1.

License for Animal Logic ALab (the "Asset Name").

Animal Logic ALab Copyright 2024 Animal Logic Pty Limited. All rights reserved.

Redistribution and use of these digital assets, with or without modification, solely for education, training, research, software and hardware development, performance benchmarking (including publication of benchmark results and permitting reproducibility of the benchmark results by third parties), or software and hardware product demonstrations, are permitted provided that the following conditions are met:

Redistributions of these digital assets or any part of them must include the above copyright notice, this list of conditions and the disclaimer below, and if applicable, a description of how the redistributed versions of the digital assets differ from the originals.
Publications showing images derived from these digital assets must include the above copyright notice.
The names of the copyright holder or the names of its contributors may NOT be used to promote or to imply endorsement, sponsorship, or affiliation with products developed or tested utilizing these digital assets or benchmarking results obtained from these digital assets, without prior written permission from copyright holder.
The assets and their output may only be referred to as the Asset Name listed above, and your use of the Asset Name shall be solely to identify the digital assets. Other than as expressly permitted by this License, you may NOT use any trade names, trademarks, service marks, or product names of the copyright holder for any purpose.

DISCLAIMER: THESE DIGITAL ASSETS ARE PROVIDED BY THE COPYRIGHT HOLDER "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDER BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THESE DIGITAL ASSETS, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

