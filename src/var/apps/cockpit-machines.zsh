#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/cockpit-machines
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/cockpit-machines
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
cockpit-machines::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-MACHINES"
	echo "===================================================================="
	echo

	apt install -y gettext nodejs make

	apt install -y cockpit-machines libvirt-dbus

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-machines::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-MACHINES"
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
cockpit-machines::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-MACHINES"
	echo "===================================================================="
	echo

	apt purge -y cockpit-machines libvirt-dbus

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
