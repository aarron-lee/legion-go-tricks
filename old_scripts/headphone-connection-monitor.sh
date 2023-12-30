#!/usr/bin/bash

DECK_SINK=37
DECK_SOURCE=$(wpctl status | grep Echo | grep Source | cut -d " " -f 7 | cut -d "." -f 1)
DECK_SINK_VOL=$(wpctl get-volume $DECK_SINK | cut -d " " -f 2)
DECK_SOURCE_VOL=$(wpctl get-volume $DECK_SOURCE | cut -d " " -f 2)
SINK_LIST=$(pactl list sinks | grep 'Sink #' | cut -d "#" -f 2)
SOURCE_LIST=$(pactl list sources | grep 'Source #' | cut -d "#" -f 2)

max_device_volumes()
{
for SINK in $SINK_LIST
do
        if [[ $SINK != $DECK_SINK) ]]; then
                wpctl set-volume $SINK 1.0
        fi
done

for SOURCE in $SOURCE_LIST
do
        if [[ $SINK != $DECK_SINK $DECK_SOURCE) ]]; then
                wpctl set-volume $SOURCE 1.0
        fi
done
}

while true; do
    if [[ -z $(pactl list sinks | grep "Active Port: analog-output-headphones") ]]; then
        max_device_volumes
    else
        max_device_volumes
    fi
    sleep 1
done

