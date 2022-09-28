import numpy as np
import tensorflow as tf

#%% Stereonet upsampling step
class ResnetBlockNoBN(tf.keras.Model):
    """
    Simple Resnet block with no batchnorm.
    """
    def __init__(self, filters=16, kernel_size=3, activation=tf.nn.relu, dilation_rate=1):
        super(ResnetBlockNoBN, self).__init__()
        self.conv1 = tf.keras.layers.Conv2D(filters, kernel_size, activation=activation, padding='same', dilation_rate=dilation_rate)
        self.conv2 = tf.keras.layers.Conv2D(filters, kernel_size, activation=activation, padding='same', dilation_rate=dilation_rate)
        self.activation =  activation

    @tf.function
    def call(self, input_tensor):
        output = self.conv1(input_tensor)
        output = self.conv2(output)#pass into 2 conv layers
        output = tf.add(output, input_tensor)#the add skip
        output = self.activation(output)#extra activation
        return output#FIXME: naming

class ResnetEncodingLayer(tf.keras.Model):
    """
    Small conv+bn+2*resnet block encoding layer.
    """
    def __init__(self, filters=16, kernel_size=3, activation = tf.nn.leaky_relu):
        super(ResnetEncodingLayer, self).__init__()
        self.activation=activation
        self.input_conv = tf.keras.layers.Conv2D(filters=filters, kernel_size=kernel_size, activation=None, padding='same')
        self.input_conv_BN =  tf.keras.layers.BatchNormalization()
        self.resnet_block_1 = ResnetBlockNoBN(filters=filters, kernel_size=kernel_size, dilation_rate=1)
        self.resnet_block_2 = ResnetBlockNoBN(filters=filters, kernel_size=kernel_size, dilation_rate=2)

    @tf.function
    def call(self, input_tensor, training=False):
        output_tensor = self.input_conv(input_tensor)#first non activated conv (bn after activation)
        output_tensor = self.input_conv_BN(output_tensor, training=training)#BN bofre the resnet blocks
        output_tensor = self.activation(output_tensor)#activation after BN
        output_tensor = self.resnet_block_1(output_tensor)
        output_tensor = self.resnet_block_2(output_tensor)  #two resnet blocks makes for a small encoding, we use dilation 1&2 to augment receptive field
        return output_tensor

class GuidedDepthMapRefinement(tf.keras.Model):
    """
    Model that uses an rgb image to guide a depth map refinement.
    Based on stereonet TODO: add ref
    """
    def __init__(self, learn_residual=True, output_scale=None):
        """
        If learn_residual is true (default), will predict a residual and add it to the depth map.
        Otherwise will predict the depth map directly.
        If output_scale, is not none, will activate
        """
        super(GuidedDepthMapRefinement, self).__init__()
        self.depth_encoding_layer = ResnetEncodingLayer(filters=16, kernel_size=3)
        self.image_encoding_layer = ResnetEncodingLayer(filters=16, kernel_size=3)
        self.resnet_block_1 = ResnetBlockNoBN(filters=32, kernel_size=3, dilation_rate=4)
        self.resnet_block_2 = ResnetBlockNoBN(filters=32, kernel_size=3, dilation_rate=8)
        self.resnet_block_3 = ResnetBlockNoBN(filters=32, kernel_size=3, dilation_rate=1)
        self.resnet_block_4 = ResnetBlockNoBN(filters=32, kernel_size=3, dilation_rate=1)
        self.output_conv = tf.keras.layers.Conv2D(filters=1, kernel_size=3, padding='same', activation=None)
        self.learn_residual=learn_residual
        self.output_scale=output_scale

    @tf.function
    def call(self, inputs, training=False):
        #input_depth_map, input_image = inputs #input packed for the keras fit api
        input_depth_map = inputs[0]
        input_image = inputs[1] #supports tuples, lists and tensor alike
        # tf.debugging.assert_equal(input_depth_map.shape[0:3],input_image.shape[0:3])
        #encodes depth and images, this is multimodal so we use different encoding heads
        encoded_depth = self.depth_encoding_layer(input_depth_map, training)
        encoded_image = self.image_encoding_layer(input_image, training)
        #stack the features
        depth_image_concatenation = tf.concat([encoded_depth, encoded_image],axis=-1)
        #pass it into 4 resnet blocks to perform the refinement
        concat_out = self.resnet_block_1(depth_image_concatenation)
        concat_out = self.resnet_block_2(concat_out)
        concat_out = self.resnet_block_3(concat_out)
        concat_out = self.resnet_block_4(concat_out)
        #output convolution with no activation
        depth_output = self.output_conv(concat_out)
        #if a scale is passed, will activate with tanh (-1;1) and scale residual or output depth
        if self.output_scale:
            depth_output = self.output_scale*tf.nn.tanh(depth_output)
        #adds the correction to the input depth
        if self.learn_residual:
            return input_depth_map + depth_output, depth_output#FIXME: could try to bound residual (tanh?) for faster convergence
        #or direclty return predicted depth map
        return depth_output, None

class HierachicalGuidedDepthMapRefinement(tf.keras.Model):
    """
    Depth refinemnt in a coarse-to-fine fashion.
    """
    def __init__(self, scales_downsampling=[8,4,2], auto_scale_depth=False, output_scale=None):
        """
        Make sure the depth scales are in decreasing order.
        Note: for best results, make sure your image is divisible by scales the input scales.
        Also, for an upsampling only, make sure your low res depth map is of the same size as the lowest scale.
        Will return the final depth map and the intermediate depth maps (usefull for supervision).
        If autoscae is true, will automatically adjust the depth values to match the depth resolution (usefull to reason at the predicted depth resolution)
        """
        super(HierachicalGuidedDepthMapRefinement, self).__init__()
        self.scales_downsampling = scales_downsampling#FIXME: test sort or autosort
        self.guided_refinement_nets = [GuidedDepthMapRefinement(output_scale=output_scale) for _ in scales_downsampling]
        self.auto_scale_depth = auto_scale_depth
        self.resize_method = "bilinear"#imaeg resizeing method

    #@tf.function #oom for now
    def call(self, inputs, training=False):
        # input_depth_map, input_image = inputs#input packed for the keras fit api
        input_depth_map = inputs[0]
        input_image = inputs[1] #keras api does not suport unpacking
        image_size = np.asarray(input_image.shape.as_list())[1:3]
        # iteratively pass into refinement networks (no shared weigts)
        last_depth = input_depth_map
        refined_depth_scale = []
        for scale, guided_refinement_net in zip(self.scales_downsampling,  self.guided_refinement_nets):
            #resize input image
            new_image_size = image_size/scale#FIXME: does not work in keras api, returns None
            depth_size = np.asarray(last_depth.shape.as_list()[1:3])
            image = tf.image.resize(input_image, new_image_size, preserve_aspect_ratio=True, method=self.resize_method)
            # print("Image %dx%d -> %dx%d at scale 1/%d"%(image_size[0], image_size[1], new_image_size[0], new_image_size[1], scale))
            # print("Depth %dx%d -> %dx%d (by %f)"%(depth_size[0],depth_size[1], new_image_size[0], new_image_size[1], depth_scale))
            #resize previous depth to the size of the resized image ideally 1 for first it, then 2
            last_depth = tf.image.resize(last_depth, new_image_size, preserve_aspect_ratio=True, method=self.resize_method)
            # #depth scale after resize (usefull to direclty use the depth output)
            if self.auto_scale_depth:
                #scale_factor btw image resized image and depth, ideally should be 2
                depth_scale = (depth_size/new_image_size)[0]#TODO add test shoud be == in axis
                last_depth *= depth_scale
            #refine previous depth at the current scale
            last_depth, _ = guided_refinement_net((last_depth, image), training)
            #save intermediate step for suppervision
            refined_depth_scale.append(last_depth)
        #resize the demap to the full image resolution regardless of the actuall scale #FIXME: dangerous behaviour?
        # print("Depth %dx%d -> %dx%d (by %d)"%(depth_size[0],depth_size[1], image_size[0], image_size[1], depth_scale))
        last_depth = tf.image.resize(last_depth, image_size, preserve_aspect_ratio=True, method=self.resize_method)
        return last_depth, refined_depth_scale
#%%

