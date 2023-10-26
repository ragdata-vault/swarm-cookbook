#!/usr/bin/env zsh

# ==================================================================
# src/apps/exa
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/exa
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
# REQUIRES FUNCTION
#
exa::requires() { echo; }
#
# INSTALLED FUNCTION
#
exa::installed() { command -v exa; }
#
# INSTALL FUNCTION
#
exa::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING EXA"
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
exa::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING EXA"
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
exa::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING EXA"
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
exa::test()
{
	echo
	echo "===================================================================="
	echo "TESTING EXA"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
