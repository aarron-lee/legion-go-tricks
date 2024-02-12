#!/usr/bin/bash

echo "disabling swipe gestures for QAM and HOME"

mkdir -p $HOME/.config/environment.d

cat <<EOF > "$HOME/.config/environment.d/bazzite-disable-gamescope-gestures.conf"
export GAMESCOPE_DISABLE_TOUCH_GESTURES=1
EOF

echo "Done. Please restart Steam Game Mode to see changes"
echo "if you wish to undo these change, delete the $HOME/.config/environment.d/bazzite-disable-gamescope-gestures.conf file"
