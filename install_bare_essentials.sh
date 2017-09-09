#!/bin/bash

if type "yum" > /dev/null; then
	yum -y update
	yum -y install gcc curl git ruby vim tar
elif type "apt-get" > /dev/null; then
	apt-get update
	apt-get install -y build-essential curl git ruby vim tar
else
	echo "No yum or apt-get to install bare essentials."
	exit 1
fi

