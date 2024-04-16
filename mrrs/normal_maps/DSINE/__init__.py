import os

SCRIPT_FILE = os.path.join(os.path.dirname(__file__), "run.py")
ENV_FILE = os.path.join(os.path.dirname(__file__), "env.yml")
ENV_PATH = os.path.join(os.path.dirname(__file__), "conda_env")
MODEL_FILE = os.path.join(os.path.dirname(__file__), "data", "dsine.pt")