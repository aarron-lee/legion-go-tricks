## ChimeraOS Legion Go Tricks

### Introduction
This guide serves to provide workarounds and tricks to improving day-to-day use of ChimeraOS on the Legion Go. The good news is, most things work out-of-the-box on this device. There are a few other things that require some workarounds but then are functional, and there are a few things that are currently broken and being worked on.

Some of the things you find in this guide may be unofficial changes to original software, THESE PROJECTS ARE NOT SUPPORTED BY THE DEVELOPERS OF THOSE ORIGINAL PROJECTS.

### What Works?
At the moment, the following functions work just fine

-Screen orientation (fixed in latest ChimeraOS unstable branch)

-Wifi and Bluetooth

-Sound

-FPS/Mouse mode

### What Doesn't Work
These functions are not working at all out of the box (items marked with '^' have workarounds)

-Steam/QAM Buttons^

-Rear extra buttons (any assignments you make in windows will persist to ChimeraOS, they just cannot be changed without re-entering Windows)

-Gyro (gyro is recognized out-of-the-box but drivers still need to be made for ChimeraOS which interpret those gyro movements into controls)

-TDP (This is currently being worked on)

### How do I install ChimeraOS?
The process is pretty simple as most of the workarounds required to actually use the device, like screen orientation, were added to the ChimeraOS Unstable branch shortly after the device became available to the public.

-Burn ChimeraOS to a flash drive using Etcher

-Plug USB into Legion Go and enter BIOS

-Disable SecureBoot

-Boot into install USB and proceed with its instructions, ***just be sure to check the box to install the 'unstable' branch***

-Apply workarounds/improvements as you wish

### Disclaimer: 
If for whatever reason you accidentally install ChimeraOS without selecting the unstable branch, fear not. You can simply enter desktop mode, open a console, and type in the following...

```sudo frzr-deploy chimeraos/chimeraos:unstable```

followed by

```sudo systemctl reboot```

### Guides

### [Where to find ChimeraOS for your Legion Go](https://chimeraos.org/download/)
Please see the installation section of the ChimeraOS website, just remember to install the unstable branch as mentioned earlier in this guide.

### [Device immediately waking up from suspend](guides/suspend_workaround.md)

Some users are reporting that suspend/resume is not working, try the workaround [here](guides/suspend_workaround.md)

### [How to install Handycon - Controller Workaround w/ Steam/QAM (OLD)](https://github.com/bactaholic/chimeraos-legion-go-tricks/blob/main/guides/controller_workaround_handycon.md)
THIS SHOULD ALREADY COME PREINSTALLED WITH CHIMERAOS IF YOU INSTALLED THE UNSTABLE BRANCH. Handycon has been updated to support the Legion Go and brings controller functionality in addition to Steam/QAM menus using the Legion Buttons and how to change combos.

### [How to remap Steam/QAM Buttons to Scrollwheel (OLD)](https://github.com/bactaholic/chimeraos-legion-go-tricks/blob/main/guides/controller_workaround_input_mapper.md)
If for whatever reason other guides to guide the Steam/QAM Buttons working don't work for you, you can use this workaround. Please note, this is not a permanent solution, as the guide explains.


### [Using EasyEffects to Improve Speaker Audio Quality](https://github.com/bactaholic/chimeraos-legion-go-tricks/tree/main)
WIP!! AWAITING GUIDE
