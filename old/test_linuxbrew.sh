#!/bin/bash

set -x

#git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
#git clone https://github.com/Homebrew/brew ~/.linuxbrew

export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$(brew --prefix)/share/man:$MANPATH"
export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"

hash -r
sleep 1

brew install gcc #&> install.log
brew test gcc #&> test.log
#echo $? > final.log

brew install git
brew test git

