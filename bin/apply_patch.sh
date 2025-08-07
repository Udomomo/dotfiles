#!/bin/bash
set -eu

REMOTE_REPO="https://github.com/Udomomo/dotfiles"

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

apply_patch() {
  tarball="$REMOTE_REPO/archive/master.tar.gz"
  if is_exists "curl"; then
    curl -L "$tarball" > /tmp/master.tar.gz
  elif is_exists "wget"; then
    wget -O - "$tarball" > /tmp/master.tar.gz
  fi
  tar -xf /tmp/master.tar.gz -C /tmp

  cd "$(dirname "$0")"
  cd ../

  # 調査用にpatchファイルは残したいが、同名で作ると適用済みとみなされるのでsuffixをつける
  PATCH_FILE_SUFFIX=$(date +%s)

  # patchコマンドはパスを含めた名前が短い方に当てようとするので、今いるディレクトリをPWDではなく相対パスで指定している
  diff --exclude=.git -urN . /tmp/dotfiles-master > /tmp/dotfiles_diff_${PATCH_FILE_SUFFIX}.patch || echo "diff has detected"
  patch -u -p0 -d . < /tmp/dotfiles_diff_${PATCH_FILE_SUFFIX}.patch

  # レポジトリから削除したファイルが残ってしまうことがあるため、ダウンロードしたファイルは削除しておく
  rm -rf /tmp/master.tar.gz /tmp/dotfiles-master
}

link() {
  make link
}

apply_patch
link

