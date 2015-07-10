DOTFILES = $(shell pwd)

.PHONY: clean zsh git vim fonts slate python

all: clean zsh git vim slate python

clean:
	rm -f ~/.oh-my-zsh
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	rm -f ~/.vim
	rm -f ~/.vimrc
	rm -f ~/.slate
	# ein - vor dem Kommando ignoriert eventuelle Fehler:
	-pip3 uninstall -y -r $(DOTFILES)/python/requirements.txt

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

python:
	pip3 install --user --upgrade -r $(DOTFILES)/python/requirements.txt
	-mkdir ~/.virtualenvs
	-mkdir ~/projects

fonts:
	$(DOTFILES)/fonts/install.sh
