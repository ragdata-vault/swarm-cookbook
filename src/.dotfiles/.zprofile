#!/usr/bin/env zsh

# ==================================================================
# .ZSH* FILE PROCESSING ORDER:
# .zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout
# ==================================================================

if [[ -d "$USERDIR/.local/bin" ]]; then
	export PATH="$USERDIR/.local/bin:$PATH"
fi
