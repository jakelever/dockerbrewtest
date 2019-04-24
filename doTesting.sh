#!/bin/bash
set -x

if [[ $MODE == 'bio' ]]; then

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
	brew tap brewsci/bio
	brew search brewsci | sort -R | head -n 10 | sort | tee selectedPackages
	brew install $(cat selectedPackages)

elif [[ $MODE == 'docker' ]]; then

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get -y install docker-ce
	docker --version

	sudo sh build_docker_image.sh myimage
	sudo sh run_docker_image.sh myimage

fi
