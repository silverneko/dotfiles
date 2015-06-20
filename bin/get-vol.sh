#!/bin/sh

vol=`amixer sget Master | tail -n 1 | sed "s|^[^\[]*\[\([0-9]*\%\)\].*\[\([a-zA-Z]*\)\]$|\1|"`
mute=`amixer sget Master | tail -n 1 | sed "s|^[^\[]*\[\([0-9]*\%\)\].*\[\([a-zA-Z]*\)\]$|\2|"`

if [ $mute = "off" ]; then
  echo "mute"
else
  echo $vol
fi

