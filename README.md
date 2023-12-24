# Legion Go Tricks

This document serves to provide information, workarounds, and tricks to improving day-to-day use of Linux on the Legion Go.

Note that while a lot of things are working, Linux support for this device is very much a work in progress, developers are working on improving the experience.

- [Current Status of Linux on the LGO](#current-status-of-linux-on-the-lenovo-legion-go)
- [What Works?](#what-works)
- [What has Workarounds?](#what-has-workarounds)
- [What has issues?](#what-has-issues)
- [Known Bugs](#known-bugs)
- [Resources](#resources)
- [CSS Loader Themes](#css-loader-plugin---themes)
- [Videos](#videos)
- [Guides + Small Fixes](#guides--small-fixes)
- [TDP Control overview](#tdp-control)
- [Controller Support overview](#controller-support)
- [Quality of Life Fixes overview](#quality-of-life-fixes)
- [3D prints](#3d-prints)

# Current Status of Linux on the Lenovo Legion Go

ChimeraOS unstable, Nobara Deck Edition, and Bazzite Deck Edition, all have a bunch of fixes for the LGO. It's mostly working, but still has bugs that need to be addressed.

However, that being said, Linux is good enough to be a daily driver on the Legion Go.

- Using a PS5 Dualsense Edge Controller Emulator, you get access to the entire LGO controller (including gyro) via steam input
  - controller works detached too
- TDP control can be done either via Decky Plugin or steam-patch
- RGB control works via Decky Plugin or Steam Input + Dualsense emulation
- suspend-resume works
- all standard hardware (wifi, bluetooth, sound, etc) works

Some of the things you find in this document may be unofficial changes to original software

Read further below for more details

## What Works?

At the moment, the following functions work out of the box

- Screen orientation (fixed in NobaraOS Deck Edition, ChimeraOS 45 unstable, Bazzite OS)
- suspend-resume functionality
  - suspend quirk: sound often is fuzzy on resume, usually clears up after 30 seconds or so.
    - use [Pause Games plugin](https://github.com/popsUlfr/SDH-PauseGames) with `Pause on Suspend` enabled to help with this issue
- Wifi and Bluetooth
- Sound
- Controllers, both attached and detached
  - note, controllers work best in X-input mode. see [official Legion Go Userguide PDF](./legion_go_user_guide_en.pdf) to read more about controller modes
- FPS/Mouse mode
- scroll wheel on controller works fine, scroll wheel press doesn't do anything. However, holding the scroll wheel for 5s will toggle the scroll wheel on/off
- trackpad works, but cannot tap-to-click in game mode. Can tap to click on desktop mode, but must be enabled in the touchpad settings. Can be used in steam input with a workaround.

## What Has Workarounds?

These functions are not working out of the box, but have workarounds

- Steam/QAM Buttons/Rear back buttons - all buttons can be used in Steam via Dualsense Edge Virtual/Emulated Controller [Video demo here](https://www.youtube.com/watch?v=uMiXNKES2LM).
- Gyro - uses the same fix as buttons fix
  - Gyro performance is best with hhd
- Trackpad - this previously already worked, but was not usable in steam input. With the latest version of the PS5 Dualsense edge emulators, it is now usable in steam input. [Video Demo here](https://www.youtube.com/watch?v=RuSboPkZob4)
- TDP - requires using either steam-patch or decky plugins
- Controller RGB - requires decky plugin or HHD (HHD enables steam input RGB support)
- GPU Frequency control - via SimpleDeckyTDP plugin
- Games often default to 800p, you will need to manually change the resolution per game in the `Steam Settings > Properties > Game Resolution` to either `Native` or other higher resolutions.
- v28 bios - STAMP mode is bugged on both Windows and Linux when setting high TDPs with 3rd party tools like ryzenadj and handheld companion
  - users reported that they were getting hard crashes at 30W TDP on both Windows and Linux
  - **Solution**: on STAMP mode, TDP must be set with a fan curve that will prevent thermal shutdown.
    - The best way to do so, currently, is via SimpleDeckyTDP with the [custom LGO TDP enabled](https://github.com/aarron-lee/SimpleDeckyTDP/tree/main/py_modules/devices#experimental-custom-tdp-method-for-the-legion-go).
    - Setting TDP this way will also set fan curves appropriately.
- HHD PS5 Controller Emulator bug
  - If you hold an LGO joystick input while booting or resuming from suspend, the input may get stuck in whatever direction you were pointing
  - workaround: don't press anything for a few seconds, let the device register itself
  - dev is investigating, this will probably be fixed in a later update to HHD
- Due to a bug in gamescope, FPS often gets artificially capped by Steam. Usually it's 72fps
  - workaround: [run script to set 60Hz or 144Hz](#fix-72fps-artificial-fps-cap-issue)

## What has issues

- Battery indicator - it doesn't consistently work, but has a usable workaround
- Screen Refresh Rate - only refresh rates that work are 60Hz and 144Hz, everything else is not usable/has issues.
  - you can manually set 60Hz or 144Hz, see [here](#fix-72fps-artificial-fps-cap-issue)

## Known Bugs

- Dec 9th 2023 - Nobara desktop mode shortcut might break for users that update their Nobara installation. This should not apply to brand new, clean installations. This doc will be updated once the issue is fully resolved.
  - recent installations by users indicate that this bug has been resolved on Nobara 38
  - Manual fix at the bottom of the page [here](#nobara-desktop-mode-switch-temporary-fix)
  - this issue has been fixed on NobaraOS 39, but version 39 hasn't been released yet
- (Nobara) Fuzzy screen issue - this happens when an invalid refresh rate is used for your game.
   - You can workaround this issue via setting 60Hz or 144Hz, instructions [here](#fix-72fps-artificial-fps-cap-issue)
- Bug for Pipewire EQ sound improvements - Pipewire EQ sound improvements are an optional sound fix for the LGO
  - the `surround-effect.neutral` option still seems to be working as-expected
  - the `surround-effect.game` option has a bug where volume cannot be controlled
  - This is most likely due to a recent Steam Deck OLED related update.
- power button stops suspending - bug in the software that manages the power button, fixed by updating to the latest version. reinstall the latest version of [steam-powerbuttond](https://github.com/aarron-lee/steam-powerbuttond)
  - note, this **does not apply to hhd**, only applies to rogue-enemy + steam-powerbuttond
- retroarch does not support the PS5 Dualsense Edge yet
  - for now, better to use emudeck + standalone emulators for all your emulation

# Resources

PS5 Dualsense Edge Emulator - https://github.com/antheas/hhd

PS5 Dualsense Edge Emulator - https://github.com/corando98/ROGueENEMY/

RGB Decky Plugin - https://github.com/aarron-lee/LegionGoRemapper/

Simple Decky TDP Plugin - https://github.com/aarron-lee/SimpleDeckyTDP

steam-patch (for TDP control, some steam glyphs, etc) - https://github.com/corando98/steam-patch

powerbutton fix when using rogue-enemy - https://github.com/aarron-lee/steam-powerbuttond

Pipewire sound EQ improvement files - https://github.com/matte-schwartz/device-quirks/tree/legion-go/rog-ally-audio-fixes/usr/share/device-quirks/scripts/lenovo/legion-go

(ChimeraOS only) Legion Go installer tool - https://github.com/linuxgamingcentral/legion-go-tools-for-linux

reverse engineering docs - https://github.com/antheas/hwinfo/tree/master/devices

gyro increase sampling rate fix (advanced users only) - https://github.com/antheas/llg_sfh

## CSS Loader Plugin - Themes

- note, requires `CSS Loader` Decky Plugin
- manually install by downloading the theme + placing in `$HOME/homebrew/themes/` folder
- these themes may require a reboot for them to work

Legion Go Theme - https://github.com/frazse/SBP-Legion-Go-Theme

PS5 to Xbox Controller Glyph Theme - https://github.com/frazse/PS5-to-Xbox-glyphs

- If you'd like to manually edit mappings, you can find glyphs at `$HOME/.local/share/Steam/controller_base/images/api/dark/`
  - manual mapping can be done by editing the css file with the svg/png paths you want

```
# quick install, CSS Loader Decky Plugin must already be installed and enabled

# Legion Go Theme Install
cd $HOME/homebrew/themes && git clone https://github.com/frazse/SBP-Legion-Go-Theme.git

# PS5 to Xbox Controller Glyph Theme
cd $HOME/homebrew/themes && git clone https://github.com/frazse/PS5-to-Xbox-glyphs
```

# Videos

Dual Boot Tutorial Video (Nobara + Windows): https://www.youtube.com/watch?v=aODkGjjiD6U&

# Guides + small fixes

### Fix 72fps artificial fps cap issue

Due to a bug in gamescope, FPS often gets artificially capped by Steam at 72fps.

This fix was tested on NobaraOS 38 with the latest updates, untested on ChimeraOS and Bazzite

- to force 144Hz with proper working fps limiter
  - in game mode settings, go to Display, and turn off `Unified Frame Limit Management`, option should be near the very bottom
  - then run the [enable_144hz.sh script](./enable_144hz.sh)
- to force 60Hz with proper working fps limiter
  - in game mode settings, go to Display, and turn off `Unified Frame Limit Management`, option should be near the very bottom
  - then run the [enable_60hz.sh script](./enable_60hz.sh)

### Setup lock screen for desktop mode only (NobaraOS)

Currently, Desktop mode does not have a lock screen during suspend-resume cycles on NobaraOS.

To fix this, go into Desktop mode, then configure `Screen Locking` in KDE desktop settings. You can optionally configure it for `after waking from sleep`.

This should show a login screen for suspend/resume in desktop mode only. In game mode, you should still get the expected regular behavior.

### Fix dark colored screen tone shift when moving mouse/trackpad

Before trying the following fix, first try enabling the `Use Native Color Temperature` toggle in the `Display` settings in game mode.

In Game mode, enable `Developer mode` under the `System` settings.

Then, in the `Developer` settings option that shows up in the Steam settings, make sure to Enable `Steam Color Management`.

Enabling Steam Color management should fix the issue.

NOTE, this is **DIFFERENT** from the other method to disable Steam Color management listed below. It's odd that there's two separate options with similar names, but it is what it is.

### Fix orange colored hue to game mode UI

Before trying the following fix, first try enabling the `Use Native Color Temperature` toggle in the `Display` settings in game mode.

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

You can work around this by force enabling 144Hz or 60Hz, see [fps fix](#fix-72fps-artificial-fps-cap-issue)

### Nobara desktop mode switch temporary fix

a quick step-by-step for how you fix game mode/desktop switching if you updated `gamescope-session` after Dec 9th 2023, **for KDE/SD Edition only atm** (thanks matt_schwartz on the Nobara Discord):

- open up a terminal console with Ctrl + Alt + F2 (Ctrl + Alt + F3 may also work)
- login with your user name and password
- type in `startplasma-wayland` to start desktop mode
- once in desktop mode, type in `cat /etc/sddm.conf` and confirm whether it looks like the following:
```
[Autologin]
Relogin=true
User=deck(or whatever your username is)
Session=gamescope-session
```
- if it doesn't look like the following, edit the file so that it looks correct
  - you'll probably need to delete some `#` characters, as well as maybe change `Session` to `gamescope-session`
  - save changes
- reboot, and see if the issue is fixed.

If the issue is not fixed, then try the following.

- run the command `sudo mv /etc/sddm.conf /etc/sddm.conf.d/kde_settings.conf` to move the `sddm.conf` file to `kde_settings.conf`
- reboot

### Uninstall Rogue + Install HHD (NobaraOS)

for those that have rogue already installed on NobaraOS and want to try hhd, do the following:

- download + run the uninstall script for rogue: https://github.com/corando98/ROGueENEMY/blob/main/uninstall.sh
- disable handycon: `sudo systemctl disable --now handycon.service`
- disable steam-powerbutton: `sudo systemctl disable --now steam-powerbuttond.service`
- follow the pypi install instructions to install hhd: https://github.com/antheas/hhd#pypi-based-installation-nobararead-only-fs

note that hhd defaults to Steam/QAM on the Legion buttons. If you want to swap them with start/select, similar to rogue, then you will need to edit the config file and set `swap_legion` to `True`

if you want to disable steam input LED, you can similarly disable it by setting it to `False`. yaml config file is in the `$HOME/.config/hhd/plugins` folder

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

<!--
### Updated Nested Desktop with Nobara 39 (thanks matt_schwartz for the update):

`sudo dnf install plasma-lookandfeel-nobara-steamdeck-additions`

includes:

- should support Legion Go at native resolution
  - It works for both Steam Deck and ROG Ally.
  - Make sure to set the game entry to “Native” in the Steam game settings menu first.
- you’ll have to set scaling once in the KDE settings when the nested desktop session loads for the first time but it should save it for future nested desktop sessions
or else the screen will be for ants at 1600p
- also adds back the right-click “add to steam” shortcut you get with the steamdeck-KDE-presets package (which conflicts with the new theming)

-->

# TDP Control:

Note that the Legion Go (LGO) has an issue in STT mode (vs STAMP mode in the bios), where custom TDP values will eventually get changed by the bios while in STT mode. STAMP mode fixes this, but there are users reporting crashing while in STAMP mode. STT does not have this stability issue.

There's a few options for TDP Control on the Legion Go.

### `Legion_L + Y` combo

source: https://linuxgamingcentral.com/posts/chimeraos-on-legion-go/

> You can switch colors (of the power LED) by holding Legion L + Y. Each time you press this combination, you change the performance mode:

- quiet: blue LED; uses about 8 W
- balanced: white LED; uses about 15 W
- performance: red LED; uses about 20 W
- custom: purple LED; uses anywhere from 5-30 W; although at default it seems to be around 20 W

For `custom` on the new bios (bios v28) Custom by default is 30W TDP with everything maxed out
And it resets every time you switch modes

### Steam Patch

Steam Patch enables Steam's TDP slider + GPU sliders to work. Note that this works by patching the Steam client, which means that any Steam updates from Valve can potentially break this fix.

https://github.com/corando98/steam-patch

### SimpleDeckyTDP

Decky Plugin that provides a very simple TDP bar. Note that there's similarly a risk that Decky Plugins can stop working from any Steam updates from Valve

https://github.com/aarron-lee/SimpleDeckyTDP

### Simple Ryzen TDP

Basic Desktop app for TDP control, but can also be added to game mode as a backup option

https://github.com/aarron-lee/simple-ryzen-tdp/

# Controller support

### HandyGCCS (aka handycon)

Default installed OOTB on ChimeraOS, Nobara Deck Edition, and Bazzite. It supports all the standard Xbox controls, `Legion_L + X` for Steam/Home, `Legion_L + A` for QAM. Back buttons are not supported.

Note that you can get back buttons to work with the LegionGoRemapper plugin, but it has the same limitations as the LegionSpace app on Windows; you can only remap back buttons to other controller buttons, and they cannot be managed individually in Steam Input.

### hhd

Link: https://github.com/antheas/hhd

PS5 Dualsense Edge controller emulator, currently supports all buttons on the LGO controller except the back scrollwheel (scrollwheel already worked previously). Has improvements vs rogue, such as more consistently working rumble, config file for configuring different options, RGB LED control via steam input, etc. It also supports managing the power button, so no extra program is necessary.

Install instructions are available on the github.

### rogue-enemy

Link: https://github.com/corando98/ROGueENEMY

PS5 Dualsense Edge controller emulator, currently manages all hardware buttons except the back scrollwheel (scrollwheel already works). Back buttons are usable in Steam Input, same for the trackpad.

Note that rogue-enemy has conflicts with handygccs, so it must be disabled. Also, since handygccs handles for the power button, you'll need a separate solution for power button suspend. You can use this, which was extracted from handygccs: https://github.com/aarron-lee/steam-powerbuttond

# Quality Of Life Fixes

### LegionGORemapper Decky Plugin - RGB control + backbutton remapping

Link: https://github.com/aarron-lee/LegionGoRemapper/

Allows for managing back button remaps, controller RGB lights, toggle touchpad on/off, etc

- note that this uses the exact same functionality as LegionSpace on Windows, so it has the same limitations
- back button remapping should not be used w/ PS5 controller emulation

### CSS Loader Plugin - Themes

- note, requires `CSS Loader` Decky Plugin
- manually install by downloading the theme + placing in `$HOME/homebrew/themes/` folder

Legion Go Theme - https://github.com/frazse/SBP-Legion-Go-Theme

PS5 to Xbox Controller Glyph Theme - https://github.com/frazse/PS5-to-Xbox-glyphs

- If you'd like to manually edit mappings, you can find glyphs at `$HOME/.local/share/Steam/controller_base/images/api/dark/`
  - manual mapping can be done by editing the css file with the svg/png paths you want

```
# quick install, CSS Loader Decky Plugin must already be installed and enabled

# Legion Go Theme Install
cd $HOME/homebrew/themes && git clone https://github.com/frazse/SBP-Legion-Go-Theme.git

# PS5 to Xbox Controller Glyph Theme
cd $HOME/homebrew/themes && git clone https://github.com/frazse/PS5-to-Xbox-glyphs
```

### Pipewire EQ sound options

Link: https://github.com/matte-schwartz/device-quirks/tree/legion-go/rog-ally-audio-fixes/usr/share/device-quirks/scripts/lenovo/legion-go

Quote from reddit:

> This applies a surround sound convolver profile, similar to Dolby Atmos for Built-In Speakers

> The built-in speakers with a volume slider that acts as master gain, and then the virtual sink sliders that apply surround sound profiles on top of the master gain sink. Basically, this lets you adjust the overall gain separate from the sinks themselves to give a wider level of control. It’s not the most seamless solution but it seems to do the job.

# 3D prints

https://makerworld.com/en/models/88724#profileId-94984

https://www.thingiverse.com/thing:6364915/files

https://makerworld.com/en/models/57312#profileId-94578

https://www.thingiverse.com/thing:4675734
