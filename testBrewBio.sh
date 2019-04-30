#!/bin/bash
set -ex

image=ubuntubrew
container=brewtime$RANDOM$RANDOM

docker run --name $container $image //bin/bash -lc "brew update; brew tap brewsci/bio; brew search | grep 'brewsci/bio'" | grep '^brewsci/bio' | sort > formulae.txt
docker container rm $container

mkdir -p logs

while read formula
do
	shortname=`echo $formula | cut -f 3 -d '/'`
	
	if [ -f logs/$shortname.summary ]; then
		echo "Already done. Skipping $formula"
		continue
	fi

	start=$SECONDS
	docker run --name $container $image //bin/bash -lc "brew update; brew tap brewsci/bio; brew install $formula" > logs/$shortname.log 2>&1
	retval=$?
	end=$SECONDS
	
	docker container rm $container
	
	timer=$(($end-$start))
	
	echo -e "$formula\t$timer\t$retval" | tee logs/$shortname.summary
	
	break
done < formulae.txt

#docker run $image echo "hello"
