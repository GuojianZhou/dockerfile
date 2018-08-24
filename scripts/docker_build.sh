#!/bin/bash

DOCKER_IMAGE=$1
TOP_DIR=`dirname ${PWD}`

docker images
docker ps -a
echo "The docker image ${DOCKER_IMAGE} will been created on `date`"
case ${DOCKER_IMAGE} in
	"ubuntu")
		pushd ${TOP_DIR}/ubuntu/
		cp ${TOP_DIR}/images/ubuntu-base-16.04.5-base-amd64.tar.gz .
		echo "The joe/ubuntu-16.04.5:V0.1 docker image will be created!"
		docker build -t joe/ubuntu-16.04.5:V0.1 .
		echo "The joe/ubuntu-16.04.5:V0.1 docker image has be created!"
		if [ -f ubuntu-base-16.04.5-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.5-base-amd64.tar.gz
		fi
		popd
		;;
	"CUDA")
		pushd ${TOP_DIR}/CUDA/CUDA-9.2.V0.1
		cp ${TOP_DIR}/images/ubuntu-base-16.04.5-base-amd64.tar.gz .
		echo "The nv/cuda-9.2_cudnn-7.2:V0.1 docker image will be created!"
		docker build -t nv/cuda-9.2_cudnn-7.2:V0.1 .
		echo "The nv/cuda-9.2_cudnn-7.2:V0.1 docker image has be created!"
		if [ -f ubuntu-base-16.04.5-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.5-base-amd64.tar.gz
		fi
		popd
		;;
	"CUDA-bazel")
		pushd ${TOP_DIR}/CUDA/CUDA-9.2.bazel.V0.2
		cp ${TOP_DIR}/images/ubuntu-base-16.04.5-base-amd64.tar.gz .
		cp ${TOP_DIR}/images/bazel-0.16.0-installer-linux-x86_64.sh .
		cp -a ${TOP_DIR}/images/py .
		echo "The nv/cuda-9.2_cudnn-7.2_bazel:V0.2 docker image will be created!"
		docker build -t nv/cuda-9.2_cudnn-7.2_bazel:V0.2 .
		echo "The nv/cuda-9.2_cudnn-7.2_bazel:V0.2 docker image has be created!"
		if [ -f ubuntu-base-16.04.5-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.5-base-amd64.tar.gz
		fi
		if [ -f bazel-0.5.4-installer-linux-x86_64.sh ]; then
			rm -f bazel-0.5.4-installer-linux-x86_64.sh
		fi
		if [ -d py ]; then
			rm -fr py
		fi
		popd
		;;
	"CUDA-bazel-TF")
		pushd ${TOP_DIR}/CUDA/CUDA-9.2.CUDNN-7.2.Bazel-0.16.0.TF-1.10
		cp ${TOP_DIR}/images/ubuntu-base-16.04.5-base-amd64.tar.gz .
		cp ${TOP_DIR}/images/bazel-0.16.0-installer-linux-x86_64.sh .
		cp -a ${TOP_DIR}/images/py .
		echo "The nv/cuda-9.2_cudnn-7.2_bazel_TF-1.10:V1.0 docker image will be created!"
		docker build -t nv/cuda-9.2_cudnn-7.2_bazel_TF-1.10:V1.0 .
		echo "The nv/cuda-9.2_cudnn-7.2_bazel_TF-1.10:V1.0 docker image has be created!"
		if [ -f ubuntu-base-16.04.5-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.5-base-amd64.tar.gz
		fi
		if [ -f bazel-0.16.0-installer-linux-x86_64.sh ]; then
			rm -f bazel-0.16.0-installer-linux-x86_64.sh
		fi
		if [ -d py ]; then
			rm -fr py
		fi
		popd
		;;
	"CUDA-9.0-bazel-TF")
		pushd ${TOP_DIR}/CUDA/CUDA-9.0.CUDNN-7.2
		cp ${TOP_DIR}/images/ubuntu-base-16.04.5-base-amd64.tar.gz .
		cp ${TOP_DIR}/images/bazel-0.16.0-installer-linux-x86_64.sh .
		cp -a ${TOP_DIR}/images/py .
		echo "The nv/cuda-9.0_cudnn-7.2_bazel_TF-1.10:V1.0 docker image will be created!"
		docker build -t nv/cuda-9.0_cudnn-7.2_bazel_TF-1.10:V1.0 .
		echo "The nv/cuda-9.0_cudnn-7.2_bazel_TF-1.10:V1.0 docker image has be created!"
		if [ -f ubuntu-base-16.04.5-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.5-base-amd64.tar.gz
		fi
		if [ -f bazel-0.16.0-installer-linux-x86_64.sh ]; then
			rm -f bazel-0.16.0-installer-linux-x86_64.sh
		fi
		if [ -d py ]; then
			rm -fr py
		fi
		popd
		;;
	*)
		pushd ${TOP_DIR}/ubuntu/
		cp ${TOP_DIR}/images/ubuntu-base-16.04.5-base-amd64.tar.gz .
		echo "The joe/ubuntu-16.04.5:V0.1 docker image will be created!"
		docker build -t joe/ubuntu-16.04.5:V0.1 .
		echo "The joe/ubuntu-16.04.5:V0.1 docker image has be created!"
		if [ -f ubuntu-base-16.04.5-base-amd64.tar.gz ]; then
			rm -f ubuntu-base-16.04.5-base-amd64.tar.gz
		fi
		popd
		;;
esac
echo "The docker image ${DOCKER_IMAGE} has been created on `date`"
docker images
docker ps -a
