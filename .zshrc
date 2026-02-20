export PATH="$HOME/.pyenv/shims:$HOME/.nodebrew/current/bin:/usr/local/bin:/usr/local/sbin:./node_modules/.bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gettext/bin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# .zsh.dディレクトリ以下の.zshファイルを読み込む
ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

# PATHの重複を削除する
typeset -U PATH

# zshのコマンドラインで特殊文字を引数として使えるようにする
setopt nonomatch

# voltaのPATHを通す
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ghqを使うためgoが必要
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# homebrewのauto_updateを止める
export HOMEBREW_NO_AUTO_UPDATE=1

bindkey -e
autoload -Uz compinit; compinit
setopt auto_cd

# エイリアス
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ...='cd ../..'
alias ....='cd ../../..'
alias gco='git checkout'
alias gp='git push origin -u HEAD'
alias gpr='git pull --rebase'
alias unixtime='date +%s'
alias vim='nvim'

setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# C-dしたとき/の手前までしか消えないようにする
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Homebrew経由でインストールしたpureにパスを通す
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

# ls時にもicebergカラースキームを適用する
alias ls='ls -G'

# branch一覧を*なしで出力する
function git_branch_format() {
  git branch --format '%(refname:lstrip=2)'
}

# cdしたとき自動でlsする
function chpwd() {
  if [ `ls -Al | wc -l` -eq 0 ]; then
    echo "\n\nempty directory";
  else
    echo ""
    ls
  fi
}

# mkcdコマンドでmkdirとcdを同時に行う
function mkcd() { 
  mkdir -p $1 && cd $1;
}

# コマンド履歴の最大記録数
HISTSIZE=10000

# tmuxの別セッションでも履歴を共有する
setopt share_history

# 特定のコマンドは履歴に記録しない
export HISTORY_IGNORE="cd|mkcd|pwd|l[sal]|nvim|vim"

# 失敗したコマンドは履歴に残さない
precmd() {
    cmd_status=$?
    if [[ $cmd_status != 0 ]]; then
      print -sr -- "$cmd"
      fc -W
      return 0
    else 
      return 1
    fi
}

# repository search by fzf and ghq
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^G' fzf-src

# fzf command history
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# fzf directory history
function fzf-select-dir-history() {
  local selected_dir=$(dirs -p | fzf --query "$LBUFFER" --reverse)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-select-dir-history
setopt noflowcontrol
bindkey '^q' fzf-select-dir-history

# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# command to fork repo
function gfork () {
  cd $(ghq root)/github.com/Udomomo
  gh repo fork $1 --clone
  repo_name=$(echo $1 | sed -E 's/.*\/([^\/\.]+?)(\.git)?$/\1/')
  cd "$repo_name"
  git remote set-url --push upstream no-push
}

# Load Angular CLI autocompletion.
source <(ng completion script)

# zoxide (advanced cd) の設定。cdコマンドを置き換える。
eval "$(zoxide init zsh --cmd cd)"
