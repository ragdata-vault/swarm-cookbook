#!/usr/bin/env zsh

# ==================================================================
# install/zsh-plugins
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/zsh-plugins
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================
export ZDOTDIR="$USERDIR"
export ZSHDIR="$USERDIR"/.zsh
export ZSH="$USERDIR"/.oh-my-zsh
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CUSTOM_PLUGINS="$ZSH_CUSTOM/plugins"
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALLED FUNCTION
#
zsh-plugins::installed() { return 1; }
#
# INSTALL FUNCTION
#
zsh-plugins::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING :: ZSH PLUGIN FILES"
	echo "===================================================================="
	echo

	mkdir -p "$ZSH_CUSTOM_PLUGINS"

	install::log "Adding PPA Repository for Diff-So-Fancy"
	sudo add-apt-repository ppa:aos1/diff-so-fancy
	sudo apt update

	echo
	echo "--------------------------------------------------------------------"
	echo "APPLICATIONS"
	echo "--------------------------------------------------------------------"
	echo

	install::log "Installing Diff-So-Fancy Application"
	sudo apt install -y diff-so-fancy

	install::log "Installing Git-Flow Application"
	sudo apt install -y git-flow

	install::log "Installing FZF Fuzzy Finder Application"
	git clone git@github.com:junegunn/fzf "$USERDIR"/.fzf
	chmod 0755 "$USERDIR"/.fzf/install
	./"$USERDIR"/.fzf/install

	install::log "Installing Navi Application"
	bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)

	cd "$USERDIR/Downloads" || return 1

	echo
	echo "--------------------------------------------------------------------"
	echo "COMPLETIONS"
	echo "--------------------------------------------------------------------"
	echo

	install::log "Installing Git-Flow-Completion Plugin"
	git clone git@github.com:bobthecow/git-flow-completion "${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}"/plugins/git-flow-completion

	install::log "Installing ZSH Completions Plugin"
	git clone git@github.com:zsh-users/zsh-completions "${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}"/plugins/zsh-completions

	echo
	echo "--------------------------------------------------------------------"
	echo "PLUGINS"
	echo "--------------------------------------------------------------------"
	echo

	install::log "Installing enhan/cd Plugin"
	git clone git@github.com:b4b4r07/enhancd "${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}"/plugins/enhancd

	install::log "Installing Bash-Insulter Plugin"
	git clone git@github.com:hkbakke/bash-insulter
	sudo cp bash-insulter/src/bash.command-not-found /etc/

	install::log "Installing FZF ZSH Plugin"
	git clone git@github.com:unixorn/fzf-zsh-plugin "${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin

	install::log "Installing ZSH Syntax Highlighting Plugin"
	git clone git@github.com:zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

	cd - || return 1

	echo
	echo "DONE!"
	echo

	exec zsh
}
#
# CONFIG FUNCTION
#
zsh-plugins::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING :: ZSH PLUGIN FILES"
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
zsh-plugins::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: ZSH PLUGIN FILES"
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
zsh-plugins::test()
{
	echo
	echo "===================================================================="
	echo "TESTING :: ZSH PLUGIN FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
