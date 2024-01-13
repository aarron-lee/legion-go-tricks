#!/bin/bash

# Determine the username of the non-root user who invoked sudo, or use the current user if not run with sudo
if [ -n "$SUDO_USER" ]; then
    USERNAME=$SUDO_USER
else
    USERNAME=$(whoami)
fi

# Define user's home directory
USER_HOME=$(getent passwd "$USERNAME" | cut -d: -f6)

# Define the output file
OUTPUT_FILE="$USER_HOME/gathered_info.txt"

# Clear the output file or create it if it doesn't exist
> "$OUTPUT_FILE"

# Gather information from various sources
{
    echo "----- $USER_HOME/.gamescope-cmd.log -----"
    cat "$USER_HOME/.gamescope-cmd.log" 2>/dev/null || echo "File not found: $USER_HOME/.gamescope-cmd.log"

    echo "----- $USER_HOME/.gamescope-stdout.log -----"
    cat "$USER_HOME/.gamescope-stdout.log" 2>/dev/null || echo "File not found: $USER_HOME/.gamescope-stdout.log"

    echo "----- drm_info Output -----"
    drm_info

    echo "----- Device Quirks -----"
    cat /usr/share/gamescope-session-plus/device-quirks 2>/dev/null || echo "File not found: /usr/share/gamescope-session-plus/device-quirks"

    echo "----- ls -al /usr/bin | grep mango -----"
    ls -al /usr/bin | grep mango

    echo "----- Contents of $USER_HOME/.config/environment.d/ -----"
    mkdir -p $USER_HOME/.config/environment.d
    cat "$USER_HOME/.config/environment.d/"* 2>/dev/null || echo "No files found in $USER_HOME/.config/environment.d/"
} >> "$OUTPUT_FILE"

# Display a message
echo "Information gathered in $OUTPUT_FILE"