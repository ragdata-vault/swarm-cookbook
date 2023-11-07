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
export ZDOTDIR="$HOME"
export ZSHDIR="$HOME"/.zsh
export ZSH="$HOME"/.oh-my-zsh
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CUSTOM_PLUGINS="$ZSH_CUSTOM/plugins"
export ZSHSHARE=/usr/local/share/zsh
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALLED FUNCTION
#
zsh-plugins::installed() { return 0; }
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

	if ! command -v diff-so-fancy > /dev/null; then
		echo
		log::file "Adding PPA Repository for Diff-So-Fancy"
		sudo add-apt-repository ppa:aos1/diff-so-fancy
		sudo apt update
	fi

	echo
	echo "--------------------------------------------------------------------"
	echo "APPLICATIONS"
	echo "--------------------------------------------------------------------"
	echo

	if ! command -v diff-so-fancy > /dev/null; then
		log::file "Installing Diff-So-Fancy Application"
		sudo apt install -y diff-so-fancy
	fi

	if ! command -v git-flow > /dev/null; then
		echo
		log::file "Installing Git-Flow Application"
		sudo apt install -y git-flow
	fi

	if [[ ! -d "$HOME/.fzf" ]]; then
		echo
		log::file "Installing FZF Fuzzy Finder Application"
		git clone git@github.com:junegunn/fzf "$HOME"/.fzf
		chmod 0755 "$HOME"/.fzf/install
		cd "$HOME/.fzf" || return 1
		./install
		cd - || return 1
	fi

	if [[ ! -f "$HOME/.cargo/bin/navi" ]]; then
		echo
		log::file "Installing Navi Application"
		bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
	fi

	cd "$XDG_DOWNLOAD_DIR" || return 1

	echo
	echo "--------------------------------------------------------------------"
	echo "COMPLETIONS"
	echo "--------------------------------------------------------------------"
	echo

	if [[ ! -d "$ZSH_CUSTOM/plugins/git-flow-completion" ]]; then
		echo
		log::file "Installing Git-Flow-Completion Plugin"
		git clone git@github.com:bobthecow/git-flow-completion "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/git-flow-completion
	fi

	if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]]; then
		echo
		log::file "Installing ZSH Completions Plugin"
		git clone git@github.com:zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-completions
	fi

	echo
	echo "--------------------------------------------------------------------"
	echo "PLUGINS"
	echo "--------------------------------------------------------------------"
	echo

	if [[ ! -f /etc/bash.command-not-found ]]; then
		echo
		log::file "Installing Bash-Insulter Plugin"
		git clone git@github.com:hkbakke/bash-insulter
		sudo cp bash-insulter/src/bash.command-not-found /etc/
	fi

	if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-diff-so-fancy" ]]; then
		echo
		log::file "Installing Diff-So-Fancy Plugin"
		git clone git@github.com:z-shell/zsh-diff-so-fancy "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-diff-so-fancy
	fi

	if [[ ! -d "$ZSH_CUSTOM/plugins/enhancd" ]]; then
		echo
		log::file "Installing enhan/cd Plugin"
		git clone git@github.com:b4b4r07/enhancd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/enhancd
	fi

	if [[ ! -d "$ZSH_CUSTOM/plugins/fzf-zsh-plugin" ]]; then
		echo
		log::file "Installing FZF ZSH Plugin"
		git clone git@github.com:unixorn/fzf-zsh-plugin "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin
	fi

	if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
		echo
		log::file "Installing ZSH AutoSuggestions Plugin"
		git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-"$HOME"/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	fi

	if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
		echo
		log::file "Installing ZSH Syntax Highlighting Plugin"
		git clone git@github.com:zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	fi

	cd - || return 1

	chown -R "$USERNAME":"$USERNAME" "$ZSH_CUSTOM"

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
