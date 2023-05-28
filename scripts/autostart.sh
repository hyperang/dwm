#!/bin/bash

# xrandr --auto --output HDMI1 --same-as eDP1 --size widthxheight (1920x1080)
/bin/bash ~/.dwm/dwm-status.sh &
feh --recursive --bg-fill ~/pictures/wallpapers/wallpaper0005.jpg
picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b   

