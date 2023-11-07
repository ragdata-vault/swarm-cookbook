# ==================================================================
# src/apps/cockpit
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit
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
cockpit::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit::installed() { command -v cockpit > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT"
	echo "===================================================================="
	echo

	sudo apt install -y cockpit

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT"
	echo "===================================================================="
	echo

	systemctl enable --now cockpit.socket
	systemctl start cockpit.socket

	echo
	echo "Interface @ http://localhost:9090"

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
cockpit::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove cockpit

	echo
	echo "DONE!"
	echo
}
