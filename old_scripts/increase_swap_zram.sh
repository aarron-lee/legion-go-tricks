#!/usr/bin/bash

echo "increasing zram swap"

sudo cat <<EOF > "/etc/systemd/zram-generator.conf"
[zram0]
zram-size=ram*2
compression-algorithm=lz4
EOF

echo "done. reboot required"
