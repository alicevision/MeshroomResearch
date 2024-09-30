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
RUN pip install --no-cache-dir  plyfile tqdm ninja

#needed to build the rasterisation
#https://www.data-mining.co.nz/docker-for-data-scientists/troubleshooting/
ARG TORCH_CUDA_ARCH_LIST="Pascal;Volta;Turing;Ampere"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

# Build rasteriser and knn
RUN pip install --no-cache-dir gaussian-splatting/submodules/diff-gaussian-rasterization
RUN pip install --no-cache-dir gaussian-splatting/submodules/simple-knn 

#install MRRS
RUN git clone --branch refacto_for_plugin https://github.com/alicevision/MeshroomResearch.git
RUN pip install --no-cache-dir -e MeshroomResearch 
