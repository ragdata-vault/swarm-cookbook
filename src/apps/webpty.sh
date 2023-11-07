# ==================================================================
# src/apps/webpty
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/webpty
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
webpty::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}WEBPTY HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
webpty::requires() { echo; }
#
# INSTALLED FUNCTION
#
webpty::installed() { command -v webpty > /dev/null; }
#
# INSTALL FUNCTION
#
webpty::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING WEBPTY"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	wget -O "$XDG_DOWNLOAD_DIR"/webpty.bin https://github.com/mickael-kerjean/webpty/releases/download/stable/webpty_linux_amd64.bin

	sudo install -v -m 0755 -C -D -t /usr/local/bin "$XDG_DOWNLOAD_DIR"/webpty.bin

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
webpty::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING WEBPTY"
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
webpty::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING WEBPTY"
	echo "===================================================================="
	echo

	rm -f /usr/local/bin/webpty.bin

	echo
	echo "DONE!"
	echo
}
