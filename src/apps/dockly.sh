# ==================================================================
# src/apps/dockly
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/dockly
# Author:       Ragdata
# Date:         25/09/2023
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
dockly::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DOCKLY"
	echo "===================================================================="
	echo

	npm install -g dockly

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dockly::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DOCKLY"
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
dockly::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DOCKLY"
	echo "===================================================================="
	echo

	npm uninstall -g dockly

	echo
	echo "DONE!"
	echo
}
