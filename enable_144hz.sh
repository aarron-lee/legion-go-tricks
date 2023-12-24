#!/usr/bin/bash

echo "Enabling 60Hz in Game Mode"

mkdir -p $HOME/.config/environment.d
rm $HOME/.config/environment.d/disable-refresh-rates.conf

cat <<EOF > "$HOME/.config/environment.d/override-gamescopecmd.conf"
export GAMESCOPECMD="\$GAMESCOPECMD -r 144 "
export STEAM_DISPLAY_REFRESH_LIMITS="144,144"
EOF