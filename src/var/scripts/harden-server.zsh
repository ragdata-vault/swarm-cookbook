#!/usr/bin/env zsh
#
# ==================================================================
# src/scripts/harden-server.zsh
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/scripts/harden-server.zsh
# Author:       Ragdata
# Date:         15/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# MAIN
# ==================================================================

echo
echo "===================================================================="
echo "HARDENING SERVER"
echo "===================================================================="
echo

chmod 0700 /usr/bin/wget
chmod 0700 /usr/bin/cc
chmod 0700 /usr/bin/gcc

mv /etc/sysctl.conf /etc/sysctl.conf~



echo
echo "DONE!"
echo
