PHONY: all
all: homebrew git vim tmux zshrc tigrc karabiner

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

.PHONY: karabiner
karabiner:
	mkdir -p ${HOME}/.config/karabiner
	ln -snfv ${PWD}/.config/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json

.PHONY: fzf
fzf:
	yes | $(brew --prefix)/opt/fzf/install
	source ~/.zshrc

.PHONY: homebrew
homebrew:
	ln -snfv ${PWD}/Brewfile ${HOME}
	brew bundle
	brew autoupdate --start --cleanup --enable-notification


