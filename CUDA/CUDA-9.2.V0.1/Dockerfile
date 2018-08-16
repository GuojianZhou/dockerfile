FROM scratch
MAINTAINER Guojian Zhou "joe_zgj@163.com"
ENV REFRESHED_AT 2018-08-16

ADD ubuntu-base-16.04.4-base-amd64.tar.gz /

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install apt-utils iputils-ping net-tools \
    openssh-server vim sudo git python2.7 python-pip libopencv-dev -y 

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates apt-transport-https gnupg-curl && \
    rm -rf /var/lib/apt/lists/* && \
    NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

ENV CUDA_VERSION 9.2.148

ENV CUDA_PKG_VERSION 9-2=$CUDA_VERSION-1
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-9.2 /usr/local/cuda

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.2"

ENV NCCL_VERSION 2.2.13
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION \
        libnccl2=$NCCL_VERSION-1+cuda9.2 && \
    apt-mark hold libnccl2

ENV CUDNN_VERSION 7.2.1.38
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
            libcudnn7=$CUDNN_VERSION-1+cuda9.2 && \
    apt-mark hold libcudnn7

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install cmake build-essential module-assistant libboost-dev \
    libboost-thread-dev libboost-system-dev libboost-filesystem-dev \
    libboost-program-options-dev libboost-python-dev libprotobuf-dev \
    protobuf-compiler libhdf5-dev liblmdb-dev libsnappy-dev libatlas-dev \
    libatlas-base-dev libncurses5-dev gcc-multilib g++-multilib lib32z1 \
    libgoogle-glog-dev -y

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/joe && \
    echo "joe:x:${uid}:${gid}:Abc,,,:/home/joe:/bin/bash" >> /etc/passwd && \
    echo "joe:x:${uid}:" >> /etc/group && \
    echo "joe ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/joe && \
    chmod 0440 /etc/sudoers.d/joe && \
    chown ${uid}:${gid} -R /home/joe
 
USER joe
RUN pip install easydict protobuf scipy opencv-python pillow mock numpy

ENV HOME /home/joe
WORKDIR $HOME
CMD /bin/bash

