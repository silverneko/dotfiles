#!/bin/sh

git submodule update --init --recursive --depth 1

#BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASEDIR=`pwd`

#ln -svn ${BASEDIR}/ ~/.dotfiles

# vim
ln -sv ${BASEDIR}/vimrc ~/.vimrc
ln -svn ${BASEDIR}/vim/ ~/.vim

# xmonad
mkdir ~/.xmonad
ln -sv ${BASEDIR}/xmonad.hs ~/.xmonad/xmonad.hs

# xmobar
ln -sv ${BASEDIR}/xmobarrc ~/.xmobarrc

# stalonetray
ln -sv ${BASEDIR}/stalonetrayrc ~/.stalonetrayrc

# xsession
ln -sv ${BASEDIR}/xsession ~/.xsession

# zsh
ln -sv ${BASEDIR}/zshrc ~/.zshrc
