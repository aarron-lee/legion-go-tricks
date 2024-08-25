# Legion Go Tricks

This document serves to provide information, workarounds, and tricks to improving day-to-day use of Linux on the Legion Go.

Note that while a lot of things are working, Linux support for this device is very much a work in progress, developers are working on improving the experience.

- [Current Status of Linux on the LGO](#current-status-of-linux-on-the-lenovo-legion-go)
- [What Works?](#what-works)
- [What has Workarounds?](#what-has-workarounds)
- [What has issues?](#what-has-issues)
- [Known Bugs](#known-bugs)
- [User Reported Bugs (needs verification)](#user-reported-bugs-needs-verification)
- [Which Linux Distro Should I install?](#which-linux-distro-should-i-install)
- [Resources](#resources)
- [CSS Loader Themes](#css-loader-plugin---themes)
- [Tutorial Videos](#tutorial-videos)
- [Guides + Small Fixes](#guides--small-fixes)
  - [Bazzite Deck Edition](#bazzite-deck-edition-guides)
  - [NobaraOS](#nobaraos-guides)
  - [Other Guides](#other-guides)
    - [How to change display scaling on internal display](#how-to-change-display-scaling-on-internal-display)
    - [How do gamescope scaling options work?](#how-to-use-steams-scaling-features-such-as-int-scaling-fsr-etc)
    - [Calibrating gyro and joysticks](#calibrate-gyro-and-joysticks)
    - [Refind bootloader for dual boot](#install-refind-bootloader-for-touchscreen-option-to-switch-between-windows-and-linux)
- [Emulator Info](#emulator-info)
- [TDP Control overview](#tdp-control)
- [Controller Support overview](#controller-support)
- [Quality of Life Fixes overview](#quality-of-life-fixes)
- [Resolved/won't fix bugs](#resolved-or-wont-fix-bugs-changelog-for-documentation-purposes)
- [3D prints](#3d-prints)

# Current Status of Linux on the Lenovo Legion Go

ChimeraOS, Nobara Deck Edition, and Bazzite Deck Edition, all have a bunch of fixes for the LGO. Depending on the distro, Linux is either [feature complete](https://www.gamingonlinux.com/2024/02/bazzite-linux-adds-support-for-the-lenovo-legion-go-handheld/), or mostly working on the Legion Go.

Linux is good enough to be a daily driver on the Legion Go.

- Using a PS5 Dualsense Edge Controller Emulator, you get access to the entire LGO controller (including gyro) via steam input
  - the entire controller works detached too, gyros in the controller are also usable
- TDP control can be done either via Decky Plugin or HHD (handheld daemon)
- RGB control works via Decky Plugin or Steam Input + Dualsense emulation
- suspend-resume works
- all standard hardware (wifi, bluetooth, sound, etc) works
- Fan curves can be managed via hhd-ui or the LegionGoRemapper Decky plugin.
- basically all hardware on the LGO is fully usable

Some of the things you find in this document may be unofficial changes to original software

Read further below for more details

## What Works?

At the moment, the following functions work out of the box

- Screen orientation (fixed in NobaraOS Deck Edition, ChimeraOS 45 stable, Bazzite OS)
- suspend-resume functionality
  - suspend quirk: sound often can be fuzzy on resume, usually clears up after 30 seconds or so.
    - sometimes using the [Pause Games plugin](https://github.com/popsUlfr/SDH-PauseGames) with `Pause on Suspend` enabled can help with this issue
    - other times, temporarily setting a high TDP value after resume could clear up audio issues
- Wifi and Bluetooth works
- Sound works
- Controllers, both attached and detached
  - note, controllers work best in X-input mode. see [official Legion Go Userguide PDF](./legion_go_user_guide_en.pdf) to read more about controller modes
  - ChimeraOS, NobaraOS, BazziteOS all ship OOTB with basic controller support
  - BazziteOS + NobaraOS ships with HHD, which enables full gyro + back button + controller support in steam input
  - misc: some other non-gaming distros don't include the udev rule for the controller, you can manually add it with [this script](./add-lgo-xpad-rule.sh)
- FPS/Mouse mode works
- scroll wheel on controller works fine for scrolling websites, etc
  - scroll wheel press doesn't do anything in game mode, registers as a scroll wheel click in desktop mode
  - holding the scroll wheel for 5s will toggle the scroll wheel on/off, this is built-in lenovo provided functionality
- trackpad works, tap to click can be configured.
  - Can tap to click on desktop mode, but must be enabled in the touchpad settings.
  - Can be used in steam input with hhd
- Battery Indicator in Game Mode - requires bios v29 or newer

## What Has Workarounds?

These functions are not working out of the box, but have workarounds

- Steam/QAM Buttons/Rear back buttons - all buttons can be used in Steam via Dualsense Edge Virtual/Emulated Controller [Video demo here](https://www.youtube.com/watch?v=uMiXNKES2LM).
  - note that Bazzite and Nobara now ship with hhd, which enables all buttons + gyro to work ootb.
- Gyro - uses the same fix as buttons fix
  - Gyro performance is best with hhd Dualsense Edge Emulator
- Trackpad - this hardware previously already worked, but was not usable in steam input.
  - With the latest version of the PS5 Dualsense edge emulators, it is now usable in steam input. [Video Demo here](https://www.youtube.com/watch?v=RuSboPkZob4)
- TDP - requires using either hhd or decky plugins
- Controller RGB Lights - requires decky plugin or HHD (HHD enables steam input RGB support) See [Video Demo here](https://youtu.be/HHubJ8AnkUk?si=oWLVultDKBMVOxlo&t=35)
- GPU Frequency control - via SimpleDeckyTDP plugin or hhd
- Custom Fan Curves - via LegionGoRemapper plugin or HHD (you need to install hhd + hhd-ui)
  - fan curves confirmed to work with bios v29, but bios v29.1 or newer is HIGHLY recommended due to some major bugs on v29
- Games can sometimes default to 800p, you will need to manually change the resolution per game in the `Steam Settings > Properties > Game Resolution` to either `Native` or other higher resolutions.
- v28 bios - STAMP mode is bugged on both Windows and Linux when setting high TDPs with 3rd party tools like ryzenadj and handheld companion
  - users reported that they were getting hard crashes at 30W TDP on both Windows and Linux
  - **Solution**: on STAMP mode, TDP must be set with a custom fan curve that will prevent thermal shutdown.
    - You can set custom fan curves on bios v29.1 with the LegionGoRemapper plugin
    - alternatively, if you don't want to use a custom fan curve, you can enable the `Lenovo Custom TDP` toggle in SimpleDeckyTDP
- Screen Refresh Rate and FPS control - unified refresh rate + FPS slider now works perfectly on latest bazzite stable, fixes should now also be on the latest Nobara Deck Edition too.
  - ChimeraOS might not have the fix yet, should be in v46
- adaptive/auto display brightness doesn't work yet
  - manual brightness slider in steam UI works without issues
  - there's work in progress from devs for to get this fully working

## What has issues

- **v29 bios - IMPORTANT BIOS BUG:** You cannot set custom fan curves and use Lenovo's custom TDP mode for TDP control simultaneously,the LGO bios has a bug
  - this bug is fully resolved on bios v29.1 and newer
- Adaptive Brightness sensor - hardware is detectedby the OS, but not used for auto-brightness yet
  - there's dev work in progress for auto-brightness
    - if you wish to test it out, see [here](https://github.com/corando98/LLG_Dev_scripts?tab=readme-ov-file#ltchipotles-adaptive-brightness-algorithm)
    - the LegionGoRemapper Decky plugin also has experimental autobrightness controls
- microphone does not work

### Known bugs

- (08/2/2024) Bazzite - reports of an odd square-shaped rainbow colored visual artifact on the screen in game mode/gamescope-session
  - visual artifacts disappear after a suspend-resume cycle
  - alternative temporary solution: rollback to 07/22 while devs investigate: `bazzite-rollback-helper rebase 40-stable-20240722`
    - Note, after the bug is fixed, you'll want to resume stable updates via running `bazzite-rollback-helper rebase stable`
- focus issue after resume from suspend, where the controller seems to be stuck in Steam UI and not getting picked up by the game
  - solution: disable custom wake movies, see github issues [here](https://github.com/ublue-os/bazzite/issues/1474) and [here](https://github.com/ValveSoftware/SteamOS/issues/1424) for more details
- If using Decky loader, shutdown can take an unusually long time
  - this is because Decky sets an unusually long timeout time (45s)
  - workaround: shorten the timeout time:

```
sudo sed -i 's~TimeoutStopSec=.*$~TimeoutStopSec=2~g' /etc/systemd/system/plugin_loader.service
sudo systemctl daemon-reload
```

- Occasionally steam game mode will flash white
  - seems to be related to autoVRAM, recommend disabling autoVRAM and set 6GB or 8GB VRAM in the bios
- suspend-resume quirk: sound often is fuzzy on resume, usually clears up after 30 seconds or so, but not all the time.
  - sometimes using the [Pause Games plugin](https://github.com/popsUlfr/SDH-PauseGames) with `Pause on Suspend` enabled can help with this issue
  - sometimes temporarily increase TDP to a high value fixes the sound problem
- occasionally, steam will register the attached controller as player 2 even when no other controller is attached
  - reorder the controller from player 2 to player 1 in the QAM.
- user reports say wifi has lower download speeds on Linux vs Windows
- alternative resolutions while in desktop mode are buggy/broken
  - instead of changing resolution, change scaling for to enlarge/shrink UI elements

### Bazzite bugs

- Bazzite 3.5 bug - after upgrading to bazzite 3.5, some LGO users have reported booting into a black screen
  - potential workarounds:
    - first, open a tty + login via pressing `Ctrl + alt + f2` on a physical keyboard
    - then, delete old/stale env variables from `$HOME/.config/environment.d`
      - command for removing all env variables: `rm $HOME/.config/environment.d/*`
    - also, run `sudo systemctl daemon-reload`
    - reboot
  - if potential workarounds don't work, you'll probably need to consider a bazzite rollback to an older version
- bugs related to new gamescope changes, usually related to refresh rate and fps limiters - if you encounter problems, recommendation is to rollback to 04/27
  - 04/27 also is the last image available for swipe gestures while in game mode
  - experimental rollback option: antheas has made an experimental 04/27 bazzite image available, which can be used via the following command: `rpm-ostree rebase ostree-unverified-registry:ghcr.io/hhd-dev/bazzite-dc:40-20240427`
- autoVRAM can be buggy, disabling it in the bios is recommended
  - fix is being investigated

### User-reported bugs (needs verification)

- certain Decky plugins require `deck` as your username
  - deck username fixes animation changer plugin and mangopeel plugins

# Which Linux Distro should I Install?

If you want a SteamOS-like experience, there are 3 distros I would recommend

1. BazziteOS Deck Edition
2. Nobara Deck Edition
3. ChimeraOS

As for which one you should install, here's a breakdown of the benefits and drawbacks of each.

## BazziteOS Deck Edition

**Pros**

- Highly recommended for more casual users who don't want to tinker much
- Has the best out-of-box experience on the Legion Go
  - Tools such as Decky, Emudeck, HHD (for Controller Emulation), etc, are either pre-installed, or have an easy install process
  - Excellent support from the Bazzite Devs and community
    - Bazzite Discord is the place to go to for support and discussion, see [here](https://discord.bazzite.gg)
  - Quick to provide OS updates
    - also extremely easy to rollback to previous OS versions, so if an OS update breaks something, you can easily rollback to the prior OS version with a single command
- Read-only root filesystem helps with providing better security, more stability, and overall a very good stable console-like experience
  - also has SE Linux configured out of the box
- Can configure Secure Boot, which allows for disk encryption and other security benefits
  - Secure boot requires some additional configuration steps
- Has both a Gnome and KDE Desktop mode option
- supports distrobox for more flexibility in software install options

**Cons**

- Due to it's read-only root OS, it's harder to do more comprehensive tinkering
  - e.g. running a custom Linux kernel, etc
- slow OS install + OS updates, they take a long time

## Nobara Deck Edition

**Pros**

- Recommended for those more familiar with Linux, and don't mind troubleshooting a lot or tinkering
- Nobara is the most similar to a standard Linux distro, and does not have a read-only root filesystem
- This provides the most flexibility for running custom kernels, modifying system files, etc
- Can setup most workarounds and tools for a great experience on the Legion Go
- now ships with HHD and gamescope patches by default, so it should be a fairly bug-free experience now
  - requires latest NobaraOS updates

**Cons**

- Nobara tends to run cutting edge kernels, and makes other frequent changes to the OS
  - This often leads to updates introducing bugs or breaking features on the Legion Go
  - while rollbacks after a borked update are possible, it's not easy for non-technical users
- Due to no read-only root FS, easier to accidentally mess up your device and put it into a borked state
- Nobara is basically run by one dev, GloriousEggroll (same guy behind GE-Proton), along with a few helpers
  - While GloriousEggroll does excellent work, Nobara is understaffed and it will sometimes be difficult to get help or support if you run into problems
- Only Desktop is KDE, so if you prefer Gnome, you'll have to look elsewhere or manually install + manage it.

## ChimeraOS

**Pros**

- Aims to be a very streamlined console-like experience, doesn't include lots of extra software, etc
  - very minimalist, very stable
- Very easy to pin your device to a stable OS version
  - so once you get a good working setup, you can lock your OS version and then opt to manually update whenever you want
  - great if you want a console like experience where you can "set-it-up-and-forget-it"
- Has a read-only root filesystem, but can also be fully unlocked if necessary
  - note: filesystem unlock does not survive OS updates because it re-locks after an OS update.
- Excellent support for a variety of handhelds besides the Legion Go
- Good Dev and community support on their Discord
- Has it's own implementation of Emulator support, etc
- supports distrobox for more flexibility in software install options

**Cons**

- Installing some recommended tools, such as acpi_call for custom fan curves, requires unlocking the root filesystem
  - ChimeraOS 45-1 now includes `acpi_call`, which is currently required for custom fan curves and Lenovo Custom TDP control
- hhd needs to be manually installed
  - handycon will also need to be manually disabled after every major OS update
- ChimeraOS's emulation implementation interferes with Emudeck, you'll need to manually disable the ChimeraOS implementation
- Only desktop option is Gnome, so anyone that prefers KDE will have to look elsewhere
- ChimeraOS has a slower release cycle, a new version is released every 1-3 months.
  - this means it takes longer to get OS improvements, driver updates, bug fixes, etc

# Resources

HHD - PS5 Dualsense Edge Emulator - https://github.com/hhd-dev/hhd

- has a Decky plugin available for changing hhd settings: https://github.com/hhd-dev/hhd-decky
- also has a desktop app https://github.com/hhd-dev/hhd-ui
- hhd also supports overlay mode in Steam Game mode, and offers a solution for TDP and fan curve control

RGB Decky Plugin - https://github.com/aarron-lee/LegionGoRemapper/

Simple Decky TDP Plugin - https://github.com/aarron-lee/SimpleDeckyTDP

Controller-friendly Youtube app (with steam input community profile) - https://github.com/Haroon01/youtube-tv-client

Controller-friendly Crunchyroll app (with steam input community profile) - https://github.com/aarron-lee/crunchyroll-linux

<!-- Refind GUI - tool for setting up selection screen for dual-booted devices: https://github.com/jlobue10/rEFInd_GUI -->

(nobaraOS) Script that monitors CPU temps and blasts fans when temps are too high - see guide [here](#setup-monitor-script-that-blasts-fans-when-cpu-temps-climb-too-high-tested-on-nobaraos-only)

reverse engineering docs - https://github.com/antheas/hwinfo/tree/master/devices

powerbutton fix when using rogue-enemy - https://github.com/aarron-lee/steam-powerbuttond

Pipewire sound EQ improvement files (not maintained) - https://github.com/matte-schwartz/device-quirks/tree/legion-go/rog-ally-audio-fixes/usr/share/device-quirks/scripts/lenovo/legion-go

- updated version of sound improvements [here](./experimental_sound_fix/README.md)

Bios archive - https://github.com/aarron-lee/legion-go-bios

gyro increase sampling rate fix (advanced users only, not maintained) - https://github.com/antheas/llg_sfh

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

# Tutorial Videos

Dual Boot Tutorial Video (Bazzite + Windows) : https://www.youtube.com/watch?v=3jFnkcVBI_A

- Partition guide for Dual boot with Bazzite: [see here](/bazzite-dualboot-partition-guide.md)

Bazzite Rollback tutorial video: https://www.youtube.com/watch?v=XvljabnzgVo

Dual Boot Tutorial Video (Nobara + Windows): https://www.youtube.com/watch?v=anc7hyPU6Lk

# Guides + small fixes

### Update Bios

Source: https://github.com/ChimeraOS/chimeraos/wiki/Community-Guides#lenovo-legion-go

The Lenovo Legion Go is compatible with the fwupd tool. To use it follow the following steps:

    Note: Ensure your device is plugged into AC power before beginning.

1.) Download the latest BIOS exe from https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/legion-series/legion-go-8apu1/downloads/driver-list

2.) Extract the `isflash.bin` from the exe archive using file roller or some other archive tool.

3.) Go to the folder where the `isflash.bin` file is located. Right click, and select `open terminal here`. Then run `sudo fwupdtool install-blob isflash.bin`

4.) Select System Firmware from the options menu.

5.) It will ask you to reboot, Select `y`. The system will reboot multiple times. Leave the AC plugged in and wait for it to return to the OS.

## Bazzite Deck Edition Guides

### FAQ on bazzite site for rollback, pinning OS version, etc

See official site at: https://universal-blue.discourse.group/docs?topic=36

### Enable Konsole application

search for `Konsole` in your application search, you should see a `run Konsole` option.

Click the `run Konsole`, and in the new terminal window execute `ujust restore-original-terminal` for Konsole to become searchable as an app.

### eGPU setup (AMD eGPU only)

If you notice eGPU not running at full pcie speeds, you might need an additional kernel arg before it works at full speed.

1. Open up your terminal (Ptyxis), run the following command

```
rpm-ostree kargs --append=amdgpu.pcie_gen_cap=0x40000
```

2. reboot

You can also see the conf file [here](./resources/egpu-pcie3speed.conf) for more details, thanks @Ariobeth on Discord!

### Buggy Sleep with an eGPU

thanks @Ariobeth on Discord

Here is a quick fix for the default bazzite sleep/suspend under a egpu condition connected to external monitor.

Run this in terminal:

`xdg-open /etc/systemd/sleep.conf`

edit the file, remove the hash (`#`) so that the end result looks like this:

```
[Sleep]
AllowSuspend=yes
AllowHibernation=no
AllowSuspendThenHibernate=no
AllowHybridSleep=yes
SuspendMode=suspend
SuspendState=standby freeze mem disk
#HibernateMode=platform shutdown
#HibernateState=disk
#HybridSleepMode=suspend platform shutdown
#HybridSleepState=disk
#HibernateDelaySec=
#SuspendEstimationSec=60min
```

save changes, reboot.

now when pc sleeps or when you press the power button of the legion go = sleep. at least it will not have a blank screen and cannot wake up. it is still energy saving though.

### Blank Screen on First Reboot

If you see a frozen or blank screen on first reboot after a fresh installation of Bazzite, you can permanently fix the issue via the following:

1. press `Ctrl + Alt + F2` to open a terminal
2. login via your username and password
3. once logged in, type `steamos-session-select plasma`

- if you are on deck-gnome, try swapping `plasma` with `gnome` if it doesn't work

4. the terminal command should switch you to desktop mode
5. from desktop mode, just press the `Return to Game Mode` shortcut on the Desktop

- for deck-gnome, the `return to game mode` shortcut will be in the menu that you see after you click the top-left corner of the screen

### Nested Desktop Screen is rotated incorrectly

Open terminal in Nested Desktop (NOT Desktop mode), and run the following:

```bash
kscreen-doctor output.1.rotation.normal
```

then restart nested desktop

### Nested Desktop fails to start, or freezes very frequently

User reported issue where Nested Desktop frequently fails. As a fix, set a `per game profile` for Nested Desktop with 60hz as the screen resolution.

If you still run into frequent freezes, please report the bug on the Bazzite Discord.

### Change Nested Desktop Resolution

run the [bazzite-nested-desktop-resolution.sh](./bazzite-nested-desktop-resolution.sh) script.

You can edit the script with your preferred nested desktop resolution before running it.

After running the script, restart Game mode. Then change steam's resolution to match the resolution you set.

### Experimental Sound fix

see install instructions [here](./experimental_sound_fix/README.md)

Note that it should also work for NobaraOS, but will require a reboot

### Install experimental Bazzite rollback helper

**NOTE: THE ROLLBACK HELPER IS NOW INCLUDED IN BAZZITE OS AS OF RELEASE 3.0 (2024-04-24)**

If you are on an older version of bazzite, run the following to install the helper:

```bash
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/bazzite-install-rollback-helper.sh | sh
```

afterwards, run `bazzite-rollback-helper --help` in terminal for usage instructions

If you want to uninstall the helper, delete the `bazzite-rollback-helper` file in `$HOME/.local/bin`

See video for bazzite-rollback-helper usage demo: https://www.youtube.com/watch?v=XvljabnzgVo

### Roll back to Bazzite image with specific Linux Kernel

let's say you want to revert Bazzite to an image with kernel 6.6

First, you can find the list of bazzite-deck images here: https://github.com/ublue-os/bazzite/pkgs/container/bazzite-deck/versions?filters%5Bversion_type%5D=tagged

Look for the version for specific dates, it'll look like `39-YYYYMMDD`

e.g. `39-20240205`

This will let you find the kernel version on that given image

`skopeo inspect docker://ghcr.io/ublue-os/bazzite:39-20240205 | grep ostree.linux`

if the number matches with the kernel version that you want to deploy, you can then deploy the image:

```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck:39-20240205
```

### How to figure out your current Bazzite Image

run `rpm-ostree status` in terminal, you'll see info on your current image.

### Change Desktop Steam UI scaling

First, try changing the following (original tip found [here](https://www.reddit.com/r/LegionGo/comments/1as75lf/comment/kqpau3c/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)):

`System Settings > Display and Monitor > Display Configuration > Legacy Applications: Scaled by the system`

If this doesn't work, then proceed to the next steps.

This is for Bazzite-Deck, not Bazzite-Deck-Gnome

thanks @noobeta on discord for this tip!

For technical users:

run `sudoedit /etc/environment`, and add `STEAM_FORCE_DESKTOPUI_SCALING=2` to the end of the file. save changes, and reboot afterwards.

for non-technical users:

run `xdg-open /etc/environment` in terminal, it will open up the file in a text editor. Add `STEAM_FORCE_DESKTOPUI_SCALING=2` to the end of the file, and save. You will be prompted for your password, save and then reboot.

Note that if you edit the `/etc/environment` file, it will change the scaling of the on screen keyboard in desktop mode.

### "failed to download gpg key" bug when trying to rebase

try running the following, then rebase again:

```
# note, changing the "nonfree" to free in this command might also fix the rebase.
cd /etc/pki/rpm-gpg
sudo ln -s RPM-GPG-KEY-rpmfusion-nonfree-fedora-2020 RPM-GPG-KEY-rpmfusion-nonfree-fedora-39
```

<!--
secure boot tpm unlock - `systemd-cryptenroll` -->

---

## NobaraOS Guides

### Fix 60Hz and 144Hz

should now be fixed with the latest NobaraOS updates.

### Setup lock screen for desktop mode only (KDE only)

Currently, Desktop mode does not have a lock screen during suspend-resume cycles on NobaraOS.

To fix this, go into Desktop mode, then configure `Screen Locking` in KDE desktop settings. You can optionally configure it for `after waking from sleep`.

This should show a login screen for suspend/resume in desktop mode only. In game mode, you should still get the expected regular behavior.

### Setup Monitor script that blasts fans when CPU temps climb too high (tested on NobaraOS only)

The Legion Go bios currently has behavior where if temps get too high, it manually forces TDP values to lower values until temps cool off

To mitgate this issue, you can setup a monitoring script that will blast the fans at full speed whenever it sees temps that are too high.

Install Instructions:

1. run `sudo modprobe acpi_call`, and see if this command errors out for you; if it does display an error, you need to install `acpi_call` on your linux distro

If it did not error out for you, we need to enable acpi_call by default so that you don't need to manually run `sudo modprobe acpi_call` on every boot.

You can do so via running the following script: [enable-acpi-call.sh](./enable-acpi-call.sh)

2. Download the files required

```
cd $HOME && git clone https://github.com/corando98/LLG_Dev_scripts.git
```

3. before installing, you can edit the `$HOME/LLG_Dev_scripts/fan-helper_install.sh` script if you'd like to change what temperature will trigger the fan

- in the file, you can replace the `85` in the line with `--temp_high 85 --temp_low 80`

4. run the install script, it will ask for your sudo password

```
cd $HOME/LLG_Dev_scripts && chmod +x ./fan-helper_install.sh && sudo ./fan-helper_install.sh
```

5. To verify that it's working, you can type in the following: `sudo systemctl status legion_fan_helper.service`

The result should look something like this:

```
Jan 03 21:03:19 nobaraLGO systemd[1]: Started legion_fan_helper.service - Legion Go Fan helper method.
Jan 03 21:03:19 nobaraLGO python3[10905]: 2024-01-03 21:03:19,473 - INFO - CPU Temperature: 46°C
Jan 03 21:03:19 nobaraLGO python3[10905]: 2024-01-03 21:03:19,473 - INFO - AC Status: Plugged In
```

6. You can now quit/close the terminal, and reboot

7. If you ever want to uninstall this temperature monitoring script, run the following one line at a time:

```
sudo systemctl disable --now legion_fan_helper.service
sudo rm /etc/systemd/system/legion_fan_helper.service
sudo rm -rf $HOME/LLG_Dev_scripts
```

### Install kernel on Nobara (untested)

These instructions are untested, but should work

```bash
sudo dnf copr enable sentry/kernel-fsync
sudo dnf update --refresh
# sudo dnf install kernel_goes_here
# e.g.
sudo dnf install kernel-6.6.14-202.fsync.fc39
```

### Change default boot kernel on Nobara v39

This will let you change your default kernel.

using this command to figure out the kernels you have installed:

```bash
sudo grubby --info=ALL | grep kernel
```

Look for the version number you want to make the default, it should be a number, something like `6.7.0-204`

Then run the following

```bash
sudo grubby --info=ALL | grep -i REPLACE_THIS_WITH_KERNEL_VERSION_NUMBER -B 1 | grep index

# example: if you're looking for 6.6.9-203
sudo grubby --info=ALL | grep -i 6.6.9-203 -B 1 | grep index
```

You should get an index number that shows up after running the command.

After having index number of the kernel you want as the default, run:

```bash
sudo grubby --set-default THIS_INDEX_NUMBER

# example: if the number is 3
sudo grubby --set-default 3
```

Then reboot, and verify it's working:

```bash
# reboot, this should print out your kernel version
uname -r
```

Thanks @cox on discord for the info, and @megabadd for recommending some improvements to the instructions

### Fix display-out not working for a display/monitor that previously worked

`~/.config/gamescope/modes.cfg` contains resolutions for monitors that have been configured.

Sometimes monitor settings in the file are set to erroneous values that the display could not handle.

To fix this, removing the display from the file allows it to be reconfigured. thanks @braymur on discord

### NobaraOS Desktop Mode - automatically set desktop resolution scale

1. Save [this script](./desktopmode-autoscale.sh) somewhere and mark it as executable

- `chmod +x ./desktopmode-autoscale.sh`

2. (optional) edit script's `SCALE=1.5` value to whatever scale you want

3. Add it to your KDE Autostart config (Menu > search for Autostart > Add)

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

Update: There's a refresh rate permanent fix available on BazziteOS, the fix should also be on the latest NobaraOS

### Disable nobaraOS grub boot menu during boot

[Source](https://www.reddit.com/r/linux4noobs/comments/wzoiu4/comment/im5cfx7/?context=3)

Note, you should never change the content of `/boot/grub/grub.cfg`

What you probably want to do is to hide grub’s boot menu, you can do it two ways:

- By hiding the boot menu
  - for non-technical users:
    - go to your `/etc/default` folder, then open the `grub` file with kate.
    - Edit the file and add `GRUB_TIMEOUT_STYLE=hidden`, then save. It'll prompt for your password.
    - Afterwards, in terminal run `sudo update-grub`
  - for technical users: `sudo vim /etc/default/grub` and set `GRUB_TIMEOUT_STYLE=hidden`. save changes, then run `sudo update-grub`
- Or by making the boot menu timeout 0, to do that:
  - for non-technical users:
    - go to your `/etc/default` folder, then open the `grub` file with kate.
    - Edit the file and set `GRUB_TIMEOUT=0`, then save. It'll prompt for your password.
    - Afterwards, in terminal run `sudo grub-mkconfig`
  - for technical users:`sudo vim /etc/default/grub` and set `GRUB_TIMEOUT=0`. save changes, then run `sudo grub-mkconfig` to generate `/boot/grub/grub.cfg`

Tip: even if your boot menu is hidden, you can access it when your pc is starting:

If you have BIOS: press and hold SHIFT key right after you see you Motherboard/PC splash screen

If you have UEFI: start pressing ESC the moment you see your motherboard/pc splash screen.

### Updated Nested Desktop with Nobara 39 (thanks matt_schwartz for the update):

`sudo dnf install plasma-lookandfeel-nobara-steamdeck-additions`

includes:

- should support Legion Go at native resolution
  - It should work for both Steam Deck and ROG Ally.
  - Make sure to set the game entry to “Native” in the Steam game settings menu first.
- you’ll have to set scaling once in the KDE settings when the nested desktop session loads for the first time but it should save it for future nested desktop sessions
  or else the screen will be for ants at 1600p
- also adds back the right-click “add to steam” shortcut you get with the steamdeck-KDE-presets package (which conflicts with the new theming)

---

## Other guides

### How to change display scaling on internal display

source: https://www.reddit.com/r/SteamDeck/comments/17qhmpg/comment/k8dgjnq/

Follow the below steps to enable UI scaling for the internal display:

1. Install Decky loader if you haven't already.
2. Go into Decky settings and under General enable "Developer mode".
3. A new section appears on the left hand side named "Developer", go in there and enable "Enable Valve Internal".
4. Go into Steam settings and under System enable "Enable Developer Mode".
5. Scroll all the way down in the left hand list and a new section named "Valve Internal" have appeared, go in there. **BE CAREFUL HERE, THESE SETTINGS ARE POTENTIALLY DANGEROUS!**
6. Scroll down a bit until you see "Show display scaling settings for Internal Display" and enable it. **MAKE SURE TO NOT TOUCH ANYTHING ELSE UNLESS YOU KNOW WHAT YOU'RE DOING.**
7. The new display scaling options will now be available under Display.
8. Disable developer mode under Steam's System settings.
9. In Decky Loader's settings, disable "Enable Valve Internal" in the Developer section.
10. Still in Decky Loader, disable developer mode under General.

The display scaling options will still be available in the display settings after disabling developer mode. Enjoy!

### How to use steam's scaling features, such as int scaling, FSR, etc

![steam resolutions guide](./steam-resolutions-overview.png)

Full guide here: https://medium.com/@mohammedwasib/a-guide-to-a-good-docked-gaming-experience-on-the-steam-deck-346e393b657a

Reddit discussion [here](https://www.reddit.com/r/SteamDeck/comments/z90ca0/a_guide_to_a_good_docked_gaming_experience_on_the/)

PDF Mirror of guide [here](./steam-resolutions-guide.pdf)

### Calibrate Gyro and Joysticks

Requires updated controller firmware

1. hold LT+LS and RT+RS
2. once the rgb swirls blue, rotate the sticks fully deflected (calibrates sticks)
3. place the LGO on the floor and press LT and RT twice to signal you're done
4. the gyro will then begin calibration. once it stops blinking green and red and goes back to your normal rgb setting it will be done

### Install Refind bootloader for touchscreen option to switch between Windows and Linux

source: [reddit post](https://www.reddit.com/r/LegionGo/comments/1atag1z/comment/kqw3y05/?utm_source=share&utm_medium=web2x&context=3)

Resources:

https://sourceforge.net/projects/refind/

http://www.rodsbooks.com/refind/

Instructions:

1. Enter on Bazzite Desktop mode
2. Download the RPM on SourceForge (**file that ends with a** `x86_64.rpm`) and open a terminal (ex : Console on Bazzite). Note that you should **NOT** download the file that ends with`src.rpm`
3. cd into your Download directory (ex : `cd ~/Downloads/`)
4. Run `sudo rpm-ostree install refind-*.rpm` (This will install the rEFInd RPM using rpm-ostree). After installing the rpm successfully, reboot the device.
5. After reboot, run `sudo refind-install` (Read further into the resources if you want to enable Secure Boot)
6. OPTIONAL : Download [custom rEFInd theme](https://drive.google.com/drive/folders/1QJBljL_8QPeaMhQ0-qXAc9U8f3AcgNBs?usp=sharing) (credits goes to Yannis Vierkötter and his rEFInd-Minimalist for the original theme) (download mirror link [here](./resources/rEFInd-Minimalist-LGO_Bazzite.zip))
7. OPTIONAL : Unzip then run `sudo sh -c 'mkdir /boot/efi/EFI/refind/themes/ ; set -euo pipefail cp -r rEFInd-Minimalist-LGO_Bazzite/ /boot/efi/EFI/refind/themes/ && grep -qFx "include themes/rEFInd-Minimalist-LGO_Bazzite/theme.conf" "/boot/efi/EFI/refind/refind.conf" || echo "include themes/rEFInd-Minimalist-LGO_Bazzite/theme.conf" >> /boot/efi/EFI/refind/refind.conf ' ` (make sure rEFInd-Minimalist-LGO_Bazzite/ is present in the directory you are currently in, type in the command `ls` to see all available files)
8. Reboot into BIOS and set rEFInd as the first option in the boot order
9. Bonus step for Legion Go only: Set the Bazzite bootsplash in portrait mode, Run `sudo rpm-ostree kargs --append-if-missing=video=eDP-1:panel_orientation=left_side_up`

### Trick to rotate Legion Go screen for REFIND

Thanks @ariobeth on discord for this guide

not offical instructions, but seems to work fine

setup refind in linux, then run the following via Terminal:

- sudo nano /boot/efi/EFI/refind/refind.conf (requires root to edit. else, sudo -i first to enter root, then issue the sudo nano)
- scroll down and find the "#resolution 1024 768" section.
- add "resolution 2560 1600". (notice it is 2560 wide and 1600 height, it is not 1600 wide and 2560 height. This simple trick rotate the refind boot menu screen correctly on the legion go.)
- also "enable_touch" and "enable_mouse" for Touchscreen and mouse to work.
- you might also want to increase the icon size. "big_icon_size 256" (your preference)
- No idea how to increase font size. (you might need to change the theme for refind)

# Emulator Info

Emulator related documentation, including recommended settings, etc.

## Gyro configuration in CEMU

Configure gyro according to [this guide](https://emudeck.github.io/emulators/steamos/cemu/cemu-native/#how-to-configure-gyro-with-external-controllers) on the emudeck documentation, and use dualsense edge as your controller emulator

- note that this requires disabling steam input for the emulator

Thanks to @Paper on Discord for this tip

## HHD (Dualsense Controller emulation)

Game emulators sometimes don't recognize the emulated dualsense controller via HHD.

This is usually because the emulator may have temporarily latched onto the original xbox controller instead of the emulated dualsense

- you can usually resolve this by flipping the fps-mode switch on and off.
- if you still have a controller issue afterwards, reorder the controller from player 2 to player 1 in the QAM.
  - sometimes steam registers the emulated controller as player 2 even when no other controller is attached

## Emudeck

On Bazzite, install via the ujust script in terminal.

For to install on ChimeraOS or NobaraOS, go to https://www.emudeck.com, and scroll down to the section that shows installer options.

If the `Linux` install option doesn't work for you, the `ChimeraOS` install instructions should also work fine on other Linux distros.

## Dolphin (Gamecube)

For to improve stability, you can disable V-sync in the Dolphin settings

- open Dolphin on desktop mode
- select `Graphics`
- disable V-sync, save changes

# TDP Control:

Note that the Legion Go (LGO) has an issue in STT mode (vs STAMP mode in the bios), where custom TDP values will eventually get changed by the bios while in STT mode. STAMP mode fixes this, but there are users reporting crashing while in STAMP mode. STT does not have this stability issue.

If you use the SimpleDeckyTDP plugin with the [LGO custom TDP method](https://github.com/aarron-lee/SimpleDeckyTDP/blob/main/py_modules/devices/README.md#experimental-custom-tdp-method-for-the-legion-go), fixes stability issues on STAMP. Note that this requires bios v28 or newer

Alternatively, you can set a custom fan curve, which should also help fix the issue.

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

### HHD

hhd now ships with an overlay that has TDP control support. Requires acpi_call installed on your Linux distro.

### SimpleDeckyTDP

Decky Plugin that provides TDP and GPU controls. Also has an option to fix Steam's TDP + GPU Sliders. Note that there's a risk that Decky Plugins can stop working from any Steam updates from Valve

https://github.com/aarron-lee/SimpleDeckyTDP

### Simple Ryzen TDP

Basic Desktop app for TDP control, but can also be added to game mode as a backup option

https://github.com/aarron-lee/simple-ryzen-tdp/

### Steam Patch (deprecated, no longer maintained)

Steam Patch enables Steam's TDP slider + GPU sliders to work. Note that this works by patching the Steam client, which means that any Steam updates from Valve can potentially break this fix.

https://github.com/corando98/steam-patch

# Controller support

### hhd

Link: https://github.com/antheas/hhd

PS5 Dualsense Edge controller emulator, currently supports all buttons on the LGO controller except the back scrollwheel (scrollwheel already worked previously). Has improvements vs rogue, such as more consistently working rumble, config file for configuring different options, RGB LED control via steam input, etc. It also supports managing the power button, so no extra program is necessary.

It is preinstalled on Bazzite for the Legion Go, ROG Ally, abd several other PC handheld devices.

Install instructions are available on the github.

### HandyGCCS (aka handycon)

Default installed OOTB on ChimeraOS, Nobara Deck Edition. It supports all the standard Xbox controls, `Legion_L + X` for Steam/Home, `Legion_L + A` for QAM. Back buttons are not supported.

Note that you can get back buttons to work with the LegionGoRemapper plugin, but it has the same limitations as the LegionSpace app on Windows; you can only remap back buttons to other controller buttons, and they cannot be managed individually in Steam Input.

### rogue-enemy (deprecated/no longer maintained)

Link: https://github.com/corando98/ROGueENEMY

PS5 Dualsense Edge controller emulator, currently manages all hardware buttons except the back scrollwheel (scrollwheel already works). Back buttons are usable in Steam Input, same for the trackpad.

Note that rogue-enemy has conflicts with handygccs, so it must be disabled. Also, since handygccs handles for the power button, you'll need a separate solution for power button suspend. You can use this, which was extracted from handygccs: https://github.com/aarron-lee/steam-powerbuttond

# Quality Of Life Fixes

### CSS Loader Plugin - Themes

- note, requires `CSS Loader` Decky Plugin
- manually install by downloading the theme + placing in `$HOME/homebrew/themes/` folder
- sometimes themes require a reboot before they start working.
- the themes are intended to work with hhd's dualsense edge controller emulator

Legion Go Theme - https://github.com/frazse/SBP-Legion-Go-Theme

PS5 to Xbox Controller Glyph Theme - https://github.com/frazse/PS5-to-Xbox-glyphs

- If you'd like to manually edit mappings, you can find glyphs at `$HOME/.local/share/Steam/controller_base/images/api/dark/`
  - manual mapping can be done by editing the css file with the svg/png paths you want

#### Bazzite theme Install instructions

```bash
# if you didn't install decky, install it first
ujust setup-decky
# legion go theme install
ujust install-legion-go-theme
# ps5 to xbox glyph theme
ujust install-hhd-xbox-glyph-theme
# afterwards, install CSS loader from the Decky Store, and enable the legion go or hhd themes in CSS loader + reboot
```

### Other Linux Distro theme install instructions

```
# quick install, CSS Loader Decky Plugin must already be installed and enabled

# Legion Go Theme Install
cd $HOME/homebrew/themes && git clone https://github.com/frazse/SBP-Legion-Go-Theme.git

# PS5 to Xbox Controller Glyph Theme
cd $HOME/homebrew/themes && git clone https://github.com/frazse/PS5-to-Xbox-glyphs
```

### LegionGoRemapper Decky Plugin - Fan Control + RGB control + backbutton remapping

Link: https://github.com/aarron-lee/LegionGoRemapper/

Allows for managing back button remaps, controller RGB lights, toggle touchpad on/off, etc

You can also enable custom fan curves, confirmed functional on bios v29

- note that this uses the exact same functionality as LegionSpace on Windows, so it has the same limitations
- back button remapping should not be used w/ PS5 controller emulation

Note, HHD is also now an alternative for fan control on the Legion Go

# 3D prints

https://makerworld.com/en/models/88724#profileId-94984

https://www.thingiverse.com/thing:6364915/files

https://makerworld.com/en/models/57312#profileId-94578

https://www.thingiverse.com/thing:4675734

https://www.reddit.com/r/LegionGo/comments/17s8rv8/3d_printed_steamclip_kickstand_released/

https://www.thingiverse.com/thing:6311208/

https://www.thingiverse.com/thing:6444531

https://makerworld.com/en/models/157429#profileId-172767

controller adapter - https://www.printables.com/model/645576-legion-go-controller-adapter-remix

controller caryy case - https://www.thingiverse.com/thing:6499314

travel cover
https://cults3d.com/en/3d-model/gadget/legion-go-front-cover

# Misc

install AppImage manager

```
flatpak install flathub it.mijorus.gearlever -y --user
```

<!--
https://steamcommunity.com/groups/SteamClientBeta/discussions/3/3775742015037677494/

misc:
change between s2idle and s3, if s3 is available

to change it temporarily, run:

echo s2idle | sudo tee /sys/power/mem_sleep

but it'll reset on reboot
so you'll probably need a startup systemd service to enable it on boot

add a kernel arg

rpm-ostree kargs --append=mem_sleep_default=s2idle

misc thing to investigate:

# mkdir -p ~/.config/wireplumber/bluetooth.lua.d/
# cat ~/.config/wireplumber/bluetooth.lua.d/61-bluez-monitor.lua
bluez_monitor.properties = {
  ["bluez5.enable-sbc-xq"] = true,
  ["bluez5.enable-msbc"] = true,
  ["bluez5.codecs"] = "[sbc sbc_xq aac ldac aptx aptx_hd aptx_ll aptx_ll_duplex faststream faststream_duplex]",
}

https://web.archive.org/web/20230710001521/https://steamdecki.org/Steam_Deck/Wireless/Bluetooth
 -->

<!--
distrobox dev env vscode setup
https://github.com/89luca89/distrobox/blob/main/docs/posts/integrate_vscode_distrobox.md#from-flatpak -->
