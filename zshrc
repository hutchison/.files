# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew brew-cask pip pylint vagrant vi-mode)

# zsh-completions:
if [[ -d "/usr/local/share/zsh-completions" ]]; then
	fpath=(/usr/local/share/zsh-completions $fpath)
fi

# User configuration

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd 'K' run-help
export KEYTIMEOUT=1

# die Einträge von $path müssen 'unique' sein:
typeset -U path

# überprüfe die Existenz von Verzeichnissen und füge sie zu $path hinzu
if [[ -d "/usr/sbin" ]]; then
	path=("/usr/sbin" $path)
fi
if [[ -d "/usr/local/sbin" ]]; then
	path=("/usr/local/sbin" $path)
fi
if [[ -d "/usr/local/bin" ]]; then
	path=("/usr/local/bin" $path)
fi
if [[ -d "$HOME/.local/bin" ]]; then
	path=("$HOME/.local/bin" $path)
fi
if [[ -d "$HOME/bin" ]]; then
	path=("$HOME/bin" $path)
fi
if [[ -d "$HOME/Library/Python/3.5/bin" ]]; then
	path=("$HOME/Library/Python/3.5/bin" $path)
fi
if [[ -d "/usr/local/texlive/2014/bin/x86_64-darwin" ]]; then
	path=("/usr/local/texlive/2014/bin/x86_64-darwin" $path)
fi

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=de_DE.UTF-8

# In ~/.environment packen wir Einstellungen wie HTTP_PROXY und so:
if [[ -f "$HOME/.environment" ]]; then
	source $HOME/.environment
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR=vim
alias e=$EDITOR
if [[ -x $(which sudoedit) ]]; then
	alias se=sudoedit
else
	alias se='sudo -e'
fi

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

function gim () {
	vim $(git ls-files -m) -p
}

# Ein # ignoriert den Rest der Zeile:
setopt interactivecomments

# virtualenvwrapper:
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENV_PYTHON=$VIRTUALENVWRAPPER_PYTHON
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
if [[ -x $(which virtualenvwrapper.sh) ]]; then
	source $(which virtualenvwrapper.sh)
fi

# Der C-Compiler soll in diesen Ordnern automatisch nach Headerdateien suchen:
export CPATH="/usr/local/include:/usr/local/opt/openssl/include:/usr/local/opt/gettext/include"
export INCLUDE=$CPATH
# Der C-Compiler soll in diesen Ordnern automatisch nach Bibliotheksdateien suchen:
export LIBRARY_PATH="/usr/local/lib:/usr/local/opt/openssl/lib:/usr/local/opt/gettext/lib"

function virtualenvwrapper_status () {
	if [[ -n $VIRTUALENVWRAPPER_WORKON_CD ]]; then
		echo
		print -P -- "\tvirtualenvwrapper: %F{002}✓%f"
		print -P -- "\t%F{004}Python:%f\t\t$VIRTUALENVWRAPPER_PYTHON"
		print -P -- "\t%F{004}virt. Envs:%f\t$WORKON_HOME"
		print -P -- "\t%F{004}Projekte:%f\t$PROJECT_HOME"
		if [[ -n "$(workon)" ]]; then
			print -P -- "\t%F{004}aktuelle Projekte:%f"
			echo -n "\t"
			workon | paste -s -
		fi
	fi
}

function apache_status () {
	if [[ $(curl -sI localhost | grep "Server") =~ "Apache" ]]; then
		echo
		print -P -- "\tlokaler Apache: %F{002}✓%f"
	fi
}

function landscape_status () {
	if [[ -x $(which landscape-sysinfo) ]]; then
		echo
		landscape-sysinfo --exclude-sysinfo-plugins=LandscapeLink | sed 's/^\s*/\t/'
	fi
}

function path_status () {
	print -P -- "\t%F{004}aktueller Pfad:%f"
	echo $PATH | tr -s ':' '\n' | awk '{print "\t"$0 }'
}

function startup_status () {
	clear
	if [[ $(command -v "archey") ]]; then
		archey
	elif [[ $(command -v "screenfetch") ]]; then
		screenfetch
	fi
	path_status
	landscape_status
	virtualenvwrapper_status
	apache_status
}

startup_status
