## Legion Go Tricks

### Introduction
This document serves to provide information, workarounds, and tricks to improving day-to-day use of Linux on the Legion Go.

Note that while a lot of things are working, Linux support for this device is very much a work in progress, developers are working on improving the experience.

Some of the things you find in this guide may be unofficial changes to original software

### What Works?

At the moment, the following functions work out of the box

- Screen orientation (fixed in NobaraOS Deck Edition, ChimeraOS 45 unstable, Bazzite OS)
- suspend-resume functionality
- Wifi and Bluetooth
- Sound
- Controllers, both attached and detached
  - note, controllers work best in X-input mode. see [official Legion Go Userguide PDF](./lenovo_go_user_guide_en.pdf) to read more about controller modes
- FPS/Mouse mode

### What Has Workarounds?

These functions are not working out of the box, but have workarounds

- Steam/QAM Buttons/Rear back buttons^ - everything can be almost fully used with additional software
- Gyro^ - uses the same fix as buttons fix 
- TDP^ - requires using either steam-patch or decky plugins
- Controller RGB^ - requires decky plugin

## What has issues

- Battery indicator - it doesn't always work, but has a usable workaround
- Refresh Rate - only refresh rates that work are 60Hz and 144Hz, everything else is not usable/has issues.

### Resources

PS5 Dualsense Edge Emulator - https://github.com/corando98/ROGueENEMY/

RGB Decky Plugin - https://github.com/aarron-lee/LegionGoRemapper/

Simple Decky TDP Plugin - https://github.com/aarron-lee/SimpleDeckyTDP

steam-patch (for TDP control, some steam glyphs, etc) - https://github.com/corando98/steam-patch

powerbutton fix when not using handycon - https://github.com/aarron-lee/steam-powerbuttond

Pipewire sound fix files - https://github.com/matte-schwartz/device-quirks/tree/legion-go/rog-ally-audio-fixes/usr/share/device-quirks/scripts/lenovo/legion-go

gyro increase sampling rate fix - https://github.com/antheas/llg_sfh

alternative PS5 Dualsense Edge Emulator (work in progress) - https://github.com/antheas/hhd

reverse engineering docs - https://github.com/antheas/hwinfo/tree/master/devices

## Guides + small fixes

### Fix orange colored hue to game mode UI

Sometimes Steam game mode will have a bug where the color of the screen is slightly orange in tone.

disabling steam color management will fix this, but this will also remove night mode functionality.

Add the following:

```
export STEAM_GAMESCOPE_COLOR_MANAGED=0
```

to a `disable-steam-color-management.conf` file in `$HOME/.config/environment.d`. To remove this fix later, simply delete the file

### (NobaraOS only) additional script for to fix the Pipewire sound, fix issue where volume gets stuck on max volume

after installing the pipewire sound fix files, replace the `/usr/bin/headphone-connection-monitor.sh` file with the same file downloadable from this git repo. Note that you'll have to make the script executable too with `chmod +x`.

### Use MangoHud for battery indicator

Battery indicator is inconsistent on the Legion go. As a workaround, you can change mangohud to show just the battery on one of the presets.

example preset, file should be in the `$HOME/.config/MangoHud/presets.conf`

```
[preset 1]
battery=1
fps=0
cpu_stats=0
gpu_stats=0
frame_timing=0
```