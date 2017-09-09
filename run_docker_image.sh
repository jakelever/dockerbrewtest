#!/bin/bash

# Example: sh run.sh mirtex in.json out.json
# Note that input and output file must be absolute path.

set -euxo pipefail

CONTAINER_NAME=testing

touch install.log test.log final.log

docker run --name ${CONTAINER_NAME} \
       -v $PWD/install.log:/home/user/install.log \
       -v $PWD/test.log:/home/user/test.log \
       -v $PWD/final.log:/home/user/final.log \
       myimage \

# Rmove container.
docker rm ${CONTAINER_NAME}
