#!/bin/bash

#docker run -i --privileged -u $USER -h joe_docker --name zgj_`date +"%Y%m%d_%H%M%S"` -v /data:/data -t joe/ubuntu-16.04.5:V0.1 /bin/bash

# Boot with the nvidia-docker2+docker-ce 
docker run -i --runtime=nvidia --privileged -u $USER -h joe_docker --name zgj_`date +"%Y%m%d_%H%M%S"` -v /data:/data -t nv/cuda-9.2_cudnn-7.2_bazel_TF-1.10:V1.0 /bin/bash

# Boot with docker.io
#docker run -i --privileged -u $USER -h joe_docker --name zgj_`date +"%Y%m%d_%H%M%S"` -v /data:/data -t nv/cuda-9.2_cudnn-7.2_bazel_TF-1.10:V1.0 /bin/bash
