export PATH="$HOME/.pyenv/shims:/usr/local/Cellar/vim/8.0.1250/bin:/usr/local/opt/git/bin:/usr/local/bin:/usr/local/sbin:$HOME/Library/Android/sdk/platform-tools:./node_modules/.bin:/usr/local/opt/gettext/bin:$PATH"
export NODE_PATH=$(npm root -g)

# Cassandra起動用にJavaバージョンを1.8にしておく
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_131`

bindkey -e
autoload -Uz compinit; compinit
setopt auto_cd

# エイリアス
alias ...='cd ../..'
alias ....='cd ../../..'
alias gco='git checkout'
alias gp='git push'
alias gpf='git push --force'
alias gl='git log'
alias gfm='git fetch && git merge'
alias gr='git rebase'

setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# C-dしたとき/の手前までしか消えないようにする
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

autoload -U promptinit; promptinit
prompt pure

# ls時にもicebergカラースキームを適用する
alias ls='ls -G'

#rbenvがあれば自動で読み込む
type rbenv >/dev/null && eval "$(rbenv init -)"

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

# command history search by peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

HISTSIZE=1000

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi

# hubコマンドをgitコマンドでも使えるようにする
function git(){hub "$@"}
