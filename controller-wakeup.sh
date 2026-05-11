#/bin/bash

# source: https://github.com/ublue-os/bazzite/pull/4883/files

echo 'adds udev rule for Steam Controller wakeup via USB'

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi


touch /etc/udev/rules.d/99-steamcontroller-wakeup.rules

cat <<EOF > "/etc/udev/rules.d/99-steamcontroller-wakeup.rules"
# Enable wake from sleep for Valve hardware.
# Source: https://www.reddit.com/r/SteamController/s/7ZEteNW6dm
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", ATTR{power/wakeup}="enabled"
EOF

udevadm control --reload-rules
udevadm trigger

echo 'complete'