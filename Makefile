DOTFILES = $(shell pwd)
APTITUDE = sudo aptitude

.PHONY: clean zsh git vim fonts slate python

all: clean zsh git vim slate python

install: install-cmake
	git submodule update --init --recursive
	cd $(DOTFILES)/vim/bundle/youcompleteme; bash install.sh

install-cmake:
ifeq ($(shell uname),Darwin)
	brew install cmake
else
	$(APTITUDE) install -y cmake
endif

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
	pip3 install --user --upgrade -r "$(DOTFILES)/python/requirements.txt"
	@if [ -d "$(HOME)/.virtualenvs" ]; then echo "~/.virtualenvs already exists"; else mkdir -v "$(HOME)/.virtualenvs"; fi
	@if [ -d "$(HOME)/projects" ]; then echo "~/projects already exists"; else mkdir -v "$(HOME)/projects"; fi

fonts:
	$(DOTFILES)/fonts/install.sh
