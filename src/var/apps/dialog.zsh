#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/dialog
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/dialog
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

source /usr/local/lib/dialog.zsh
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALL FUNCTION
#
dialog::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DIALOG"
	echo "===================================================================="
	echo

	apt install -y dialog

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dialog::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DIALOG"
	echo "===================================================================="
	echo

	while [[ -z "$RESP" ]]
	do
		echo "Select Dialog Theme:"
		echo
		echo "    1. Debian"
		echo "    2. RedEyed"
		echo "    3. Slackware"
		echo "    4. SourceMage"
		echo "    5. SUSE"
		echo "    6. Whiptail"
		echo
		echo "    Q. Quit"
		echo
		read -r -n 1 RESP
	done

	case "$RESP" in
		1) dialogConfig debianrc;;
		2) dialogConfig redeyedrc;;
		3) dialogConfig slackwarerc;;
		4) dialogConfig sourcemagerc;;
		5) dialogConfig suserc;;
		6) dialogConfig whiptailrc;;
		q|Q) exit 0;;
		*) errorExit "Invalid Option!";;
	esac

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
dialog::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DIALOG"
	echo "===================================================================="
	echo

	apt purge -y dialog

	echo
	echo "DONE!"
	echo
}
