#!/bin/bash

# Run with sudo, this only works when using root priveleges.

# Define the path for the Bluetooth management script
SCRIPT_PATH="/usr/local/bin/check_bluetooth.sh"

# Create the directory for the script if it doesn't exist
mkdir -p $(dirname "$SCRIPT_PATH")

# Write the Bluetooth management script
cat <<'EOF' >"$SCRIPT_PATH"
#!/bin/bash

# Check for active Bluetooth connections
if bluetoothctl info | grep -q "Missing device address argument"; then
    echo "No Bluetooth devices connected. Turning Bluetooth off."
    rfkill block bluetooth
else
    echo "Bluetooth device connected."
fi
EOF

# Make the script executable
chmod +x "$SCRIPT_PATH"

# Add the cron job to the root's crontab
echo "* * * * * $SCRIPT_PATH >> /var/log/check_bluetooth.log 2>&1" | crontab -

# Confirmation message
echo "Bluetooth management script installed and cron job added to root's crontab."
