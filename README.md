## Legion Go Tricks

### Introduction
This document serves to provide information, workarounds, and tricks to improving day-to-day use of Linux on the Legion Go.

Note that while a lot of things are working, Linux support for this device is very much a work in progress, developers are working on improving the experience.

Some of the things you find in this guide may be unofficial changes to original software

### What Works?

At the moment, the following functions work out of the box

- Screen orientation (fixed in NobaraOS Deck Edition, ChimeraOS 45 unstable, Bazzite OS)
- suspend-resume functionality
  - small suspend quirk: sometimes sound is fuzzy on resume, usually clears up after 30 seconds or so.
    - use [Pause Games plugin](https://github.com/popsUlfr/SDH-PauseGames) with `Pause on Suspend` enabled to help with this issue
- Wifi and Bluetooth
- Sound
- Controllers, both attached and detached
  - note, controllers work best in X-input mode. see [official Legion Go Userguide PDF](./legion_go_user_guide_en.pdf) to read more about controller modes
- FPS/Mouse mode
- scroll wheel on controller works fine, scroll wheel press doesn't do anything. However, holding the scroll wheel for 5s will toggle the scroll wheel on/off
- trackpad works, but cannot tap-to-click in game mode. Can tap to click on desktop mode, but must be enabled in the touchpad settings.
  - trackpad cannot currently be used in steam input without a workaround

### What Has Workarounds?

These functions are not working out of the box, but have workarounds

- Steam/QAM Buttons/Rear back buttons^ - all buttons can be used in Steam via Dualsense Edge Virtual/Emulated Controller [Video demo here](https://www.youtube.com/watch?v=uMiXNKES2LM).
- Gyro^ - uses the same fix as buttons fix 
- Trackpad^ - this previously already worked, but was not usable in steam input. With the latest version of rogue-enemy, it is now usable in steam input
- TDP^ - requires using either steam-patch or decky plugins
- Controller RGB^ - requires decky plugin

## What has issues

- Battery indicator - it doesn't consistently work, but has a usable workaround
- Screen Refresh Rate - only refresh rates that work are 60Hz and 144Hz, everything else is not usable/has issues.

## Known Bugs

- Dec 9th 2023 - Nobara desktop mode shortcut is broken after fresh install + update, dev is working on a fix. This doc will be updated once the issue is resolved.
  - Manual fix at the bottom of the page [here](#nobara-desktop-mode-switch-temporary-fix)
- related to v28 bios - STAMP might be bugged on both Windows and Linux - user on discord reported that they were getting hard crashes at 30W TDP on both Windows and Linux
  - crash was replicated on Nobara Linux 30W TDP STAMP
  - different user on Windows replicated at 30W TDP, suspects it's due to faster charging speed in bios
  - bug is still being investigated
  - if you encounter crashing at high TDPs, STT seems to still work fine without issues, so continue to use it for high TDP usage.
    - lower TDPs, below 20-22W, seem stable on STAMP
- Due to an update for the Steam Deck OLED, FPS often gets artificially capped by Steam. Usually it's around 72fps
- FPS slider isn't always accurate
- (Nobara) Fuzzy screen issue - this happens when an invalid refresh rate is used for your game. As a workaround, run the [disable_refresh_rates.sh](./disable_refresh_rates.sh) script to disable problematic refresh rates above 60Hz
- Bug for Pipewire EQ sound improvements - Pipewire EQ sound improvements are an optional sound fix for the LGO
  - the `surround-effect.neutral` option still seems to be working as-expected
  - the `surround-effect.game` option has a bug where volume cannot be controlled
  - This is most likely due to a recent Steam Deck OLED related update.
- power button stops suspending - bug in the software that manages the power button, fixed by updating to the latest version. reinstall the latest version of [steam-powerbuttond](https://github.com/aarron-lee/steam-powerbuttond)

## Resolved bugs on NobaraOS (update OS with the `Update System` app on Desktop):
- Nobara bug where you can't go from Desktop Mode directly to Game Mode directly, you must reboot. Nested Desktop works fine.

## Resources

PS5 Dualsense Edge Emulator - https://github.com/corando98/ROGueENEMY/

RGB Decky Plugin - https://github.com/aarron-lee/LegionGoRemapper/

Simple Decky TDP Plugin - https://github.com/aarron-lee/SimpleDeckyTDP

steam-patch (for TDP control, some steam glyphs, etc) - https://github.com/corando98/steam-patch

powerbutton fix when not using handycon - https://github.com/aarron-lee/steam-powerbuttond

Pipewire sound EQ improvement files - https://github.com/matte-schwartz/device-quirks/tree/legion-go/rog-ally-audio-fixes/usr/share/device-quirks/scripts/lenovo/legion-go

gyro increase sampling rate fix (advanced users only) - https://github.com/antheas/llg_sfh

alternative PS5 Dualsense Edge Emulator (work in progress) - https://github.com/antheas/hhd

reverse engineering docs - https://github.com/antheas/hwinfo/tree/master/devices

### CSS Loader Plugin - Themes

- note, requires `CSS Loader` Decky Plugin
- manually install by placing in `$HOME/homebrew/themes/`

Legion Go Theme - https://github.com/frazse/SBP-Legion-Go-Theme

Theme changing controller glyphs - https://github.com/frazse/PS5-to-Xbox-glyphs
- If you'd like to manually edit mappings, you can find glyphs at `$HOME/.local/share/Steam/controller_base/images/api/dark/`
  - manual mapping can be done by editing the css file with the svg/png paths you want


## Guides + small fixes

### Fix dark colored screen tone shift when moving mouse/trackpad

In Game mode, enable `Developer mode` under the `System` settings.

Then, in the `Developer` settings option that shows up in the Steam settings, make sure to Enable `Steam Color Management`.

Enabling Steam Color management should fix the issue.

NOTE, this is **DIFFERENT** from the other method to disable Steam Color management listed below. It's odd that there's two separate options with similar names, but it is what it is.

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

### Fuzzy screen issue

If you're seeeing a fuzzy screen, it means that the you're somehow using an invalid refresh rate. The only valid refresh rates for a game are 60 and 144Hz.

You can work around this somewhat by disabling the 144hz refresh rate. You can either run the script in this repo, or do the following:

create an `disable-refresh-rate.conf` file in `$HOME/config/environment.d`, and add the following to the file:

```
export STEAM_DISPLAY_REFRESH_LIMITS=""
```

### Nobara desktop mode switch temporary fix

a quick step-by-step for how you fix game mode/desktop switching if you updated `gamescope-session` on Dec 9th 2023, **for KDE/SD Edition only atm** (thanks matt_schwartz on the Nobara Discord):

- open up a terminal console with Ctrl + Alt + F2 (Ctrl + Alt + F3 may also work)
- login with your user name and password
- run the command `sudo mv /etc/sddm.conf /etc/sddm.conf.d/kde_settings.conf` to move the `sddm.conf` file to `kde_settings.conf`
- reboot, then go to Desktop mode
- (to fix Desktop mode => Game Mode switch) go to your `/etc/sddm.conf.d/kde_settings.conf` file and add in `Relogin=true` under `[Autologin]`.
- Save changes, then reboot

### Manual full reinstall of RogueEnemy PS5 Dualsense emulator (nobaraOS)

if you want to try a manual clean install of rogue, you can do the following:

```
sudo systemctl disable --now rogue-enemy.service
sudo rm /usr/bin/rogue-enemy
sudo rm /usr/lib/udev/rules.d/99-rogue.rules
sudo rm /usr/lib/udev/rules.d/99-disable-sonypad.rules
sudo rm /etc/systemd/system/rogue-enemy.service
sudo systemctl enable --now handycon.service
sudo udevadm control --reload-rules
sudo udevadm trigger
```

reboot, then download the latest `install.sh` from the rogue github repo, and run the `install.sh` + reboot again.