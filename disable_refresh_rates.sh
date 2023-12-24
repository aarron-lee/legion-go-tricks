#!/usr/bin/bash

echo "this is no longer necessary, see updated instructions on the legion-go-tricks website"

mkdir -p $HOME/.config/environment.d

rm -f $HOME/.config/environment.d/disable-refresh-rates.conf

cat <<EOF > "$HOME/.config/environment.d/override-gamescopecmd.conf"
export GAMESCOPECMD="\$GAMESCOPECMD -r 60 "
export STEAM_DISPLAY_REFRESH_LIMITS=""
EOF