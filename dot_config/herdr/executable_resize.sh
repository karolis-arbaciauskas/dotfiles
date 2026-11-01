#!/usr/bin/env bash
# Preserve smart-splits resizing inside Neovim; resize Herdr elsewhere.
set -euo pipefail

herdr="${HERDR_BIN_PATH:-herdr}"
pane="${HERDR_ACTIVE_PANE_ID:-${HERDR_PANE_ID:-}}"
[[ -n "$pane" ]] || exit 0

case "${1:-}" in
  left) key="alt+h" ;;
  down) key="alt+j" ;;
  up) key="alt+k" ;;
  right) key="alt+l" ;;
  *) echo "usage: resize.sh <left|down|up|right>" >&2; exit 2 ;;
esac

# Match the foreground-process detection used by smart-splits' Herdr plugin.
if "$herdr" pane process-info --pane "$pane" |
  jq -e '[.result.process_info.foreground_processes[]?
    | (.name // "") | ascii_downcase
    | select(test("^g?(view|l?n?vim?x?)(diff)?$"))] | length > 0' >/dev/null; then
  exec "$herdr" pane send-keys "$pane" "$key"
fi

# Herdr uses a fraction of the split, not tmux's cell-based resize amount.
exec "$herdr" pane resize --pane "$pane" --direction "$1" --amount 0.05
