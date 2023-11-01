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
# INSTALL FUNCTION
#
dry::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DRY"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	wget -O "$USERDIR"/downloads/dryup.zsh https://moncho.github.io/dry/dryup.zsh

	chmod 0755 "$USERDIR"/downloads/dryup.zsh

	sh "$USERDIR"/downloads/dryup.zsh

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
