#!/bin/bash
set -ex


mv ~/.linuxbrew ~/deleteme.$RANDOM.$RANDOM.$RANDOM

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_FILTERING=1

git clone git://github.com/Homebrew/brew ~/.linuxbrew
git clone git://github.com/Homebrew/linuxbrew-core ~/.linuxbrew/Library/Taps/homebrew/homebrew-core

#brew install curl
#brew install --only-dependencies glibc
#brew install --ignore-dependencies https://raw.githubusercontent.com/Linuxbrew/homebrew-core/6fb5dfd50895416bea3d00628b8d3b41fa1f4f32/Formula/glibc.rb  # 2.2
#brew install --ignore-dependencies xz gmp mpfr libmpc isl gcc
#brew install isl@0.18
#brew upgrade glibc

#cd /home/jlever/.linuxbrew/Library/Taps/homebrew/homebrew-core
#git checkout eb9bf19f24d1b0e5991f1c6a13a053eaf1bc6b13 glibc.rb

brew install curl

cd $(brew --prefix)/Library/Taps/homebrew/homebrew-core/Formula/
git checkout 6fb5dfd508 glibc.rb
perl -pi -e 's/GlibcRequirement.system_version <= Glibc.version/1 > 0/' glibc.rb
cd -

brew install gcc

brew pin glibc

brew install git

#brew install gnu-tar
#brew install gzip
#brew install unzip
#brew install python
#pip3 install virtualenv
#brew install jdk

