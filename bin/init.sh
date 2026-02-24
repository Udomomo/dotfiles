#!/bin/bash
set -eu

REMOTE_REPO="https://github.com/Udomomo/dotfiles"
DOTFILE_PATH="$HOME/dotfiles"

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
  mv dotfiles-master/* "$DOTFILE_PATH"
}

link() {
  make link
}

homebrew() {
  which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  UNAME_MACHINE="$(/usr/bin/uname -m)"
  if [[ "${UNAME_MACHINE}" == "arm64" ]]
  then 
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

deploy() {
  cd `dirname $0`
  # Skip download if already cloned dotfiles repo via git command
  if [ -d "../.git" ]; then
    cd ../
    link
    homebrew
  else
    download
    link
    homebrew
  fi
}

deploy
