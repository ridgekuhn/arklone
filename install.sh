#!/bin/bash
# arklone installation script
# by ridgek
########
# CONFIG
########
source "/opt/arklone/config.sh"

##############
# DEPENDENCIES
##############
# Install rclone
if ! rclone --version &> /dev/null; then
	sudo apt update && sudo apt install rclone -y || (echo "Could not install required dependencies" && exit 1)
fi

# Create rclone user config dir
if [ ! -d "${USER_CONFIG_DIR}/rclone" ]; then
	sudo mkdir "${USER_CONFIG_DIR}/rclone"
fi
sudo chown -R pi:pi "${USER_CONFIG_DIR}/rclone"
sudo chmod -R 777 "${USER_CONFIG_DIR}/rclone"

# Create rclone.conf
if [ ! -f "${USER_CONFIG_DIR}/rclone/rclone.conf" ]; then
	sudo touch "${USER_CONFIG_DIR}/rclone/rclone.conf"
fi

#########
# arklone
#########
# Grant permissions to scripts
sudo chmod -v a+r+x "${ARKLONE_DIR}/uninstall.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/dialogs/settings.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/rclone/scripts/arklone-saves.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/rclone/scripts/arklone-arkos.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/systemd/scripts/generate-retroarch-units.sh"

# Generate retroarch path units
"${ARKLONE_DIR}/systemd/scripts/generate-retroarch-units.sh"

# Create arklone user config dir
if [ ! -d "${USER_CONFIG_DIR}/arklone" ]; then
	sudo mkdir "${USER_CONFIG_DIR}/arklone"
fi
sudo chown -R ark:ark "${USER_CONFIG_DIR}/arklone"
sudo chmod -R a+r+w "${USER_CONFIG_DIR}/arklone"
