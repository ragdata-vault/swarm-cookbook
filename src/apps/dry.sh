# ==================================================================
# src/apps/dry
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/dry
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
dry::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}DRY HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
dry::requires() { echo; }
#
# INSTALLED FUNCTION
#
dry::installed() { command -v dry > /dev/null; }
#
# INSTALL FUNCTION
#
dry::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DRY"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	wget -O "$XDG_DOWNLOAD_DIR"/dryup.zsh https://moncho.github.io/dry/dryup.zsh

	chmod 0755 "$XDG_DOWNLOAD_DIR"/dryup.zsh

	sh "$XDG_DOWNLOAD_DIR"/dryup.zsh

	chmod 0755 /usr/local/bin/dry

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dry::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DRY"
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
dry::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DRY"
	echo "===================================================================="
	echo

	rm -f /usr/local/bin/dry

	echo
	echo "DONE!"
	echo
}
