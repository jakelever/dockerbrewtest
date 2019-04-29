#!/bin/bash
set -ex

cd ~

git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)

platform=$(python -mplatform)
if [[ $platform == *"centos-6"* ]]; then
#git clone git://github.com/Homebrew/linuxbrew-core ~/.linuxbrew/Library/Taps/homebrew/homebrew-core --depth 1

	export HOMEBREW_NO_AUTO_UPDATE=1
	export HOMEBREW_NO_ANALYTICS=1
	export HOMEBREW_NO_ENV_FILTERING=1

	perl -pi -e 's/"git", "config", "--local",/"git", "config",/' ~/.linuxbrew/Homebrew/Library/Homebrew/tap.rb

	brew install -s gmp mpfr libmpc isl@0.18

	HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_BUILD_FROM_SOURCE=1 brew install gcc --without-glibc
	HOMEBREW_NO_AUTO_UPDATE=1 brew install glibc
# If encountering locale errors in postinstall of glibc, run 
# HOMEBREW_NO_AUTO_UPDATE=1 LC_CTYPE=en_GB.UTF-8 brew postinstall glibc
# see issue - https://github.com/Linuxbrew/legacy-linuxbrew/issues/929
	HOMEBREW_NO_AUTO_UPDATE=1 brew remove gcc
	HOMEBREW_NO_AUTO_UPDATE=1 brew install gcc
fi

brew install hello

