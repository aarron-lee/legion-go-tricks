source: https://universal-blue.discourse.group/docs?topic=129

# Bazzite Dualboot partition guide

**Be careful! Follow this guide at your own discretion because you can break your system attempting any of this! Upstream does not recommend manual partitioning and neither does Universal Blue!**

Dual booting can work through two methods:

1. Installing the other operating system(s) on a separate drive and booting (recommended)
2. Manual partitioning, which is not supported by upstream, on the same drive

# General Guide for the Same Drive

Special thanks to ChaiQi for writing this portion of the guide!

**This is about as much support as you will get for dual booting on the same drive as Bazzite:**

If you do not have multiple drives, then there is an advanced method that requires manual partitioning

## This is unsupported if you run into any issues!

Dual booting Bazzite with Windows on the same drive works better with Windows already installed before Bazzite.

1. Shrink partitions.

2. Write ISO to USB drive.

3. Boot into ISO via BIOS.

4. Use installer - for partitioning select “custom” or “advanced custom” to be absolutely sure.

5. Create partitions and devices

```
    Manual Partitioning Scheme:

    mount point: /boot/efi  
    format:      EFI system partition  (also known as vfat)
    size:        300MB  
    (optional: use existing system efi partition)

    mount point: /boot
    format:      ext4
    size:        1GB

    mount point:
    format: btrfs
    size: [max]

    mount point: /
    format:      btrfs (subvolume)

    mount point: /var
    format:      btrfs (subvolume)

    mount point: /var/home
    format:      btrfs (subvolume)
```

6. Boot into Bazzite and complete the Bazzite Portal.

7. Reboot

8. Should have both OSes on the same drive

Note: Steam Deck, HTPC, and Handheld PC images hide GRUB by default, enter:

```
ujust unhide-grub
```

If you do not see your Windows boot in the GRUB menu, then open a host terminal and enter:

```
ujust regenerate-grub
``````

Also, if you want to dual boot another Fedora OSTree image (like Bluefin) installed alongside Bazzite, then you would have to make an additional EFI partition and switch between them through the BIOS boot menu.