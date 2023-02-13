export PATH="$HOME/.pyenv/shims:$HOME/.nodebrew/current/bin:/usr/local/bin:/usr/local/sbin:./node_modules/.bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gettext/bin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# voltaのPATHを通す
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

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
#alias gfm='git fetch && git merge'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gg='ghq get'
alias gb='git_branch_format | fzf | xargs git checkout'
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpcs='docker-compose ps'
alias k='kubectl'
alias unixtime='date +%s'

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

#rbenvがあれば自動で読み込む
type rbenv >/dev/null && eval "$(rbenv init -)"

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
  gh repo fork $1 --clone
  repo_name=$(echo $1 | sed -E 's/.*\/([^\/\.]+?)(\.git)?$/\1/')
  cd "$repo_name"
  git remote set-url --push upstream no-push
}

# kubectlの自動補完を有効にする
source <(kubectl completion zsh)

