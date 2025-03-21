DOTFILES = $(shell pwd)
OS_TYPE := $(shell uname)

.PHONY: help \
	clean \
	update \
	install install-fonts install-homebrew install-fzf install-mac-extras \
	setup setup-git setup-hammerspoon setup-python setup-vim setup-zsh

extra_casks = adobe-acrobat-reader dash ghostty hammerspoon handbrake libreoffice microsoft-remote-desktop \
	obs obsidian rar skim teamviewer transmission viscosity vlc zed zotero
extra_programs = ack ascii bat bison black cbonsai cheat clang-format cmake cmatrix cmus coreutils cowsay \
	csvkit ctags d2 doggo eza fcrackzip fd ffmpeg gcal gettext ghostscript gifski git git-delta \
	git-svn gitui gnupg go gping htop httpie hugo id3lib imagemagick ipython jq libressl minisat \
	mkcert mtr ncdu nmap nyancat openldap openssl@3 overmind pandoc pdftk-java pipdeptree pipenv pwgen \
	qrencode rabbitmq ranger redis ripgrep ruff sc-im sevenzip swi-prolog telnet tidy-html5 tig tmux \
	transmission-cli tree twine typst uv w3m watch wget xq yarn yt-dlp zlib
extra_fonts = font-fira-code font-new-york font-sf-compact font-sf-mono font-sf-mono-for-powerline \
	font-sf-mono-nerd-font-ligaturized font-sf-pro font-victor-mono

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo
	@echo "    clean \t\t\t to remove all installed configuration"
	@echo
	@echo "    update \t\t\t to update this repo in one go"
	@echo "    upgrade-submodules \t\t to upgrade all submodules"
	@echo
	@echo "    install \t\t\t to install all the things"
	@echo "    \t\t\t\t (homebrew, cmake, git, hammerspoon, python3, zsh, curl, wget, vim, fonts)"
	@echo "    install-fonts \t\t to just install some fonts"
	@echo "    install-homebrew \t\t to just install homebrew"
	@echo "    install-mac-extras \t\t to just install a lot of software on a Mac"
	@echo "    * casks: \t\t\t $(extra_casks)"
	@echo "    * programs: \t\t $(extra_programs)"
	@echo "    * fonts: \t\t\t $(extra_fonts)"
	@echo "    install-latex \t\t to install LaTeX"
	@echo
	@echo "    setup \t\t\t to setup all programs (installs nothing, just links config files)"
	@echo "    setup-git \t\t\t to setup git"
	@echo "    setup-hammerspoon \t\t to setup hammerspoon"
	@echo "    setup-python \t\t to setup python"
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
	pkgs_to_install += "pylint"
	pkgs_to_install += "twine"
	pkgs_to_install += "ipython"
	pkgs_to_install += "litecli"
	pkgs_to_install += "yt-dlp"
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

TMUX := $(call is_installed,tmux)
ifndef TMUX
	pkgs_to_install += "tmux"
endif

CHEAT := $(call is_installed,cheat)
ifndef CHEAT
	pkgs_to_install += "cheat"
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
	pkgs_to_install += "hammerspoon"
endif

ifeq "$(OS_TYPE)" "Darwin"
	PKG_CMD = brew
else
	PKG_CMD = sudo apt
endif

BREW_IS_INSTALLED := $(call is_installed,brew)

UPGRADE = $(PKG_CMD) upgrade
INSTALL = $(PKG_CMD) install
ifeq "$(OS_TYPE)" "Darwin"
	INSTALL += --appdir=~/Applications/
endif


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

install-fonts:
	$(DOTFILES)/fonts/install.sh

install-fzf: bootstrap
ifeq "$(OS_TYPE)" "Linux"
	$(INSTALL) fzf
else
	$(DOTFILES)/scripts/fzf/install --bin
endif

install-mac-extras: install-homebrew
ifeq "$(OS_TYPE)" "Darwin"
	$(INSTALL) --cask $(extra_fonts)
	$(INSTALL) --cask $(extra_casks)
	$(INSTALL) $(extra_programs)
endif

install-latex:
	@echo "Cf. https://tug.org/texlive/quickinstall.html"
	@echo "Download and start the installation script,"
	@echo "change the installation directory"
	@echo "and install everything this way."
	@echo "also cf. cheat tex"

setup: setup-git setup-python setup-vim setup-tmux setup-zsh setup-ghostty setup-hammerspoon

setup-ghostty:
ifeq "$(OS_TYPE)" "Darwin"
	mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
	ln -fs $(DOTFILES)/ghostty.config ~/Library/Application\ Support/com.mitchellh.ghostty/config
endif

setup-git:
	ln -fs $(DOTFILES)/gitconfig ~/.gitconfig

setup-hammerspoon:
ifeq "$(OS_TYPE)" "Darwin"
	ln -fs $(DOTFILES)/hammerspoon.lua ~/.hammerspoon/init.lua
endif

setup-python:
	@if [ -d "$(HOME)/projects" ]; then echo "~/projects already exists"; else mkdir -v "$(HOME)/projects"; fi
	@if [ -f "$(HOME)/.pypirc" ]; then echo "~/.pypirc already exists"; else ln -s "$(DOTFILES)/pypirc" "$(HOME)/.pypirc"; fi

setup-tmux:
	ln -fs $(DOTFILES)/tmux.conf ~/.tmux.conf

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
	git submodule foreach "git pull origin master || true"
	git submodule foreach "git pull origin main || true"

clean:
	rm -f ~/.oh-my-zsh
	rm -f ~/.zshrc
	rm -f ~/.gitconfig
	rm -f ~/.hammerspoon
	rm -f ~/.vim
	rm -f ~/.vimrc
	# ein Minus vor dem Kommando ignoriert eventuelle Fehler:
	-pip3 uninstall -y -r $(DOTFILES)/python/requirements.txt
