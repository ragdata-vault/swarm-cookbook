#!/usr/bin/env zsh

# ==================================================================
# install/lib
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/lib
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
lib::installed() { return 1; }
#
# INSTALL FUNCTION
#
lib::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING :: LIBRARY FILES"
	echo "===================================================================="
	echo

	source="$REPO"/src/lib
	while IFS= read -r file
	do
		sudo install -v -C -m 0755 -D -t /usr/local/lib "$file"
		if [[ $? -ne 0 ]]; then
			install::log "Possible problem installing '$file' to /usr/local/lib - exit code $?"
		else
			install::log "Installed '$file' to /usr/local/lib OK!"
		fi
	done < <(find "$source" -type f)

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
lib::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING :: LIBRARY FILES"
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
lib::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: LIBRARY FILES"
	echo "===================================================================="
	echo

	cd /usr/local/lib || return 1
	rm -f ./*.zsh
	cd - || return 1

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
lib::test()
{
	echo
	echo "===================================================================="
	echo "TESTING :: LIBRARY FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
