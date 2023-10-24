#!/usr/bin/env zsh

# ==================================================================
# install/node
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/node
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================
if [[ ! -d "$SWARMDIR"/apps ]]; then
	echo "You need to run the swarm installer BEFORE the node installer"
	exit 1
fi
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALLED FUNCTION
#
node::installed() { return 1; }
#
# INSTALL FUNCTION
#
node::install()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "INSTALLING :: NODE FILES"
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
node::config()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "CONFIGURING :: NODE FILES"
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
node::remove()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "UNINSTALLING :: NODE FILES"
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
node::test()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "TESTING :: NODE FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
