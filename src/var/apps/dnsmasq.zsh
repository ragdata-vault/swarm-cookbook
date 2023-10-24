#!/usr/bin/env zsh
#shellcheck disable=SC1090
# ==================================================================
# src/var/apps/dnsmasq
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/dnsmasq
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
dnsmasq::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING DNSMASQ"
	echo "===================================================================="
	echo

	local USERNAME NODE_ID NODE_DOMAIN

	NODE_ID="$(docker info -f '{{.Swarm.NodeID}}')"

	source "$SWARMDIR"/.env

	NODE_DOMAIN="$(hashGET NODE:"${NODE_ID}" NODE_DOMAIN)"

	systemctl disable systemd-resolved
	systemctl stop systemd-resolved

	ls -lh /etc/resolv.conf
	rm /etc/resolv.conf

	echo "nameserver 127.0.0.1" > /etc/resolv.conf
	echo "nameserver 1.1.1.1" >> /etc/resolv.conf

	apt install -y dnsmasq

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

	apt purge -y dnsmasq

	echo
	echo "DONE!"
	echo
}
