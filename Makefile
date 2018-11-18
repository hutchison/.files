DOTFILES = $(shell pwd)
APT = sudo apt

.PHONY: help \
	clean \
	install install-fonts install-homebrew install-git install-python3 install-vim install-zsh \
	setup setup-git setup-python setup-slate setup-vim setup-zsh

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "    clean \t\t\t to remove all installed configuration"
	@echo
	@echo "    install \t\t\t to install all programs"
	@echo "    install-fonts \t\t to install some fonts"
	@echo "    install-homebrew \t\t to install homebrew and brew-cask"
	@echo "    install-git \t\t to install git"
	@echo "    install-python3 \t\t to install python3"
	@echo "    install-slate \t\t to install slate"
	@echo "    install-vim \t\t to install vim and its submodules"
	@echo "    install-zsh \t\t to install zsh"
	@echo
	@echo "    setup \t\t\t to setup all programs"
	@echo "    setup-git \t\t\t to setup git"
	@echo "    setup-python \t\t to setup python"
	@echo "    setup-slate \t\t to setup slate"
	@echo "    setup-vim \t\t\t to setup vim"
	@echo "    setup-zsh \t\t\t to setup zsh"

install: install-fonts install-homebrew install-git install-python3 install-slate install-vim install-zsh

BREW := $(shell command -v brew 2> /dev/null)
install-homebrew:
ifndef BREW
ifeq ($(shell uname),Darwin)
	@if [ -x $(shell which brew) ]; then echo "Homebrew already installed."; else $(DOTFILES)/scripts/install_homebrew.sh; fi
else
	@echo "We are not on a Mac, so we don't need Homebrew."
endif
endif

CMAKE := $(shell command -v cmake 2> /dev/null)
install-cmake: install-homebrew
ifndef CMAKE
ifeq ($(shell uname),Darwin)
	brew install cmake
else
	$(APT) install -y cmake
endif
endif

GIT := $(shell command -v git 2> /dev/null)
install-git: install-homebrew
ifndef GIT
ifeq ($(shell uname),Darwin)
	brew install git
else
	$(APT) install -y git
endif
endif

PYTHON3 := $(shell command -v python3 2> /dev/null)
install-python3: install-homebrew
ifndef PYTHON3
ifeq ($(shell uname),Darwin)
	brew install python3
else
	$(APT) install -y python3 python3-pip
endif
endif

install-slate: install-homebrew
ifeq ($(shell uname),Darwin)
	brew cask install slate
endif

install-vim: brew-vim install-ycm

# Wenn wir auf einem Mac sind, dann wollen wir vim per Homebrew installieren, auch wenn es schon existiert.
VIM := $(shell command -v vim 2> /dev/null)
brew-vim: install-homebrew install-cmake install-python3 update-submodules
ifeq ($(shell uname),Darwin)
	brew install vim --with-override-system-vi --with-python3
else
ifndef VIM
	$(APT) install -y vim-nox
endif
endif

install-ycm: install-python3 update-submodules
	python3 $(DOTFILES)/vim/bundle/youcompleteme/install.py --clang-completer

ZSH := $(shell command -v zsh 2> /dev/null)
install-zsh: install-homebrew
ifndef ZSH
ifeq ($(shell uname),Darwin)
	brew install zsh
else
	$(APT) install -y zsh
endif
endif

install-fonts: update-submodules
	$(DOTFILES)/fonts/install.sh

update-submodules: install-git
	git submodule update --init --recursive

setup: setup-git setup-python setup-slate setup-vim setup-zsh

setup-git: install-git
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig
	@echo
	@echo "Be sure to change your name and email in every repo that you work on,"
	@echo "unless you want to be named '$(shell git config --get user.name)'."

setup-python: install-python3
	pip3 install --user --upgrade -r "$(DOTFILES)/python/requirements.txt"
	@if [ -d "$(HOME)/.virtualenvs" ]; then echo "~/.virtualenvs already exists"; else mkdir -v "$(HOME)/.virtualenvs"; fi
	@if [ -d "$(HOME)/projects" ]; then echo "~/projects already exists"; else mkdir -v "$(HOME)/projects"; fi

setup-slate:
ifeq ($(shell uname),Darwin)
	ln -fs $(DOTFILES)/slate ~/.slate
endif

setup-vim: install-vim
	rm -f ~/.vim
	ln -fs $(DOTFILES)/vim ~/.vim
	ln -fs $(DOTFILES)/vimrc ~/.vimrc

setup-zsh: install-zsh update-submodules
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
