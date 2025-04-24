# enable maliit kb script on bazzite
# After install, make sure you enable the Maliit keyboard in your Keyboard > Virtual Keyboard Settings

echo "enabling + fixing Maliit virtual keyboard in bazzite desktop mode"

mkdir -p $HOME/.local/share/applications

# desktop entry source: https://github.com/maliit/keyboard/blob/master/com.github.maliit.keyboard.desktop
cat <<EOF > "$HOME/.local/share/applications/com.github.maliit.keyboard.desktop"
[Desktop Entry]
Name=Maliit
Exec=maliit-keyboard
Type=Application
X-KDE-Wayland-VirtualKeyboard=true
Icon=input-keyboard-virtual
NoDisplay=true
EOF

# bugfix kb source: https://www.youtube.com/watch?v=Dp0QhmtIP6k

# mkdir -p ~/.config/plasma-workspace/env/

# cat << EOF > "$HOME/.config/plasma-workspace/env/immodule_temp_fix.sh"
# #!/bin/bash
# unset GTK_IM_MODULE
# unset QT_IM_MODULE
# EOF

# sudo chcon -u system_u -r object_r --type=bin_t "$HOME/.config/plasma-workspace/env/immodule_temp_fix.sh"

echo "Install complete!"
echo "READ THIS!!!"
echo "Make sure you enable the Maliit keyboard in your Keyboard > Virtual Keyboard Settings, then reboot"
