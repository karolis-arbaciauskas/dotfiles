# Brew-managed zsh plugins (avoid repeated `brew --prefix` at startup)
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix)}"
  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

autoload -Uz compinit
compinit -C
