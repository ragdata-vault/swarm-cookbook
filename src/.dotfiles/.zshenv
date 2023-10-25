#!/usr/bin/env zsh
# shellcheck disable=SC2155
# ==================================================================
# .ZSH* FILE PROCESSING ORDER:
# .zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout
# ==================================================================

export SESSION_START="$(date -Iseconds)"

# Don't re-run this
if [ -n "$ENV_SET" ]; then exit 0; fi

# ------------------------------------------------------------------
# OWNERSHIP VARIABLES
# ------------------------------------------------------------------

export USERNAME="${SUDO_USER:-$(whoami)}"

if [[ "$USERNAME" != "root" ]]; then
	export USERDIR=/home/"$USERNAME"
else
	export USERDIR=/root
fi

# ------------------------------------------------------------------
# TELEMETRY OPT-OUT
# ------------------------------------------------------------------
export DO_NOT_TRACK=1					# https://consoledonottrack.com/
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1
export HINT_TELEMETRY="off"
export GATSBY_TELEMETRY_OPT_OUT=1
export NEXT_TELEMETRY_DEBUG=1
export NUXT_TELEMETRY_DISABLED=1
export ET_NO_TELEMETRY=1
export INFLUXD_REPORTING_DISABLED=true
export NG_CLI_ANALYTICS=false
export CHOOSENIM_NO_ANALYTICS=1
export POWERSHELL_TELEMETRY_OPTOUT=1
# ------------------------------------------------------------------
# ZSH VARIABLES
# ------------------------------------------------------------------
# launchctl setenv ZDOTDIR="$USERDIR"
# launchctl setenv ZSHDIR="$USERDIR"/.zsh
export ZDOTDIR="$USERDIR"
export ZSHDIR="$USERDIR"/.zsh
export ZSH="$USERDIR"/.oh-my-zsh
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CUSTOM_PLUGINS="$ZSH_CUSTOM/plugins"
# ------------------------------------------------------------------
# XDG PATH VARIABLES
# ------------------------------------------------------------------
export XDG_DATA_HOME="$USERDIR"/.local/share
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
# SET XDG_DATA_DIRS
# ------------------------------------------------------------------
xdg::data::add()
{
	if ! echo "$XDG_DATA_DIRS" | grep -q "$1" > /dev/null; then
		XDG_DATA_DIRS="$1${XDG_DATA_DIRS:+":$XDG_DATA_DIRS"}"
	fi
}
# ------------------------------------------------------------------
# XDG_DATA_DIRS
# ------------------------------------------------------------------
XDG_DATA_DIRS=/usr/local/share
xdg::data::add "/usr/share"
xdg::data::add "$XDG_DATA_HOME"
export XDG_DATA_DIRS
# ------------------------------------------------------------------
export XDG_DIRS=("XDG_DATA_HOME" "XDG_DATA_DIRS" "XDG_CONFIG_HOME" "XDG_CONFIG_DIRS" "XDG_STATE_HOME" "XDG_CACHE_HOME" "XDG_DESKTOP_DIR" "XDG_DOWNLOAD_DIR" "XDG_DOCUMENTS_DIR" "XDG_MUSIC_DIR" "XDG_PICTURES_DIR" "XDG_VIDEOS_DIR" "XDG_TEMPLATES_DIR" "XDG_PUBLICSHARE_DIR")
# ------------------------------------------------------------------
# SET MANPATH
# ------------------------------------------------------------------
manpath::add()
{
	if [ -d "$1" ] && ! echo "$MANPATH" | grep -q "$1" > /dev/null; then
		MANPATH="$1${MANPATH:+":$MANPATH"}"
	fi
}
# ------------------------------------------------------------------
# MANPATH
# ------------------------------------------------------------------
manpath::add "/usr/share/man"
manpath::add "/usr/local/share/man"
manpath::add "$USERDIR/.local/man"
manpath::add "$USERDIR/.local/share/man"
export MANPATH
# ------------------------------------------------------------------
# SET PATH
# ------------------------------------------------------------------
path::add::head()
{
	if [ -d "$1" ] && ! echo "$PATH" | grep -q "$1" > /dev/null; then
		PATH="$1${PATH:+":$PATH"}"
	fi
}
path::add::tail()
{
	if [ -d "$1" ] && ! echo "$PATH" | grep -q "$1" > /dev/null; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}
# ------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------
path::add::tail "/usr/local/sbin"
path::add::tail "/usr/local/bin"
path::add::tail "/usr/sbin"
path::add::tail "/usr/bin"
path::add::tail "/sbin"
path::add::tail "/bin"
path::add::head "$USERDIR/.local/sbin"
path::add::head "$USERDIR/.local/bin"
export PATH
# ------------------------------------------------------------------
# MISC PATHS
# ------------------------------------------------------------------
export SSHDIR="$USERDIR"/.ssh
export GNUPGHOME="$USERDIR"/.gnupg
export INFOPATH="/usr/local/share/info:$INFOPATH"
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
export LC_TIME=C					# 24-hour date
export LANG=en_US.UTF-8
export TZ="Australia/Brisbane"
export AUTH_AGENT="ssh"

umask 022

export ENV_SET=1
