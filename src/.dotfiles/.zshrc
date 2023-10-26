#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2154
# ==================================================================
# .ZSH* FILE PROCESSING ORDER:
# .zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout
# ==================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------
# OH MY ZSH!
# ------------------------------------------------------------------
# Uncomment below to load 'Oh My ZSH' on startup
source $ZSH/oh-my-zsh.sh

# ------------------------------------------------------------------
# POWERLEVEL10K THEME
# ------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-$USERNAME.zsh" ]]; then
	source "$XDG_CACHE_HOME/p10k-instant-prompt-$USERNAME.zsh"
fi

# ------------------------------------------------------------------
# USER VARIABLES
# ------------------------------------------------------------------
export COLUMS ROWS

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nano'
else
	export EDITOR='pico'
fi

if [ -z "$PROFILE_SET" ]; then
	source "$USERDIR/.profile"
	export PROFILE_SET='zshrc'
fi

# ------------------------------------------------------------------
# LAZY AUTOLOAD
# ------------------------------------------------------------------
# Using this method of autoloading functions means that you don't
# incur that huge drain on resources each time a script loads because
# you're loading all required functions up-front.  This method loads
# functions the first time they are called, and only IF they are called.
fpath=("$fpath" "$ZSHDIR/functions")
autoload -Uz "$ZSHDIR/functions/**/*"

# ------------------------------------------------------------------
# RESOURCE PATHS
# ------------------------------------------------------------------
fpath=("$fpath" "/usr/share/zsh/functions/Completion")
fpath=("$fpath" "/usr/share/zsh/functions/Zle")

# Uncomment the line below to initialise the ZSH Completion System
autoload -U compinit; compinit

# ------------------------------------------------------------------
# THEME
# ------------------------------------------------------------------
# If set to "random", then a random theme will be loaded each time oh-my-zsh is loaded.
# If you need to know which theme was randomly loaded, run: `echo $RANDOM_THEME`
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# ------------------------------------------------------------------
# RANDOM THEMES LIST
# ------------------------------------------------------------------
# List of themes to pick from to load randomly
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this array instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# ------------------------------------------------------------------
# AUTO-UPDATE BEHAVIOUR
# ------------------------------------------------------------------
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 14

# ------------------------------------------------------------------
# MAGIC FUNCTIONS
# ------------------------------------------------------------------
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# ------------------------------------------------------------------
# LS COLORS
# ------------------------------------------------------------------
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# ------------------------------------------------------------------
# AUTO-TITLE
# ------------------------------------------------------------------
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# ------------------------------------------------------------------
# AUTO-CORRECTION
# ------------------------------------------------------------------
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# ------------------------------------------------------------------
# UNTRACKED FILES DIRTY
# ------------------------------------------------------------------
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# ------------------------------------------------------------------
# HISTORY CONFIG
# ------------------------------------------------------------------
# HISTORY FILE
[ -z "$HISTFILE" ] && HISTFILE="$USERDIR/.zsh_history"
# HISTORY IGNORE
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
# HISTORY SIZE
# While the system can handle histories numbering 5 figures or more,
# a list that size is not very usable - so I like to keep it shorter
HISTSIZE=99
# MINIBUFFER HISTORIES TO SAVE
SAVEHIST=90
# HISTORY COMMAND CONFIG
setopt extended_history			# record timestamp of command in HISTFILE
setopt hist_expire_dups_first	# Delete duplicates first when HISTFILE exceeds HISTSIZE
setopt hist_ignore_dups			# don't add duplicate entries
setopt hist_ignore_space		# ignore commands that start with a space
setopt hist_verify				# show command with history expansion to user before running it
setopt inc_append_history		# add commands to HISTFILE in order of execution
setopt share_history			# share command history data
setopt hist_find_no_dups		# don't display duplicates in reverse search
setopt hist_reduce_blanks		# remove superfluous blanks
setopt extended_glob			# muh globbing
setopt equals					# use '=' to point to path of an executable
setopt prompt_subst				# expansion
setopt interactivecomments		# comments in the interactive shell
setopt auto_continue			# send CONT signal automatically when disowning jobs
setopt auto_param_slash			# implicit 'cd' if the command is a path
unsetopt correct_all			# don't autocorrect when thefuck does it better
# pushd stuff
# setopt pushd_ignore_dups
# export DIRSTACKSIZE=20
# setopt auto_pushd
# ------------------------------------------------------------------
# HISTORY DATESTAMPS
# ------------------------------------------------------------------
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# ------------------------------------------------------------------
# ZSH_CUSTOM FOLDER
# ------------------------------------------------------------------
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# ==================================================================
# PLUGINS
# ==================================================================

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
 	git
 	sudo
#  	copybuffer
#  	docker
#  	docker-compose
#	enhancd
#  	fzf-zsh-plugin
#	git-flow-completion
#  	jsontools
#  	zsh-autosuggestions
#	zsh-completions
#  	zsh-syntax-highlighting
)

# ==================================================================
# COMPLETION PREFERENCES
# ==================================================================

# CORE COMPLETIONS
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 3 numeric

# # Don't complete backup files as commands
# zstyle ':completion:*:complete:-command-::*' ignored-patterns '*\~'
#
# # USERNAME COMPLETION
# # Delete old definitions
# zstyle -d users
# # For SSH & RSYNC, use remote users set in SSH config, plus root
# zstyle ':completion:*:*:(scp|ssh|rsync):*' users root $(awk '$1 == "User" {print $2}' "$USERDIR"/.ssh/config | sort -u)
# # For everything else, use non-system users from /etc/passwd, plus root
# zstyle ':completion:*:*:*:*' users root $(awk -F: '$3 > 1000 && $3 < 65000 {print $1}' /etc/passwd)
#
# # HOSTNAME COMPLETION
# zstyle ':completion:*' hosts $(grep -h '\.' /etc/hosts)
#
# # URL COMPLETION
# # use URLs from history
# zstyle -e ':completion:*:*:urls' urls 'reply=( ${${(f)"$(grep -E --only-matching \(ftp\|https\?\)://\[A-Za-z0-9\].\* $HISTFILE)"}%%[# ]*} )'
#
# # FILENAME SUFFIXES TO IGNORE
# zstyle ':completion::complete:*:*:files' ignored-patterns '*.o' '*.old' '*.bak' '*.retry' '*~'
# zstyle ':completion::complete:*:*:globbed-files' ignored-patterns '*.o' '*.old' '*.bak' '*.retry' '*~'
# zstyle ':completion::complete:rm:*:globbed-files' ignored-patterns
# zstyle ':completion::complete:emacs:*:globbed-files' ignored-patterns '*.o' '*.old' '*.bak' '*.retry' '*~' '*.asis'
# zstyle '*' single-ignored show
#
# # Finenames to prefer/limit during completion
# zstyle ':completion:*:*:loffice:*' file-patterns '*.(doc|docx|dot|dotx|xls|xlsx|xlt|xltx|odt|ods|csv|tsv|txt):documents *(-/):directories' '%p:all-files'
# zstyle ':completion:*:*:rmdir:*' file-sort time
#
# # CD to never select parent directory
# zstyle ':completion:*:cd:*' ignore-parents parent pwd
#
# # USE CACHE
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "$USERDIR"/.zsh/cache

# ------------------------------------------------------------------
# CASE-SENSITIVE COMPLETION
# ------------------------------------------------------------------
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# ------------------------------------------------------------------
# HYPHEN-SENSITIVE COMPLETION
# ------------------------------------------------------------------
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# ------------------------------------------------------------------
# COMPLETION WAITING DOTS
# ------------------------------------------------------------------
# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# # ==================================================================
# # KEYBINDINGS & FUNCTIONS
# # ==================================================================
#
# # PREFERENCES
# export _ZL_MATCH_MODE=1
# export _ZL_ECHO=0				# my prompt shows the PWD
# export _ZL_NO_CHECK=1			# unmounting and re-mounting drives shouldn't mess up history
#
# # Bind CTRL+Z to "fg" so the same keybind suspends and resumes
# fancy_ctrl_z()
# {
# 	if [[ "$#BUFFER" -eq 0 ]]; then
# 		export BUFFER='fg'
# 		zle accept-line
# 	else
# 		zle push-input
# 		zle clear-screen
# 	fi
# }
# zle -N fancy_ctrl_z
#
# bindkey ' ' magic-space			# history expansion
#
# autoload edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
#
# # copy the active line from the command line buffer
# copybuffer() { printf '%s' "$BUFFER" | wl-copy -n; }
# zle -N copybuffer
# bindkey "^O" copybuffer
#
# # print previous command with ALT-N, where N is the number of arguments
# bindkey -s '\e1' "!:0 \t"
# bindkey -s '\e2' "!:0-1 \t"
# bindkey -s '\e3' "!:0-2 \t"
# bindkey -s '\e4' "!:0-3 \t"
# bindkey -s '\e5' "!:0-4 \t"
# bindkey -s '\e`' "!:0- \t"		# all but the last word
#
# # automatically escape pasted URLs
# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic
#
# # Use fd (https://github.com/sharkdp/fd) instead of the default find
# # command for listing path candidates.
# # The first argument to the function ($1) is the base path to start traversal
# # See the source code (completion.{bash,zsh}) for the details
# _fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1"; }
#
# # Use fd to generate the list for directory completion
# _fzf_compgen_dir() { fd --type d --hidden --follow --exclude ".git" . "$1"; }
#
# # reload the zsh session - from OMZ:plugins/zsh_reload
# zreload()
# {
# 	local cache="$ZSH_CACHE_DIR"
# 	autoload -U compinit zrecompile
# 	compinit -i -d "$cache/zcomp-$HOST"
#
# 	for f in "${ZDOTDIR:-~}/.zshrc" "$cache/zcomp-$HOST"
# 	do
# 		zrecompile -p $f && command rm -f $f.zwc.old
# 	done
#
# 	# use $SHELL if available; remove leading dash if login shell
# 	[[ -n "$SHELL" ]] && exec "${SHELL#-}" || exec zsh
# }

# ------------------------------------------------------------------
# CUSTOM INSULTS
# ------------------------------------------------------------------
# for the bash-insulter plugin
custom_insults=(
	"DAFUQ?!"
	"REEEEEEEEEEEEEEEEEEEEEEEEEE!!!"
	"I'll bite you ..."
	"Once more - in English this time, if you please ..."
	"You're not the sharpest tool in the shed, are you?"
	"Oh, it's DEFINITELY you!"
	"Are you trying to beat your high score today?"
)
# increase the probability of custom insults being used by duplicating them
custom_insults=("${custom_insults[@]}" "${custom_insults[@]}")
custom_insults=("${custom_insults[@]}" "${custom_insults[@]}")
export CMD_NOT_FOUND_MSGS_APPEND=("${custom_insults[@]}" "${custom_insults[@]}")

# ==================================================================
# INCLUDED FILES
# ==================================================================

# Load .zsh_aliases, if available
[[ ! -f "$ZSHDIR"/.zsh_aliases ]] || source "$ZSHDIR"/.zsh_aliases
# Load .zsh_completion, if available
[[ ! -f "$ZSHDIR"/.zsh_completion ]] || source "$ZSHDIR"/.zsh_completion
# Load .zsh_functions, if available
[[ ! -f "$ZSHDIR"/.zsh_functions ]] || source "$ZSHDIR"/.zsh_functions
# Load .zsh_ssh, if available
[[ ! -f "$ZSHDIR"/.zsh_ssh ]] || source "$ZSHDIR"/.zsh_ssh
# Load .zsh_ware, if available
[[ ! -f "$ZSHDIR"/.zsh_ware ]] || source "$ZSHDIR"/.zsh_ware
