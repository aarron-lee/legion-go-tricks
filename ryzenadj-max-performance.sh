#/bin/bash

# credit to adolforegosa on discord for this

echo 'sets ryzenadj --max-performance whenever AC status changes to battery from plugged-in'

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi

#  LGO battery info: sudo udevadm info --attribute-walk --path=/sys/class/power_supply/ACAD
# udevadm info --attribute-walk --path=/sys/class/power_supply/AC0

RYZENADJ_PATH="/usr/bin/ryzenadj"

if [ -e "$RYZENADJ_PATH" ]; then

echo "ryzenadj exists at $RYZENADJ_PATH"

touch /etc/udev/rules.d/99-power-source-change.rules

cat <<EOF >> "/etc/udev/rules.d/99-power-source-change.rules"
SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="$RYZENADJ_PATH --max-performance"
EOF

udevadm control --reload-rules

echo 'complete. If you wish to remove the changes, delete the /etc/udev/rules.d/99-power-source-change.rules and reboot'

else
  echo "ryzenadj does not exist at $RYZENADJ_PATH. Exiting."
fi
