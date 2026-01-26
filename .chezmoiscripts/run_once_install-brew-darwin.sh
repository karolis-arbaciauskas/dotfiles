#!/bin/bash
set -e

if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # shell env (Apple Silicon + Intel safe)
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

else
  echo "✅ Homebrew already installed"
fi
