DOTFILES = $(shell pwd)

ifeq ($(shell uname),Darwin)
	PKG_CMD = brew
else
	PKG_CMD = sudo apt
endif
UPDATE = $(PKG_CMD) update
INSTALL = $(PKG_CMD) install

.PHONY: help \
	clean \
	install install-fonts install-homebrew \
	setup setup-git setup-python setup-slate setup-vim setup-zsh

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo
	@echo "    clean \t\t\t to remove all installed configuration"
	@echo
	@echo "    install \t\t\t to install all the things"
	@echo "    \t\t\t\t (homebrew, cmake, git, python3, zsh, curl, wget, vim, slate, fonts)"
	@echo "    install-fonts \t\t to just install some fonts"
	@echo "    install-homebrew \t\t to just install homebrew"
	@echo
	@echo "    setup \t\t\t to setup all programs"
	@echo "    setup-git \t\t\t to setup git"
	@echo "    setup-python \t\t to setup python"
	@echo "    setup-slate \t\t to setup slate"
	@echo "    setup-vim \t\t\t to setup vim"
	@echo "    setup-zsh \t\t\t to setup zsh"

install: install-homebrew bootstrap install-fonts install-ycm

BREW := $(shell command -v brew 2> /dev/null)
install-homebrew:
ifndef BREW
ifeq ($(shell uname),Darwin)
	@if [ -x $(shell which brew) ]; then echo "Homebrew already installed."; else $(DOTFILES)/scripts/install_homebrew.sh; fi
else
	@echo "We are not on a Mac, so we don't need Homebrew."
endif
endif

bootstrap: install-homebrew
	$(UPDATE)
	$(INSTALL) cmake git python3 zsh curl wget
ifeq ($(shell uname),Linux)
	$(INSTALL) python3-pip python3-dev vim-nox
endif
ifeq ($(shell uname),Darwin)
	$(INSTALL) vim --with-override-system-vi --with-python3
	$(PKG_CMD) cask install slate
endif
	git submodule update --init --recursive

install-ycm: bootstrap
	python3 $(DOTFILES)/vim/bundle/youcompleteme/install.py --clang-completer

install-fonts: bootstrap
	$(DOTFILES)/fonts/install.sh

setup: setup-git setup-python setup-slate setup-vim setup-zsh

setup-git: bootstrap
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig
	@echo
	@echo "Be sure to change your name and email in every repo that you work on,"
	@echo "unless you want to be named '$(shell git config --get user.name)'."

setup-python: bootstrap
	pip3 install --user --upgrade -r "$(DOTFILES)/python/requirements.txt"
	@if [ -d "$(HOME)/.virtualenvs" ]; then echo "~/.virtualenvs already exists"; else mkdir -v "$(HOME)/.virtualenvs"; fi
	@if [ -d "$(HOME)/projects" ]; then echo "~/projects already exists"; else mkdir -v "$(HOME)/projects"; fi

setup-slate:
ifeq ($(shell uname),Darwin)
	ln -fs $(DOTFILES)/slate ~/.slate
endif

setup-vim: bootstrap
	rm -f ~/.vim
	ln -fs $(DOTFILES)/vim ~/.vim
	ln -fs $(DOTFILES)/vimrc ~/.vimrc

setup-zsh: bootstrap
	rm -f ~/.oh-my-zsh
	ln -fs $(DOTFILES)/oh-my-zsh ~/.oh-my-zsh
	ln -fs $(DOTFILES)/zshrc ~/.zshrc

clean:
	rm -f ~/.oh-my-zsh
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	rm -f ~/.vim
	rm -f ~/.vimrc
	rm -f ~/.slate
	# ein Minus vor dem Kommando ignoriert eventuelle Fehler:
	-pip3 uninstall -y -r $(DOTFILES)/python/requirements.txt
