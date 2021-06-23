#!/bin/bash
set -eu

REMOTE_REPO="https://github.com/Udomomo/dotfiles"
DOTFILE_PATH="$HOME/.dotfiles"

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

download() {
  tarball="$REMOTE_REPO/archive/master.tar.gz"
  if is_exists "curl"; then
    curl -L "$tarball"
  elif is_exists "wget"; then
    wget -O - "$tarball"
  fi | tar -xv
  mv -f dotfiles-master "$DOTFILE_PATH"
}

link() {
  for f in "$DOTFILE_PATH"/.??*; do {
    if [[ $f != "$DOTFILE_PATH/.git" ]] \
    && [[ $f != "$DOTFILE_PATH/.DS_Store" ]] \
    && [[ $f != "$DOTFILE_PATH/.config" ]]; then {
      ln -snfv "$f" "$HOME"
    }
    fi 
  }
  done
}

deploy() {
  download
  link
}

deploy
