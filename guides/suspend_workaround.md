## Legion Go immediately waking up from suspend

Some users are reporting that suspend/resume is not working.

The Legion Go controllers are waking up the device.

For to workaround this issue, create a udev rule that blocks the controllers from waking the device.

You can install the fix by running the following in terminal, then reboot:

```
echo 'ACTION=="add", SUBSYSTEM=="pci", DEVPATH=="*/0000:00:08.1/*c2:00.3", ATTR{power/wakeup}="disabled"' | sudo tee /etc/udev/rules.d/99-suspend-fix.rules
```

If you wish to remove this fix later on, simply delete the udev rule file.

```
sudo rm /etc/udev/rules.d/99-suspend-fix.rules
```
