DOTFILES = $(shell pwd)

zsh:
	ln -Fs $(DOTFILES)/oh-my-zsh ~/.oh-my-zsh
	ln -fs $(DOTFILES)/zshrc ~/.zshrc
