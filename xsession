#!/usr/bin/env sh

#wallpaper
feh $HOME/.dotfiles/img/air.png --bg-fill &

#enable composite windows
xcompmgr -D2 -fF &

#GPG Password Agent
#SSH Key Agent
/usr/bin/gnome-keyring-daemon --components=gpg,ssh &

#authenticate for programs like mintupdate
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

cinnamon-settings-daemon &
# /usr/lib/notification-daemon/notification-daemon
# cinnamon-screensaver &
start-pulseaudio-x11 &
nm-applet &
xscreensaver -no-splash &

#dropbox
dropbox start -i &

#Allows Ctrl+Alt+Backspace to restart Xorg
setxkbmap -option terminate:ctrl_alt_bksp &

#mintupdate
mintupdate-launcher &

#tray
stalonetray &

#disable the fucking touchpad on startup
# xinput set-prop 'ETPS/2 Elantech Touchpad' 'Device Enabled' 0 &

export PATH="$HOME/.cabal/bin:$PATH"
exec xmonad

