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

fold_start() {
   echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"
}

fold_end() {
   echo -e "\ntravis_fold:end:$1\r"
}

image="image$RANDOM$RANDOM$RANDOM"

docker run -it -d --name $image $DOCKER //bin/bash

fold_start setup1 setupBasicsAndUse
docker cp setupBasicsAndUser.sh $image:/
docker exec -it $image sh setupBasicsAndUser.sh
fold_end setup1

fold_start brew1 installLinuxBrew
docker cp installLinuxBrew.sh $image:/home/gromit/
docker exec -it -u gromit $image sh //home/gromit/installLinuxBrew.sh
fold_end brew1

#docker stop $image
