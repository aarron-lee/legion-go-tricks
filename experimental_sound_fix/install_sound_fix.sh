#!/usr/bin/bash
# Lenovo Legion Go setup script
# does the following:
# - Modified Pipewire EQ fixes


# Notes:
# pw-cli info all | grep 'node.name = "alsa_output'
# wpctl status

# Ensure not running as root
if [ "$(id -u)" -e 0 ]; then
    echo "This script must not be run as root." >&2
    exit 1
fi

echo "installing pipewire EQ sound improvements"
# download + setup pipewire EQ sound improvements

cd /tmp

git clone https://github.com/aarron-lee/legion-go-tricks.git 

cd /tmp/legion-go-tricks/experimental_sound_fix

PIPEWIRE_DIR=$HOME/.config/pipewire
PIPEWIRE_CONF_DIR=$PIPEWIRE_DIR/pipewire.conf.d

mkdir -p $PIPEWIRE_DIR
mkdir -p $PIPEWIRE_CONF_DIR

cat << EOF > "$PIPEWIRE_CONF_DIR/convolver.conf"
# Convolver Configuration for Pipewire
#
# This configuration applies a convolver effect using the neutral.wav impulse response file
# to the entire system audio output.

context.modules = [
    { name = libpipewire-module-filter-chain
        args = {
            node.description = "Convolver Sink - Neutral"
            media.name       = "Convolver Sink - Neutral"
            filter.graph = {
                nodes = [
                    {
                        type   = builtin
                        name   = neutral_convolver
                        label  = convolver
                        config = {
                            blocksize = 256        # FFT block size
                            tailsize = 2048        # Tail block size in FFT
                            gain = 2.5             # Overall gain to apply to the IR file
                            delay = 0              # Extra delay in samples
                            filename = "$HOME/.config/pipewire/neutral.wav" # Path to the impulse response file
                            offset = 0             # Sample offset in the file as the start of the IR
                            length = 0             # Number of samples to use as the IR
                            channel = 0            # Channel to use from the file as the IR
                            resample_quality = 4   # Resample quality
                        }
                    }
                ]
                # Internal links within the filter chain
                # These can be adjusted or extended based on additional nodes or requirements
            }
            audio.channels = 2
            audio.position = [ FL FR ]
            capture.props = {
                node.name      = "surround-effect.neutral"
                media.class    = "Audio/Sink"
                audio.channels = 2
                audio.position = [ FL FR ]
            }
            playback.props = {
                audio.position = [ FL FR ]
                node.target = "alsa_output.pci-0000_c2_00.6.analog-stereo"
                stream.dont-remix = true
                node.passive = true
                audio.channels = 2
            }
            # playback.props = {
            #     node.name      = "effect_output.convolver"
            #     node.passive   = true
            #     audio.channels = 2
            #     audio.position = [ FL FR ]
            # }
        }
    },
]
EOF

cp /tmp/legion-go-tricks/experimental_sound_fix/pipewire/neutral.wav $PIPEWIRE_DIR/neutral.wav

systemctl --user restart --now wireplumber pipewire pipewire-pulse

rm -rf /tmp/legion-go-tricks

echo "Installation complete. Change your audio source to Convolver Sink - Neutral"