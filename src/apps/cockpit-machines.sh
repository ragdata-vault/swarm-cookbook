# ==================================================================
# src/apps/cockpit-machines
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-machines
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
cockpit-machines::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-MACHINES HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-machines::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-machines::installed() { command -v cockpit-machines > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-machines::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-MACHINES"
	echo "===================================================================="
	echo

	sudo apt install -y gettext nodejs make

	sudo apt install -y cockpit-machines libvirt-dbus

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-machines::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-MACHINES"
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
cockpit-machines::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-MACHINES"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove cockpit-machines libvirt-dbus

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
