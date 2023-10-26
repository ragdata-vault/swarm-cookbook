#!/usr/bin/env zsh

# ==================================================================
# src/apps/toolset-common
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/toolset-common
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
toolset-common::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING TOOLSET-COMMON"
	echo "===================================================================="
	echo

	export DEBIAN_FRONTEND=noninteractive

	sudo apt install -y apt-transport-https apt-listchanges apt-utils rpm ca-certificates
	sudo apt install -y curl wget mcrypt dialog attr coreutils software-properties-common certbot
	sudo apt install -y bash-completion unattended-upgrades software-properties-common nano lsb-release
	sudo apt install -y id-utils uuid net-tools apache2-utils daemon passwd psmisc util-linux openssh-client
	sudo apt install -y bison arj bzip2 nomarch lzop unzip zip cabextract
	sudo apt install -y debconf-utils binutils lsb-core net-tools nfs-common nfs-kernel-server samba samba-common-bin winbind gawk

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
toolset-common::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING TOOLSET-COMMON"
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
toolset-common::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING TOOLSET-COMMON"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove apt-transport-https apt-listchanges apt-utils rpm ca-certificates
	apt purge -y --autoremove gpg curl wget mcrypt jq mkcert dialog attr coreutils
	apt purge -y --autoremove bash-completion unattended-upgrades software-properties-common nano
	apt purge -y --autoremove id-utils uuid net-tools apache2-utils daemon passwd psmisc util-linux openssh-client
	apt purge -y --autoremove zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libc-bin
	apt purge -y --autoremove libffi-dev libgdbm-dev libncurses5-dev automake libtool bison arj bzip2 nomarch lzop unzip zip cabextract
	apt purge -y --autoremove debconf-utils binutils lsb-core net-tools nfs-common nfs-kernel-server samba samba-common-bin winbind gawk
	apt purge -y --autoremove software-properties-common python3-software-properties python3-dev python3-dateutil python3-debconf python3-debian python3-pip python3-venv python3-django
	apt purge -y --autoremove certbot python3-certbot-nginx php-cli php-pear perl

	echo
	echo "DONE!"
	echo
}
