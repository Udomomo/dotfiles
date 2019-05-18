export PATH="$HOME/.pyenv/shims:$HOME/.nodebrew/current/bin:$HOME/node_modules/typescript/bin:/usr/local/opt/go/libexec/bin:$GOPATH/bin:$PATH"
export GOPATH="$HOME/go"

bindkey -e
autoload -Uz compinit; compinit
setopt auto_cd
alias ...='cd ../..'
alias ....='cd ../../..'
alias gc='git clone'
alias gp='git push'
alias gpf='git push --force'
alias gco='git checkout'
alias gfm='git fetch && git merge'
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# C-dしたとき/の手前までしか消えないようにする
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# 起動時にPureを読み込む
fpath+=($fpath "${HOME}/.nodebrew/node/v6.11.4/lib/node_modules/pure-prompt/functions")
autoload -U promptinit; promptinit
prompt pure

# ls時にもsolarizedカラースキームを適用する(GNU版glsを使う)
eval `/usr/local/opt/coreutils/libexec/gnubin/dircolors ~/.dircolors-solarized/dircolors.ansi-dark`
alias ls='gls --color=auto'

# rbenvを自動で読み込む
eval "$(rbenv init -)"

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

# complinit警告を無視する
autoload -U compinit
compinit -u
eval "$(rbenv init -)"

# hubコマンドをgitコマンドでも使えるようにする
function git(){hub "$@"}
