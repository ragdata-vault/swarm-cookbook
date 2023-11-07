# shellcheck disable=SC2088
# ==================================================================
# src/pkgs/wsl2-ubuntu.zsh
# ==================================================================
# Swarm Cookbook - Package Installer
#
# File:         src/pkgs/wsl2-ubuntu.zsh
# Author:       Ragdata
# Date:         25/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================
source /usr/local/lib/common.zsh
# ==================================================================
# VARIABLES
# ==================================================================
if [[ -z "$REPO" ]]; then
	mkdir -p "$XDG_DOWNLOAD_DIR"
	git clone git@github.com:ragdata/swarm-cookbook "$XDG_DOWNLOAD_DIR/swarm-cookbook"
	export REPO="$XDG_DOWNLOAD_DIR/Download/swarm-cookbook"
fi
# ==================================================================
# MAIN
# ==================================================================
cd "$XDG_DOWNLOAD_DIR" || exit 1
# ------------------------------------------------------------------
# ZSH
# ------------------------------------------------------------------
./install.sh zsh
./install.sh zsh cont
./install.sh zsh-p10k

chsh -s "$(which zsh)" "$(whoami)"

# ------------------------------------------------------------------
# SWARM-COOKBOOK
# ------------------------------------------------------------------
./install.zsh plugins
./install.zsh dotfiles
./install.zsh config
./install.zsh lib
./install.zsh bin
./install.zsh cron-updates
./install.zsh swarm

# ------------------------------------------------------------------
# FOUNDATION
# ------------------------------------------------------------------
if ! loadSource dialog -d; then loadSource dialog -i -c; fi
if ! loadSource redis -d; then loadSource redis; fi
if ! loadSource jq -d; then loadSource jq; fi
loadSource gpg -i -c
loadSource locale -c
loadSource mkcert

# ------------------------------------------------------------------
# DEV TOOLSET
# ------------------------------------------------------------------
if ! loadSource git -d; then loadSource git; fi
loadSource git-crypt
loadSource toolset-common
loadSource toolset-dev
loadSource nodejs
loadSource perl
loadSource php-8 -i -c
loadSource composer
loadSource python
loadSource go
loadSource gh-cli
loadSource shellcheck
loadSource devcontainers-cli

# ------------------------------------------------------------------
# APPS
# ------------------------------------------------------------------
loadSource sysstat -i -c
loadSource docker
loadSource docker-ctop
loadSource dockly
loadSource devdash
