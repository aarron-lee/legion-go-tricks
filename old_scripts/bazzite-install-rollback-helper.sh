#!/usr/bin/bash

# Ensure not running as root
if [ "$EUID" -eq 0 ]; then
    echo "This script must not be run as root." >&2
    exit 1
fi

echo "installing bazzite rollback helper"
# download + setup rollback helper

cd /tmp

git clone https://github.com/aarron-lee/legion-go-tricks.git

cd /tmp/legion-go-tricks/old_scripts

mkdir -p $HOME/.local/bin

chmod +x ./bazzite-rollback-helper

cp bazzite-rollback-helper ~/.local/bin/

sudo chcon -u system_u -r object_r --type=bin_t $HOME/.local/bin/bazzite-rollback-helper

rm -rf /tmp/legion-go-tricks

echo "Installation complete. run 'bazzite-rollback-helper -h' in terminal"
