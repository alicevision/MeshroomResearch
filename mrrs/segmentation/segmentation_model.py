class SegmentationModel():
    """
    Interface definition for SegmentationModel
    """

    def __init__(self):
        pass

    def __call__(self, input_image):
        raise RuntimeError("Abstract class SegmentationModel not meant to be used")

    @staticmethod
    @property
    def CLASSES_NAMES():
        raise RuntimeError("Abstract class SegmentationModel not meant to be used")

    @staticmethod
    def export_model():
        raise RuntimeError("Abstract class SegmentationModel not meant to be used")
