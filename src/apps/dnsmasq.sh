#shellcheck disable=SC1090
# ==================================================================
# src/apps/dnsmasq
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/dnsmasq
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
# HELP FUNCTION
#
dnsmasq::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}DNSMASQ HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
dnsmasq::requires() { echo; }
#
# INSTALLED FUNCTION
#
dnsmasq::installed() { command -v dnsmasq > /dev/null; }
#
# INSTALL FUNCTION
#
dnsmasq::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DNSMASQ"
	echo "===================================================================="
	echo

	local NODE_ID NODE_DOMAIN

	NODE_ID="$(docker info -f '{{.Swarm.NodeID}}')"

	source "$SWARMDIR"/.env

	NODE_DOMAIN="$(hashGET NODE:"${NODE_ID}" NODE_DOMAIN)"

	systemctl disable systemd-resolved
	systemctl stop systemd-resolved

	ls -lh /etc/resolv.conf
	rm /etc/resolv.conf

	echo "nameserver 127.0.0.1" > /etc/resolv.conf
	echo "nameserver 1.1.1.1" >> /etc/resolv.conf

	sudo apt install -y dnsmasq

	echo "address=/.${NODE_DOMAIN}/127.0.0.1" >> /etc/dnsmasq.conf

	mkdir -v /etc/resolver && echo "nameserver 127.0.0.1" > /etc/resolver/"${NODE_DOMAIN}"

	systemctl enable dnsmasq
	systemctl restart dnsmasq

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dnsmasq::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DNSMASQ"
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
dnsmasq::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DNSMASQ"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove dnsmasq

	echo
	echo "DONE!"
	echo
}
