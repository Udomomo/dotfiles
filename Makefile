HOMEBREW_PREFIX := $(shell brew --prefix)

PHONY: all
all: git vim tmux zshrc tigrc karabiner fzf homebrew

PHONY: test
test: git vim tmux zshrc tigrc karabiner fzf

.PHONY: git
git:
	ln -snfv ${PWD}/.gitconfig ${HOME}

.PHONY: vim
vim:
	ln -snfv ${PWD}/.vimrc ${HOME}
	curl -o ${HOME}/.vim/colors/iceberg.vim --create-dirs https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim
	mkdir -p ${HOME}/.config/nvim/colors
	ln -snfv ${PWD}/.vimrc ${HOME}/.config/nvim/init.vim
	cp ${HOME}/.vim/colors/iceberg.vim ${HOME}/.config/nvim/colors


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

# Omit `source ~/.zshrc` since this might be executed on bash too
.PHONY: fzf
fzf:
	brew install fzf
	yes | $(HOMEBREW_PREFIX)/opt/fzf/install

.PHONY: homebrew
homebrew:
	ln -snfv ${PWD}/Brewfile ${HOME}
	brew bundle
