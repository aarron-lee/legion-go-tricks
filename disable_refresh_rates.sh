#!/usr/bin/bash

echo "force enabling 60Hz mode"

mkdir -p $HOME/.config/environment.d

rm -f $HOME/.config/environment.d/disable-refresh-rates.conf

cat <<EOF > "$HOME/.config/environment.d/override-gamescopecmd.conf"
export GAMESCOPECMD="\$GAMESCOPECMD -r 60 "
export STEAM_DISPLAY_REFRESH_LIMITS=""
EOF

echo "done, please reboot"