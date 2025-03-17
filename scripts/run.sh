#!/usr/bin/env bash

xrdb merge ~/.Xresources 
#xbacklight -set 10 &
feh --bg-fill ~/Pictures/wallpaper &
xset r rate 200 50 &
picom &

bash ~/.config/dwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
