from typing import List
import tensorflow as tf
from tensorflow.keras.layers import Layer 
from enum import Enum

class DownSamplingType(Enum):
    NONE = 0
    POOL = 1
    STRIDE = 2

class UpSamplingType(Enum):
    NONE = 0
    BILINEAR = 1
    TRANSPOSE = 2

class ConvolutionBlock(Layer):
    def __init__(self, filters, kernel_sizes, padding, activation, nb_convolutions_layers):
        """
        Wrapper around a group of convolutional layers with same parameters.
        """
        super(ConvolutionBlock, self).__init__()
        self.convolution_layers = []
        for _ in range(nb_convolutions_layers):
            self.convolution_layers.append(tf.keras.layers.Conv2D(filters, kernel_sizes, padding=padding, activation=activation))

    def call(self, inputs):
        outputs=inputs
        for convolution_layer in self.convolution_layers:
            outputs= convolution_layer(outputs)
        return outputs

class DownSamplingBlock(tf.keras.layers.Layer):
    def __init__(self, filters, kernel_sizes, 
                       padding='same', activation = tf.nn.leaky_relu, 
                       downsampling_type = DownSamplingType.POOL,#FIXME: it mght be stride in the paper
                       downsampling_rate = 2, nb_convolutions_layers = 2):
        """
        Wrapper class around the a downsampling block used in unets (eg downsampling followed by convolutions).
        The convolution are classical, biais enabled stride 1 convs.
        You may change the downsampling method from pool to striding.
        """
        super(DownSamplingBlock, self).__init__()
        if downsampling_type == DownSamplingType.NONE:
            self.downsampling = tf.keras.Layer()#note: default of layer is identity
        elif downsampling_type == DownSamplingType.POOL:
            self.downsampling = tf.keras.layers.MaxPool2D(pool_size=(downsampling_rate, downsampling_rate))
        elif downsampling_type == DownSamplingType.STRIDE:
            self.downsampling = lambda tensor:tensor[:,::downsampling_rate, ::downsampling_rate, :]#lambda that slices along image dims, note: could also use striding in conv2
        else:
            raise RuntimeError("Invalid downsampling type")
        self.convolution_layers = ConvolutionBlock(filters, kernel_sizes, padding, activation, nb_convolutions_layers)

    def call(self, inputs):
        outputs = self.downsampling(inputs)
        outputs = self.convolution_layers(outputs)
        return outputs

class UpSamplingBlock(tf.keras.layers.Layer):
    def __init__(self, filters, kernel_sizes, 
                       padding='same', activation = tf.nn.leaky_relu, 
                       upsampling_type = UpSamplingType.BILINEAR,
                       upsampling_rate = 2, nb_convolutions_layers = 2):
        """
        Wrapper class around the upsampling used in unets (upsampling/deconvolution + convolutions).
        The convolution are classical, biais enabled stride 1 convs.
        You may change the upsampling method from bilinear to transpose convolution.
        """
        super(UpSamplingBlock, self).__init__()
        if upsampling_type == UpSamplingType.NONE:
            self.upsampling = tf.keras.Layer()#note: default of layer is identity
        elif upsampling_type == UpSamplingType.BILINEAR:
            self.upsampling = tf.keras.layers.UpSampling2D(size=(upsampling_rate, upsampling_rate), interpolation='bilinear')
        elif upsampling_type == UpSamplingType.TRANSPOSE:
            self.upsampling = tf.keras.layers.Conv2DTranspose(
                                filters, kernel_sizes, padding=padding,
                                activation=activation, strides = (upsampling_rate, upsampling_rate))
        else:
            raise RuntimeError("Invalid downsampling type")
        
        self.convolution_layers = ConvolutionBlock(filters, kernel_sizes, padding, activation, nb_convolutions_layers)
    
    def call(self, inputs):
        outputs = self.upsampling(inputs)
        outputs = self.convolution_layers(outputs)
        return outputs

class Unet(tf.keras.Model):
    """
    TODO: check https://github.com/DmitryUlyanov/deep-image-prior/blob/master/models/skip.py
    they are two model, skip and unets its a mess.
    Can also check https://github.com/yindaz/DeepCompletionRelease
    """
    def __init__(self,
                 layers_filters=[16, 32, 64, 128, 128, 3], #layer filters, note that first and last layers a normal convolutional layers if input_layer or output_layer is true
                 input_layer = True, output_layer=True,
                 kernel_sizes = 3,#note kernel size is constant is the paper
                 activation=tf.nn.leaky_relu,#will be applied on all layers but the last one
                 last_layer_activation=tf.nn.sigmoid,#in the paper, the last layer has a sigmoid activation
                 padding="same",
                 skip_connections=True):#skip connection is at all stages of the unet (eg output at each step) FIXME: also add case with input layers?
        """
        Creates a Unet parametrically.
        The most important parameter is layers_filters, that defines the fiter depth of the downsampling and upsampling parts (they are symetrical)
        You may want your input to be a multiple of 2.
        input_layer = True, output_layer=True are to add a simple layer of normal convolution at the input or output., just make sure to add their filter size at the begining and end of layers_filters
        kernel_sizes can be a scalar or a list to specify filter size for each layer.
        Note the size of the filters are not know at this point, and the weigts will be instantiated during the first call. 
        """
        super(Unet, self).__init__()

        if not isinstance(kernel_sizes, List):
            kernel_sizes = [kernel_sizes for _ in range(len(layers_filters))]
        
        assert(len(kernel_sizes)==len(layers_filters))

        self.input_convolution = None
        if input_layer:
            first_layer_depth = layers_filters.pop(0)
            first_layer_kernel_size = kernel_sizes.pop(0)
            self.input_convolution = tf.keras.layers.Conv2D(first_layer_depth, first_layer_kernel_size,
                                                            padding=padding, activation=activation,
                                                            name='input_convolution')
        
        self.output_convolution = None
        if output_layer:
            last_layer_depth = layers_filters.pop(-1)
            last_layer_kernel_size = kernel_sizes.pop(-1)
            self.output_convolution = tf.keras.layers.Conv2D(last_layer_depth, last_layer_kernel_size, 
                                                             padding=padding, activation=last_layer_activation,
                                                             name='output_convolution')
        elif last_layer_activation is not None:
            raise BaseException("You must have output_layer True to use last_layer_activation")

        self._nb_scales = len(layers_filters) #touching this has side effects

        self.downsampling_convolutions = []
        for kernel_size, layer_depth in zip(layers_filters, kernel_sizes):
            self.downsampling_convolutions.append(  DownSamplingBlock(layer_depth, kernel_size, 
                                                    padding=padding, activation=activation) )
        self.upsampling_convolutions = []
        for kernel_size, layer_depth in zip(reversed(layers_filters),  reversed(kernel_sizes)):
            self.upsampling_convolutions.append(  UpSamplingBlock(layer_depth, kernel_size, 
                                                    padding=padding, activation=activation) )

        self.skip_connections=skip_connections

    def call(self, inputs):
        intermediate_feature_map = inputs

        #optional first conv layer
        if self.input_convolution is not None:
            intermediate_feature_map = self.input_convolution(intermediate_feature_map)
        #encoder block
        downsampling_intermediate_feature_map = []
        for downsampling_convolution in self.downsampling_convolutions:
            intermediate_feature_map = downsampling_convolution(intermediate_feature_map)
            downsampling_intermediate_feature_map.append(intermediate_feature_map)
        
        #decoder block
        for layer_index, upampling_convolution in enumerate(self.upsampling_convolutions):
            input = intermediate_feature_map
            if self.skip_connections:
                input = tf.concat([input, downsampling_intermediate_feature_map[self._nb_scales-layer_index-1]], axis=-1)
            intermediate_feature_map = upampling_convolution(input)
        #optional last layer
        if self.output_convolution is not None:
            intermediate_feature_map = self.output_convolution(intermediate_feature_map)

        return intermediate_feature_map

# def unet_conv_block(inputs, nch):
#     outputs = tf.layers.conv2d(inputs, nch, 3, padding='same', activation=tf.nn.relu, \
#                                kernel_initializer=tf.contrib.layers.xavier_initializer())

#     outputs = tf.layers.conv2d(outputs, nch, 3, padding='same', activation=tf.nn.relu, \
#                                kernel_initializer=tf.contrib.layers.xavier_initializer())
    
#     return outputs

# class Unet(tf.keras.Model):
#     def __init__(self):



    
# def unet_upsample(inputs, nlayers=4):
#     outputs = {}
#     outputs[1] = unet_conv_block(inputs, 32)
#     for layer in range(2, nlayers+1):
#         _tmp = tf.layers.max_pooling2d(outputs[layer-1], pool_size=2, strides=2, padding='same')
#         outputs[layer] = unet_conv_block(_tmp, _tmp.shape[-1]*2) 
        
#     # intermediate layers
#     _tmp = tf.layers.max_pooling2d(outputs[nlayers], pool_size=2, strides=2, padding='same')
#     _tmp = tf.layers.conv2d(_tmp, _tmp.shape[3], 3, padding='same', \
#                             activation=tf.nn.relu, kernel_initializer=tf.contrib.layers.xavier_initializer())
#     for layer, nch in zip(range(1, nlayers+1), (128, 64, 32, 32)):
#         _tmp = tf.image.resize_images(_tmp, (2*_tmp.shape[1], 2*_tmp.shape[2]))
#         _tmp = tf.concat([outputs[nlayers-layer+1], _tmp], 3)
#         _tmp = unet_conv_block(_tmp, nch)

#     _tmp = tf.layers.conv2d(_tmp, 16, 1, padding='valid', \
#                             kernel_initializer=tf.contrib.layers.xavier_initializer(), \
#                             activation=tf.nn.relu)
#     _tmp = tf.layers.conv2d(_tmp, inputs.shape[-1],  1, padding='valid', \
#                             kernel_initializer=tf.contrib.layers.xavier_initializer(), \
#                             activation=tf.nn.tanh)
#     return _tmp    
        
# class Denoise(Model):#from tf tuto
#   def __init__(self):
#     super(Denoise, self).__init__()
#     self.encoder = tf.keras.Sequential([
#       tf.layers.Input(shape=(28, 28, 1)),
#       tf.layers.Conv2D(16, (3, 3), activation='relu', padding='same', strides=2),
#       tf.layers.Conv2D(8, (3, 3), activation='relu', padding='same', strides=2)])

#     self.decoder = tf.keras.Sequential([
#       tf.layers.Conv2DTranspose(8, kernel_size=3, strides=2, activation='relu', padding='same'),
#       tf.layers.Conv2DTranspose(16, kernel_size=3, strides=2, activation='relu', padding='same'),
#       tf.layers.Conv2D(1, kernel_size=(3, 3), activation='sigmoid', padding='same')])

#   def call(self, x):
#     encoded = self.encoder(x)
#     decoded = self.decoder(encoded)
#     return decoded
