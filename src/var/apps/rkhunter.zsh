#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/rkhunter
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/rkhunter
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
rkhunter::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING RKHUNTER"
	echo "===================================================================="
	echo

	sudo apt install -y rkhunter

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
rkhunter::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING RKHUNTER"
	echo "===================================================================="
	echo

    sed -i '/UPDATE_MIRRORS.*/c\UPDATE_MIRRORS=1' /etc/rkhunter.conf
    sed -i '/MIRRORS_MODE.*/c\MIRRORS_MODE=0' /etc/rkhunter.conf
    sed -i '/WEB_CMD.*/c\WEB_CMD=""' /etc/rkhunter.conf

    sed -i '/CRON_DAILY_RUN.*/c\CRON_DAILY_RUN="true"' /etc/default/rkhunter
    sed -i '/CRON_DB_UPDATE.*/c\CRON_DB_UPDATE="true"' /etc/default/rkhunter
    sed -i '/APT_AUTOGEN.*/c\APT_AUTOGEN="true"' /etc/default/rkhunter

    rkhunter --update
    rkhunter --propupd

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
rkhunter::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING RKHUNTER"
	echo "===================================================================="
	echo

	apt purge -y --autoremove rkhunter

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
rkhunter::test()
{
	echo
	echo "===================================================================="
	echo "TESTING RKHUNTER"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
