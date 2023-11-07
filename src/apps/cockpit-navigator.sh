# ==================================================================
# src/apps/cockpit-navigator
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-navigator
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
cockpit-navigator::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-NAVIGATOR HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-navigator::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-navigator::installed() { command -v cockpit-navigator > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-navigator::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-NAVIGATOR"
	echo "===================================================================="
	echo

	sudo apt install -y cockpit-navigator

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-navigator::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-NAVIGATOR"
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
cockpit-navigator::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-NAVIGATOR"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove cockpit-navigator

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
