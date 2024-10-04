FROM docker.io/nvidia/cuda:12.3.1-devel-ubuntu20.04 

# Update apt
RUN apt update && apt install -y curl libncurses5 libstdc++6 libbz2-1.0 wget

# Install CUDA
#RUN mkdir /tmp/cuda && \
#    wget https://developer.download.nvidia.com/compute/cuda/repos/$CUDA_VERSION/pkgs/14.22-25044800_411.70-0ubuntu1_amd64.deb && \
#    dpkg -i *.deb && \
#    rm *.deb && \
#    apt-get update && \
#    apt-get install -y cuda-$CUDA_VERSION
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Install conda
RUN mkdir /tmp/anaconda3 && \
    wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh && \
    sh Anaconda3-2022.05-Linux-x86_64.sh -b -f -p /tmp/anaconda3 && \
    source /tmp/anaconda3/etc/profile.d/conda.sh

ENV PATH /tmp/anaconda3/bin:$PATH
# Install conda packages
RUN conda create -n vfus python=$PYTHON_VERSION
SHELL ["conda", "run", "-n", "vfus", "/bin/bash", "-c"]
RUN conda install pytorch torchvision
RUN conda init bash
#RUN conda activate vfus  
#RUN conda install pytorch=2.3.0 torchvision==0.18.0 pytorch-cuda=$CUDA_VERSION -c pytorch -c nvidia 
RUN python3 -m pip install transformers
RUN python3 -m pip install imageio[ffmpeg]
RUN python3 -m pip install PyMCubes==0.1.4
RUN python3 -m pip install trimesh==4.3.2
RUN python3 -m pip install rembg[gpu,cli]
RUN python3 -m pip install kiui
RUN python3 -m pip install gradio==4.31.4
RUN python3 -m pip install gradio-litmodel3d==0.0.1
RUN python3 -m pip install fastapi==0.111.0
# Set working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app/

CMD ["conda", "activate", "vfus"]