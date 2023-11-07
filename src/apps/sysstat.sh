# ==================================================================
# src/apps/sysstat
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/sysstat
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
sysstat::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}SYSSTAT HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
sysstat::requires() { echo; }
#
# INSTALLED FUNCTION
#
sysstat::installed() { command -v sysstat > /dev/null; }
#
# INSTALL FUNCTION
#
sysstat::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING SYSSTAT"
	echo "===================================================================="
	echo

	sudo apt install -y sysstat

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
sysstat::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING SYSSTAT"
	echo "===================================================================="
	echo

    sed -i '/^ENABLED.*/c\ENABLED="true"' /etc/default/sysstat

    systemctl enable sysstat
    systemctl start sysstat

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
sysstat::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING SYSSTAT"
	echo "===================================================================="
	echo

	sudo apt install -y sysstat

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
sysstat::test()
{
	echo
	echo "===================================================================="
	echo "TESTING SYSSTAT"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
