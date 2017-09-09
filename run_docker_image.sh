#!/bin/bash

# Example: sh run.sh mirtex in.json out.json
# Note that input and output file must be absolute path.

set -euxo pipefail

imageName=$1

CONTAINER_NAME=testing

touch install.log test.log final.log

#docker run --name ${CONTAINER_NAME} \
#       -v $PWD/install.log:/home/user/install.log \
#       -v $PWD/test.log:/home/user/test.log \
#       -v $PWD/final.log:/home/user/final.log \
#       myimage \

docker run --name ${CONTAINER_NAME} $imageName
docker cp ${CONTAINER_NAME}:/home/user/install.log $PWD/install.log
docker cp ${CONTAINER_NAME}:/home/user/test.log $PWD/test.log
docker cp ${CONTAINER_NAME}:/home/user/final.log $PWD/final.log

# Rmove container.
docker rm ${CONTAINER_NAME}

gccTestExit=`cat $PWD/final.log`
if [ $gccTestExit -ne 0 ]; then
	echo "The build failed for some reason. Logs are below:"
	cat $PWD/install.log
	cat $PWD/test.log
fi
