# ==================================================================
# src/apps/composer
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/composer
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
composer::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COMPOSER HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
composer::requires() { echo; }
#
# INSTALLED FUNCTION
#
composer::installed() { command -v composer > /dev/null; }
#
# INSTALL FUNCTION
#
composer::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COMPOSER"
	echo "===================================================================="
	echo

	sudo apt install -y composer

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
composer::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COMPOSER"
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
composer::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COMPOSER"
	echo "===================================================================="
	echo

	apt purge -y --autoremove composer

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
composer::test()
{
	echo
	echo "===================================================================="
	echo "TESTING COMPOSER"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
