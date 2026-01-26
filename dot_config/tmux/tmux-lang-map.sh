#!/usr/bin/env bash
set -euo pipefail

# Prints current input source/keyboard layout name (best-effort).
# Used by tmux status; should never block tmux.

if command -v defaults >/dev/null 2>&1; then
  # macOS: e.g. "com.apple.keylayout.US" -> "US"
  layout=$(defaults read -g AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null || true)
  layout=${layout##*.}
  if [[ -n "${layout:-}" ]]; then
    printf '%s' "$layout"
    exit 0
  fi
fi

exit 0
