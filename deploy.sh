#!/bin/bash
set -ex

#DOCKER=ubuntu:trusty

#count=$(docker ps -a -q | wc -l)
#if [[ $count -ne 0 ]]; then
#	docker stop $(docker ps -a -q)
#fi
#docker system prune -f

#exit 0
#image=`echo $DOCKER"_container" | sed -e 's/[^A-Za-z0-9_]*//g'`

image="image$RANDOM$RANDOM$RANDOM"

docker run -it -d --name $image $DOCKER //bin/bash

docker cp setupBasicsAndUser.sh $image:/
docker exec -it $image sh setupBasicsAndUser.sh

docker cp installLinuxBrew.sh $image:/home/gromit/
docker exec -it -u gromit $image sh //home/gromit/installLinuxBrew.sh

#docker stop $image
