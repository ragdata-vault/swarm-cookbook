#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/ruby
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/ruby
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
ruby::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING RUBY"
	echo "===================================================================="
	echo

	apt install -y build-essential libyaml-dev ruby-dev

	# Uncomment to install Bashly
	# gem install bashly

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
ruby::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING RUBY"
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
ruby::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING RUBY"
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
ruby::test()
{
	echo
	echo "===================================================================="
	echo "TESTING RUBY"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
