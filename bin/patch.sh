#!/bin/bash
set -eu

REMOTE_REPO="https://github.com/Udomomo/dotfiles"

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

patch() {
  tarball="$REMOTE_REPO/archive/master.tar.gz"
  if is_exists "curl"; then
    curl -L "$tarball" > /tmp/master.tar.gz
  elif is_exists "wget"; then
    wget -O - "$tarball" > /tmp/master.tar.gz
  fi
  tar -xf /tmp/master.tar.gz -C /tmp

  cd "$(dirname "$0")"
  cd ../
  
  diff --exclude=.git -urN ${PWD} /tmp/dotfiles-master > /tmp/dotfiles_diff.patch
  patch -u -p 3 -d ${PWD} < /tmp/dotfiles_diff.patch 
}

link() {
  make link
}

patch
link

