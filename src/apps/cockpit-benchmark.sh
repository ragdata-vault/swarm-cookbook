# ==================================================================
# src/apps/cockpit-benchmark
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-benchmark
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
cockpit-benchmark::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}COCKPIT-BENCHMARK HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
cockpit-benchmark::requires() { echo; }
#
# INSTALLED FUNCTION
#
cockpit-benchmark::installed() { command -v cockpit-benchmark > /dev/null; }
#
# INSTALL FUNCTION
#
cockpit-benchmark::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-BENCHMARK"
	echo "===================================================================="
	echo

	sudo apt install -y cockpit-benchmark

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-benchmark::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-BENCHMARK"
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
cockpit-benchmark::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-BENCHMARK"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove cockpit-benchmark

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
