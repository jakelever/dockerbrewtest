#!/bin/bash
set -ex

if type "yum" > /dev/null; then
	yum -y update
	yum groupinstall -y 'Development Tools'
	yum install -y curl file git

	# Extra
	yum install -y tar which
	
	useradd -m gromit
elif type "apt-get" > /dev/null; then
	apt-get update
	apt-get install -y build-essential curl file git
	
	# Extra
	apt-get install -y gawk
	
	# Code to change locale
	apt-get install -y locales
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen || true
	locale-gen en_US.UTF-8
	update-locale LANG=en_US.UTF-8

	useradd -m gromit
elif type "apk" > /dev/null; then
	apk update
	apk add gcc curl file git
	apk add tar which gawk
	apk add bash 
	apk add ruby ruby-json ruby-bigdecimal ruby-irb ruby-dev ruby-bundler ruby-rake
	apk add gcompat
	
	adduser -D -s /bin/bash gromit
	
	touch /home/gromit/.profile
	chown gromit /home/gromit/.profile
	
elif type "pacman" > /dev/null; then
	pacman -Sy
	pacman -S --noconfirm gcc curl file git
	pacman -S --noconfirm tar which gawk
	
	useradd -m gromit
else
	echo "No yum or apt-get to install bare essentials."
	exit 1
fi

