import tensorflow as tf

class Weigted_MSE(tf.keras.losses.Loss):
    def __init__(self):
        super().__init__(name= "Weigted_MSE")

    def __call__(self, x, y, w=1):
        return tf.reduce_mean(w*(x-y)**2)

# class Weigted_MSE_guided(tf.keras.losses.Loss):
#     def __init__(self):
#         super().__init__(name= "Weigted_MSE")

#     def __call__(self, x1, x2, y, w=1):
#         pass #MSE with target depth and encurages RGB? => or as in their method ?
