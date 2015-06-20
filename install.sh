#!/bin/bash

git submodule init
git submodule update --remote

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
ln -svf ${BASEDIR}/vimrc ~/.vimrc
ln -svfn ${BASEDIR}/vim/ ~/.vim

