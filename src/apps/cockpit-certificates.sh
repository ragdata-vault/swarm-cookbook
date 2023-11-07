# ==================================================================
# src/apps/cockpit-certificates
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-certificates
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
# HELP FUNCTION
#
cockpit-certificates::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-CERTIFICATES HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-certificates::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-certificates::installed() { command -v cockpit-certificates > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-certificates::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-CERTIFICATES"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	sudo apt install -y certmonger

	git clone git@github.com:skobyda/cockpit-certificates "$XDG_DOWNLOAD_DIR"/cockpit-certificates

	cd "$XDG_DOWNLOAD_DIR"/cockpit-certificates || return 1

	make

	export NODE_ENV=production

	make install

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-certificates::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-CERTIFICATES"
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
cockpit-certificates::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-CERTIFICATES"
	echo "===================================================================="
	echo

	systemctl restart cockpit.socket

	sudo apt purge -y --autoremove cockpit-certificates

	echo
	echo "DONE!"
	echo
}
