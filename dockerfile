# Use NVIDIA's base image with CUDA and cuDNN support
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    PYTHON_VERSION=3.10 \
    PATH="/opt/conda/bin:$PATH"

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    curl \
    git \
    sudo \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    libssl-dev \
    libffi-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Create Conda environment and install scientific packages
RUN /opt/conda/bin/conda create -n colab-env python=$PYTHON_VERSION -y && \
    /opt/conda/bin/conda install -n colab-env -c conda-forge -y \
    ipywidgets \
    matplotlib \
    numpy \
    pandas \
    scipy \
    scikit-learn && \
    /opt/conda/bin/conda clean -a

# Install Jupyter-related, deep-learning, and additional packages with pip
RUN /opt/conda/envs/colab-env/bin/pip install --upgrade pip && \
    /opt/conda/envs/colab-env/bin/pip install \
    notebook \
    jupyterlab \
    tensorflow==2.12 \
    tensorflow-addons \
    typeguard>=4.0.1 \
    inflect \
    vit-keras \
    gdown \
    seaborn \
    plotly \
    opencv-python-headless \
    tqdm && \
    /opt/conda/envs/colab-env/bin/pip install \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
    /opt/conda/envs/colab-env/bin/pip cache purge

# Expose ports
EXPOSE 8888

# Set working directory
WORKDIR /workspace

# Command to start Jupyter Lab
CMD ["/opt/conda/envs/colab-env/bin/jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
