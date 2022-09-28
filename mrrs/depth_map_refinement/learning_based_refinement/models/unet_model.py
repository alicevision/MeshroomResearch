from typing import List, Tuple
import tensorflow as tf
from tensorflow.keras.layers import Layer
from enum import Enum

class DownSamplingType(Enum):
    """
    Enum for the downsampling used
    """
    NONE = 0
    POOL = 1
    STRIDE = 2

class UpSamplingType(Enum):
    """
    Enum for the downsampling used
    """
    NONE = 0
    BILINEAR = 1
    TRANSPOSE = 2

class ConvolutionBlock(Layer):
    """
    Wrapper around a group of convolutional layers with same parameters.
    """
    def __init__(self, filters, kernel_sizes, padding, activation, nb_convolutions_layers):
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
    """
    Wrapper class around the a downsampling block used in unets (eg downsampling followed by convolutions).
    The convolution are classical, biais enabled stride 1 convs.
    You may change the downsampling method from pool to striding.
    """
    def __init__(self, filters, kernel_sizes,
                       padding='same', activation = tf.nn.leaky_relu,
                       downsampling_type = DownSamplingType.POOL,#FIXME: it mght be stride in the paper
                       downsampling_rate = 2, nb_convolutions_layers = 2):
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
    """
    Wrapper class around the upsampling used in unets (upsampling/deconvolution + convolutions).
    The convolution are classical, biais enabled stride 1 convs.
    You may change the upsampling method from bilinear to transpose convolution.
    """
    def __init__(self, filters, kernel_sizes,
                       padding='same', activation = tf.nn.leaky_relu,
                       upsampling_type = UpSamplingType.BILINEAR,
                       upsampling_rate = 2, nb_convolutions_layers = 2):
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

class Encoder(tf.keras.layers.Layer):
    """
    Encoder part of a unet
    """
    def __init__(self,
                layers_filters=[16, 32, 64, 128, 128, 3], #layer filters, note that first and last layers a normal convolutional layers if input_layer or output_layer is true
                input_layer = True,
                kernel_sizes = 3,
                activation=tf.nn.leaky_relu,
                padding="same"):
        super(Encoder, self).__init__()
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
        self._nb_scales = len(layers_filters)

        self.downsampling_convolutions = []
        for layer_depth, kernel_size in zip(layers_filters, kernel_sizes):
            self.downsampling_convolutions.append(  DownSamplingBlock(layer_depth, kernel_size,
                                                    padding=padding, activation=activation) )
    def call(self, inputs):
        """
        Will return a list of feature maps at each level
        """
        intermediate_feature_map = inputs
        #optional first conv layer
        if self.input_convolution is not None:
            intermediate_feature_map = self.input_convolution(intermediate_feature_map)
        #encoder block
        downsampling_intermediate_feature_maps = [intermediate_feature_map]
        for downsampling_convolution in self.downsampling_convolutions:
            intermediate_feature_map = downsampling_convolution(intermediate_feature_map)
            downsampling_intermediate_feature_maps.append(intermediate_feature_map)
        return downsampling_intermediate_feature_maps

class Decoder(tf.keras.Model):
    """
    Decoder part of a unet
    """
    def __init__(self,
                 layers_filters=[16, 32, 64, 128, 128, 3], #layer filters, note that first and last layers a normal convolutional layers if input_layer or output_layer is true
                 output_layer=True,
                 kernel_sizes = 3,
                 activation=tf.nn.leaky_relu,#will be applied on all layers but the last one
                 last_layer_activation=None,
                 padding="same",
                 skip_connections=True):
        super(Decoder, self).__init__()
        if not isinstance(kernel_sizes, List):
            kernel_sizes = [kernel_sizes for _ in range(len(layers_filters))]
        assert(len(kernel_sizes)==len(layers_filters))
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
        self.upsampling_convolutions = []
        for layer_depth, kernel_size in zip(reversed(layers_filters),  reversed(kernel_sizes)):
            self.upsampling_convolutions.append(  UpSamplingBlock(layer_depth, kernel_size,
                                                    padding=padding, activation=activation) )
        self.skip_connections=skip_connections

    def call(self, inputs):
        """
        Inputs is a list of feature maps from the encoder.
        Use [bottlneck_feature_map] if you have no skip.
        """
        intermediate_feature_map = inputs[-1]
        #decoder block
        for layer_index, upampling_convolution in enumerate(self.upsampling_convolutions):
            if self.skip_connections and layer_index != 0:
                intermediate_feature_map = tf.concat([intermediate_feature_map, inputs[-layer_index-1]], axis=3)
            intermediate_feature_map = upampling_convolution(intermediate_feature_map)
            # print(intermediate_feature_map.shape)
        #optional last layer
        if self.output_convolution is not None:
            output_feature_map = self.output_convolution(intermediate_feature_map)
        return output_feature_map

class Unet(tf.keras.Model):
    """
    TODO: check https://github.com/DmitryUlyanov/deep-image-prior/blob/master/models/skip.py
    they are two model, skip and unets its a mess.
    Can also check https://github.com/yindaz/DeepCompletionRelease
    """
    def __init__(self,
                 layers_filters=[16, 32, 64, 128, 128, 3], #layer filters, note that first and last layers a normal convolutional layers if input_layer or output_layer is true
                 input_layer = True, output_layer=True,
                 kernel_sizes = 3,#note kernel size is constant in the paper
                 activation=tf.nn.leaky_relu,#will be applied on all layers but the last one
                 last_layer_activation=None,#tf.nn.sigmoid,#in the paper, the last layer has a sigmoid activation
                 padding="same",
                 skip_connections=True):#skip connection is at all stages of the unet (eg output at each step) FIXME: also add case with input layers?
        """
        Creates a Unet parametrically.
        The most important parameter is layers_filters, that defines the fiter depth of the downsampling and upsampling parts (they are symetrical)
        You may want your input to be a multiple of 2.
        input_layer = True, output_layer=True are to add a simple layer of normal convolution at the input or output., just make sure to add their filter size at the begining and end of layers_filters
        kernel_sizes can be a scalar or a list to specify filter size for each layer.
        Note the size of the filters are not known at this point, and the weigts will be instantiated during the first call.
        activation will define the activations for all blocks, last_layer_activation will be specific for the last.
        skip_connections will concatenate the ouptut of the encoder at multiple levels at the decodig stage.
        """
        super(Unet, self).__init__()

        if not isinstance(kernel_sizes, List):
            kernel_sizes = [kernel_sizes for _ in range(len(layers_filters))]

        assert(len(kernel_sizes)==len(layers_filters))

        layers_filters_encoder = layers_filters
        kernel_sizes_encoder = kernel_sizes
        layers_filters_decoder = layers_filters
        kernel_sizes_decoder = kernel_sizes

        if input_layer:
            layers_filters_decoder = layers_filters[1:]
            kernel_sizes_decoder = kernel_sizes[1:]
        if output_layer:
            layers_filters_encoder = layers_filters[:-1]
            kernel_sizes_encoder = kernel_sizes[:-1]

        self.encoder = Encoder(layers_filters_encoder, input_layer, kernel_sizes_encoder, activation, padding)
        self.decoder = Decoder(layers_filters_decoder, output_layer, kernel_sizes_decoder, activation,
                               last_layer_activation, padding, skip_connections)

        self.skip_connections=skip_connections

    @tf.function
    def call(self, inputs):
        """
        Returns the decded output along with the intermetiate encoder feature maps.
        """
        #by default, multiple tensors are concatenated
        if hasattr(inputs, '__len__') :#FIXME: ugly but could find workaround, also wont do in export
            inputs = tf.concat(inputs, axis=3)
        encoded_outputs = self.encoder(inputs)
        # for encoded_output in encoded_outputs:
        #     print(encoded_output.shape)
        # print("---")
        decoder_output = self.decoder(encoded_outputs)
        # print(decoder_output.shape)
        return decoder_output, tf.constant(0)

class MultimodalUnet(tf.keras.Model):
    """
    Unet
    """
    def __init__(self,
                 encoding_branches = 2,
                 decoding_branches = 1,
                 layers_filters=[16, 32, 64, 128, 128, 3], #layer filters, note that first and last layers a normal convolutional layers if input_layer or output_layer is true
                 input_layer = True, output_layer=True,
                 kernel_sizes = 3,#note kernel size is constant in the paper
                 activation=tf.nn.leaky_relu,#will be applied on all layers but the last one
                 last_layer_activation=None,#tf.nn.sigmoid,#in the paper, the last layer has a sigmoid activation
                 padding="same",
                 skip_connections=True):#skip connection is at all stages of the unet (eg output at each step) FIXME: also add case with input layers?
        super(MultimodalUnet, self).__init__()
        if not isinstance(kernel_sizes, List):
            kernel_sizes = [kernel_sizes for _ in range(len(layers_filters))]
        assert(len(kernel_sizes)==len(layers_filters))

        self._nb_scales = len(layers_filters) #touching this has side effects

        self.encoders = [Encoder(layers_filters, input_layer, kernel_sizes, activation, padding) for _ in range(encoding_branches)]
        self.decoders = [Decoder(layers_filters, output_layer,kernel_sizes, activation,
                               last_layer_activation, padding, skip_connections) for _ in range(decoding_branches)]
        self.skip_connections=skip_connections

    def call(self, inputs):
        """
        Inputs must be a list, even with a single element
        """
        encoded_outputs=[encoder(input) for encoder, input in zip(self.encoders, inputs) ]
        #stack at bottleneck
        bottleneck = tf.concatenate(encoded_outputs, axis=-1)

        decoder_output=[decoder(encoded_outputs) for decoder, encoded_outputs in zip(self.decoders, encoded_outputs)]

        return decoder_output
