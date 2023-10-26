#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/ssh
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/ssh
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
# INSTALLED FUNCTION
#
ssh::installed() { command -v ssh; }
#
# INSTALL FUNCTION
#
ssh::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING SSH"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
ssh::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING SSH"
	echo "===================================================================="
	echo

	sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original

    sed -i '/#Port 22/c\Port 2022' /etc/ssh/sshd_config
    sed -i '/#PermitRootLogin.*/c\PermitRootLogin no' /etc/ssh/sshd_config
    sed -i '/#LogLevel.*/c\LogLevel VERBOSE' /etc/ssh/sshd_config
    sed -i '/ChallengeResponseAuthentication.*/c\ChallengeResponseAuthentication no' /etc/ssh/sshd_config
    sed -i '/PasswordAuthentication.*/c\PasswordAuthentication no' /etc/ssh/sshd_config
    sed -i '/#KerberosAuthentication.*/c\KerberosAuthentication no' /etc/ssh/sshd_config
    sed -i '/#GSSAPIAuthentication.*/c\GSSAPIAuthentication no' /etc/ssh/sshd_config
    sed -i '/#PermitEmptyPasswords.*/c\PermitEmptyPasswords no' /etc/ssh/sshd_config
    sed -i '/#IgnoreRhosts.*/c\IgnoreRhosts ye' /etc/ssh/sshd_config
    sed -i '/#HostBasedAuthentication.*/c\HostBasedAuthentication no' /etc/ssh/sshd_config
    sed -i '/#TCPKeepAlive.*/c\TCPKeepAlive ye' /etc/ssh/sshd_config
    sed -i '/#ClientAliveInterval.*/c\ClientAliveInterval 60' /etc/ssh/sshd_config
    sed -i '/#ClientAliveCountMax.*/c\ClientAliveCountMax 3' /etc/ssh/sshd_config
    sed -i '/#LoginGraceTime.*/c\LoginGraceTime 300' /etc/ssh/sshd_config
    sed -i '/#MaxAuthTries.*/c\MaxAuthTries 3' /etc/ssh/sshd_config
    sed -i '/X11Forwarding.*/c\#X11Forwarding no' /etc/ssh/sshd_config

	if ! grep -q "Protocol 2" /etc/ssh/sshd_config; then
		echo | sudo tee /etc/ssh/sshd_config
		echo "Protocol 2" | sudo tee /etc/ssh/sshd_config
	fi

	if ! grep -q "$MY_USER" /etc/ssh/sshd_config; then
		echo | sudo tee /etc/ssh/sshd_config
		echo "AllowUsers $MY_USER" | sudo tee /etc/ssh/sshd_config
	fi

	sudo systemctl restart ssh

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
ssh::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING SSH"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
ssh::test()
{
	echo
	echo "===================================================================="
	echo "TESTING SSH"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
