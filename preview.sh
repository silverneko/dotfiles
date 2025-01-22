#!/bin/sh

case "$1" in
  *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar -tvjf "$1" ;;
  *.tar.gz|*.tgz) tar -tvzf "$1" ;;
  *.tar) tar -tvf "$1" ;;
  *.gz) gunzip -l "$1" ;;
  *.zip) zipinfo "$1" ;;
  *) batcat --color=always --style=header,header-filesize "$1" ;;
esac

true
