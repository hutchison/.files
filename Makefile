DOTFILES = $(shell pwd)
OS_TYPE := $(shell uname)

.PHONY: help \
	clean \
	install install-fonts install-homebrew install-fzf \
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
	@echo "    setup-ycm \t\t\t to setup you-complete-me"
	@echo "    setup-zsh \t\t\t to setup zsh"

is_installed = $(shell command -v $(1) 2> /dev/null)
pkgs_to_install =
casks_to_install =

CMAKE := $(call is_installed,cmake)
ifndef CMAKE
	pkgs_to_install += "cmake"
endif

GIT := $(call is_installed,git)
ifndef GIT
	pkgs_to_install += "git"
endif

PYTHON3 := $(call is_installed,python3)
ifndef PYTHON3
	pkgs_to_install += "python3"
endif

ZSH := $(call is_installed,zsh)
ifndef ZSH
	pkgs_to_install += "zsh"
endif

CURL := $(call is_installed,curl)
ifndef CURL
	pkgs_to_install += "curl"
endif

WGET := $(call is_installed,wget)
ifndef WGET
	pkgs_to_install += "wget"
endif

VIM := $(call is_installed,vim)
ifndef VIM
ifeq "$(OS_TYPE)" "Darwin"
	pkgs_to_install += "vim"
endif
ifeq "$(OS_TYPE)" "Linux"
	pkgs_to_install += "vim-nox"
endif
endif

ifeq "$(OS_TYPE)" "Darwin"
SLATE := $(shell brew cask list | grep slate)
ifndef SLATE
	casks_to_install += "slate"
endif
endif

ifeq "$(OS_TYPE)" "Darwin"
	PKG_CMD = brew
else
	PKG_CMD = sudo apt
endif

BREW := $(call is_installed,brew)

UPGRADE = $(PKG_CMD) upgrade
INSTALL = $(PKG_CMD) install

install: install-homebrew bootstrap install-fonts install-fzf

install-homebrew:
ifeq "$(OS_TYPE)" "Darwin"
ifndef BREW
	$(DOTFILES)/scripts/install_homebrew.sh
endif
endif

bootstrap: install-homebrew
	$(UPGRADE)
ifneq "$(strip $(pkgs_to_install))" ""
	$(INSTALL) $(pkgs_to_install)
endif
ifeq "$(OS_TYPE)" "Linux"
	$(INSTALL) python3-pip python3-dev
endif
ifeq "$(OS_TYPE)" "Darwin"
ifneq "$(strip $(casks_to_install))" ""
	$(PKG_CMD) cask install $(casks_to_install)
endif
endif
	git submodule update --init --recursive

install-fonts: bootstrap
	$(DOTFILES)/fonts/install.sh

install-fzf: bootstrap
	$(DOTFILES)/scripts/fzf/install --bin

setup: setup-git setup-python setup-slate setup-vim setup-tmux setup-zsh

setup-git: bootstrap
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig
	@echo
	@echo "Be sure to change your name and email in every repo that you work on,"
	@echo "unless you want to be named '$(shell git config --get user.name)'."

setup-python: bootstrap
	pip3 install --user --upgrade -r "$(DOTFILES)/python/requirements.txt"
	@if [ -d "$(HOME)/.virtualenvs" ]; then echo "~/.virtualenvs already exists"; else mkdir -v "$(HOME)/.virtualenvs"; fi
	@if [ -d "$(HOME)/projects" ]; then echo "~/projects already exists"; else mkdir -v "$(HOME)/projects"; fi

setup-tmux:
	ln -fs $(DOTFILES)/tmux.conf ~/.tmux.conf

setup-slate:
ifeq "$(OS_TYPE)" "Darwin"
	ln -fs $(DOTFILES)/slate ~/.slate
endif

setup-vim: bootstrap
	rm -f ~/.vim
	ln -fs $(DOTFILES)/vim ~/.vim
	ln -fs $(DOTFILES)/vimrc ~/.vimrc

setup-ycm:
	python3 $(DOTFILES)/vim/bundle/youcompleteme/install.py --clang-completer

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
