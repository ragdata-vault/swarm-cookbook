#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/jq
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/jq
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
jq::installed() { command -v jq; }
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

	sudo apt purge -y jq

	echo
	echo "DONE!"
	echo
}
