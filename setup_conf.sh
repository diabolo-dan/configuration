#! /bin/bash
mkdir ~/.conf.bak
#This is non-destructive, but can leave named symlinks in the home folder if done repeatedly
#Solution, don't do that.

#If file exists, back it up, then symlink to our version
function setup_conf {
	find ~ -maxdepth 1 -name .$1 -exec mv -n '{}' ~/.conf.bak/ ';'
	ln -s $(realpath $1) ~/.$1
}

git submodule init && git submodule update

setup_conf bashrc
setup_conf vimrc
setup_conf vim
setup_conf xprofile
setup_conf pylintrc

find ~/.i3 -maxdepth 1 -name config -exec mv -n '{}' ~/.conf.bak/ ';' &&
ln -s $(realpath i3_config) ~/.i3/config

#Clear out symlinks from .conf.bak
find ~/.conf.bak -maxdepth 1 -type l -delete



#find ~ -maxdepth 1 -name .vimrc -exec mv '{}' ~/.conf.bak/ ';'
#ln -s $(realpath vimrc) ~/.vimrc

#find ~ -maxdepth 1 -name .vim -exec mv  '{}' ~/.conf.bak/  ';'
#ln -s $(realpath vim) ~/.vim




