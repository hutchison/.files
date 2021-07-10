DOTFILES = $(shell pwd)
OS_TYPE := $(shell uname)

.PHONY: help \
	clean \
	update \
	install install-fonts install-homebrew install-fzf install-mac-extras \
	setup setup-git setup-python setup-slate setup-vim setup-zsh

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo
	@echo "    clean \t\t\t to remove all installed configuration"
	@echo
	@echo "    update \t\t\t to update this repo in one go"
	@echo "    upgrade-submodules \t\t\t to upgrade all submodules"
	@echo
	@echo "    install \t\t\t to install all the things"
	@echo "    \t\t\t\t (homebrew, cmake, git, python3, zsh, curl, wget, vim, slate, fonts)"
	@echo "    install-fonts \t\t to just install some fonts"
	@echo "    install-homebrew \t\t to just install homebrew"
	@echo "    install-mac-extras \t\t to just install some software on a Mac"
	@echo
	@echo "    setup \t\t\t to setup all programs (installs nothing, just links config files)"
	@echo "    setup-git \t\t\t to setup git"
	@echo "    setup-python \t\t to setup python"
	@echo "    setup-slate \t\t to setup slate"
	@echo "    setup-vim \t\t\t to setup vim"
	@echo "    setup-zsh \t\t\t to setup zsh"

is_installed = $(shell command -v $(1) 2> /dev/null)
pkgs_to_install =

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
SLATE := $(shell brew list | grep slate)
ifndef SLATE
	pkgs_to_install += "slate"
endif
endif

ifeq "$(OS_TYPE)" "Darwin"
	PKG_CMD = brew
else
	PKG_CMD = sudo apt
endif

BREW_IS_INSTALLED := $(call is_installed,brew)

UPGRADE = $(PKG_CMD) upgrade
INSTALL = $(PKG_CMD) install

install: install-homebrew bootstrap install-fonts install-fzf

install-homebrew:
ifeq "$(OS_TYPE)" "Darwin"
ifndef BREW_IS_INSTALLED
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
	pip3 install --user --upgrade -r "$(DOTFILES)/python/requirements.txt"
	git submodule update --init --recursive

install-fonts: bootstrap
	$(DOTFILES)/fonts/install.sh

install-fzf: bootstrap
ifeq "$(OS_TYPE)" "Linux"
	$(INSTALL) fzf
else
	$(DOTFILES)/scripts/fzf/install --bin
endif

install-mac-extras: install-homebrew
ifeq "$(OS_TYPE)" "Darwin"
	$(INSTALL) --cask google-chrome basictex viscosity zotero vlc
endif


setup: setup-git setup-python setup-slate setup-vim setup-tmux setup-zsh

setup-git:
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig

setup-python:
	@if [ -d "$(HOME)/projects" ]; then echo "~/projects already exists"; else mkdir -v "$(HOME)/projects"; fi
	@if [ -d "$(HOME)/.pypirc" ]; then echo "~/.pypirc already exists"; else ln -s "$(DOTFILES)/pypirc" "$(HOME)/.pypirc"; fi

setup-tmux:
	ln -fs $(DOTFILES)/tmux.conf ~/.tmux.conf

setup-slate:
ifeq "$(OS_TYPE)" "Darwin"
	ln -fs $(DOTFILES)/slate ~/.slate
endif

setup-vim:
	rm -f ~/.vim
	ln -fs $(DOTFILES)/vim ~/.vim
	ln -fs $(DOTFILES)/vimrc ~/.vimrc

setup-zsh:
	rm -f ~/.oh-my-zsh
	ln -fs $(DOTFILES)/oh-my-zsh ~/.oh-my-zsh
	ln -fs $(DOTFILES)/zshrc ~/.zshrc

update:
	git pull origin master
	git submodule update --init --recursive

upgrade-submodules:
	git submodule foreach git pull origin master

clean:
	rm -f ~/.oh-my-zsh
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	rm -f ~/.vim
	rm -f ~/.vimrc
	rm -f ~/.slate
	# ein Minus vor dem Kommando ignoriert eventuelle Fehler:
	-pip3 uninstall -y -r $(DOTFILES)/python/requirements.txt
