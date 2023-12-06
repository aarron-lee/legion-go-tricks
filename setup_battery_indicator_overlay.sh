#!/usr/bin/bash

echo "configuring preset 1 of performance overlay to display battery levels"
# configure mangohud 1st preset for battery
mkdir -p $HOME/.config/MangoHud
cat <<EOF > "$HOME/.config/MangoHud/presets.conf"
[preset 1]
battery=1
fps=0
cpu_stats=0
gpu_stats=0
frame_timing=0
EOF