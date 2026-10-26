#!/bin/bash
set -e

# Node is managed by mise (~/.config/mise/config.toml)
if command -v mise >/dev/null 2>&1; then
  mise install --yes
  NPM="mise exec -- npm"
elif command -v npm >/dev/null 2>&1; then
  NPM="npm"
else
  echo "❌ npm not installed (install mise or node)"
  exit 0
fi

echo "📦 Installing npm packages..."

# Install base packages
$NPM install -g @fsouza/prettierd
$NPM install -g --ignore-scripts @earendil-works/pi-coding-agent
$NPM install -g markdownlint-cli

echo "✅ npm packages installed"
