#!/usr/bin/bash
# Lenovo Legion Go setup script
# does the following:
# - Modified Pipewire EQ fixes

# updated with new convolver from @adolfotregosa on discord. thanks!

# original fix from here:
# git clone https://github.com/matte-schwartz/device-quirks.git
# cd device-quirks/usr/share/device-quirks/scripts/lenovo/legion-go
# mv pipewire /etc

# Notes:
# pw-cli info all | grep 'node.name = "alsa_output'
# wpctl status
# coppwr app
# qpwgraph app

# Ensure not running as root
if [ "$EUID" -eq 0 ]; then
    echo "This script must not be run as root." >&2
    exit 1
fi

product_name=$(cat /sys/devices/virtual/dmi/id/product_name)
product_name=$(echo "$product_name" | tr -d '[:space:]')

if [ "$product_name" = "83E1" ]; then
    echo "Legion Go detected. Continuing install"
else
    echo "Device $product_name is not a Legion Go"
    echo "This fix is NOT intended for your device. If you decided to proceed with installing it,"
    echo "note that it is NOT supported and can potentially cause issues on your device."
    echo "no support or help will be provided by developers for this"

    read -p "Would you like to proceed? (y/n)" yn
    case $yn in
        [Yy]) echo "Continuing install...";;
        *) echo "Exiting." && exit 1;;
    esac
fi

echo "installing pipewire EQ sound improvements"
# download + setup pipewire EQ sound improvements

cd /tmp

git clone --depth=1 https://github.com/aarron-lee/legion-go-tricks.git

cd /tmp/legion-go-tricks/experimental_sound_fix

PIPEWIRE_DIR=$HOME/.config/pipewire
PIPEWIRE_CONF_DIR=$PIPEWIRE_DIR/pipewire.conf.d

mkdir -p $PIPEWIRE_DIR
mkdir -p $PIPEWIRE_CONF_DIR

cat << EOF > "$PIPEWIRE_CONF_DIR/convolver.conf"
# Convolver Configuration for Pipewire
#
# This configuration applies separate left and right convolver effects using the corresponding impulse response files
# to the entire system audio output.

context.modules = [
    { name = libpipewire-module-filter-chain
        args = {
            node.description = "Legion GO"
            media.name       = "Legion GO"
            filter.graph = {
                nodes = [
                    {
                        type  = builtin
                        label = convolver
                        name  = convFL
                        config = {
                            filename = "$HOME/.config/pipewire/multiwayCor48.wav"
                            channel  = 0
                        }
                    }
                    {
                        type  = builtin
                        label = convolver
                        name  = convFR
                        config = {
                            filename = "$HOME/.config/pipewire/multiwayCor48.wav"
                            channel  = 1
                        }
                    }
                ]
                inputs = [ "convFL:In" "convFR:In" ]
                outputs = [ "convFL:Out" "convFR:Out" ]
            }
            capture.props = {
                node.name      = "Legion GO"
                media.class    = "Audio/Sink"
                priority.driver = 1000
                priority.session = 1000
                audio.channels = 2
                audio.position = [ FL FR ]
            }
            playback.props = {
                node.name      = "Legion GO corrected"
                node.passive   = true
                audio.channels = 2
                audio.position = [ FL FR ]
                node.target = "alsa_output.pci-0000_c2_00.6.analog-stereo"
            }
        }
    }
]

# wav file is 48000 khz, so you must set allowed-rates accordingly
context.properties = {
    default.clock.allowed-rates = [ 48000 ]
}
EOF

cp /tmp/legion-go-tricks/experimental_sound_fix/multiwayCor48.wav $PIPEWIRE_DIR/multiwayCor48.wav

systemctl --user restart --now wireplumber pipewire pipewire-pulse

rm -rf /tmp/legion-go-tricks

echo "Installation complete. Change your audio source to 'Legion GO'"

echo "-------------
READ THE FOLLOWING!
-------------"

echo "note that this fix itself is a bit odd.
the volume of your regular speakers affects the max volume of the 'Legion GO' sound option.
so basically install this fix, then max out/adjust audio volume on regular speakers, then swap to other audio source"
