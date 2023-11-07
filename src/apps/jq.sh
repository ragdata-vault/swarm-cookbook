# ==================================================================
# src/apps/jq
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/jq
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
jq::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}JQ HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
jq::requires() { echo; }
#
# INSTALLED FUNCTION
#
jq::installed() { command -v jq > /dev/null; }
#
# INSTALL FUNCTION
#
jq::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING JQ"
	echo "===================================================================="
	echo

	sudo apt install -y jq

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
jq::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING JQ"
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
jq::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING JQ"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove jq

	echo
	echo "DONE!"
	echo
}
