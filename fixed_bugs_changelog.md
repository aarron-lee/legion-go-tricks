# Bugs changelog

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
