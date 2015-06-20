#!/usr/bin/env bash

git submodule init
git submodule update --remote

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -svfn ${BASEDIR}/ ~/.dotfiles

# vim
ln -svf ${BASEDIR}/vimrc ~/.vimrc
ln -svfn ${BASEDIR}/vim/ ~/.vim

# xmonad
cp -f ${BASEDIR}/xmonad.hs ~/.xmonad/xmonad.hs

# xmobar
ln -svf ${BASEDIR}/xmobarrc ~/.xmobarrc

# stalonetray
ln -svf ${BASEDIR}/stalonetrayrc ~/.stalonetrayrc

# xsession
ln -svf ${BASEDIR}/xsession ~/.xsession
