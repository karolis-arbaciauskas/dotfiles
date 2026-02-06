#!/bin/bash
set -e

if command -v npm >/dev/null 2>&1; then
  echo "📦 Installing npm packages..."

  # Install base packages
  npm install -g @fsouza/prettierd

  echo "✅ npm packages installed"
else
  echo "❌ npm not installed"
fi
