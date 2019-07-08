DOTPATH=${PWD}

DOTFILES=(.zshrc .tmux.conf .vimrc Brewfile)

for f in ${DOTFILES[@]}
do
    ln -snfv $DOTPATH/$f $HOME/$f
done
