#!/usr/bin/env zsh

# ==================================================================
# src/apps/user
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/user
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
user::installed() { command -v user; }
#
# INSTALL FUNCTION
#
user::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING USER"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
user::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING USER"
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
user::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING USER"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
user::test()
{
	echo
	echo "===================================================================="
	echo "TESTING USER"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
