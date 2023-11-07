# ==================================================================
# src/apps/cockpit-cloudflared
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-cloudflared
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
cockpit-cloudflared::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-CLOUDFLARED HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-cloudflared::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-cloudflared::installed() { command -v cockpit-cloudflared > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-cloudflared::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-CLOUDFLARED"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	wget -O "$XDG_DOWNLOAD_DIR"/cockpit-cloudflared-v0.0.2-1.fc38.noarch.rpm https://github.com/spotsnel/cockpit-cloudflared/releases/download/v0.0.2/cockpit-cloudflared-v0.0.2-1.fc38.noarch.rpm

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-cloudflared::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-CLOUDFLARED"
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
cockpit-cloudflared::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-CLOUDFLARED"
	echo "===================================================================="
	echo

	rpm -e cockpit-cloudflared

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
