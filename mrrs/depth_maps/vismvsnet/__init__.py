import os
ENV_FILE = os.path.join(os.path.dirname(__file__), 'env.yaml')
EXEC = "python "+ os.path.join(os.path.dirname(__file__), "Vis-MVSNet/test.py")
MODEL_PATH = os.path.join(os.path.dirname(__file__), "Vis-MVSNet/pretrained_model/vis")
