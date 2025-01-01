# Experimental Sound Fix v2

## IF ON BAZZITE OS, THIS FIX HAS BEEN ADDED TO THE OS ALREADY.

## IF ON CHIMERA OS, THIS FIX HAS BEEN ADDED

> This sound fix applies a surround sound convolver profile, similar to Dolby Atmos for Built-In Speakers

> The built-in speakers with a volume slider that acts as master gain, and then the virtual sink sliders that apply surround sound profiles on top of the master gain sink. Basically, this lets you adjust the overall gain separate from the sinks themselves to give a wider level of control. It’s not the most seamless solution but it seems to do the job.

credit to @matte-schwartz for developing the initial fix, found [here](https://github.com/matte-schwartz/device-quirks/tree/main/usr/share/device-quirks/scripts/lenovo/legion-go)

credit to @adolfotregosa on discord for developing an improved version of the audio fix!

credit to @KyleGospo for fixing default sound options and other configuration updates

# Install instructions

run the following in terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/experimental_sound_fix/install_sound_fix_v2.sh)

# alternative command for the Legion Go, if the one above doesn't work for you
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/experimental_sound_fix/install_sound_fix_v2.sh | sh
```

Afterwards, you will see an additional Playback device in your audio options `Legion GO`

## WARNING!

Before you switch to the `Legion GO` option, make sure to max out the audio of your regular speakers sound option! The max volume of your audio speakers affects the volume of the `Legion GO` option.

# Uninstall instructions

run the following in terminal:

```
rm $HOME/.config/pipewire/pipewire.conf.d/convolver.conf
rm $HOME/.config/pipewire/multiwayCor48.wav
systemctl --user restart --now wireplumber pipewire pipewire-pulse
```
