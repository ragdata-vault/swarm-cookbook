# ==================================================================
# src/apps/cockpit-headscale
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-headscale
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
cockpit-headscale::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-HEADSCALE HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-headscale::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-headscale::installed() { command -v cockpit-headscale > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-headscale::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-HEADSCALE"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	wget -O "$XDG_DOWNLOAD_DIR"/cockpit-headscale-v0.0.1-1.fc38.noarch.rpm https://github.com/spotsnel/cockpit-headscale/releases/download/v0.0.1/cockpit-headscale-v0.0.1-1.fc38.noarch.rpm

	rpm -ivh "$XDG_DOWNLOAD_DIR"/cockpit-headscale-v0.0.1-1.fc38.noarch.rpm

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-headscale::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-HEADSCALE"
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
cockpit-headscale::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-HEADSCALE"
	echo "===================================================================="
	echo

	rpm -e cockpit-headscale

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
