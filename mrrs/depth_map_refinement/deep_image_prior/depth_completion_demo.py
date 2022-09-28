# # %% imports and params
# #TODO: try an implicit representaion for completion (train with confidence=>force predict)
# import tensorflow as tf
# from datetime import datetime
# import os

# from .unet import Unet
# from .ios import *
# from .losses import *

# print("HELLO!")
# print("TF version:")
# print(tf.__version__)
# print("Gpus:")
# print(tf.config.list_physical_devices('GPU'))#conda install -c esri tensorflow-gpu

# #meshroom outputs
# IMAGE_PATH =      "C:\\Users\\hogm\\OneDrive - Technicolor\\Documents\\data\\datasets\\blendedMVSNEt\\low_res\\BlendedMVS\\5c34529873a8df509ae57b58\\blended_images\\00000004.jpg"
# DEPTH_PATH =      "c:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/test_depth_map_meshroom/127086276_depthMap.exr"
# DEPTH_GT_PATH = None
# CONFIDENCE_PATH = "c:/Users/hogm/OneDrive - Technicolor/Documents/data/datasets/test_depth_map_meshroom/127086276_simMap.exr"
# PROCESSING_RESOLUTION = [512, 512]

# TENSORBOARD_LOGDIR = os.path.join("./tensorboard_logs", datetime.now().strftime('%Y-%m-%d %H-%M-%S'))
# TENSORBOARD_SAVE_STEP = 50

# #optimiser params
# LOSS = Weigted_MSE()
# LEARNING_RATE = 0.0001#0.0001 work with no confidence (weigted mse with no param)
# TV_WEIGTH = 1/500000 #1/500000#FIXME: normalise with size image?
# TV_ITERATION_REDUCE = 5000#23000
# TV_ITERATION_DECAY = 0.9999
# OPTIMISER = tf.keras.optimizers.Adam(learning_rate=LEARNING_RATE)
# ITERATIONS = 100000#50000
# PREDICT_IMAGE = True

# #%% prepare data

# #opens and batch image
# image=open_image(IMAGE_PATH)
# depth=open_exr(DEPTH_PATH)
# confidence=1-normalise_01(open_exr(CONFIDENCE_PATH))#inverse confidence

# print("Depth range : %f - %f"%(tf.reduce_min(depth), tf.reduce_max(depth)))
# print("Conf range : %f - %f"%(tf.reduce_min(confidence), tf.reduce_max(confidence)))
# #resize
# image=tf.image.resize_with_pad(image,
#                       method=tf.image.ResizeMethod.BILINEAR,
#                       target_height=PROCESSING_RESOLUTION[1],
#                       target_width=PROCESSING_RESOLUTION[0])
# depth=tf.image.resize_with_pad(depth,
#                       method=tf.image.ResizeMethod.BILINEAR,
#                       target_height=PROCESSING_RESOLUTION[1],
#                       target_width=PROCESSING_RESOLUTION[0])
# confidence=tf.image.resize_with_pad(confidence,
#                       method=tf.image.ResizeMethod.BILINEAR,
#                       target_height=PROCESSING_RESOLUTION[1],
#                       target_width=PROCESSING_RESOLUTION[0])

# #instantiate model, unet with no skip connections
# output_dim = 1
# if PREDICT_IMAGE:
#     output_dim = 4
# model = Unet(
#             layers_filters=[16, 32, 64, 128, 128, 128, output_dim], #layer filters, note that first and last layers a normal convolutional layers if input_layer or output_layer is true
#             input_layer = False, output_layer=True,
#             kernel_sizes = 3,#constant kernel size
#             activation=tf.nn.relu,#tf.nn.leaky_relu,
#             last_layer_activation=tf.identity,#lambda x:15*(tf.nn.sigmoid(x)+0.5),
#             padding="same",
#             skip_connections=False)

# #random input noise note: could use multichanel noise
# random_noise = tf.random.uniform(depth.shape)

# #tensorboard
# summary_writer = tf.summary.create_file_writer(TENSORBOARD_LOGDIR)
# print("Created logdir "+TENSORBOARD_LOGDIR)

# #display transform
# def depth_transform_display(depth): #meshroom
#     depth_falsecolor = tf.identity(depth)
#     depth_falsecolor = normalise_01(depth_falsecolor)
#     depth_falsecolor = depth_falsecolor.numpy()*255
#     depth_falsecolor = np.concatenate([depth_falsecolor, depth_falsecolor, depth_falsecolor], axis=-1)
#     depth_falsecolor = depth_falsecolor.astype(np.uint8)
#     return depth_falsecolor

# # %% run optim
# with summary_writer.as_default():
#     tf.summary.image("rgb_image", image, step=0)
#     tf.summary.image("input_depth", depth_transform_display(depth), step=0)
#     tf.summary.image("confidence", confidence, step=0)
#     tf.summary.image("random_noise", random_noise, step=0)
#     tf.summary.text("loss_name", LOSS.name, step=0)
#     tf.summary.text("optimiser_name", OPTIMISER._name, step=0)
#     tf.summary.histogram("input_depth_hist", tf.reshape(depth, -1), step=0)
#     summary_writer.flush()

# tv_weight = TV_WEIGTH
# for iteration in range(ITERATIONS):
#     with tf.GradientTape() as tape:
#         print("fw")
#         if PREDICT_IMAGE:
#             predicted_depth_image = model(random_noise, training=True)
#             predicted_depth = tf.expand_dims(predicted_depth_image[:,:,:,0], axis=-1)
#             predicted_image = predicted_depth_image[:,:,:,1:]
#         else:
#             predicted_depth = model(random_noise, training=True)
#         print("loss")
#         pixel_value = LOSS(predicted_depth,depth,confidence) #LOSS(predicted_depth,depth)#LOSS(predicted_depth,depth,confidence)
#         tv_loss_value = tf.image.total_variation(predicted_depth[0])
#         if PREDICT_IMAGE:
#             tv_loss_rgb_value = tf.image.total_variation(predicted_image[0])
#             loss_rgb_value = LOSS(image, predicted_image)
#         if iteration>TV_ITERATION_REDUCE:
#             tv_weight=tv_weight*TV_ITERATION_DECAY
#         loss_value=pixel_value+tv_weight*tv_loss_value
#         if PREDICT_IMAGE:
#             loss_value+=loss_rgb_value+tv_weight*tv_loss_rgb_value

#     print("Iteration %0.4d/%0.4d: loss %0.8f tv: %0.8f"%(iteration, ITERATIONS, loss_value, tv_loss_value ), end="\r")
#     grads = tape.gradient(loss_value, model.trainable_weights)
#     print("opt step")
#     OPTIMISER.apply_gradients(zip(grads, model.trainable_weights))
#     print("tb save")
#     #tensorboard save
#     if iteration%TENSORBOARD_SAVE_STEP==0:
#         with summary_writer.as_default():#(step=iteration) :
#             tf.summary.image("predicted_depth", depth_transform_display(predicted_depth), step=iteration)
#             tf.summary.scalar("loss", loss_value, step=iteration)
#             tf.summary.scalar("tv_loss", tv_loss_value, step=iteration)
#             tf.summary.scalar("mse_loss", pixel_value, step=iteration)
#             tf.summary.scalar("learning_rate", OPTIMISER.learning_rate, step=iteration)#note: this is for adam i think
#             tf.summary.scalar("tv_weight", tv_weight, step=iteration)
#             tf.summary.histogram("predicted_depth_hist", tf.reshape(predicted_depth, -1), step=iteration)
#             if PREDICT_IMAGE:
#                 tf.summary.image("predicted_image", predicted_image, step=iteration)
#                 tf.summary.histogram("predicted_image_hist", tf.reshape(predicted_image, -1), step=iteration)