
class DeepMVSModel():
    """
    Interface definition for DeepMVSModel
    """

    def __init__(self):
        pass

    def __call__(self, input_images, input_poses, input_intrinsics):
        raise RuntimeError("Abstract class DeepMVSModel not meant to be used")

    @staticmethod
    def export_model():
        raise RuntimeError("Abstract class DeepMVSModel not meant to be used")