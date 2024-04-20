#!/bin/bash

# Script to demote the priority of "xfinitywifi"

# Find and demote xfinitywifi by adjusting its autoconnect-priority
# List all connections and search for "xfinitywifi", extracting its UUID
local uuids=$(nmcli -t -f UUID,NAME con show | grep -i 'xfinitywifi' | cut -d: -f1)

if [[ -z "$uuids" ]]; then
	echo "xfinitywifi network not found."
	return 1
fi

# Loop through all found UUIDs and demote their priority
for uuid in $uuids; do
	echo "Demoting xfinitywifi with UUID: $uuid"
	nmcli connection modify "$uuid" connection.autoconnect-priority -999
done

echo "All xfinitywifi networks have been demoted in priority."
