#!/bin/bash
set -euo pipefail

if [ -x "$HOME/.pi/agent/bin/pi" ]; then
  echo "✅ Installer-managed Pi already installed (update with: pi update)"
  exit 0
fi

# Homebrew installs Node (including npm) before this script runs.
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  echo "❌ Node.js and npm are required before installing Pi" >&2
  exit 1
fi

if ! node -e 'const [major, minor] = process.versions.node.split(".").map(Number); process.exit(major > 22 || (major === 22 && minor >= 19) ? 0 : 1)'; then
  echo "❌ Pi requires Node.js 22.19 or newer" >&2
  exit 1
fi

echo "📦 Installing Pi using the official installer..."
curl -fsSL https://pi.dev/install.sh | sh
