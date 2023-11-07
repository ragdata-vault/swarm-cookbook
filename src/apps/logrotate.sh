# ==================================================================
# src/apps/logrotate
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/logrotate
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
logrotate::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}LOGROTATE HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
logrotate::requires() { echo; }
#
# INSTALLED FUNCTION
#
logrotate::installed() { command -v logrotate > /dev/null; }
#
# INSTALL FUNCTION
#
logrotate::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING LOGROTATE"
	echo "===================================================================="
	echo

	sudo apt install -y logrotate

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
logrotate::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING LOGROTATE"
	echo "===================================================================="
	echo

	cp "$SWARMDIR"/inc/log/logrotate-traefik.conf /etc/logrotate.d/traefik

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
logrotate::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING LOGROTATE"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove logrotate

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
logrotate::test()
{
	echo
	echo "===================================================================="
	echo "TESTING LOGROTATE"
	echo "===================================================================="
	echo

	logrotate /etc/logrotate.conf --debug

	echo
	echo "DONE!"
	echo
}
