#!/bin/bash
set -ex

cd ~

git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)

# Add Linuxbrew env setup to profile
if [ -r ~/.bash_profile ]; then
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
elif [ -r ~/.profile ]; then
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
else
	echo "ERROR: Unable to add Linuxbrew env setup to profile"
	exit 1
fi


if grep -q "CentOS release 6" /etc/*-release; then

	perl -pi -e 's/"git", "config", "--local",/"git", "config",/' ~/.linuxbrew/Homebrew/Library/Homebrew/tap.rb

	HOMEBREW_NO_AUTO_UPDATE=1 brew install -s gmp mpfr libmpc isl@0.18

	HOMEBREW_NO_AUTO_UPDATE=1 ./keepawake brew install -s gcc --without-glibc
	HOMEBREW_NO_AUTO_UPDATE=1 brew install glibc
# If encountering locale errors in postinstall of glibc, run 
# HOMEBREW_NO_AUTO_UPDATE=1 LC_CTYPE=en_GB.UTF-8 brew postinstall glibc
# see issue - https://github.com/Linuxbrew/legacy-linuxbrew/issues/929
	HOMEBREW_NO_AUTO_UPDATE=1 brew remove gcc
	HOMEBREW_NO_AUTO_UPDATE=1 brew install gcc
	
	HOMEBREW_NO_AUTO_UPDATE=1 brew install git

	(cd ~/.linuxbrew/Homebrew/Library/Homebrew/ && git checkout HEAD tap.rb)
fi

brew install hello

brew doctor || true

