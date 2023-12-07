#!/usr/bin/bash

echo "disabling 144Hz refresh rate, reboot required"

mkdir -p $HOME/.config/environment.d
cat <<EOF > "$HOME/.config/environment.d/disable-refresh-rates.conf"
export STEAM_DISPLAY_REFRESH_LIMITS=""
EOF