#!/bin/bash

if [ "$(id -u)" -e 0 ]; then
    echo "This script must be not be run as root, don't use sudo" >&2
    exit 1
fi

# disable built in bazzite service
sudo systemctl disable --now hhd@$USER.service

cd $HOME/.local/bin

git clone https://github.com/hhd-dev/hhd.git && cd hhd

python -m venv --system-site-packages venv

source ./venv/bin/activate

./venv/bin/pip install -e .

# cannot directly cat into /etc/systemd/system/ (probably due to se linux)
cat << EOF >> "./hhd_local.service"
[Unit]
Description=hhd local service
RequiresMountFor=/var/home/$USER

[Service]
Type=simple
Nice = -15
Restart=always
RestartSec=5
WorkingDirectory=/var/home/$USER/.local/bin/hhd/venv/bin
ExecStart=/var/home/$USER/.local/bin/hhd/venv/bin/hhd --user $USER

[Install]
WantedBy=default.target
EOF

sudo cp ./hhd_local.service /etc/systemd/system/

# handle for SE linux
sudo chcon -u system_u -r object_r --type=bin_t /var/home/$USER/.local/bin/hhd/venv/bin/hhd

sudo systemctl daemon-reload
sudo systemctl enable --now hhd_local.service
