#!/bin/bash

TOP_DIR=`dirname ${PWD}`
pushd ${TOP_DIR}/ubuntu/
echo "The joe/ubuntu-16.04.4:V0.1 docker image will be created!"
docker build -t joe/ubuntu-16.04.4:V0.1 .
echo "The joe/ubuntu-16.04.4:V0.1 docker image has be created!"
popd
