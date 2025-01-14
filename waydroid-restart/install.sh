#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root with sudo"
  exit
fi

cd /tmp

git clone --depth=1 https://github.com/aarron-lee/legion-go-tricks.git

cd /tmp/legion-go-tricks/waydroid-restart

HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)

WAYDROID_RESTART_BIN=/usr/local/bin/waydroid-force-restart

cp ./waydroid-force-restart.desktop "$HOME_DIR/.local/share/applications/waydroid-force-restart.desktop"

cp ./waydroid-force-restart $WAYDROID_RESTART_BIN

chmod +x $WAYDROID_RESTART_BIN

sudo chcon -u system_u -r object_r --type=bin_t $WAYDROID_RESTART_BIN

cat <<-EOF > "/etc/sudoers.d/waydroid-force-restart"
ALL ALL=(ALL) NOPASSWD: $WAYDROID_RESTART_BIN
EOF

rm -rf /tmp/legion-go-tricks