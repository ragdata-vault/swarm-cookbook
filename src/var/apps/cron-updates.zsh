#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/cron-updates
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/cron-updates
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
cron-updates::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING CRON-UPDATES"
	echo "===================================================================="
	echo

	install -v -m 0755 -C -D -t /etc/cron.daily "$SWARMDIR"/inc/cron/apt-update

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
	echo "CONFIGURING CRON-UPDATES"
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
	echo "UNINSTALLING CRON-UPDATES"
	echo "===================================================================="
	echo

	rm -f /etc/cron.daily/apt-update

	echo
	echo "DONE!"
	echo
}
