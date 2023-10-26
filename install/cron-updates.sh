#!/usr/bin/env zsh

# ==================================================================
# install/cron-updates
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/cron-updates
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
cron-updates::installed() { return 1; }
#
# INSTALL FUNCTION
#
cron-updates::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING :: CRON UPDATE FILES"
	echo "===================================================================="
	echo

	sudo install -v -m 0755 -C -D -t /etc/cron.daily "$REPO"/var/etc/cron/apt-update

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cron-updates::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING :: CRON UPDATE FILES"
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
cron-updates::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: CRON UPDATE FILES"
	echo "===================================================================="
	echo

	sudo rm -f /etc/cron.daily/apt-update

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
cron-updates::test()
{
	echo
	echo "===================================================================="
	echo "TESTING :: CRON UPDATE FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
