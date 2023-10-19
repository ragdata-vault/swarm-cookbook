#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/shellcheck
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/shellcheck
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
shellcheck::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING SHELLCHECK"
	echo "===================================================================="
	echo

	apt install -y shellcheck

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
shellcheck::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING SHELLCHECK"
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
shellcheck::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING SHELLCHECK"
	echo "===================================================================="
	echo

	apt purge -y shellcheck

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
shellcheck::test()
{
	echo
	echo "===================================================================="
	echo "TESTING SHELLCHECK"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
