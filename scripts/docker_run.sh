#!/bin/bash

docker run -i --privileged -u $USER -h joe_docker --name zgj_`date +"%Y%m%d_%H%M%S"` -v /data:/data -t joe/ubuntu-16.04.4:V0.1 /bin/bash


