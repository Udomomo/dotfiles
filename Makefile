HOMEBREW_PREFIX := $(shell brew --prefix)

PHONY: all
all: link install

PHONY: link
link: git vim tmux zshrc tigrc karabiner alacritty homebrew

.PHONY: git
git:
	ln -snfv ${PWD}/.gitconfig ${HOME}

.PHONY: vim
vim:
	mkdir -p ${HOME}/.config/nvim
	ln -snfv ${PWD}/.vimrc ${HOME}
	ln -snfv ${PWD}/.vimrc ${HOME}/.config/nvim/init.vim
	ln -snfv ${PWD}/dein.toml ${HOME}/.config/nvim/dein.toml

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

.PHONY: alacritty
alacritty:
	mkdir -p ${HOME}/.config/alacritty
	ln -snfv ${PWD}/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml

.PHONY: homebrew
homebrew:
	ln -snfv ${PWD}/Brewfile ${HOME}

.PHONY: install
install:
	ln -snfv ${PWD}/Brewfile ${HOME}
	brew bundle
	yes | $(HOMEBREW_PREFIX)/opt/fzf/install

