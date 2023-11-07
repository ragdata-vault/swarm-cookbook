# ==================================================================
# src/apps/cockpit-identities
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-identities
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# FUNCTIONS
# ==================================================================
#
# HELP FUNCTION
#
cockpit-identities::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-IDENTITIES HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-identities::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-identities::installed() { command -v cockpit-identities > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-identities::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-IDENTITIES"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	wget -O "$XDG_DOWNLOAD_DIR"/cockpit_identities-setup.zsh https://repo.45drives.com/setup

	bash "$XDG_DOWNLOAD_DIR"/cockpit_identities-setup.zsh

	sudo apt update

	sudo apt install -y cockpit-identities

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-identities::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-IDENTITIES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
cockpit-identities::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-IDENTITIES"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove cockpit-identities

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
