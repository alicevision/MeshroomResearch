#%% Imports
"""
Training script to train a depth refinement step.
This was implemented using tensoflow 2.?? and MRRS v0.

To try :
- no multiscale supervision => ok, not helping
- also mask from input -1
- normalise (01 and centernorm) both input and dataset
- loss with diff least square to robostify != in depth pose
- unet altogoterh

"""
from datetime import datetime
import os
import shutil

import numpy as np
import tensorflow as tf

from mrrs.depth_map_refinement.learning_based_refinement.data_generator import TrainingGenerator, assert_all_finite, invert_depth
from mrrs.depth_map_refinement.learning_based_refinement.models.stereonet_model import HierachicalGuidedDepthMapRefinement
from mrrs.depth_map_refinement.learning_based_refinement.losses import WeigtedMSE, WeigtedMSEandSSIM
from mrrs.depth_map_refinement.learning_based_refinement.models.unet_model import MultimodalUnet, Unet
from mrrs.core.geometry import EPSILON
from mrrs.core.utils import recursive_call

import argparse

# nohup "rez env mrrs-hogm tensorflow-2.4.0 -- python /s/apps/users/multiview/mrrs/hogm/mrrs/mrrs/depth_map_refinement/learning_based_refinement/training.py"&

if __name__ == "__main__":#FIXME: logging? instead of print

    print("Starting training")
    print("TF version:")
    print(tf.__version__)
    print("Gpus:")
    print(tf.config.list_physical_devices('GPU'))#conda install tensorflow-gpu=2.6/ conda install -c anaconda tensorflow-gpu

    #%% Params

    #ios
    if os.name == 'nt':
        DATASET_PATH = "C:\\runs\\testonesequence"#root of the training set
        TEST_DATASET_PATH = "C:\\runs\\testonesequence"#root of the testing set
        OUTPUT_PATH = "C:\\runs\\testonesequence\\"
        EXPORT_ONNX = os.path.join(OUTPUT_PATH, "model.onnx")
        SUBMIT = False
    else:
        #mrrs-hogm tensorflow-2.4.0, can submit  trhu meshroom
        DATASET_PATH = "/s/prods/mvg/_source_global/users/hogm/meshroom_benchmark_outputs"#root of the training set
        TEST_DATASET_PATH = None#"C:\\runs\\testonesequence"#root of the testing set #FIXME: todo
        RANDOM_TEST = True
        OUTPUT_PATH = "/s/prods/mvg/_source_global/users/hogm/training_depth_refinement"
        EXPORT_ONNX = None #need onnx installed

    RUN_NICKNAME = "AE_rm_outliers2_loss_norm"#convenient for lookup in tensorboard
    OUTPUT_PATH =  os.path.join(OUTPUT_PATH,RUN_NICKNAME) #output path for checkpoints and saved models
    RESUME_CHECKPOINT = True

    TENSORBOARD_TRAIN_SAVE_STEP = 1000
    TENSORBOARD_TRAIN_FORCE_SAVE_UNTIL_ITERATION = 10000
    TENSORBOARD_SAVE_GRAPH = False
    TENSORBOARD_LOGDIR = os.path.join(OUTPUT_PATH, datetime.now().strftime('%Y-%m-%d %H-%M-%S'))

    #optimiser params
    LOSS = WeigtedMSE()#WeigtedMSEandSSIM()#WeigtedMSE() #FIXME: try different losses, ssim, edge aware loss from monodepth etc...
    LOSS_NORMS = True
    EPOCHS = 100000
    LEARNING_RATE = 0.0001
    BATCH_SIZE = 5
    SHUFFLE_SIZE=BATCH_SIZE*2
    BUFFER_SIZE=BATCH_SIZE*10
    OPTIMISER = tf.keras.optimizers.Adam(learning_rate=LEARNING_RATE)

    #preprocess
    FILTER_DEPTH_OUTLIERS = True
    NORMALISE_DEPTH = True

    #model
    # MODEL = HierachicalGuidedDepthMapRefinement
    # scales = [8,4,2,1]
    # auto_scale_depth = False
    # output_scale = None
    # SUPERVISION_ALL_SCALES = True
    # MODEL_PARAMS = [scales, auto_scale_depth, output_scale]

    MODEL = Unet#MultimodalUnet
    SUPERVISION_ALL_SCALES = False
    layers_filters=[16, 16, 32, 64, 128, 128, 1]#will use input and ouptut layers by default, kernel 33, last_layer_activation=None and skips
    MODEL_PARAMS = [layers_filters]

    #%% prepare data
    #make dataset
    generator = TrainingGenerator(DATASET_PATH, resize_gt=True)#For now only filtering no upsampling
    if RANDOM_TEST and  TEST_DATASET_PATH is None:
        print("Will use 10 percent of the input dataset as testing:")
        nb_test = 0.1*len(generator)
        print("%d images"%nb_test)
        selected_views = np.random.randint(nb_test)
        TEST_DATASET_PATH = os.path.join(DATASET_PATH+"_test", "test_set", "dummy_sequence")
        if os.path.exists(TEST_DATASET_PATH):
            print("Test set already exists, skipping")
        else:
            os.makedirs(TEST_DATASET_PATH)
            print("Making random test set")
            for index, dataset_item in enumerate(generator.scanned_files):#note generator shuffles by default
                depth, image,depth_gt = dataset_item
                shutil.move(depth, os.path.join(TEST_DATASET_PATH, os.path.basename(depth)))
                shutil.move(image, os.path.join(TEST_DATASET_PATH, os.path.basename(image)))
                shutil.move(depth_gt, os.path.join(TEST_DATASET_PATH, os.path.basename(depth_gt)))

                if index >= nb_test:
                    break
            generator = TrainingGenerator(DATASET_PATH, resize_gt=True)#need to reload this because files have changed

    test_generator = TrainingGenerator(TEST_DATASET_PATH, shuffle_scenes=False) if TEST_DATASET_PATH is not None else None
    #automatically detects type and sizes
    data_resolutions = recursive_call(generator[0], lambda x: x.shape, lambda x:isinstance(x, np.ndarray) )
    data_types = recursive_call(generator[0], lambda x: x.dtype, lambda x:isinstance(x, np.ndarray) )
    print("%d training samples found"%len(generator))
    dataset = tf.data.Dataset.from_generator(generator,
                                            output_types=((tf.float32, tf.float32), tf.float32),#FIXME: autotype
                                            output_shapes=data_resolutions )
    test_dataset = tf.data.Dataset.from_generator(test_generator,
                                                    output_types=((tf.float32, tf.float32), tf.float32),#FIXME: autotype
                                                    output_shapes=data_resolutions ) if test_generator is not None else None
    #usefull sanity check
    dataset = dataset.map(assert_all_finite)

    #FIXME: try that, also try 1/depth, try global dataset normalisation as well
    # dataset = dataset.map(invert_depth)
    # dataset = dataset.map(normalise_depth)
    # dataset = dataset.map(center_depth)

    #shuffle a bit more
    dataset = dataset.shuffle(SHUFFLE_SIZE)
    #bufferize input
    dataset = dataset.prefetch(BUFFER_SIZE)
    #make batches
    dataset = dataset.batch(BATCH_SIZE)

    #TODO: add DA etc

    #instantiate model
    model = MODEL(*MODEL_PARAMS)
    #tmp debug
    #not working, https://stackoverflow.com/questions/61427583/how-do-i-plot-a-keras-tensorflow-subclassing-api-model
    # img_file = os.path.join(OUTPUT_PATH, 'unet.png')
    # tf.keras.utils.plot_model(model, to_file=img_file, show_shapes=True)
    # model.summary(expand_nested=True) #needs to be built first

    #create checkpoint&checkpoint manager
    checkpoint = tf.train.Checkpoint(step=tf.Variable(1), optimizer=OPTIMISER, net=model, iterator=iter(dataset))
    checkpoint_manager = tf.train.CheckpointManager(checkpoint, os.path.join(OUTPUT_PATH, 'training_checkpoint'), max_to_keep=3)
    #resumr from checkpoint if needed
    start_epoch = 0
    if RESUME_CHECKPOINT and (checkpoint_manager.latest_checkpoint is not None):
        checkpoint.restore(checkpoint_manager.latest_checkpoint)
        start_epoch = checkpoint.step.numpy()
        print("Restored training from "+checkpoint_manager.latest_checkpoint+" at epoch "+str(start_epoch))
    else:
        print("Initializing training from scratch.")

    #init tensorboard
    summary_writer = tf.summary.create_file_writer(TENSORBOARD_LOGDIR)
    print("Created logdir "+TENSORBOARD_LOGDIR)
    with summary_writer.as_default():
        tf.summary.text("run_name", RUN_NICKNAME, step=0)
        tf.summary.text("model_name", model.name, step=0)
        tf.summary.text("loss_name", LOSS.name, step=0)
        tf.summary.text("optimiser_name", OPTIMISER._name, step=0)
        tf.summary.text("training_set", DATASET_PATH, step=0)
        summary_writer.flush()

    #%% run optim with manual loop
    epoch_steps = len(generator)-len(generator)%BATCH_SIZE
    global_step = start_epoch*epoch_steps#FIXME: this seems to bug
    loss_values = []
    for epoch in range(start_epoch, EPOCHS):
        for iteration, ((depth, image),depth_gt) in enumerate(dataset):
            with tf.GradientTape() as tape:
                #compute mask
                valid_depth_mask = (depth_gt > 0) #& (depth > 0)

                if FILTER_DEPTH_OUTLIERS: #edit mask to removes outliers #FIXME: axis!!
                    median_threshold = 2 #arbitraty therhold used to filter out outliers that exect N times the std dev
                    #get distribution median from valid GT
                    depth_gt_med = np.median(depth_gt[valid_depth_mask], axis = 0)
                    #distance to median for gt and depth
                    abs_diff_med_gt = np.abs(depth_gt - depth_gt_med)
                    abs_diff_med = np.abs(depth - depth_gt_med)
                    #median absolute distance to the gt valid median as a robust std dev
                    median_standard_deviation = np.median(abs_diff_med_gt[valid_depth_mask.numpy()])
                    #norm distance to median for convenience
                    median_standard_deviation_norm_gt = abs_diff_med_gt/median_standard_deviation
                    median_standard_deviation_norm = abs_diff_med/median_standard_deviation
                    #outlier is somethins that exceed the given threshold eg deviantes from gaussian more that n times sigma
                    no_outlier_depth = (median_standard_deviation_norm_gt<median_threshold) & (median_standard_deviation_norm<median_threshold)
                    valid_depth_mask &= no_outlier_depth

                if tf.math.count_nonzero(valid_depth_mask) == 0:#FIXME: replace tf
                    raise BaseException("Depth was found to be all invalid")
                valid_depth_mask_float = tf.cast(valid_depth_mask, tf.float32)

                if NORMALISE_DEPTH:
                    # norm 01
                    min=tf.reduce_min(depth_gt[valid_depth_mask], axis = 0)
                    max=tf.reduce_max(depth_gt[valid_depth_mask], axis = 0)
                    depth_gt = (valid_depth_mask_float*(depth_gt-min+EPSILON))/(max-min+EPSILON)
                    depth =   (valid_depth_mask_float*(depth-min+EPSILON))/(max-min+EPSILON)

                    # #median norm
                    # #get median
                    # depth_gt_med = np.median(depth_gt[valid_depth_mask], axis = 0)
                    # abs_diff_med_gt = np.abs(depth_gt - depth_gt_med)
                    # #save this for later
                    # depth_med = np.median(depth[valid_depth_mask], axis = 0)
                    # abs_diff_med = np.abs(depth - depth_gt_med)
                    # #get equivalent of std dev but using median
                    # std_deviation_median_gt = np.median(abs_diff_med_gt[valid_depth_mask.numpy()], axis = 0)
                    # #center and normalise with gt med and std dev
                    # depth_gt = (depth_gt-depth_gt_med)/std_deviation_median_gt #fixme div 0
                    # depth =  (depth-depth_gt_med)/std_deviation_median_gt

                    # if FILTER_DEPTH_OUTLIERS: #edit mask to removes outliers
                    #     median_threshold = 2
                    #     median_deviation_norm_gt = abs_diff_med_gt/depth_gt_med
                    #     median_deviation_norm = abs_diff_med/depth_med
                    #     valid_depth_mask &= (median_deviation_norm<median_threshold)&(median_deviation_norm_gt<median_threshold)
                    #     valid_depth_mask_float = tf.cast(valid_depth_mask, tf.float32)

                #forward pass
                predicted_depth, intermediate_scales = model((depth, image), training=True)

                #compute loss
                loss_value=0
                if SUPERVISION_ALL_SCALES:#loss at all scales
                    for predicted_depth_scale, scale in zip(intermediate_scales, model.scales_downsampling):
                        #resize to gt and x by scale, loss for each scale #TODO: try downsample GT rather
                        predicted_depth_scale_resized = tf.image.resize(predicted_depth_scale, depth_gt.shape[1:3], preserve_aspect_ratio=True)
                        # predicted_depth_scale_resized *= scale
                        loss_scale = LOSS(depth_gt,predicted_depth_scale_resized,valid_depth_mask_float)
                        loss_value += loss_scale
                        with summary_writer.as_default():
                            tf.summary.scalar("loss-1\\%d"%scale,loss_scale, step=global_step)
                else:#loss on final depth only
                    loss_value = LOSS(depth,predicted_depth,valid_depth_mask_float)
            tf.debugging.assert_all_finite(loss_value, "invalid number in loss_value")
            print("Epoch %d Iteration %04d/%04d: loss %0.8f "%(epoch, iteration, epoch_steps, loss_value ), end="\r")
            loss_values.append(loss_value)
            #backward pass
            grads = tape.gradient(loss_value, model.trainable_weights)
            OPTIMISER.apply_gradients(zip(grads, model.trainable_weights))

            #tensorboard save
            if TENSORBOARD_SAVE_GRAPH:
                if iteration == 0 :#second iteration will have trace
                    tf.summary.trace_on(graph=True, profiler=True)
                elif iteration == 1 :#save graph on second iteration
                    with summary_writer.as_default():
                        tf.summary.trace_export(name="model_trace", step=0, profiler_outdir=TENSORBOARD_LOGDIR)
                        tf.summary.trace_on(graph=False, profiler=False)#deactivate trace after second iteration

            if iteration%TENSORBOARD_TRAIN_SAVE_STEP==0 or iteration < TENSORBOARD_TRAIN_FORCE_SAVE_UNTIL_ITERATION:
                with summary_writer.as_default():#(step=global_step) : max_outputs
                    tf.summary.image("rgb_image", image, step=global_step)
                    tf.summary.image("valid_depth", valid_depth_mask_float, step=global_step)
                    depth_concat = tf.concat([valid_depth_mask_float*depth,#all in one display for comparison
                                                                            valid_depth_mask_float*depth_gt,
                                                                            predicted_depth], axis=2)
                    # if NORMALISE_DEPTH:
                    #     depth_concat = tf.clip_by_value(depth_concat, -1, 2)
                    tf.summary.image("[input|gtpredicted]depth", depth_concat, step=global_step)
                    tf.summary.histogram("depth_hist", tf.reshape(depth[valid_depth_mask], -1), step=global_step)
                    tf.summary.histogram("gt_depth_hist", tf.reshape(depth_gt[valid_depth_mask], -1), step=global_step)
                    tf.summary.scalar("loss", np.mean(loss_values), step=global_step)
                    loss_values = []
                    tf.summary.histogram("predicted_depth_hist", tf.reshape(predicted_depth, -1), step=global_step)
                    tf.summary.scalar("learning_rate", OPTIMISER.learning_rate, step=global_step)
                    if intermediate_scales and len(intermediate_scales)>1 : #cant return None because of export model
                        for predicted_depth_scale, scale in zip(intermediate_scales, model.scales_downsampling):
                            #resize and multiply
                            predicted_depth_scale_resized = tf.image.resize(predicted_depth_scale, depth_gt.shape[1:3], preserve_aspect_ratio=True)
                            tf.summary.image("scale-1\\%d-[input|gtpredicted|depth]"%scale, tf.concat([valid_depth_mask_float*depth,
                                                                                                    valid_depth_mask_float*depth_gt,
                                                                                                    predicted_depth_scale_resized], axis=2), step=global_step)
                            tf.summary.histogram("scale-1\\%d-predicted_depth_hist"%scale, tf.reshape(predicted_depth_scale_resized, -1), step=global_step)
            global_step+=BATCH_SIZE

        #save checkpoint
        checkpoint.step.assign_add(1)
        save_path = checkpoint_manager.save()
        print("Saved checkpoint")
        if EXPORT_ONNX:# you need tf2onnx: pip install -U tf2onnx
            tf_saved_model = os.path.join(OUTPUT_PATH, 'model_weigts_epoch_%d'%epoch)
            #also save model to tf format
            tf.keras.models.save_model( model, tf_saved_model,
                                        overwrite=True, include_optimizer=False )
            #export to onnx FIXME: replace system call with https://github.com/onnx/tensorflow-onnx/blob/main/tf2onnx/convert.py
            os.system("python -m tf2onnx.convert --saved-model "+tf_saved_model+" --output "+EXPORT_ONNX)
            #see https://onnxruntime.ai/docs/get-started/with-python.html
            # also see --inputs-as-nchw

        #run on test set every epoch
        if test_dataset is not None:
            for iteration, ((depth, image),depth_gt) in enumerate(test_dataset):
                with summary_writer.as_default():#(step=global_step) : max_outputs
                    predicted_depth, intermediate_scales = model((depth, image), training=False)
                    tf.summary.image("test_rgb_image", image, step=global_step)
                    # tf.summary.image("valid_depth", valid_depth_mask_float, step=global_step)
                    tf.summary.image("test_[input|gtpredicted|depth]", tf.concat([valid_depth_mask_float*depth,#all in one display for comparison
                                                                            valid_depth_mask_float*depth_gt,
                                                                            predicted_depth], axis=2), step=global_step)
                    tf.summary.histogram("test_depth_hist", tf.reshape(depth[valid_depth_mask], -1), step=global_step)
                    tf.summary.histogram("test_gt_depth_hist", tf.reshape(depth_gt[valid_depth_mask], -1), step=global_step)
                    tf.summary.histogram("test_predicted_depth_hist", tf.reshape(predicted_depth, -1), step=global_step)
                    if intermediate_scales and len(intermediate_scales)>1 : #cant return None because of export model
                        for predicted_depth_scale, scale in zip(intermediate_scales, model.scales_downsampling):
                            #resize and multiply
                            predicted_depth_scale_resized = tf.image.resize(predicted_depth_scale, depth_gt.shape[1:3], preserve_aspect_ratio=True)
                            tf.summary.image("test_scale-1\\%d-[input|gtpredicted|depth]"%scale, tf.concat([valid_depth_mask_float*depth,
                                                                                                        valid_depth_mask_float*depth_gt,
                                                                                                        predicted_depth_scale_resized], axis=2), step=global_step)
                            tf.summary.histogram("test_scale-1\\%d-predicted_depth_hist"%scale, tf.reshape(predicted_depth_scale_resized, -1), step=global_step)
    #%%sanity check test the saved model seems to works
    # from mrrs.depth_map_refinement.learning_based_refinement.forward_wrapper import LearningBasedDepthRefinement
    # refiner = LearningBasedDepthRefinement()
    # # for iteration, ((depth, image),depth_gt) in enumerate(generator):
    # #     depth_output=refiner(depth,image)
    # #     save_exr(depth_output, "depth_%d.exr"%iteration, data_type="depth")
    # #     save_exr(depth, "depth_input_%d.exr"%iteration, data_type="depth")
    # #     # save_image(depth, "image_%d.exr"%iteration)
    # #     if iteration==10: break
    # #check open from scratch
    # depth=open_depth_map("c:/runs/testonesequence/5947b62af1b45630bd0c2a02/MeshroomCache/DepthMapComparison/b0029d8ca6c3f3e9cbc2fa72813597b489269e20/0_depthMap.exr")
    # image=open_image("c:/runs/testonesequence/5947b62af1b45630bd0c2a02/MeshroomCache/PrepareDenseScene/b7ad7980667c861db0fc33b0ea2ccb8cb12b25fd/0.exr")
    # depth_output=refiner(depth,image[:,:,0:3])
    # save_exr(depth_output, "depth.exr", data_type="depth")
    # save_exr(depth, "depth_input.exr", data_type="depth")
    #%%training with keras api
    # def loss_keras(input, gt):
    #     predicted_depth = input[0]
    #     intermediate_scales = input[1:]
    #     depth_gt=gt
    #     valid_depth_mask = depth_gt > 0
    #     valid_depth_mask_float = tf.cast(valid_depth_mask, tf.float32)
    #     if not SUPERVISION_ALL_SCALES:
    #         return LOSS(predicted_depth,depth_gt,valid_depth_mask_float)
    #     else:
    #         loss_value = 0
    #         # for predicted_depth_scale, scale in zip(intermediate_scales, model.scales_downsampling):
    #         #     predicted_depth_scale_resized = tf.image.resize(predicted_depth_scale, depth_gt.shape[1:3], preserve_aspect_ratio=True)
    #         #     loss_scale = LOSS(predicted_depth_scale_resized,depth_gt,valid_depth_mask_float)
    #         #     loss_value +=loss_scale
    #         for scale_idx, scale in enumerate(model.scales_downsampling):
    #             predicted_depth_scale = intermediate_scales[scale_idx]
    #             predicted_depth_scale_resized = tf.image.resize(predicted_depth_scale, depth_gt.shape[1:3], preserve_aspect_ratio=True)
    #             loss_scale = LOSS(predicted_depth_scale_resized,depth_gt,valid_depth_mask_float)
    #             loss_value += loss_scale
    #         return  loss_value
    # model.compile(optimizer=OPTIMISER, loss=loss_keras, metrics=[])
    # model.fit(dataset)

# %%
