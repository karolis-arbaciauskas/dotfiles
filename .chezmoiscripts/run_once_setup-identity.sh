#!/usr/bin/env bash
set -e

KEY_NAME="GitHub SSH Key"
VAULT="Private"

# Check if key exists in 1Password
if ! op item get "$KEY_NAME" >/dev/null 2>&1; then
  echo "🔐 Creating SSH key in 1Password..."
  op ssh generate --title "$KEY_NAME" --vault "$VAULT"
else
  echo "✅ SSH key already exists in 1Password"
fi

# Print public key for GitHub setup
echo ""
echo "👉 Add this public key to GitHub:"
op item get "$KEY_NAME" --fields label=public_key
