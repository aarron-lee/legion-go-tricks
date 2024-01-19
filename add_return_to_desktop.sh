#/bin/bash

echo "Nobara OS v39 repair"

echo 'adding return to desktop icon'

if [ "$(id -u)" -e 0 ]; then
    echo "This script must be not be run as root, don't use sudo" >&2
    exit 1
fi


cat <<EOF >> "$HOME/Desktop/return.desktop"
[Desktop Entry]
Name=Return to Gaming Mode
Exec=steamos-desktop-return
Icon=steamdeck-gaming-return
Terminal=false
Type=Application
StartupNotify=false
EOF

chmod +x $HOME/Desktop/return.desktop

echo "done!"