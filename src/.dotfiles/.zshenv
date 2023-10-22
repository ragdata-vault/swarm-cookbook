#!/usr/bin/env zsh
# shellcheck disable=SC2155
# ==================================================================
# .ZSH* FILE PROCESSING ORDER:
# .zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout
# ==================================================================

export USERNAME="${SUDO_USER:-$(whoami)}"

if [[ "$USERNAME" != "root" ]]; then
	export USERDIR=/home/"$USERNAME"
else
	export USERDIR=/root
fi

# ------------------------------------------------------------------
# ZSH VARIABLES
# ------------------------------------------------------------------
# launchctl setenv ZDOTDIR="$USERDIR"
# launchctl setenv ZSHDIR="$USERDIR"/.zsh
export ZDOTDIR="$USERDIR"
export ZSHDIR="$USERDIR"/.zsh
export ZSH="$USERDIR"/.oh-my-zsh
export ZSH_CUSTOM="$ZSH/custom"
# ------------------------------------------------------------------
# XDG PATH VARIABLES
# ------------------------------------------------------------------
export XDG_DATA_HOME="$USERDIR"/.local/share
export XDG_DATA_DIRS=/usr/local/share
export XDG_CONFIG_HOME="$USERDIR"/.config
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_STATE_HOME="$USERDIR"/.local/state
export XDG_CACHE_HOME="$USERDIR"/.cache
# ------------------------------------------------------------------
export XDG_DESKTOP_DIR="$USERDIR"/Desktop
export XDG_DOWNLOAD_DIR="$USERDIR"/Download
export XDG_DOCUMENTS_DIR="$USERDIR"/Documents
export XDG_MUSIC_DIR="$USERDIR"/Music
export XDG_PICTURES_DIR="$USERDIR"/Pictures
export XDG_VIDEOS_DIR="$USERDIR"/Videos
export XDG_TEMPLATES_DIR="$USERDIR"/Templates
export XDG_PUBLICSHARE_DIR="$USERDIR"/Public
# ------------------------------------------------------------------
export XDG_DIRS=("XDG_DATA_HOME" "XDG_DATA_DIRS" "XDG_CONFIG_HOME" "XDG_CONFIG_DIRS" "XDG_STATE_HOME" "XDG_CACHE_HOME" "XDG_DESKTOP_DIR" "XDG_DOWNLOAD_DIR" "XDG_DOCUMENTS_DIR" "XDG_MUSIC_DIR" "XDG_PICTURES_DIR" "XDG_VIDEOS_DIR" "XDG_TEMPLATES_DIR" "XDG_PUBLICSHARE_DIR")
# ------------------------------------------------------------------
# MISC PATHS
# ------------------------------------------------------------------
export SSHDIR="$USERDIR"/.ssh
# ------------------------------------------------------------------
# GIT VARIABLES
# ------------------------------------------------------------------
export GIT_USER="$(git config --global --get user.name)"
export GIT_EMAIL="$(git config --global --get user.email)"
export GIT_FILEMODE="$(git config --global --get core.filemode)"
export GIT_EOL="$(git config --global --get core.eol)"
export GIT_AUTOCRLF="$(git config --global --get core.autocrlf)"
# ------------------------------------------------------------------
# MISC VARIABLES
# ------------------------------------------------------------------
export EDITOR="pico"
export LC_ALL="en_AU.UTF-8"
export SYMBOL_ERROR="✘"
export SYMBOL_SUCCESS="✔"
export SYMBOL_INFO="ℹ️"
export SYMBOL_WARNING="⚠️"
# ------------------------------------------------------------------
# ENV
# ------------------------------------------------------------------
umask 022
