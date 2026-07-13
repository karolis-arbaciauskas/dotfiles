#!/bin/bash
set -e

if command -v brew >/dev/null 2>&1; then
  # Homebrew requires explicit trust for formulae from non-official taps.
  if grep -Fq 'tap "atlassian/homebrew-acli"' "$HOME/.Brewfile"; then
    brew trust --tap atlassian/acli
  fi

  echo "📦 Syncing Homebrew packages..."
  brew bundle --file="$HOME/.Brewfile"

  # Non-fatal sanity check (often fails if App Store login / `mas` isn't ready yet)
  if ! brew bundle check --file="$HOME/.Brewfile"; then
    echo "⚠️  brew bundle check reported issues"
  fi
else
  echo "❌ Homebrew not installed"
fi
