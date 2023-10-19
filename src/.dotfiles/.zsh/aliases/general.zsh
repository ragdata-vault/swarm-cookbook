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
# ------------------------------------------------------------------
# FILES ------------------------------------------------------------
# ------------------------------------------------------------------
alias bigguns='find / -xdev -type f -size +500M'						# display 'big' files - 500MB+
# ------------------------------------------------------------------
# LS ---------------------------------------------------------------
# ------------------------------------------------------------------
alias ls='ls --group-directories-first --color=auth'
alias lsl='ls -l'
alias ll='ls -alhF'
alias lls='ls -alhFtr'
alias la='ls -A'
alias lc='ls -CF'
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
