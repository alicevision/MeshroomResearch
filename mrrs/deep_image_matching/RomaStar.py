__version__ = "2.0"

import json
import os

from meshroom.core import desc
from meshroom.core.plugin import PluginNode, EnvType

# FIXME: hardcoded
MASK_EXTENTION = ".png"
# roma working size
H, W = 864, 864
# device to run roma on
DEVICE = "cuda"


# prepare warp and conf
def prepare_roma_outputs(w, c):
    w = w[:, :W, :]
    c = c[:, :W]
    w = ((w[:, :, 2:4] * W + (W - 1)) / 2).detach().cpu().numpy()
    c = c.detach().cpu().numpy()
    return w, c


# happens ones at the end of a tensor
def make_homogeneous(input_array):
    import numpy as np

    return np.concatenate(
        [input_array, np.ones(shape=(input_array.shape[0], 1))], axis=-1
    )


class RomaStar(PluginNode):

    category = "MRRS - Deep Matching"
    documentation = """ """
    gpu = desc.Level.INTENSIVE

    # overides the env path
    envFile = os.path.join(os.path.dirname(__file__), "env.yaml")
    envType = EnvType.CONDA

    inputs = [
        desc.File(
            name="inputSfMData",
            label="SfMData",
            description="Input SfMData file.",
            value="",
        ),
        desc.File(
            name="keyFrameSfMData",
            label="keyFrameSfMData",
            description="Input Keyframe SfMData (will overwite sampling).",
            value="",
        ),
        desc.File(
            name="maskFolder",
            label="maskFolder",
            description="maskFolder",
            value="",
        ),
        desc.IntParam(
            name="keyframeSteps",
            label="keyframeSteps",
            description="""Steps to set each keyframe""",
            value=20,
            range=(0, 20000, 1),
            advanced=False,
            enabled=lambda node: node.keyFrameSfMData.value == "",
        ),
        desc.IntParam(
            name="samplingStep",
            label="samplingStep",
            description="""Sampling for Keypoint, 0 to use Roma's sampling, 1 for no sampling, otherwise will sample pixels every n pixel, on a grid""",
            value=15,
            range=(0, 20000, 1),
            advanced=True,
        ),
        desc.FloatParam(
            name="geometricFilter",
            label="geometricFilter",
            description="""Deactivated if 0, will perform geometric test using this threshold before adding features to tracks.""",
            value=20.0,
            range=(0.0, 100.0, 1.0),
            advanced=True,
        ),
        desc.BoolParam(
            name="uniqueFeatId",
            label="uniqueFeatId",
            description="""Will assign a unique feature Id for each feature of the match from image f to keyframe k. If false, the feature id will be set to match the one of the corresponding pixel in k""",
            value=True,
            advanced=True,
        ),
        desc.IntParam(
            name="minTrackLength",
            label="minTrackLength",
            description="""Remove tracks shorter than the given length""",
            value=2,
            range=(2, 20000, 1),
            advanced=True,
        ),
        desc.FloatParam(
            name="confThreshold",
            label="confThreshold",
            description="""Dont include in track unreliable matches""",
            value=0.05,
            range=(0.0, 1.0, 0.01),
            advanced=True,
        ),
        desc.ChoiceParam(
            name="verboseLevel",
            label="Verbose Level",
            description="Verbosity level (fatal, error, warning, info, debug, trace).",
            value="info",
            values=["fatal", "error", "warning", "info", "debug", "trace"],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name="outputTracks",
            label="Output tracks",
            description="",
            value=os.path.join(desc.Node.internalFolder, "tracks.json"),
        )
    ]

    def processChunk(self, chunk):
        """
        Computes the different transforms
        """
        import numpy as np
        from PIL import Image
        import cv2
        from romatch import roma_outdoor

        chunk.logManager.start(chunk.node.verboseLevel.value)

        # load sfmdata
        chunk.logger.info("Loading sfm data")
        with open(chunk.node.inputSfMData.value, "r") as json_file:
            sfm_data = json.load(json_file)

        # sort by frame id
        if "frameId" in sfm_data["views"][0].keys():
            sfm_data["views"] = sorted(
                sfm_data["views"], key=lambda x: int(x["frameId"])
            )
        else:
            raise RuntimeError("No frameId")

        # utils variables
        nb_image = len(sfm_data["views"])
        images_paths = [v["path"] for v in sfm_data["views"]]
        masks_files = None
        images_uids = [v["viewId"] for v in sfm_data["views"]]
        oW, oH = int(sfm_data["views"][0]["width"]), int(sfm_data["views"][0]["height"])

        # load masks paths if any (should not be to big)
        if chunk.node.maskFolder.value != "":
            masks_files = sorted(
                [
                    os.path.join(chunk.node.maskFolder.value, f)
                    for f in os.listdir(chunk.node.maskFolder.value)
                    if f.endswith(MASK_EXTENTION)
                ]
            )
            assert len(masks_files) == len(images_paths)

        # loads model, note that this is lazy
        chunk.logger.info("Loading model")
        matcher = roma_outdoor(device=DEVICE)

        # if any, will load keyframe indices from another sfm
        if chunk.node.keyFrameSfMData.value != "":
            chunk.logger.info("Loading keyframes indices from sfm")
            with open(chunk.node.keyFrameSfMData.value, "r") as json_file:
                sfm_data_kf = json.load(json_file)
            images_uids_kf = [v["viewId"] for v in sfm_data_kf["views"]]
            keyframes_indices = np.where(np.isin(images_uids, images_uids_kf))[0]
            chunk.logger.info(keyframes_indices)
        # will just uniform sampling otherwise
        else:
            keyframes_indices = range(0, nb_image, chunk.node.keyframeSteps.value)

        # init track for reference keyframe pixels (one track per pixel, modulo grid sampling if any)
        tracks = []
        #coordinates of pixels in downsampled images
        pys, pxs = np.meshgrid(
            np.arange(0, H, max(1, chunk.node.samplingStep.value)),
            np.arange(0, W, max(1, chunk.node.samplingStep.value)),
            indexing="ij",
        )
        pys = pys.flatten()
        pxs = pxs.flatten()
        for i, k in enumerate(keyframes_indices):
            for j, (x, y) in enumerate(zip(pxs, pys)):
                feat = [
                    int(images_uids[k]),
                    {
                        #give index in order
                        "featureId": int(j),
                        # coords in original image
                        "coords": [float(oW * x / W), float(oH * y / H)],
                        #for now scale 0 as these are 'reference' features
                        "scale": float(0),
                    },
                ]
                tracks.append(
                    [
                        #track index in order
                        pxs.shape[0] * i + j,
                        {"descType": "dspsift", "featPerView": [feat]},
                    ]
                )

        chunk.logger.info("Matching")
        # keeps track of how many features we have per view
        nb_feat_per_view = [0 for _ in range(nb_image)]

        # for each keyframe
        for i, k in enumerate(keyframes_indices):
            chunk.logger.info("  %d/%d" % (i, len(keyframes_indices)))

            # open mask image
            if masks_files is not None:
                chunk.logger.info("  Opening mask")
                mask_file = masks_files[i]
                mask = np.asarray(Image.open(mask_file))
                mask = cv2.resize(mask, (W, H))
                chunk.logger.info("  Done")

            # save the warps and certainties
            warps = {}
            certainties = {}
            # is we use roma sampling, keep track of what keypoint was sampled
            if chunk.node.samplingStep.value == 0:
                was_sampled = np.zeros((H, W)).astype(bool)
            else:
                was_sampled = np.ones((H, W)).astype(bool)

            # compute the non keyframes range to be matched with
            # start_frame = 0 if i == 0 else keyframes_indices[i-1]+1
            # end_frame = nb_image-1 if i == len(keyframes_indices)-1 else keyframes_indices[i+1]
            # matched_non_keyframes = list(range(start_frame, end_frame))
                
            #before: note we accidently have matching in between keyframes
            matched_non_keyframes = [f for f in range(k - chunk.node.keyframeSteps.value, 
                                                    k + chunk.node.keyframeSteps.value) 
                                                    if f >= 0 and f < nb_image and k != f]
            chunk.logger.info("  Matching kf %d with :"%k)
            chunk.logger.info(matched_non_keyframes)

            # for each frame in between the keyframes run roma
            for f in matched_non_keyframes:
                # if not keyframe
                if k == f:
                    continue
                # match
                chunk.logger.info("  Matching kf %d with %d" % (k, f))
                warp, certainty = matcher.match(images_paths[k], images_paths[f], device=DEVICE)
                chunk.logger.info("  Done")
                if chunk.node.samplingStep.value == 0:
                    # will keep keypoint it if was sampled once
                    chunk.logger.info("  Running roma sampling")
                    roma_matches, _ = matcher.sample(
                        warp, certainty, num=2000
                    )  # chunk.node.maxKeypoints.value) #TODO: expose this parameter?
                    roma_matches = (
                        ((roma_matches[:, 2:4] * W + (W - 1)) / 2)
                        .detach()
                        .cpu()
                        .numpy()
                    )
                    roma_matches = np.round(roma_matches).astype(np.int32)
                    was_sampled[roma_matches[:, 1], roma_matches[:, 0]] = True
                    chunk.logger.info("  Done")
                # prepare and stack data
                warp, certainty = prepare_roma_outputs(warp, certainty)
                # coords in original image size
                warp_orig = np.stack(
                    [oW * warp[:, :, 0] / W, oH * warp[:, :, 1] / H], axis=-1
                )
                #save for later
                warps[f] = warp_orig
                certainties[f] = certainty
            chunk.logger.info("Done matching")

            # run the keypoint selection
            chunk.logger.info("Selecting keypoints")

            for f in matched_non_keyframes:
                # if not keyframe 
                if k == f:
                    continue
                certainty = certainties[f]
                warp_orig = warps[f]
                chunk.logger.info("  Selecting keypoints from kf %d with %d" % (k, f))
                certain_keypoints = certainty[pys, pxs] > chunk.node.confThreshold.value
                chunk.logger.info("  %d rejected by confidence " % (np.count_nonzero(~certain_keypoints)))
                unmasked_keypoints = np.ones_like(certain_keypoints)
                if masks_files is not None:
                    unmasked_keypoints = mask[pys, pxs, 0] != 0
                    chunk.logger.info("  %d rejected by masks " % (np.count_nonzero(~unmasked_keypoints)))

                selected_keypoints = (was_sampled[pys, pxs] & certain_keypoints & unmasked_keypoints)
                chunk.logger.info(
                    "  %d/%d rejected by confidence or masks "
                    % (np.count_nonzero(~selected_keypoints), H * W)
                )
                # geometric filter from funcdamental matrices from selected points
                if chunk.node.geometricFilter.value:
                    chunk.logger.info("  Geometric filtering")
                    import cv2
                    from cv2 import findFundamentalMat

                    # compute fundamental matrices
                    npxs, npys = pxs[selected_keypoints], pys[selected_keypoints]
                    keypoints_0 = np.stack([oW * npxs / W, oH * npys / H], axis=-1)
                    keypoints_1 = warp_orig[npys, npxs]
                    F, _ = findFundamentalMat(keypoints_0, keypoints_1, cv2.RANSAC)
                    if F is None:
                        chunk.logger.error(
                            RuntimeError("Failed to compute fundamental matrix")
                        )
                        raise RuntimeError("Failed to compute fundamental matrix")
                    # epipolar lines
                    keypoints_0 = np.stack([oW * pxs / W, oH * pys / H], axis=-1)
                    keypoints_1 = warp_orig[pys, pxs]
                    l1 = make_homogeneous(keypoints_0) @ F.T
                    l0 = make_homogeneous(keypoints_1) @ F

                    # compute epipolar error
                    # distance of each match point to line
                    def distance_point_to_line(p, l):
                        # from each point in p [N*3], compute the reprojection error from the epipolar line l [N*3]
                        return np.abs(
                            np.sum(l * make_homogeneous(p), axis=1)
                        ) / np.sqrt(np.sum(np.power(l[:, 0:2], 2), axis=1))

                    error = (
                        distance_point_to_line(keypoints_0, l0)
                        + distance_point_to_line(keypoints_1, l1)
                    ) / 2.0

                    valid_points = error < chunk.node.geometricFilter.value
                    chunk.logger.info(
                        "  %d points rejected by geometry"
                        % (np.count_nonzero(~valid_points))
                    )
                    selected_keypoints &= valid_points

                chunk.logger.info(
                    "  %d/%d point kept"
                    % (np.count_nonzero(selected_keypoints), pxs.shape[0])
                )

                chunk.logger.info("  Formating")
                for j, (x, y) in enumerate(zip(pxs, pys)):
                    if not selected_keypoints[j]:
                        continue

                    proj = list([float(warp_orig[y, x][0]), float(warp_orig[y, x][1])])
                    corresp_track_index = pxs.shape[0] * i + j
                    if chunk.node.uniqueFeatId.value:
                        featureId = nb_feat_per_view[f]
                        nb_feat_per_view[f] += 1
                    else:
                        featureId = j
                    feat = [
                        int(images_uids[f]),
                        {
                            "featureId": featureId,
                            "coords": proj,
                            "scale": 0#float(certainty[y, x]), #option for now
                        },
                    ]
                    tracks[corresp_track_index][1]["featPerView"].append(feat)

                chunk.logger.info("  Done")
        chunk.logger.info("Done")

        filtered_tracks = []
        chunk.logger.info("%d tracks" % (len(tracks)))
        chunk.logger.info("Post-filtering tracks")
        for t in tracks:
            if len(t[1]["featPerView"]) >= chunk.node.minTrackLength.value:
                filtered_tracks.append(t)

        chunk.logger.info("Done")
        chunk.logger.info("%d tracks" % (len(tracks)))
        chunk.logger.info("Saving")
        with open(chunk.node.outputTracks.value, "w") as tf:
            json.dump(filtered_tracks, tf, indent=2)
        chunk.logger.info("Done")
        chunk.logManager.end()
