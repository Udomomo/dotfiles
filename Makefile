HOMEBREW_PREFIX := $(shell brew --prefix)

PHONY: all
all: git vim tmux zshrc tigrc karabiner alacritty fzf homebrew

PHONY: test
test: git vim tmux zshrc tigrc karabiner alacritty fzf

.PHONY: git
git:
	ln -snfv ${PWD}/.gitconfig ${HOME}

.PHONY: vim
vim:
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

# Omit `source ~/.zshrc` since this might be executed on bash too
.PHONY: fzf
fzf:
	brew install fzf
	yes | $(HOMEBREW_PREFIX)/opt/fzf/install

.PHONY: homebrew
homebrew:
	ln -snfv ${PWD}/Brewfile ${HOME}
	brew bundle
