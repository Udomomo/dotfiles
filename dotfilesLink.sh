DOTPATH=${PWD}

DOTFILES=(.zshrc .tmux.conf .vimrc .tigrc Brewfile .tigrc)

for f in ${DOTFILES[@]}
do
    ln -snfv $DOTPATH/$f $HOME/$f
done
