# Experimental Sound Fix v2

> This sound fix applies a surround sound convolver profile, similar to Dolby Atmos for Built-In Speakers

> The built-in speakers with a volume slider that acts as master gain, and then the virtual sink sliders that apply surround sound profiles on top of the master gain sink. Basically, this lets you adjust the overall gain separate from the sinks themselves to give a wider level of control. It’s not the most seamless solution but it seems to do the job.

credit to @matte-schwartz for developing the initial fix, found [here](https://github.com/matte-schwartz/device-quirks/tree/main/usr/share/device-quirks/scripts/lenovo/legion-go)

credit to @adolfotregosa on discord for developing an improved version of the audio fix!

# Install instructions

If you installed the v1 version, you can just rerun both scripts to reinstall.

run the following in terminal:

```
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/experimental_sound_fix/install_sound_fix_v2.sh | sh
```

Afterwards, you will see an additional Playback device in your audio options `Legion GO`

## WARNING!

Before you switch to the `Legion GO` option, make sure to max out the audio of your regular speakers sound option! The max volume of your audio speakers affects the volume of the `Legion GO` option.

Note that the `Legion GO` option often gets reset on reboot, you can run the following script for to fix this:

```
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/experimental_sound_fix/fix_sound_default_v2.sh | sh
```

This script will also add a fixed `Return to Desktop` icon that sets the default sound option accordingly.

# Uninstall instructions

run the following in terminal:

```
systemctl --user disable --now surround-effect-default.service
rm $HOME/.config/pipewire/pipewire.conf.d/convolver.conf
rm $HOME/.config/pipewire/neutral.wav
rm $HOME/.config/pipewire/multiwayCor48.wav
systemctl --user restart --now wireplumber pipewire pipewire-pulse
```
