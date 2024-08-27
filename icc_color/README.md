# ICC color profiles

thanks @adolfotregosa on discord!

icc color profiles tuned for sRGB on the LGO display

Works everywhere BUT KDE6 also corrects gamut.

# Apply lut to gamescope-session

vkBasalt must be installed. Bazzite ships with vkBasalt.

download vkBasalt.conf, and place it here:

`~/.config/vkBasalt/vkBasalt.conf`

also, download the `lut_32.png` file, and place it in the `~/.config/vkBasalt` folder.

Then, edit the `vkBasalt.conf` file and update the lutFile to the correct path

```
lutFile = "/path/to/lut_file/lut_32.png"
```

to enable it globally, edit the `/etc/environment` file and add the following:

```bash
ENABLE_VKBASALT=1
```

Then in gamescope-session, the `home` button (on a keyboard) will toggle it on/off.
