DOTPATH=${PWD}

DOTFILES=(.zshrc .tmux.conf .vimrc Brewfile .tigrc .gitconfig)

for f in ${DOTFILES[@]}
do
    ln -snfv $DOTPATH/$f $HOME/$f
done
