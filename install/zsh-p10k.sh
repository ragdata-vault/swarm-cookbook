# ==================================================================
# install/zsh-p10k
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/zsh-p10k
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# VARIABLES
# ==================================================================
export ZSH_RESTART=1
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALLED FUNCTION
#
zsh-p10k::installed() { return 1; }
#
# INSTALL FUNCTION
#
zsh-p10k::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING :: POWERLEVEL10K FILES"
	echo "===================================================================="
	echo

	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}"/themes/powerlevel10k

	sed -i '/^ZSH_THEME.*/c\ZSH_THEME="powerlevel10k/powerlevel10k"' "$USERDIR"/.zshrc

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
zsh-p10k::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING :: POWERLEVEL10K FILES"
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
zsh-p10k::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: POWERLEVEL10K FILES"
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
zsh-p10k::test()
{
	echo
	echo "===================================================================="
	echo "TESTING :: POWERLEVEL10K FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
