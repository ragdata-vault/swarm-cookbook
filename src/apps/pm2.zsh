#!/usr/bin/env zsh

# ==================================================================
# src/apps/pm2
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/pm2
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
# INSTALLED FUNCTION
#
pm2::installed() { command -v pm2; }
#
# INSTALL FUNCTION
#
pm2::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING PM2"
	echo "===================================================================="
	echo

	if ! command -v npm; then echo "Requires npm to be installed first!"; exit 1; fi

	sudo npm i -g pm2

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
pm2::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING PM2"
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
pm2::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING PM2"
	echo "===================================================================="
	echo

	pm2 kill
	npm remove pm2 -g

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
pm2::test()
{
	echo
	echo "===================================================================="
	echo "TESTING PM2"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
