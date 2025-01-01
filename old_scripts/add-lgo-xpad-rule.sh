#/bin/bash

echo 'adding missing x-box gamepad udev rule'

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi

touch /etc/udev/rules.d/50-lenovo-legion-controller.rules

cat <<EOF >> "/etc/udev/rules.d/50-lenovo-legion-controller.rules"
# Lenovo Legion Go
ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6182", RUN+="/sbin/modprobe xpad" RUN+="/bin/sh -c 'echo 17ef 6182 > /sys/bus/usb/drivers/xpad/new_id'"
EOF

udevadm control --reload-rules
udevadm trigger

echo 'complete!'
