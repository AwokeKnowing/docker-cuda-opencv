FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
LABEL maintainer "jamesdavidmorris@gmail.com"

RUN apt-get clean && apt-get update && apt-get install -y \
        build-essential \
        cmake \
        gcc \
        apt-utils \
        pkg-config \
        wget \
        unzip \
        git \
        ca-certificates \
        curl \
        vim \
        nano \
        python3 \
        python3-pip \
        python3-dev \
        python3-numpy \
        gfortran \
        libatlas-base-dev \
        libatlas-dev \
        libatlas3-base \
        libhdf5-dev \
        libfreetype6-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libxml2-dev \
        libxslt-dev \
        xvfb \
        xorg-dev \
        libav-tools \
        libavcodec-dev \
        libavformat-dev \
        libxvidcore-dev \
        ffmpeg \
        libx264-dev \
        x264 \
        libdc1394-22-dev \
        libswscale-dev \
        libv4l-dev \
        libsdl2-dev \
        swig \
        libboost-program-options-dev \
        libboost-all-dev \
        libboost-python-dev \
        zlib1g-dev \
        libjasper-dev \
        libtbb2 \
        libtbb-dev \
        libgtk-3-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp && \
    cd /tmp && \
    wget --no-check-certificate -O opencv.zip https://github.com/opencv/opencv/archive/3.4.0.zip && \
    unzip opencv.zip && \
    mkdir opencv-3.4.0/build && \
    cd opencv-3.4.0/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D PYTHON3_EXECUTABLE=/usr/bin/python3 \
        -D WITH_CUDA=ON \
        -D CUDA_FAST_MATH=1 \
        -D WITH_CUBLAS=1 \
        -D CMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
        -D WITH_TBB=ON \
        -D PYTHON_INCLUDE_DIR=/usr/include/python3.5 \
        -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python3.5m \
        -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.5m.so \
        -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3/dist-packages/numpy/core/include/ \
        .. && \
    make -j$(nproc) && \
    make install && \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf && \
    ldconfig && \
    cd /tmp && \
    rm -rf opencv-3.4.0 opencv.zip && \
    cd /
