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
# INSTALL FUNCTION
#
webpty::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING WEBPTY"
	echo "===================================================================="
	echo

	[[ ! -d "$HOME"/downloads ]] && mkdir -p "$HOME"/downloads

	wget -O "$HOME"/downloads/webpty.bin https://github.com/mickael-kerjean/webpty/releases/download/stable/webpty_linux_amd64.bin

	sudo install -v -m 0755 -C -D -t /usr/local/bin "$HOME"/downloads/webpty.bin

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
