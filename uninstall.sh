#!/bin/bash
# arklone uninstallation script
# by ridgek
########
# CONFIG
########
source "/opt/arklone/config.sh"

###########
# PREFLIGHT
###########
UNITS=($(systemctl list-unit-files | awk '/arkloned/ {print $1}'))

#########
# arklone
#########
# Remove units from systemd
if [ ! -z $UNITS ]; then
	for unit in ${UNITS[@]}; do
		sudo systemctl disable "${unit}"
	done
fi

# Remove arklone user config dir
sudo rm -r "${USER_CONFIG_DIR}/arklone"

# Print confirmation
echo "======================================================================"
echo "arklone has been uninstalled, but some files must be deleted manually:"
echo "\"Cloud Settings.sh\" system in /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml"
echo "/opt/arklone/"
echo "${USER_CONFIG_DIR}/rclone/"
echo "rclone apt package"
