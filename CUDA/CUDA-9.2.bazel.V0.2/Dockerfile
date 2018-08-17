FROM scratch
MAINTAINER Guojian Zhou "joe_zgj@163.com"
ENV REFRESHED_AT 2018-08-16

ADD ubuntu-base-16.04.4-base-amd64.tar.gz /

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates apt-utils apt-transport-https gnupg-curl && \
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
RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION \
        libnccl2=$NCCL_VERSION-1+cuda9.2 && \
    apt-mark hold libnccl2

ENV CUDNN_VERSION 7.2.1.38
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated \
            libcudnn7=$CUDNN_VERSION-1+cuda9.2 && \
    apt-mark hold libcudnn7

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install apt-utils iputils-ping net-tools \
    openssh-server vim sudo git python2.7 python-pip unzip -y

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install cmake build-essential module-assistant libboost-dev \
    libboost-thread-dev libboost-system-dev libboost-filesystem-dev \
    libboost-program-options-dev libboost-python-dev libprotobuf-dev libopencv-dev \
    protobuf-compiler libhdf5-dev liblmdb-dev libsnappy-dev libatlas-dev \
    libatlas-base-dev libncurses5-dev gcc-multilib g++-multilib lib32z1 \
    libgoogle-glog-dev -y

RUN mkdir /.py
ADD py/* /.py/
RUN pip2 install /.py/*.whl && \
    pip2 install virtualenv easydict protobuf scipy opencv-python pillow mock numpy

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/joe && \
    echo "joe:x:${uid}:${gid}:joe,,,:/home/joe:/bin/bash" >> /etc/passwd && \
    echo "joe:x:${uid}:" >> /etc/group && \
    echo "joe ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/joe && \
    chmod 0440 /etc/sudoers.d/joe && \
    cp -a /root/.bashrc /home/joe/ && \
    chown ${uid}:${gid} -R /home/joe && \
    export "PATH=/home/joe/bin:${PATH}" && \
    chown ${uid}:${gid} -R /home/joe/.bashrc
 
USER joe
ENV HOME /home/joe
WORKDIR $HOME

ENV USER joe
ADD bazel-0.5.4-installer-linux-x86_64.sh /home/${USER}
ENV PATH_TFVENV_MLU /home/${USER}/TF-v1.4/virtualenv_mlu
ENV PATH_TFVENV_CPU /home/${USER}/TF-v1.4/virtualenv_cpi
ENV PATH_TFVENV_GPU /home/${USER}/TF-v1.4/virtualenv_gpu

RUN export USER=joe && \
    mkdir -p /home/${USER}/.pip && \
    echo "[global]" > /home/${USER}/.pip/pip.conf && \
    echo "download_cache = /.py" >> /home/${USER}/.pip/pip.conf

RUN export USER=joe && \
    /home/${USER}/bazel-0.5.4-installer-linux-x86_64.sh --user && \
    rm -f /home/${USER}/bazel-0.5.4-installer-linux-x86_64.sh && \
    mkdir -p ${PATH_TFVENV_MLU} && \
    virtualenv --system-site-packages ${PATH_TFVENV_MLU} && \
    . ${PATH_TFVENV_MLU}/bin/activate && \
    pip2 install /.py/*.whl && \
    pip2 install easydict protobuf scipy opencv-python pillow mock numpy

RUN export USER=joe && \
    mkdir -p ${PATH_TFVENV_GPU} && \
    virtualenv --system-site-packages ${PATH_TFVENV_GPU} && \
    . ${PATH_TFVENV_GPU}/bin/activate && \
    pip2 install /.py/*.whl && \
    pip2 install easydict protobuf scipy opencv-python pillow mock numpy

RUN export USER=joe && \
    mkdir -p ${PATH_TFVENV_CPU} && \
    virtualenv --system-site-packages ${PATH_TFVENV_CPU} && \
    . ${PATH_TFVENV_CPU}/bin/activate && \
    pip2 install /.py/*.whl && \
    pip2 install easydict protobuf scipy opencv-python pillow mock numpy

CMD /bin/bash
