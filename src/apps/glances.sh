# ==================================================================
# src/apps/glances
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/glances
# Author:       Ragdata
# Date:         25/09/2023
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
glances::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}GLANCES HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
glances::requires() { echo; }
#
# INSTALLED FUNCTION
#
glances::installed() { command -v glances > /dev/null; }
#
# INSTALL FUNCTION
#
glances::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING GLANCES"
	echo "===================================================================="
	echo

	sudo apt install -y python3-defusedxml python3-ujson python3-future

	pip install glances

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
glances::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING GLANCES"
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
glances::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING GLANCES"
	echo "===================================================================="
	echo

	pip uninstall glances

	echo
	echo "DONE!"
	echo
}
