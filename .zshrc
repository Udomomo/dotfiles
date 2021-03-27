export PATH="$HOME/.pyenv/shims:$HOME/.nodebrew/current/bin:/usr/local/Cellar/vim/8.0.1250/bin:/usr/local/opt/git/bin:/usr/local/bin:/usr/local/sbin:$HOME/Library/Android/sdk/platform-tools:./node_modules/.bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gettext/bin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/mysql@5.7/bin:$HOME/apache-cassandra-3.11.4/bin:$PATH"
export NODE_PATH=$(npm root -g)

# ghqを使うためgoが必要
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

bindkey -e
autoload -Uz compinit; compinit
setopt auto_cd

# .zsh.dディレクトリ以下の.zshファイルを読み込む
ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

# エイリアス
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ...='cd ../..'
alias ....='cd ../../..'
alias gco='git checkout'
alias gp='git push'
alias gpf='git push --force'
alias gl='git log'
alias gfm='git fetch && git merge'
alias gr='git rebase'
alias gg='ghq get'

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

HISTSIZE=1000

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

# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# command to fork repo
function gfork () {
  cd $(ghq root)/github.com/Udomomo
  gh repo fork $1
  repo_name=$(echo $1 | sed -E 's/.*\/([^\/\.]+?)(\.git)?$/\1/')
  cd "$repo_name"
  git remote set-url --push upstream no-push
}

# kubectlの自動補完を有効にする
source <(kubectl completion zsh)

