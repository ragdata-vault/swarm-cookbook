#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2154
# ==================================================================
# .ZSH* FILE PROCESSING ORDER:
# .zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout
# ==================================================================

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
# THEME
# ------------------------------------------------------------------
# If set to "random", then a random theme will be loaded each time oh-my-zsh is loaded.
# If you need to know which theme was randomly loaded, run: `echo $RANDOM_THEME`
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# ------------------------------------------------------------------
# RANDOM THEMES LIST
# ------------------------------------------------------------------
# List of themes to pick from to load randomly
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this array instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
# AUTO-UPDATE BEHAVIOUR
# ------------------------------------------------------------------
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 14

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
# COMPLETION WAITING DOTS
# ------------------------------------------------------------------
# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# ------------------------------------------------------------------
# UNTRACKED FILES DIRTY
# ------------------------------------------------------------------
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# ------------------------------------------------------------------
# HISTORY DATESTAMPS
# ------------------------------------------------------------------
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# ------------------------------------------------------------------
# ZSH_CUSTOM FOLDER
# ------------------------------------------------------------------
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# ------------------------------------------------------------------
# LOAD SHELDON SOURCES
# ------------------------------------------------------------------
eval "$(sheldon source)"



# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
# 	git
# 	sudo
# 	web-search
# 	copyfile
# 	copybuffer
# 	dirhistory
# 	docker
# 	docker-compose
# 	jsontools
# 	zsh-autosuggestions
# 	zsh-syntax-highlighting
# )

# Uncomment below to load 'Oh My ZSH' on startup
# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nano'
# else
#   export EDITOR='pico'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Uncomment the line below to initialise the ZSH Completion System
# autoload -U compinit; compinit

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Load .zsh_aliases, if available
[[ ! -f "$ZSHDIR"/.zsh_aliases ]] || source "$ZSHDIR"/.zsh_aliases
# Load .zsh_completion, if available
[[ ! -f "$ZSHDIR"/.zsh_completion ]] || source "$ZSHDIR"/.zsh_completion
# Load .zsh_functions, if available
[[ ! -f "$ZSHDIR"/.zsh_functions ]] || source "$ZSHDIR"/.zsh_functions
# Load .zsh_functions, if available
[[ ! -f "$ZSHDIR"/.zsh_ssh ]] || source "$ZSHDIR"/.zsh_ssh
# Load .zsh_functions, if available
[[ ! -f "$ZSHDIR"/.zsh_ware ]] || source "$ZSHDIR"/.zsh_ware
