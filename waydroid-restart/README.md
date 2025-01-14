This will add a `Force Waydroid Restart` app shortcut to your applications menu

This should work regardless of distro or device, assuming you have waydroid already installed.

# Install

run the following in terminal, it will prompt you for your sudo password:

```bash
curl -L https://raw.githubusercontent.com/aarron-lee/legion-go-tricks/main/waydroid-restart/install.sh | sudo sh
```

# Uninstall

For to uninstall, delete the following files:

```
sudo rm /usr/local/bin/waydroid-force-restart
sudo rm $HOME/.local/share/applications/waydroid-force-restart.desktop
sudo rm /etc/sudoers.d/waydroid-force-restart
```
