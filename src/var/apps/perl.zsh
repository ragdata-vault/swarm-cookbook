#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/perl
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/perl
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
perl::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING PERL"
	echo "===================================================================="
	echo

	sudo apt install -y perl perl-openssl-defaults perl-doc libterm-readline-gnu-perl libdbi-perl libdbd-mysql-perl
	sudo apt install -y libsql-statement-perl libclone-perl libmldbm-perl libnet-daemon-perl

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
perl::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING PERL"
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
perl::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING PERL"
	echo "===================================================================="
	echo

	sudo apt purge -y perl perl-openssl-defaults perl-doc libterm-readline-gnu-perl libdbi-perl libdbd-mysql-perl
	sudo apt purge -y libsql-statement-perl libclone-perl libmldbm-perl libnet-daemon-perl

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
perl::test()
{
	echo
	echo "===================================================================="
	echo "TESTING PERL"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
