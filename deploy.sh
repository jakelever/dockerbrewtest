#!/bin/bash
set -ex

#DISTRO=ubuntu:trusty

#count=$(docker ps -a -q | wc -l)
#if [[ $count -ne 0 ]]; then
#	docker stop $(docker ps -a -q)
#fi
#docker system prune -f

image=`echo $DISTRO"_container" | sed -e 's/[^A-Za-z0-9_]*//g'`

docker run -it -d --name $image ubuntu:trusty //bin/bash

docker cp dockerBrew.sh $image:/

docker exec -it $image sh dockerBrew.sh

docker stop container_ubuntutrusty
