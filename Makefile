DOTFILES = $(shell pwd)

all: clean zsh git

clean:
	rm ~/.oh-my-zsh
	rm ~/.zshrc
	rm ~/.gitconfig

zsh:
	ln -Ffs $(DOTFILES)/oh-my-zsh ~/.oh-my-zsh
	ln -fs $(DOTFILES)/zshrc ~/.zshrc

git:
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig
