#!/usr/bin/bash

WIDTH=1920
HEIGHT=1200

echo "Enabling resolution $WIDTH $HEIGHT. If you wish to use different values, edit the script"

mkdir -p $HOME/.config/environment.d

cat <<EOF > "$HOME/.config/environment.d/bazzite-nested-desktop-resolution.conf"
export STEAMOS_NESTED_DESKTOP_WIDTH=$WIDTH
export STEAMOS_NESTED_DESKTOP_HEIGHT=$HEIGHT
EOF

echo "Done. Please restart Steam Game Mode to see changes"
echo "make sure you change the Steam resolution setting to match the resolution you set"
