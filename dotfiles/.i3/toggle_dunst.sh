##!/usr/bin/env bash

#notify="notify-send -u low dunst"

#case `dunstctl is-paused` in
#    true)
#        dunstctl set-paused false
#        $notify "Notifications are enabled"
#        ;;
#    false)
#        $notify "Notifications are paused"
#        # the delay is here because pausing notifications immediately hides
#        # the ones present on your desktop; we also run dunstctl close so
#        # that the notification doesn't reappear on unpause
#        (sleep 3 && dunstctl close && dunstctl set-paused true) &
#        ;;
#esac
#
#



#check if on XFCE
if ! command -v xfconf-query > /dev/null; then 
    echo "This script is only for XFCE, sorry."
    exit 1
fi

#check if libnotify is available
if ! [[ "$(which notify-send)" =~ (notify-send) ]]; then
	echo ":: libnotify not found... install with sudo pacman -S libnotify"
	exit 1
fi

#toggle DND
xfconf-query -c xfce4-notifyd -p /do-not-disturb -T

#read the new value
#sleep 0.2
dnd_status=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)

#notify
if [[ $dnd_status == true ]]
then
        notify-send -u critical "DND toggled on" "<span color='#ff1000' font='28px'><i><b>Notifications OFF</b></i></span>"
else
        notify-send -u normal "DND toggled off" "<span color='#57ff00' font='28px'><i><b>Notifications ON</b></i></span>"
fi
