#!/usr/bin/env bash

SCALE=1.5


IS_GAMEMODE="$(cat /proc/*/comm | grep gamescope-ses*)"

# this is to prevent the autoscale from kicking in on nested desktop
if [[ -z "$IS_GAMEMODE" ]] ;
then

# This script was modified for to set the screen scale in the Desktop Mode in KDE
# Original Author: d3Xt3r
# source: https://github.com/d3-X-t3r/LinuxThings/blob/main/bazzite-rotation-fix.sh
# 
# - Save this script somewhere and mark it as executabe (chmod +x ./desktopmode-autoscale.sh)
# - Add it to your KDE Autostart config (Menu > search for Autostart > Add)

sleep 8
echo $(date '+%Y-%m-%d %H:%M:%S') Starting Autoscale Fix script...| tee -a /tmp/desktop-mode-scale.log

# This bit is needed to allow enough time for the desktop to load, otherwise the fix won't work
# Since Steam launches automatically in the Desktop mode in Bazzite-Deck, we can use it 
# to determine whether or not the desktop has loaded.
while ! pgrep -x "steam" > /dev/null; do
	echo $(date '+%Y-%m-%d %H:%M:%S') Waiting for Steam to start.. | tee -a /tmp/desktop-mode-scale.log
	sleep 1.5
done

sleep 1

# Debug: Get current outputs
kscreen-doctor --outputs 2>&1 | tee -a /tmp/desktop-mode-scale.log

# Fix desktop orientation
# Rotation options: right, normal, left, inverted
echo $(date '+%Y-%m-%d %H:%M:%S') Fixing desktop scale... | tee -a /tmp/desktop-mode-scale.log
kscreen-doctor output.1.scale.$SCALE 2>&1 | tee -a /tmp/desktop-mode-scale.log

echo $(date '+%Y-%m-%d %H:%M:%S') Ending Desktop Scale Fix script >> /tmp/desktop-mode-scale.log
echo -e '\n' >> /tmp/desktop-mode-scale.log

echo "complete!"
fi
