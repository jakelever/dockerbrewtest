#!/bin/bash
set -ex

useradd -m -s /bin/bash gromit

if type "yum" > /dev/null; then
	yum -y update
	#yum -y install gcc curl git ruby vim tar
	yum groupinstall -y 'Development Tools'
	yum install -y curl file git
elif type "apt-get" > /dev/null; then
	apt-get update
	#apt-get install -y build-essential curl git ruby vim tar
	apt-get install -y build-essential curl file git gawk tar
else
	echo "No yum or apt-get to install bare essentials."
	exit 1
fi
