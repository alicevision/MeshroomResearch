### Need to have docker with nvida-containeer-toolkit installled
### Build with 'docker build . -t gs'
### Run container with 'docker run --rm --runtime=nvidia --gpus all -it gs'

## Base image and git
FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel as build1
RUN apt update && apt -y upgrade
RUN apt install -y git

# Cloning GS repo
RUN git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive

#installing GS deps
RUN pip install plyfile tqdm ninja

#needed to build the rasterisation
#https://www.data-mining.co.nz/docker-for-data-scientists/troubleshooting/
ARG TORCH_CUDA_ARCH_LIST="Pascal;Volta;Turing;Ampere"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

# Build rasteriser and knn
RUN pip install gaussian-splatting/submodules/diff-gaussian-rasterization
RUN pip install gaussian-splatting/submodules/simple-knn 

# ## Test stage (optional), not working as cuda is nout found
# FROM build1 as testing
# # DLL&unzip test data
# RUN apt install -y wget unzip
# RUN wget https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/datasets/input/tandt_db.zip
# RUN unzip tandt_db.zip -d test_data
# # Run test
# RUN python gaussian-splatting/train.py -s test_data/db/playroom/
