#!/bin/sh

# MacOS build version: {{ output "sw_vers" "--buildVersion" }}

# Check for Homebrew and install if we don't have it
if which -s brew; then
    echo 'Homebrew is already installed'
else
  echo '🍺  Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOF
brew "colima"
brew "coreutils"
brew "delve"
brew "fzf"
brew "go"
brew "golangci-lint"
brew "lazydocker"
brew "lazygit"
brew "mas"
brew "neovim"
brew "node"
brew "powerlevel10k"
brew "ripgrep"
brew "serve"
brew "tmux"
brew "xclip"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

cask "1password"
cask "1password-cli"
cask "arc"
cask "font-jetbrains-mono-nerd-font"
cask "ghostty"
cask "obsidian"
cask "postman"
cask "raycast"
cask "tableplus"
cask "the-unarchiver"

# if [ "$IS_WORK_COMPUTER" = "true" ]; then
# cask "slack"
# else
# cask "transmission"
# cask "vlc"
# cask "discord"
# fi


mas "Magnet", id: 441258766
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "Xcode", id: 497799835
EOF
