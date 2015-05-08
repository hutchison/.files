DOTFILES = $(shell pwd)

.PHONY: clean zsh git vim fonts slate

all: clean zsh git vim slate

clean:
	rm -f ~/.oh-my-zsh
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	rm -f ~/.vim
	rm -f ~/.vimrc
	rm -f ~/.slate

zsh:
	ln -Ffs $(DOTFILES)/oh-my-zsh ~/.oh-my-zsh
	ln -fs $(DOTFILES)/zshrc ~/.zshrc

git:
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig

vim:
	ln -Fs $(DOTFILES)/vim ~/.vim
	ln -fs $(DOTFILES)/vimrc ~/.vimrc

slate:
	ln -fs $(DOTFILES)/slate ~/.slate

fonts:
	$(DOTFILES)/fonts/install.sh
