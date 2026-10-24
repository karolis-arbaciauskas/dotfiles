#!/usr/bin/env bash
set -euo pipefail

# Compile once, then query macOS directly without starting Swift each refresh.
[[ "$(uname -s)" == Darwin ]] || exit 0
source_file="$(cd -- "$(dirname -- "$0")" && pwd)/input-source.swift"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/tmux"
helper="$cache_dir/input-source"

if [[ ! -x "$helper" || "$source_file" -nt "$helper" ]]; then
  mkdir -p "$cache_dir"
  build_dir=$(mktemp -d "$cache_dir/input-source.XXXXXX")
  trap 'rm -rf "$build_dir"' EXIT
  /usr/bin/swiftc -O "$source_file" -o "$build_dir/input-source" 2>/dev/null || exit 0
  mv -f "$build_dir/input-source" "$helper"
fi

"$helper" 2>/dev/null || true
