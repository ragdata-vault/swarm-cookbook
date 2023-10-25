#!/usr/bin/env zsh

# ==================================================================
# general.zsh
# ==================================================================
# Bash-Bits Modular Bash Library File
#
# File:         general.zsh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# Aliases
# ==================================================================
# ------------------------------------------------------------------
# SYSTEM -----------------------------------------------------------
# ------------------------------------------------------------------
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'
alias :q='exit'
alias cmdv='command -v'
# ------------------------------------------------------------------
# FILES ------------------------------------------------------------
# ------------------------------------------------------------------
alias bigguns='find / -xdev -type f -size +500M'				# display 'big' files - 500MB+
# ------------------------------------------------------------------
# LS ---------------------------------------------------------------
# ------------------------------------------------------------------
alias l='ls --icons --group-directories-first --color=auth'
alias ll='l -lhF --time-style=long-iso'
alias lll='l -lhF --time-style=full-iso -s modified'				# show full timestamp
alias la='l -a'
alias lla='ll -a'
alias lls='ll -s size'
alias llas='lla -s size'
alias llla='lll -a'
alias lc='l -C'
alias llc='ll -C'
alias lllc='lll -C'
# ------------------------------------------------------------------
# CURL -------------------------------------------------------------
# ------------------------------------------------------------------
alias curll='curl -SL'
alias curltl='curl-tor -L'
alias curls='curl --proto "=https" --proto-default https'
alias curlsl='curls -sSL'
alias curlslc='curlsl --compressed'
alias curlslct='curlsl --tlsv1.3 --compressed'
alias ccurl='curl --proto "=https" --proto-default https --http2 -sSL --tlsv1.3 --compressed --cert-status'
# ------------------------------------------------------------------
# NETWORK ----------------------------------------------------------
# ------------------------------------------------------------------
# shellcheck disable=SC2142
alias localhosts='ip n | grep REACHABLE | awk "{print \$1}" | xargs -n1 host | grep -v "not found"'
# ------------------------------------------------------------------
# EDIT FILES -------------------------------------------------------
# ------------------------------------------------------------------
alias zshrc='pico ~/.zshrc'
alias zshenv='pico ~/.zshenv'
# ------------------------------------------------------------------
# CP ---------------------------------------------------------------
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# DU ---------------------------------------------------------------
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# GREP -------------------------------------------------------------
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# TIME -------------------------------------------------------------
# ------------------------------------------------------------------
alias today="date +'%D'"
alias theTime="date +'%T'"
alias day='%A'
# ------------------------------------------------------------------
# LS ---------------------------------------------------------------
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# BOOKMARKS --------------------------------------------------------
# ------------------------------------------------------------------
alias cdhome='cd ~'
alias swarmrepo='cd ~/projects/ragdata/swarm-cookbook'
alias projects='cd ~/projects'
alias downloads='cd ~/Downloads'
alias .zsh='cd ~/.zsh'
alias .swarm='cd ~/.swarm'
alias .ssh='cd ~/.ssh'
# ------------------------------------------------------------------
# MISSPELLINGS -----------------------------------------------------
# ------------------------------------------------------------------
alias httop='htop'
# ------------------------------------------------------------------
# SHELLCHECK -------------------------------------------------------
# ------------------------------------------------------------------
alias shchk='shellcheck'
alias shchkv='shellcheck -xa -o all -e SC2250'
# alias quit='exit'
# alias e.='explorer.exe .'
# alias rl='. ~/.bashrc'
#
# # Tools
# alias p='ps axo pid,user,pcpu.comm'                         # process overview
# alias pg='ps aux | grep'                                    # find a process
# alias spider='wget --no-config --spider'                    # use wget as spider
# alias hideme='unset HISTFILE'                               # do not save history in current session anymore
# alias hgrep='history 0 | grep'                              # find a command in the history
# alias timer='echo "Timer started. Stop with Ctrl-D." && date "+%a, %d %b %H:%M:%S" && time cat && date "+%a, %d %b %H:%M:%S"'   # starts a stopwatch
# alias upgrade='sudo apt-get update && apt-get upgrade -y'   # upgrade all packages
#
# # Shortcuts
# alias x='exit'
# alias c='clear'
# alias h='history'
