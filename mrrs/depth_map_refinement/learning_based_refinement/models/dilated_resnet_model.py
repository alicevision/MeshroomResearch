import tensorflow as tf

class DRN():
    """Dilated Residual Network for semantic segmentation
    This class creates either an 18 or 26 layer dilated residual network.
    The is_training flag is used to switch between training and evaluation
    mode.

    Args:
        image: 4D tensor, input image
        image_dims: list, dimensions for input rows, columns and channels
        batch_size: int, number of images in batch
        num_classes: int, number of class maps to produce at output
        is_training: bool, flag to indicate whether model is being trained
        network: string, choice of network, must be either 'DRN18' or 'DRN26'
    """

    def __init__(self, image, image_dims, batch_size, num_classes, is_training, network):
        self.image = image
        self.batch_size = batch_size
        self.num_classes = num_classes
        self.is_training = is_training
        self.image_dims = image_dims

        if network == 'DRN18':
            self.build_DRN18()
        elif network == 'DRN26':
            self.build_DRN26()
        else:
            raise RuntimeError("Invalid network type")

    def batch_norm(self, X, is_training, decay=0.999):
        """Batch normalization
        The offset (beta) should always be used, but the scale is not
        necessary for activation function like relu. beta and scale will
        have the same shape as the bias i.e. the no. of features. Code
        source https://gist.github.com/tomokishii/0ce3bdac1588b5cca9fa5fbdf6e1c412
        Args:
            X: 4D tensor, image or feature map
            is_training: bool, flag to indicate whether model is being trained
            decay: decay rate for exponential moving average
        Returns:
            X: 4D tensor, batch normalized tensor for input X
        """

        scale = tf.Variable(tf.ones([X.get_shape()[-1]]))
        beta = tf.Variable(tf.zeros([X.get_shape()[-1]]))
        epsilon = 1e-6

        batch_mean, batch_var = tf.nn.moments(X, [0, 1, 2])
        ema = tf.train.ExponentialMovingAverage(decay)

        def mean_var_with_update():
            ema_apply_op = ema.apply([batch_mean, batch_var])
            with tf.control_dependencies([ema_apply_op]):
                return tf.identity(batch_mean), tf.identity(batch_var)

        mean, var = tf.cond(is_training,
                            mean_var_with_update,
                            lambda: (ema.average(batch_mean), ema.average(batch_var)))

        X = tf.nn.batch_normalization(X, mean, var, beta, scale, epsilon)

        return X

    def conv_repeat(self, X, strides, dilation, kernel, residual, name):
        """Performs convolution with residual block

        Args:
            X: 4D tensor, image or feature map
            strides: int, stride for convolution
            dilation: list/int, factor by which convolution kernel is dilated
            kernel:  list, 3 elements - size of kernel and number of filters
            residual: bool, flag for residual connection
            name: string, layer name
        Returns:
            X: 4D tensor, output from residual block
        """

        if residual:
            shortcut = X
            if strides[-1] != 1:
                # strided convolution and double channel depth
                shortcut = self.conv_2d(shortcut, strides[-1], [1, 1, kernel[-1]], name + '_shortcut')
            elif shortcut.get_shape()[3] != kernel[-1]:
                shortcut = self.conv_2d(shortcut, strides[0], kernel, name + '_shortcut')

        for i in range(len(strides)):
            if dilation:
                X = self.atrous_conv_2d(X, dilation, kernel, name=name + '_' + str(i))
                X = self.batch_norm(X, is_training=self.is_training)
                X = tf.nn.relu(X)  # perform relu activation
            else:
                X = self.conv_2d(X, strides[i], kernel, name=name + '_' + str(i))
                X = self.batch_norm(X, is_training=self.is_training)
                X = tf.nn.relu(X)  # perform relu activation

                if residual and i == len(strides) - 1:
                    # add shortcut on last operation
                    X = tf.add(shortcut, X)
                    X = tf.nn.relu(X)
                else:
                    X = tf.nn.relu(X)

        return X

    def atrous_conv_2d(self, X, dilation, kernel, name):
        """2D Dilated (atrous) convolution
        The atrous convolution is a convolution with holes. It is used to
        expand the receptive field without downsizing the activation map.
        Here a stride of 1 is assumed
        Args:
            X: 4D tensor, image or feature map
            dilation: int, factor by which convolution kernel is dilated
            kernel: list, 3 elements - size of kernel and number of filters
            name: string, layer name
        Returns:
            X: 4D tensor, output after convolution and bias operations
        """

        with tf.variable_scope(name) as scope:
            W = tf.get_variable(shape=[kernel[0], kernel[1], X.shape[3], kernel[2]],
                                dtype=tf.float32, name=name + '_weights')
            b = tf.get_variable(shape=[kernel[2]], dtype=tf.float32,
                                name=name + '_bias')

        X = tf.nn.atrous_conv2d(X, W, dilation, padding='SAME')
        X = X + b

        return X

    def conv_2d(self, X, strides, kernel, name):
        """2D convolution
        Args:
            X: 4D tensor, image or feature map
            strides: int, stride for convolution
            kernel: list, 3 elements - size of kernel and number of filters
            name: string, name of layer
        Returns:
            X: 4D tensor, output after convolution and bias operations
        """

        with tf.variable_scope(name) as scope:
            W = tf.get_variable(shape=[kernel[0], kernel[1], X.shape[3], kernel[2]],
                                dtype=tf.float32, name=name + '_weights')
            b = tf.get_variable(shape=[kernel[2]], dtype=tf.float32,
                                name=name + '_bias')

        X = tf.nn.conv2d(X, W, [1, strides, strides, 1], padding='SAME', name=None)
        X = X + b

        return X

    def build_DRN18(self):
        """Dilated residual network with 18 layers"""

        X = self.image
        X.set_shape([None, self.image_dims[0], self.image_dims[1], self.image_dims[2]])

        print('Input shape is {}'.format(X.get_shape()))

        kernel = [7, 7, 64]
        strides = 2
        dilation = []
        X = self.conv_2d(X, strides, kernel, 'layer2')
        print('Layer2 shape is {}'.format(X.get_shape()))

        residual = 1
        X = tf.nn.max_pool(X, [1, 1, 1, 1], [1, 2, 2, 1], padding='SAME')
        kernel = [3, 3, 64]
        strides = [1, 1]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer3_1')
        strides = [1, 2]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer3_2')
        print('Layer3 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 128]
        strides = [1, 1]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer4_1')
        strides = [1, 1]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer4_2')
        print('Layer4 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 256]
        strides = [1, 1, 1, 1]
        dilation = 2
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer5')
        print('Layer5 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 512]
        strides = [1, 1, 1, 1]
        dilation = 4
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer6')
        print('Layer6 shape is {}'.format(X.get_shape()))

        # 1x1 convolution to squash output to number of classes
        kernel = [1, 1, self.num_classes]
        strides = [1]
        dilation = []
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'output')
        print('Output shape is {}'.format(X.get_shape()))

        self.prob = X
        self.pred = tf.argmax(X, 3)

    def build_DRN26(self):
        """Dilated residual network with 26 layers"""

        X = self.image
        X.set_shape([None, self.image_dims[0], self.image_dims[1], self.image_dims[2]])

        print('Input shape is {}'.format(X.get_shape()))

        kernel = [7, 7, 16]
        strides = 1
        self.conv_2d(X, strides, kernel, 'layer1_1')
        residual = 1
        kernel = [3, 3, 16]
        strides = [1, 2]
        dilation = []
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer1_2')
        print('Layer1 shape is {}'.format(X.get_shape()))

        residual = 1
        kernel = [3, 3, 32]
        strides = [1, 2]
        dilation = []
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer2')
        print('Layer2 shape is {}'.format(X.get_shape()))

        residual = 1
        kernel = [3, 3, 64]
        strides = [1, 1]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer3_1')
        strides = [1, 2]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer3_2')
        print('Layer3 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 128]
        strides = [1, 1]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer4_1')
        strides = [1, 1]
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer4_2')
        print('Layer4 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 256]
        strides = [1, 1, 1, 1]
        dilation = 2
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer5')
        print('Layer5 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 512]
        strides = [1, 1, 1, 1]
        dilation = 4
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer6')
        print('Layer6 shape is {}'.format(X.get_shape()))

        residual = 0
        kernel = [3, 3, 512]
        strides = [1, 1]
        dilation = 2
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer7')
        print('Layer7 shape is {}'.format(X.get_shape()))

        kernel = [3, 3, 512]
        strides = [1, 1]
        dilation = 1
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'layer8')
        print('Layer8 shape is {}'.format(X.get_shape()))

        # 1x1 convolution to squash output to number of classes
        kernel = [1, 1, self.num_classes]
        strides = [1]
        dilation = []
        X = self.conv_repeat(X, strides, dilation, kernel, residual, 'output')
        print('Output shape is {}'.format(X.get_shape()))

        self.prob = X
        self.pred = tf.argmax(X, 3)