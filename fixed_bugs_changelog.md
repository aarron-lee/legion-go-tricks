# Bugs changelog

<!-- - (06/30/24) Bazzite 3.5 bug - user reports of booting into a black screen.
  - temporary workaround for now is to rollback to an older image.
  - instructions:
    - try booting unti you see a blank screen. then press `ctrl + alt + f2` for to get a terminal. login + run `steamos-session-select plasma`
      which should log you into desktop mode
    - then in terminal there, run `bazzite-rollback-helper list` to see available bazzite versions, then run `bazzite-rollback-helper rebase replace-this-with-older-bazzite-version`
      - e.g. `bazzite-rollback-helper rebase 40-stable-20240627`
    - once the bug is fixed, run `bazzite-rollback-helper rebase stable` to go back to regular updates
- (2024/5/12) Bazzite - some users are reporting issues where they boot into a black screen

  - cause is currently unknown and being investigated, most likely related to new gamescope
  - if you encounter problems, recommendation is to rollback to a stable image with old gamescope such as 04/27, 04/06, 03/15. see tutorial video https://www.youtube.com/watch?v=gE1ff72g2Gk
    - rollback instructions: press esc during boot to get the grub menu, and boot your prior bazziteOS version
    - once booted into the previous version, rebase to an older bazzite
      - e.g. run `bazzite-rollback-helper rebase 40-20240427` to rebase to Bazzite with old gamescope
    - if you want to return to regular updates later, run `bazzite-rollback-helper rebase stable` -->

- (2024/5/12) Bazzite - some users are reporting issues where they boot into a black screen
  - cause is currently unknown and being investigated, most likely related to new gamescope
  - if you encounter problems, recommendation is to rollback to a stable image with old gamescope such as 04/27, 04/06, 03/15. see tutorial video https://www.youtube.com/watch?v=gE1ff72g2Gk
    - rollback instructions: press esc during boot to get the grub menu, and boot your prior bazziteOS version
    - once booted into the previous version, rebase to an older bazzite
      - e.g. run `bazzite-rollback-helper rebase 40-20240427` to rebase to Bazzite with old gamescope
    - if you want to return to regular updates later, run `bazzite-rollback-helper rebase stable`
- (2024/5/5) Bazzite - some users are reporting bugs related to recent new gamescope changes, usually related to refresh rate and fps caps
  - try enabling developer mode, then enable Force Compositing in the Developer options
  - if force compositing doesn't work, then the recommendation is to rollback to a stable image with old gamescope such as 04/27, 04/06, 03/15.
  - if you encounter a failed gpg key error during rebase, please try [this](#failed-to-download-gpg-key-bug-when-trying-to-rebase)
- (2024/04/03) - Steam Client update now causing a bug where after resume, the active game isn't focused properly

  - controller after resume will instead interact with SteamUI
  - temporary workarounds:
    - tap the screen to bring the game back into focus
    - press `Steam` or `B/Circle` button a few times to return focus back to the game
    - set a Security Pin on Resume. After inputting your pin, it should bring focus back to the game properly.
    - disable wake movie in customization settings, see here for github issue: https://github.com/ValveSoftware/SteamOS/issues/1222
      - according to github bug report, this issue only happens when "Startup Steam Deck Default" is selected AND "Use as Wake Movie" is enabled, even when there are more custom videos downloaded.
      - It does not happen when custom video from Points Shop is selected.

- (2024/03/28) BazziteOS - Ptyxis terminal app might be crashing
  - if crashing, switch to the Konsole terminal until the bug gets fixed.
    - instructions can be found [here](#enable-konsole-application)

Bazzite - hhd 2.0 bug - game controller stops working when detached/reattached.

- fixed, update to the latest bazzite

(2024-03-13) bazzite suspend bug is fixed, you can go back to regular updates by going back to `stable` via running the following in terminal:

- `rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck:stable`

- (resolved 2/28/2024) Decky Loader has some bugs that are causing issues with menus like the power button menu, exiting games, etc. [bug report](https://github.com/SteamDeckHomebrew/decky-loader/issues/586)

  - bugs are being investigated by the Decky devs
  - temporary workaround: rollback to Decky v2.10.14
    - install script for v2.10.14 [here](./decky_v2_10_14_install.sh)

- nobara now ships unified framelimiter fix + 60fps 30hz bugfix

- SimpleDeckyTDP Plugin - bug where GPU slider is broken, and breaks setting TDP.
  - temporary workaround: delete the `$HOME/homebrew/settings/SimpleDeckyTDP/settings.json` file, and then update to the latest SimpleDeckyTDP plugin
    - this bug is being actively investigated
- Nobara 39 - bug where controller doesn't work after a clean install or upgrade from Nobara 38.
  - fix:
    - run this script on Desktop mode
      - `curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/add-lgo-xpad-rule.sh | sudo sh`
    - if planning on running a dualsense emulator (hhd or rogue), disable handycon too.
      - `sudo systemctl disable --now handycon.service`
    - then reboot
- Bazzite

  - Nested Desktop orientation might be wonky

- Dec 9th 2023 - Nobara desktop mode shortcut might break for users that update their Nobara installation. This should not apply to brand new, clean installations.
  - this issue has been fixed on NobaraOS 39
  - recent installations by users indicate that this bug has been resolved on Nobara 38
  - Manual fix at the bottom of the page [here](#nobara-desktop-mode-switch-temporary-fix)
- (won't fix) Bugs for Pipewire EQ sound improvements - Pipewire EQ sound improvements are an optional sound fix for the LGO, currently is buggy and not recommended
  - This is most likely due to a Steam Deck OLED related update.

# outdated guides

### Nobara desktop mode switch temporary fix

- Note, should be fixed now

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

- if it doesn't look correct, edit the file so that it looks correct
  - you'll probably need to delete some `#` characters, as well as maybe change `Session` to `gamescope-session`
  - save changes
- reboot, and see if the issue is fixed.

If the issue is not fixed, then try the following.

- run the command `sudo mv /etc/sddm.conf /etc/sddm.conf.d/kde_settings.conf` to move the `sddm.conf` file to `kde_settings.conf`
- reboot

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

### Pipewire EQ sound options

Link: https://github.com/matte-schwartz/device-quirks/tree/legion-go/rog-ally-audio-fixes/usr/share/device-quirks/scripts/lenovo/legion-go

Quote from reddit:

> This applies a surround sound convolver profile, similar to Dolby Atmos for Built-In Speakers

> The built-in speakers with a volume slider that acts as master gain, and then the virtual sink sliders that apply surround sound profiles on top of the master gain sink. Basically, this lets you adjust the overall gain separate from the sinks themselves to give a wider level of control. It’s not the most seamless solution but it seems to do the job.

### fix 60hz 144hz nobara

Massive thanks to all the devs who helped diagnose, troubleshoot, and and investigate this issue.

Install Instructions:

1. update NobaraOS from the desktop mode via the `update system` app. then, after rebooting, run the [enable_60_144hz.sh script](./enable_60_144hz.sh) in terminal.

- This script will cleanup old files and setup some extra environment variables you need to enable 144hz

2. Go back to game mode, and in `Display` settings, and turn off `Unified Frame Limit Management`, also make sure you enable/turn on `Use Native Color Temperature` as well.

3. If this fixes your 144Hz, you can stop here

- you should see no artificial 72fps cap in games, and fps limiter should work
- swapping to 60hz should work, and fps limiter should similarly work here
  - note that steamUI forces 144hz, you won't see 60hz in steam UI
- WARNING FOR THE REFRESH SLIDER: any values other than 60hz and 144hz is dangerous, make sure to be careful when changing the screen refresh rate
  - Update: there's now a fix for the refresh rate slider in BazziteOS, the fixes should eventually be available on NobaraOS and ChimeraOS

4. If steps 1-3 didn't fix your 144hz, continue on to the following:

Download Valve's Neptune Kernel with acpi_call precompiled (thanks [@corando98](https://github.com/corando98/) for compiling the rpm!) [download link, should be the 1.51GB file](https://drive.filen.io/f/9271e6eb-95e7-4deb-bc80-a90a620ebf53#175zrewF3URWgsnNfQMzETlJA4Auy5xo)

```
# (optional) for those that want to verify the file integrity of the download, here's the md5sum
$ md5sum kernel-6.1.52_valve14_1_neptune_acpi_call.x86_64.rpm
bd51cbb23972171026b6219b705f2127  kernel-6.1.52_valve14_1_neptune_acpi_call.x86_64.rpm
```

5. Open the folder where your download is in terminal, and run:

```
sudo dnf install kernel-6.1.52_valve14_1_neptune_acpi_call.x86_64.rpm
```

After install is complete, reboot and go back to desktop mode

6. Run `uname -r` in terminal, and verify that you are running the valve kernel. You should see:

```
6.1.52-valve14-1-neptune-61
```

Also run `sudo modprobe acpi_call` in terminal, you should see no errors

7. Retest and see if you're seeing any issues on 144Hz

# Deprecated Resources

steam-patch (for TDP control, some steam glyphs, etc) - https://github.com/corando98/steam-patch

rogue-enemy (deprecated, no longer maintained) - PS5 Dualsense Edge Emulator - https://github.com/corando98/ROGueENEMY/

LegionGoRefreshRates Decky Plugin - experimental plugin for changing default screen resolution in game mode. https://github.com/aarron-lee/LegionGoRefreshRate
