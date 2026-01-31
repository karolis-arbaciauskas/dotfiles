if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix)}"
  export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"
  fpath=("$BREW_PREFIX/share/zsh/site-functions" $fpath)
fi
export PATH="$GOPATH/bin:$PATH"
