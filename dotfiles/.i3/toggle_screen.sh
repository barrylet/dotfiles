#!/bin/bash
# This script is intended to make switching between laptop and external displays easier when using i3+dmenu
# To run this script, map it to some shortcut in your i3 config, e.g:
# bindsym $mod+p exec --no-startup-id $config/display.sh
# IMPORTANT: run chmod +x on the script to make it executable
# The result is 4 options appearing in dmenu, from which you can choose


# Identify the two displays
connected_displays=$(xrandr | grep ' connected ' | awk '{ print$1 }')
displays_array=(${connected_displays//$' '/ })

# Maybe this should be hardcoded? What happens if the displays were to have a different order?
INTERNAL_OUTPUT=${displays_array[0]}
EXTERNAL_OUTPUT=${displays_array[1]}

# Choices will be displayed in rofi
# If only one monitor was found, truncate the options
choices="laptop only"
if [ ! -z "${EXTERNAL_OUTPUT}" ]; then
	choices="laptop\ndual\nclone\nexternal"
fi

# Your choice in dmenu will determine what xrandr command to run
chosen=$(echo -e $choices | rofi -dmenu -i -window-title "display option" -theme solarized)

# xrander will run and turn on the display you want, if you have an option for 3 displays, this will need some modifications
case "$chosen" in
    external) xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto --primary ;;
    laptop) xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --off ;;
    "laptop only") xrandr --auto ;;
    clone) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT ;;
    dual) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --right-of $INTERNAL_OUTPUT --primary ;;
esac

# Fix wallpaper
sleep 5 && nitrogen --set-auto $HOME/Pictures/wallpaper.jpg --head=0 && nitrogen --set-auto $HOME/Pictures/wallpaper.jpg --head=1

