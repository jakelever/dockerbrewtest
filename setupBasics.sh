#!/bin/bash
set -ex

useradd -m -s /bin/bash gromit

if type "yum" > /dev/null; then
	yum -y update
	yum groupinstall -y 'Development Tools'
	yum install -y curl file git

	# Extra
	yum install -y tar which
elif type "apt-get" > /dev/null; then
	apt-get update
	apt-get install -y build-essential curl file git
	
	# Extra
	apt-get install -y gawk
	
	# Code to change locale
	apt-get install -y locales
	locale-gen en_US.UTF-8
	update-locale LANG=en_US.UTF-8
else
	echo "No yum or apt-get to install bare essentials."
	exit 1
fi

