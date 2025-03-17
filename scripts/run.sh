#!/usr/bin/env bash

xrandr --output DP-1 --primary --mode 2560x1440 --rate 165 --output DP-2 --mode 2560x1440 --rate 165 --right-of DP-1
xrdb merge ~/.Xresources 
#xbacklight -set 10 &
feh --bg-fill ~/Pictures/wallpaper &
xset r rate 200 50 &
picom &

bash ~/.config/dwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
