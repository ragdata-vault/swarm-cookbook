#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/composer
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/composer
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

	apt purge -y composer

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
