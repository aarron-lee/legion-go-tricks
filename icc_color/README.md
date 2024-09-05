# ICC color profiles

thanks @adolfotregosa on discord!

icc color profiles tuned for sRGB on the LGO display

ICC works only under linux and only wayland. KDE6 and GNOME 46/47 should also correct gamut.

# Apply lut to gamescope-session

vkBasalt must be installed. Bazzite ships with vkBasalt.

download vkBasalt.conf, and place it here:

`~/.config/vkBasalt/vkBasalt.conf`

also, download the `lut_18.png` file, and place it in the `~/.config/vkBasalt` folder.

Then, edit the `vkBasalt.conf` file and update the lutFile to the correct path

```
lutFile = "/path/to/lut_file/lut_18.png"
```

to enable it globally, edit the `/etc/environment` file and add the following:

```bash
ENABLE_VKBASALT=1
```

Then in gamescope-session, the `home` button (on a keyboard) will toggle it on/off.

If you do not want it enabled globally, you must add `ENABLE_VKBASALT=1 %command%` for each game.

It currently only works for applications that use Vulkan. For OpenGL games, you can try using Zink with the following command:

`ENABLE_VKBASALT=1 MESA_LOADER_DRIVER_OVERRIDE=zink %command%`
