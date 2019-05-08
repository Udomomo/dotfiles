DOTPATH=~/.dotfiles

DOTFILES=(.zshrc .tmux.conf .vimrc)

for f in ${DOTFILES[@]}
do
    ln -snfv $DOTPATH/$f $HOME/$f
done
