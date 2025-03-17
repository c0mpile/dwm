#!/usr/bin/env bash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/dwm/scripts/bar_themes/onedark

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$blue^ ^b$black^ CPU"
  printf "^c$white^ ^b$black^ $cpu_val"
}

pkg_updates() {
  updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch

  if [ -z "$updates" ]; then
    printf "  ^c$green^    Fully Updated"
  else
    printf "  ^c$red^^b$black^    " "^c$white^^b$black^ $updates updates"
  fi
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
  printf "^c$blue^ ^b$black^  "
  printf "^c$white^ ^b$black^ $get_capacity"
}

brightness() {
  printf "^c$red^   "
  printf "^c$white^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

mem() {
  printf "^c$blue^ ^b$black^  "
  printf "^c$white^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$blue^ ^b$black^ 󰤨 ^d^%s" " ^c$white^Connected" ;;
	down) printf "^c$blue^ ^b$black^ 󰤭 ^d^%s" " ^c$white^Disconnected" ;;
	esac
}

clock() {
	printf "^c$blue^ ^b$black^ 󱑆 "
	printf "^c$white^^b$black^ $(date '+%H:%M')  "
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$updates $(cpu) $(mem) $(clock)"
  #sleep 1 && xsetroot -name "$updates $(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
done
