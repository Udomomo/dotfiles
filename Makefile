.PHONY: all
all: git vim tmux

.PHONY: git
git:
	ln -snfv ${PWD}/.gitconfig ${HOME}

.PHONY: vim
vim:
	ln -snfv ${PWD}/.vimrc ${HOME}
	curl -o ${HOME}/.vim/colors/iceberg.vim --create-dirs https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim

.PHONY: tmux
tmux:
	ln -snfv ${PWD}/.tmux.conf ${HOME}

.PHONY: zshrc
zshrc:
	ln -snfv ${PWD}/.zshrc ${HOME}

.PHONY: tigrc
tigrc:
	ln -snfv ${PWD}/.tigrc ${HOME}


