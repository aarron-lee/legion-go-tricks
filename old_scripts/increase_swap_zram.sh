#!/usr/bin/bash

echo "increasing zram swap"

sudo cat <<EOF > "/etc/systemd/zram-generator.conf"
[zram0]
zram-fraction=2.0
EOF

echo "done. reboot required"
