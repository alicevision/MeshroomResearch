# Deep feature matching

This module is dedicated to test deep feature matches in meshroom.

It is using the [Kornia](https://github.com/kornia/kornia) library to wrap the descriptors and detectors.

The env.yaml is used in meshroom to automatically build the environnements.

Utils contains the IOs for the features/matches.

# Deep feature extraction

This node is used to isolates the feature extraction.

! it relies on a meshroom PR that is not yet merge to have arbitrary desriptors.

# LightGlue Matcher 

Uses the [Lightglue](https://github.com/cvg/LightGlue) matcher to matches the computed feature.


 # Loftr Matcher

 Uses the image-to-image matcher of LOFTR, we use the feature coordinates to establish corespondances.
 
