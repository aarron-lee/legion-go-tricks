#!/usr/bin/bash
# Lenovo Legion Go script
# does the following:
# - disable steam color management


echo "disabling steam color management"
# disable steam color management
mkdir -p $HOME/.config/environment.d
cat <<EOF > "$HOME/.config/environment.d/disable-steam-color-management.conf"
export STEAM_GAMESCOPE_COLOR_MANAGED=0
EOF
