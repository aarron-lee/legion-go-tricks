#!/usr/bin/bash
# Lenovo Legion Go setup script
# does the following:
# - headphone connection-monitor script fix
# - install steamos-nested-desktop
# - install steam-powerbuttond for to replicate power button behavior from handycon
# - basic TDP control via SimpleDeckyTDP plugin
# - RGB control via LegionGoRemapper Decky Plugin
# - Pipewire EQ fixes from matt_schartz

BUILD_DIR="/tmp/LGO_nobara_setup"

# Define the user's home directory
# This ensures that we get the original user's home directory, not root's
if [ "$SUDO_USER" ]; then
    HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    HOME_DIR=$HOME
fi

# Ensure running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

echo "Installing Headphone Conenction fix for Pipewire EQ..."
# add fixed up headphone connection monitor for Pipewire EQ sound fix
cp ./headphone-connection-monitor.sh /usr/bin/headphone-connection-monitor.sh

echo "Installing SteamOS Nested Desktop File"
# install steamos-nested-desktop
chmod +x steamos-nested-desktop
cp ./steamos-nested-desktop /usr/local/bin/steamos-nested-desktop

mkdir -p $BUILD_DIR
cd $BUILD_DIR

echo "fixing powerbutton suspend behavior"
# download + install powerbuttond
git clone https://github.com/aarron-lee/steam-powerbuttond.git
cd steam-powerbuttond

chmod +x install.sh
./install.sh

echo "installing SimpleDeckyTDP plugin"
# download + install Simple TDP Decky Plugin
curl -L $(curl -s https://api.github.com/repos/aarron-lee/SimpleDeckyTDP/releases/latest | grep "browser_download_url" | cut -d '"' -f 4) -o $BUILD_DIR/SimpleDeckyTDP.tar.gz
tar -xzf SimpleDeckyTDP.tar.gz -C $HOME_DIR/homebrew/plugins

echo "installing LegionGoRemapper plugin for RGB control"
# download + install Legion go remapper
curl -L $(curl -s https://api.github.com/repos/aarron-lee/LegionGoRemapper/releases/latest | grep "browser_download_url" | cut -d '"' -f 4) -o $BUILD_DIR/LegionGoRemapper.tar.gz
tar -xzf LegionGoRemapper.tar.gz -C $HOME_DIR/homebrew/plugins

echo "installing pipewire EQ sound improvements"
# download + setup pipewire EQ sound improvements
git clone https://github.com/matte-schwartz/device-quirks.git
cd device-quirks/usr/share/device-quirks/scripts/lenovo/legion-go
mv pipewire /etc

cd $BUILD_DIR

# install complete, remove build dir
cd /
rm -rf $BUILD_DIR
echo "Installation complete"