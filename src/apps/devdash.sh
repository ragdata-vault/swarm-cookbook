# ==================================================================
# src/apps/devdash
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/devdash
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
devdash::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}DEVDASH HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
devdash::requires() { echo; }
#
# INSTALLED FUNCTION
#
devdash::installed() { command -v devdash > /dev/null; }
#
# INSTALL FUNCTION
#
devdash::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DEVDASH"
	echo "===================================================================="
	echo

	cd "$XDG_DOWNLOAD_DIR" || return 1

	curl -LO https://raw.githubusercontent.com/Phantas0s/devdash/master/install/linux.sh

	mv linux.sh install-devdash.sh

	sh ./install-devdash.sh

	cd - || return 1

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
devdash::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DEVDASH"
	echo "===================================================================="
	echo

	# default location for config file is:
	# $XDG_CONFIG_HOME/devdash/default.yml

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
devdash::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DEVDASH"
	echo "===================================================================="
	echo

	rm -f "$XDG_DOWNLOAD_DIR/install-devdash.sh"

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
devdash::test()
{
	echo
	echo "===================================================================="
	echo "TESTING DEVDASH"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
