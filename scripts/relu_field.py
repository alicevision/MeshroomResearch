
#%%
"""
Trains a relu field to learn a depth map.
Uses confidence to weight the relu field.
"""
import os
from datetime import datetime
import tensorflow as tf

from mrrs.core.ios import open_depth_map, open_image
from mrrs.core.utils import norm_01

print("HELLO!")
print("TF version:")
print(tf.__version__)
print("Gpus:")
print(tf.config.list_physical_devices('GPU'))

#meshroom outputs
IMAGE_PATH =      None#"todo\\00000004.jpg"
DEPTH_PATH =      "C:\\runs\\test_relufield.png"#"C:\\runs\\tests_video_photog\\krab\\MeshroomCache\\DepthMap\\92b189f232a8ad5a275fe546c132c1f197ecd2cf\\50230604_depthMap.exr"
DEPTH_GT_PATH = None
# CONFIDENCE_PATH = "C:\\runs\\tests_video_photog\\krab\\MeshroomCache\\DepthMap\\92b189f232a8ad5a275fe546c132c1f197ecd2cf\\50230604_simMap.exr"
FIELD_SIZE = [16, 16, 1]

TENSORBOARD_LOGDIR = os.path.join("./tensorboard_logs", datetime.now().strftime('%Y-%m-%d %H-%M-%S'))

#optimiser params
class l1:
    name = "l1"
    def __call__(self, x,y):
        return  tf.reduce_sum(tf.abs(x-y))
LOSS = l1()
LEARNING_RATE = 0.01
BATCH_SIZE = 10000
OPTIMISER = tf.keras.optimizers.Adam(learning_rate=LEARNING_RATE)
EPOCHS = 100000
#stop condition, variance of avg loss from last epochs is lower than the
# STOP_CONDITION_LOSS = lambda losses_per_epoch: tf.math.reduce_variance(losses_per_epoch[:-5])<
# PREDICT_COLORS = True

#%% prepare data

#opens and batch
# image=open_image(IMAGE_PATH)
depth=tf.expand_dims(open_image(DEPTH_PATH), axis=0)#tf.expand_dims(open_depth_map(DEPTH_PATH), axis=0)
depth=norm_01(depth)
# confidence=1-norm_01(open_exr(CONFIDENCE_PATH))#inverse confidence

print("Depth range : %f - %f"%(tf.reduce_min(depth), tf.reduce_max(depth)))
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

#tensorboard
summary_writer = tf.summary.create_file_writer(TENSORBOARD_LOGDIR)
print("Created logdir "+TENSORBOARD_LOGDIR)

#display transform
def depth_transform_display(depth): #meshroom
    return depth
    # depth_falsecolor = tf.identity(depth)
    # depth_falsecolor = norm_01(depth_falsecolor)
    # depth_falsecolor = depth_falsecolor.numpy()*255
    # depth_falsecolor = np.concatenate([depth_falsecolor, depth_falsecolor, depth_falsecolor], axis=-1)
    # depth_falsecolor = depth_falsecolor.astype(np.uint8)
    # return depth_falsecolor

#%% model def

#2d bilinear interpolation
def bilinear_interpolation2D(array, input_coordinates):
    """
    Returns values of array at coordinates input_coordinates using bilinear interpolation.
    """
    x = input_coordinates[:,0]
    y = input_coordinates[:,1]
    #indices for linear interpolation
    y1 = tf.floor(y)
    y2 = y + 1
    x1 = tf.floor(x)
    x2 = x1 + 1

    #assemble interpolation indices
    interp_pts_1 = tf.stack([y1, x1], -1)
    interp_pts_2 = tf.stack([y2, x1], -1)
    interp_pts_3 = tf.stack([y1, x2], -1)
    interp_pts_4 = tf.stack([y2, x2], -1)

    #gather values to be interpolated
    pixel_0 = tf.gather_nd(array, tf.cast(interp_pts_1, tf.int32))
    pixel_1 = tf.gather_nd(array, tf.cast(interp_pts_2, tf.int32))
    pixel_2 = tf.gather_nd(array, tf.cast(interp_pts_3, tf.int32))
    pixel_3 = tf.gather_nd(array, tf.cast(interp_pts_4, tf.int32))

    #interpolation weights
    y1_f = tf.cast(y1, tf.float32)
    x1_f = tf.cast(x1, tf.float32)
    d_y1 = 1.0 - (y - y1_f)
    d_y2 = 1.0 - d_y1
    d_x1 = 1.0 - (x - x1_f)
    d_x2 = 1.0 - d_x1
    w1 = d_y1 * d_x1
    w2 = d_y2 * d_x1
    w3 = d_y1 * d_x2
    w4 = d_y2 * d_x2

    # broadcast weigt along last dim!!
    w1 = tf.expand_dims(w1, axis=-1)
    w2 = tf.expand_dims(w2, axis=-1)
    w3 = tf.expand_dims(w3, axis=-1)
    w4 = tf.expand_dims(w4, axis=-1)

    return w1*pixel_0+w2*pixel_1+w3*pixel_2+w4*pixel_3

def bilinear_interpolation(array, input_coordinates):
    """
    Returns values of n-dims tensor at coordinates input_coordinates using bilinear interpolation.
    The tensor must have a final dims (even if dimentionality is 1)
    """
    dims = len(array.shape)-1#D
    # assert(dims == input_coordinates.shape[-1])

    #indices for linear interpolation
    floored_indices = tf.floor(input_coordinates)#NxD
    ceil_indices = floored_indices+1#NxD
    floor_ceil_coords = tf.stack([floored_indices, ceil_indices], axis=1)#Nx2xD ?

    #assemble interpolation indices on last dim
    interp_points = []# https://github.com/tensorflow/tensorflow/issues/37512 !!!!
    for floor_ceil_coord in floor_ceil_coords:#FIXME: loop costly
        neighbour_indices = tf.meshgrid(*tf.split(floor_ceil_coord, dims, axis=1), indexing='ij' )#all cobinations of floored and flored+1 indices
        neighbour_indices = tf.stack([tf.reshape(ni, [-1]) for ni in neighbour_indices], axis=1) #2**Dx2
        interp_points.append(neighbour_indices)
    interp_points = tf.stack(interp_points, axis=0)#Nx2**DxD

    #gather values to be interpolated
    values = []
    for neigt in range(2**dims):
        values.append(tf.gather_nd(array, tf.cast(interp_points[:,neigt,:], tf.int32)))
    values = tf.stack(values, axis=1)#Nx2**DxD

    #interpolation weights
    interpolation_weigts = []
    for neigt in range(2**dims):#FIXME: loads of unoptimal computations but simplifies the code
        interpolation_weigts.append(tf.reduce_prod(tf.abs(interp_points[:,neigt,:]-input_coordinates), axis=-1))
    interpolation_weigts = tf.expand_dims(tf.stack(interpolation_weigts, axis=1), axis=-1)#Nx2**DxDx1, expand to broadcast to last grud value
    #return weigted sum
    interpolated_results = tf.reduce_sum(values*interpolation_weigts, axis=1)

    return interpolated_results

class ReluField(tf.keras.Model):
    """
    Relu fields learn a unbouded representation of a signal.
    At forward, it passes it into a bilinear intropoaltion and a relu.
    """
    def __init__(self, grid_size, activation = tf.nn.relu):
        super(ReluField, self).__init__()
        initial_grid = tf.random.uniform(grid_size)#tf.zeros(grid_size)
        # self._field = tf.Variable(tf.squeeze(initial_grid), dtype=tf.float32, trainable=True)#not deeper?
        self._field = tf.Variable(initial_grid, dtype=tf.float32, trainable=True)
        self.activation = activation

    # @tf.function
    def call(self, input_coordinates):
        """
        Return the value corresponding to the position in the grid, using bilinear interpolation.
        The coordinates are assumed to be normalised bewteen 0 and 1.
        """
        # assert(tf.reduce_all(0<=input_coordinates)), "Invalid dim"
        # assert(tf.reduce_all(input_coordinates<1) ), "Invalid dim"
        # input_coordinates = input_coordinates*tf.cast(self._field.shape, tf.float32)
        input_coordinates = input_coordinates*tf.cast(self._field.shape[:-1], tf.float32)
        return self.activation(bilinear_interpolation(self._field, input_coordinates))

    def train_step(self, input_data):
        input_coordinates, gt_values = input_data
        with tf.GradientTape() as tape:
            predicted_value = self(input_coordinates)
            loss = self.compiled_loss(predicted_value, gt_values, regularization_losses=self.losses)
        #compute gradients
        trainable_vars = self.trainable_variables
        gradients = tape.gradient(loss, trainable_vars)
        #update variables
        self.optimizer.apply_gradients(zip(gradients, trainable_vars))
        #update metrics
        self.compiled_metrics.update_state(y, gt_values)
        # Return a dict mapping metric names to current value
        return {m.name: m.result() for m in self.metrics}

#%% Init
#create and init field
field = ReluField(FIELD_SIZE)
#pixel coordinates
ys,xs = tf.meshgrid(tf.range(0, depth.shape[1]),
                    tf.range(0, depth.shape[2]),
                    indexing="ij")
ys=tf.reshape(ys, [-1])
xs=tf.reshape(xs, [-1])

pixels_coordinates = tf.stack([xs,ys], axis=-1)
#buffer
latest_prediction = tf.zeros_like(depth)

#%% train with fit
pixels_coordinates = tf.stack([xs/depth.shape[1],ys/depth.shape[1]], axis=-1)
gt_d=tf.reshape(depth, [-1])
field.compile(optimizer="adam", loss="mse", metrics=["mae"])
field.fit(pixels_coordinates, gt_d, epochs=3)

# # %% train custom loop
# with summary_writer.as_default():
#     # tf.summary.image("rgb_image", image, step=0)
#     tf.summary.image("input_depth", depth_transform_display(depth), step=0)
#     # tf.summary.image("confidence", confidence, step=0)
#     tf.summary.text("loss_name", LOSS.name, step=0)
#     tf.summary.text("optimiser_name", OPTIMISER._name, step=0)
#     tf.summary.histogram("input_depth_hist", tf.reshape(depth, -1), step=0)
#     summary_writer.flush()
# print("Will optimise with %d batches of %d pixels"%( (depth.shape[1]*depth.shape[2])/BATCH_SIZE, BATCH_SIZE))
# for epoch in range(EPOCHS):
#     #random.shuffle(mylist)
#     loss_values = []
#     def chunker(seq, size):
#         return [seq[pos:pos + size] for pos in range(0, seq.shape[0], size)]
#     for i, pixel_coordinates in enumerate(chunker(pixels_coordinates, BATCH_SIZE)):#FIXME:  randomize
#         with tf.GradientTape() as tape:
#             x=pixel_coordinates[:,0]
#             y=pixel_coordinates[:,1]
#             norm_coordinates = tf.cast(tf.stack([x/depth.shape[2],y/depth.shape[1]], axis=-1),tf.float32)
#             # print(coordinates)
#             predicted_value = field(norm_coordinates)
#             # print(predicted_value)
#             #gt_values = tf.gather_nd(tf.squeeze(depth), pixel_coordinates)
#             gt_values = tf.gather_nd(depth[0], pixel_coordinates)
#             loss_value = LOSS(predicted_value, gt_values)
#             loss_values.append(loss_value)
#             print("Epoch %d Iteration %0.4d/%0.4d: loss %0.8f"%(epoch, i, BATCH_SIZE, loss_value ), end="\r")
#             grads = tape.gradient(loss_value, field.trainable_weights)
#             OPTIMISER.apply_gradients(zip(grads, field.trainable_weights))
#         #for display
#         #latest_prediction = tf.tensor_scatter_nd_update(tf.squeeze(latest_prediction), pixel_coordinates, predicted_value)
#         latest_prediction = tf.tensor_scatter_nd_update(latest_prediction[0], pixel_coordinates, predicted_value)
#         latest_prediction = tf.expand_dims(latest_prediction, 0)
#     with summary_writer.as_default():
#         tf.summary.image("predicted_depth", depth_transform_display(latest_prediction), step=epoch)
#         tf.summary.scalar("loss", tf.reduce_sum(loss_values), step=epoch)
#         tf.summary.histogram("predicted_depth_hist", tf.reshape(latest_prediction, -1), step=epoch)
#         tf.summary.histogram("field_hist", tf.reshape(field._field, -1), step=epoch)#TODO: display hist
#         # if PREDICT_COLORS:
#         #     tf.summary.image("predicted_image", predicted_image, step=iteration)
#         #     tf.summary.histogram("predicted_image_hist", tf.reshape(predicted_image, -1), step=iteration)
