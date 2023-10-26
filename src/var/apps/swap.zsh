#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/swap
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/swap
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
swap::installed() { command -v swap; }
#
# INSTALL FUNCTION
#
swap::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING SWAP"
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
swap::config()
{
	autoload -Uz regexResponse

	echo
	echo "===================================================================="
	echo "CONFIGURING SWAP"
	echo "===================================================================="
	echo

    SWAP_TOTAL=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)
    SWAP_MiB=$(( SWAP_TOTAL / 1024))
    SWAP_MB=$(awk -vr=$SWAP_MiB 'BEGIN{printf "%.0f", r * 1.049}')
    SWAP_GiB=$(( SWAP_MB / 1024 ))
    PRINT_SWAP_MiB=$(printf "%'d" $SWAP_MiB)
    PRINT_SWAP_MB=$(printf "%'d" "$SWAP_MB")
    PRINT_SWAP_GiB=$(printf "%'d" $SWAP_GiB)

	# shellcheck disable=SC2028
	echo "TOTAL SWAP: ${SWAP_TOTAL} (${PRINT_SWAP_MiB} MiB)\n"

	echo -e -n "Do you want to configure swap space for this server? (${WHITE}Y${RESET}/n) "

	read -rsq SWAPYN

	if [[ "${SWAPYN:l}" == "n" ]]; then echo "User elected not to configure swap space"; fi

	if [[ ! $SWAPYN =~ $NEGAT ]]; then
		if [[ $SWAP_TOTAL -lt 4194000 ]]
	fi

	echo
	echo "DONE!"
	echo
}
}
#
# REMOVE FUNCTION
#
swap::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING SWAP"
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
swap::test()
{
	echo
	echo "===================================================================="
	echo "TESTING SWAP"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
