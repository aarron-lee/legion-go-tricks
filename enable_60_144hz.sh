#!/usr/bin/bash

if [ "$(id -u)" -e 0 ]; then
    echo "This script must be not be run as root, don't use sudo" >&2
    exit 1
fi

echo "Enabling 60hz + 144hz. Note, this assumes Valve's 6.1 Neptune Kernel is already installed"

mkdir -p $HOME/.config/environment.d
rm -f $HOME/.config/environment.d/disable-refresh-rates.conf
rm -f $HOME/.config/environment.d/override-gamescopecmd.conf

# remove previous workaround plugin
sudo rm -rf $HOME/homebrew/plugins/LegionGoRefreshRate

cat <<EOF > "$HOME/.config/environment.d/override-gamescopecmd.conf"
export ENABLE_GAMESCOPE_WSI=1
export STEAM_DISPLAY_REFRESH_LIMITS="60,144"
EOF

sudo systemctl restart plugin_loader.service

echo "Done. Please restart Steam Game Mode to see changes"
