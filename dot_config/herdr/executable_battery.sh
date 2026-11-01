#!/usr/bin/env bash
set -euo pipefail

[[ "$(uname -s)" == Darwin ]] || exit 0

/usr/bin/pmset -g batt | /usr/bin/awk '
  /Now drawing from/ { on_ac = ($0 ~ /AC Power/) }
  /[0-9]+%/ {
    if (match($0, /[0-9]+%/)) {
      percent = substr($0, RSTART, RLENGTH)
      # Power source is independent of charging (which macOS can pause).
      if (on_ac) {
        print "⚡ " percent
      } else {
        print "🔋 " percent
      }
      exit
    }
  }
'
