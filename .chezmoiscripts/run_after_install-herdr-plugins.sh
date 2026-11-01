#!/bin/bash
set -euo pipefail

# The Neovim directory is a chezmoi git-repo external and cannot also contain
# managed files. Link the managed overlay after the external has been installed.
overlay="$HOME/.config/herdr/nvim.lua"
link="$HOME/.config/nvim/after/plugin/herdr.lua"
if [[ -d "$HOME/.config/nvim" && -f "$overlay" ]]; then
  mkdir -p "$(dirname "$link")"
  if [[ ! -e "$link" && ! -L "$link" ]]; then
    ln -s "$overlay" "$link"
  elif [[ ! -L "$link" || "$(readlink "$link")" != "$overlay" ]]; then
    echo "Refusing to overwrite existing Neovim config: $link" >&2
    exit 1
  fi
fi

# Run after the Brew bundle script, including on fresh machines.
if command -v herdr >/dev/null 2>&1; then
  plugins="$(herdr plugin list 2>&1)"
  if ! grep -Fq 'smart-splits-backend-herdr' <<< "$plugins"; then
    herdr plugin install --yes adriankarlen/smart-splits-backend-herdr
  fi
  if ! grep -Fq 'herdr-bar (' <<< "$plugins"; then
    herdr plugin install --yes jeffarese/herdr-bar
  fi
fi
