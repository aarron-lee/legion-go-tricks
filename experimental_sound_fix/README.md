# Experimental Sound Fix

Modified for ROG Ally Z1E and Ally X

# Install instructions

run the following in terminal:

```bash
# for ROG Ally
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/rog_ally_sound_fix/experimental_sound_fix/install_sound_fix_ally.sh | sh

# for ROG Ally X
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/rog_ally_sound_fix/experimental_sound_fix/install_sound_fix_ally_x.sh | sh
```

Afterwards, you will see an additional Playback device in your audio options `ROG Ally`

## WARNING!

Before you switch to the `ROG Ally` option, make sure to max out the audio of your regular speakers sound option! The max volume of your audio speakers affects the volume of the `ROG Ally` option.

# Uninstall instructions

run the following in terminal:

```
rm $HOME/.config/pipewire/pipewire.conf.d/convolver.conf
rm $HOME/.config/pipewire/ally*.wav
systemctl --user restart --now wireplumber pipewire pipewire-pulse
```
