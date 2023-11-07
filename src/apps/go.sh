# ==================================================================
# src/apps/go
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/go
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
go::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}GO HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
go::requires() { echo; }
#
# INSTALLED FUNCTION
#
go::installed() { command -v go > /dev/null; }
#
# INSTALL FUNCTION
#
go::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING GO"
	echo "===================================================================="
	echo

	sudo apt install -y golang

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
go::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING GO"
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
go::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING GO"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove golang

	echo
	echo "DONE!"
	echo
}
