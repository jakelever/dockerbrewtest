#!/bin/bash

set -e

exit 1

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


sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

brew install hello

