#!/usr/bin/bash

WIDTH=1920
HEIGHT=1200
DPI=340

echo "Enabling resolution $WIDTH $HEIGHT, and DPI $DPI for waydroid. If you wish to use different values, edit the script"

mkdir -p $HOME/.config/environment.d

cat <<EOF > "$HOME/.config/environment.d/bazzite-waydroid-resolution.conf"
export WAYDROID_WIDTH=$WIDTH
export WAYDROID_HEIGHT=$HEIGHT
export WAYDROID_DENSITY=$DPI
EOF

echo "Done. Please restart Steam Game Mode to see changes"
echo "make sure you change the Steam resolution setting to match the resolution you set"
