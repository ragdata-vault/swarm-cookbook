#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/go
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/go
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
go::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING GO"
	echo "===================================================================="
	echo

	sudo apt install -y golang

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
go::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING GO"
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
go::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING GO"
	echo "===================================================================="
	echo

	sudo apt purge -y golang

	echo
	echo "DONE!"
	echo
}
