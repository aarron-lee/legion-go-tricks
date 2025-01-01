#/bin/bash

echo 'enabling acpi call on boot'

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi

touch /etc/modules-load.d/acpi-call.conf

cat <<EOF >> "/etc/modules-load.d/acpi-call.conf"
acpi_call
EOF

echo 'complete, reboot for changes to take effect'
