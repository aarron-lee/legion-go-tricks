#/bin/bash

# workaround for fuzzy sound on resume
# source: https://www.reddit.com/r/SteamDeck/comments/1eh99as/distorted_audio_after_waking_up_your_steam_deck/

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi

HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)

# Uninstall
sudo systemctl disable --now pipewire-fix-audio-after-suspend.service
sudo rm /etc/systemd/system/pipewire-fix-audio-after-suspend.service
sudo rm $HOME_DIR/.local/bin/pipewire-fix-audio-after-suspend.sh
