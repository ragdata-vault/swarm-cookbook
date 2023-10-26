#!/usr/bin/env zsh
# shellcheck disable=SC2154,SC2181
# ==================================================================
# install/bin
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/bin
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
bin::installed() { return 1; }
#
# INSTALL FUNCTION
#
bin::install()
{
	local source

	echo
	echo "===================================================================="
	echo "INSTALLING :: BIN FILES"
	echo "===================================================================="
	echo

	source="$REPO"/src/bin
	while IFS= read -r file
	do
		sudo install -v -C -m 0755 -D -t /usr/local/bin "$file"
		if [[ $? -ne 0 ]]; then
			log::file "Possible problem installing '$file' to /usr/local/bin - exit code $?"
		else
			log::file "Installed '$file' to /usr/local/bin OK!"
		fi
	done < <(find "$source" -type f)

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
bin::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING BIN"
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
bin::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING BIN"
	echo "===================================================================="
	echo

	cd /usr/local/bin || return 1
	rm -f app* stack* swarm* cluster*
	cd - || return 1

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
bin::test()
{
	echo
	echo "===================================================================="
	echo "TESTING BIN"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
