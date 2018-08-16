#!/bin/bash

DOCKER_IMAGE=$1
TOP_DIR=`dirname ${PWD}`

docker images
docker ps -a
echo "The docker image ${DOCKER_IMAGE} will been created on `date`"
case ${DOCKER_IMAGE} in
	"ubuntu")
		pushd ${TOP_DIR}/ubuntu/
		cp ${TOP_DIR}/images/ubuntu-base-16.04.4-base-amd64.tar.gz .
		echo "The joe/ubuntu-16.04.4:V0.1 docker image will be created!"
		docker build -t joe/ubuntu-16.04.4:V0.1 .
		echo "The joe/ubuntu-16.04.4:V0.1 docker image has be created!"
		if [ -f ubuntu-base-16.04.4-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.4-base-amd64.tar.gz
		fi
		popd
		;;
	"CUDA")
		pushd ${TOP_DIR}/CUDA/CUDA-9.2.V0.1
		cp ${TOP_DIR}/images/ubuntu-base-16.04.4-base-amd64.tar.gz .
		echo "The nv/cuda-9.2_cudnn-7.2:V0.1 docker image will be created!"
		docker build -t nv/cuda-9.2_cudnn-7.2:V0.1 .
		echo "The nv/cuda-9.2_cudnn-7.2:V0.1:V0.1 docker image has be created!"
		if [ -f ubuntu-base-16.04.4-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.4-base-amd64.tar.gz
		fi
		popd
		;;
	*)
		pushd ${TOP_DIR}/ubuntu/
		cp ${TOP_DIR}/images/ubuntu-base-16.04.4-base-amd64.tar.gz .
		echo "The joe/ubuntu-16.04.4:V0.1 docker image will be created!"
		docker build -t joe/ubuntu-16.04.4:V0.1 .
		echo "The joe/ubuntu-16.04.4:V0.1 docker image has be created!"
		if [ -f ubuntu-base-16.04.4-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.4-base-amd64.tar.gz
		fi
		popd
		;;
esac
echo "The docker image ${DOCKER_IMAGE} has been created on `date`"
docker images
docker ps -a
