#!/usr/bin/env zsh

# ==================================================================
# src/apps/template
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/template
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
template::installed() { command -v template; }
#
# INSTALL FUNCTION
#
template::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING TEMPLATE"
	echo "===================================================================="
	echo

	sudo apt install -y exa

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
template::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING TEMPLATE"
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
template::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING TEMPLATE"
	echo "===================================================================="
	echo

	sudo purge -y --autoremove exa

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
template::test()
{
	echo
	echo "===================================================================="
	echo "TESTING TEMPLATE"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
