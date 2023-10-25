#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/logrotate
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/logrotate
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
logrotate::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING LOGROTATE"
	echo "===================================================================="
	echo

	apt install -y logrotate

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
logrotate::config()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "CONFIGURING LOGROTATE"
	echo "===================================================================="
	echo

	cp "$SWARMDIR"/inc/log/logrotate-traefik.conf /etc/logrotate.d/traefik

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
logrotate::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING LOGROTATE"
	echo "===================================================================="
	echo

	apt purge -y logrotate

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
logrotate::test()
{
	echo
	echo "===================================================================="
	echo "TESTING LOGROTATE"
	echo "===================================================================="
	echo

	logrotate /etc/logrotate.conf --debug

	echo
	echo "DONE!"
	echo
}
