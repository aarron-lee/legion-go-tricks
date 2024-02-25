#/bin/bash

echo 'enable sound fix as default sound on system boot'

if [ "$(id -u)" -e 0 ]; then
    echo "This script must not be run as root, don't use sudo" >&2
    exit 1
fi

mkdir -p $HOME/.local/bin

SOUND_FIX_SCRIPT=$HOME/.local/bin/default_sound_sink

cat << EOF > "$SOUND_FIX_SCRIPT"
#!/usr/bin/env python

import os
from time import sleep
import subprocess

def execute_command(command):
  try:
    result = subprocess.run(command, shell=True, check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return result.stdout.strip()
  except subprocess.CalledProcessError as e:
    print(f"Error executing command: {e.stderr}")
    return None

def is_game_mode():
  # Get the currently running Steam PID.
  steampid_path = '$HOME' + '/.steam/steam.pid'
  pid = None
  try:
    with open(steampid_path) as f:
        pid = f.read().strip()
  except Exception as e:
    print(f"steam-powerbuttond: failed to get steam PID: {e}")
    return False

  steam_cmd_path = f"/proc/{pid}/cmdline"
  if not os.path.exists(steam_cmd_path):
    # Steam not running.
    return False

  try:
    with open(steam_cmd_path, "rb") as f:
        steam_cmd = f.read()
  except Exception as e:
    print(f"steam-powerbuttond: failed to get steam cmdline: {e}")
    return False 

  # Use this and line to determine if Steam is running in DeckUI mode.
  is_deck_ui = b"-gamepadui" in steam_cmd
  if not is_deck_ui:
    return False
  return True

# -----------------------------------

while (not is_game_mode()):
  sleep(5)

# execute_command("pactl set-default-source alsa_output.pci-0000_c2_00.6.analog-stereo.monitor")

# sleep(0.1)

# execute_command("pactl -- set-sink-volume 0 100%")

# sleep(0.1)

execute_command("pactl set-default-sink surround-effect.neutral")

# sleep(0.1)

# execute_command("pactl -- set-sink-volume 0 50%")

EOF

chmod +x $SOUND_FIX_SCRIPT

mkdir -p $HOME/.config/systemd/user

# handle for SE linux
sudo chcon -u system_u -r object_r --type=bin_t $SOUND_FIX_SCRIPT

systemctl --user disable --now surround-effect-default

cat << EOF >> "./surround-effect-default.service"
[Unit]
Description=surround sound effect as default sound sink service

[Service]
Type=oneshot
WorkingDirectory=/var/home/$USER/.local/bin/
ExecStart=/var/home/$USER/.local/bin/default_sound_sink

[Install]
WantedBy=default.target
EOF

sudo mv ./surround-effect-default.service $HOME/.config/systemd/user

sudo systemctl daemon-reload
systemctl --user enable --now surround-effect-default &

cat << EOF > "$HOME/Desktop/ReturnToGameModeModified.desktop"
[Desktop Entry]
Comment[en_US]=
Comment=
Exec=sh -c "systemctl start return-to-gamemode.service && systemctl --user start surround-effect-default.service"
GenericName[en_US]=
GenericName=
Icon=steamdeck-gaming-return
MimeType=
Name[en_US]=Return to Gaming Mode (patched)
Name=Return to Gaming Mode (patched)
Path=
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=deck
EOF

chmod +x "$HOME/Desktop/ReturnToGameModeModified.desktop"

echo 'complete!'


