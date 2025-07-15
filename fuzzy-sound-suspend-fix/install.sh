#/bin/bash

# workaround for fuzzy sound on resume
# source: https://www.reddit.com/r/SteamDeck/comments/1eh99as/distorted_audio_after_waking_up_your_steam_deck/

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi

systemctl disable --now pipewire-fix-audio-after-suspend.service

HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)
HOME_USER="${SUDO_USER:-${USER}}"


cat <<EOF > "/etc/systemd/system/pipewire-fix-audio-after-suspend.service"
[Unit]
Description=A workaround for distorted audio after suspend
After=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
Type=oneshot
User=$HOME_USER
Environment="XDG_RUNTIME_DIR=/run/user/1000"
ExecStart=/bin/bash "$HOME_DIR/.local/bin/pipewire-fix-audio-after-suspend.sh"

[Install]
WantedBy=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
EOF

mkdir -p $HOME_DIR/.local/bin

SCRIPT_PATH=$HOME_DIR/.local/bin/pipewire-fix-audio-after-suspend.sh

cat <<'EOF' > "$SCRIPT_PATH"
#!/bin/env bash
set -o errexit

cmd_output="$(pw-metadata -n settings 0 clock.force-quantum)"
regex="^.{1,}value:'([[:digit:]]{1,})'.{1,}$"

[[ $cmd_output =~ $regex ]] && old_quantum="${BASH_REMATCH[1]}" || exit 1
[ $old_quantum != 0 ] && temp_quantum=$(( $old_quantum - 1 )) || temp_quantum=16
pw-metadata -n settings 0 clock.force-quantum $temp_quantum
pw-metadata -n settings 0 clock.force-quantum $old_quantum
EOF

chmod +x $SCRIPT_PATH

if [[ -f "$json_file" ]]; then
    image_name=$(grep -oP '"image-name"\s*:\s*"\K[^"]+' "$json_file")

    if [[ "$image_name" =~ bazzite ]]; then
        echo "bazzite detected, handling for SE Linux"

        chcon -u system_u -r object_r --type=bin_t $SCRIPT_PATH
    else
        echo "The image-name is not 'bazzite', it is '$image_name'."
    fi
else
    echo "Bazzite not detected, skipping Bazzite steps"
fi

systemctl daemon-reload
systemctl enable --now pipewire-fix-audio-after-suspend.service
