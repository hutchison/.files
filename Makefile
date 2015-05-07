DOTFILES = $(shell pwd)

.PHONY: clean zsh git vim fonts

all: clean zsh git vim

clean:
	rm -f ~/.oh-my-zsh
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	rm -f ~/.vim
	rm -f ~/.vimrc

zsh:
	ln -Ffs $(DOTFILES)/oh-my-zsh ~/.oh-my-zsh
	ln -fs $(DOTFILES)/zshrc ~/.zshrc

git:
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig

vim:
	ln -Fs $(DOTFILES)/vim ~/.vim
	ln -fs $(DOTFILES)/vimrc ~/.vimrc

fonts:
	$(shell $(DOTFILES)/fonts/install.sh)
