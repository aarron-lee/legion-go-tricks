#!/usr/bin/bash

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
