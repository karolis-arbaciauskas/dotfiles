# Starship prompt
eval "$(starship init zsh)"

# mise
eval "$(mise activate zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf + rg + fd
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
