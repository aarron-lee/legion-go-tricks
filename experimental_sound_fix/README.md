# Experimental Sound Fix

> This sound fix applies a surround sound convolver profile, similar to Dolby Atmos for Built-In Speakers

> The built-in speakers with a volume slider that acts as master gain, and then the virtual sink sliders that apply surround sound profiles on top of the master gain sink. Basically, this lets you adjust the overall gain separate from the sinks themselves to give a wider level of control. It’s not the most seamless solution but it seems to do the job.

credit to @matte-schwartz for developing the initial fix, found [here](https://github.com/matte-schwartz/device-quirks/tree/main/usr/share/device-quirks/scripts/lenovo/legion-go)

# Install instructions

run the following in terminal:

```
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/experimental_sound_fix/install_sound_fix.sh | sh
```

Afterwards, you will see an additional Playback device in your audio options `sound-effect.neutral`

Before you switch to the `sound-effect.neutral` option, make sure to max out the audio of your regular speakers sound option. The max volume of your audio speakers affects the volume of the `sound-effect.neutral` option.

Note that the `sound-effect.neutral` option often gets reset on reboot, you can run the following script for to fix this:

```
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/experimental_sound_fix/fix-sound-default.sh | sh
```

This script will also add a fixed `Return to Desktop` icon that sets the default sound option accordingly.

# Uninstall instructions

run the following in terminal:

```
systemctl --user disable --now surround-effect-default.service
rm $HOME/.config/pipewire/pipewire.conf.d/convolver.conf
rm $HOME/.config/pipewire/neutral.wav
systemctl --user restart --now wireplumber pipewire pipewire-pulse
```
