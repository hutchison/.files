# Ort meiner dotfiles
# "${(%):-%N}" ist das aktuelle Skript
# "readlink" löst eventuelle Softlinks auf (die .zshrc liegt normalerweise in $HOME und ist ein Softlink auf die zshrc im Repo)
# "dirname" gibt uns das gesuchte Verzeichnis
export DOTFILES=$(dirname $(readlink "${(%):-%N}"))

# Path to your oh-my-zsh installation.
export ZSH=$DOTFILES/oh-my-zsh

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
plugins=(git brew brew-cask pip pylint vagrant vi-mode ssh-agent osx)

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
add_to_path() {
	if [[ -d "$1" ]]; then
		path=("$1" $path)
	fi
}

add_to_path "/usr/local/bin"
add_to_path "/usr/sbin"
add_to_path "/usr/local/sbin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/Library/Python/3.6/bin"
add_to_path "$HOME/bin"
add_to_path "/usr/local/texlive/2014/bin/x86_64-darwin"
add_to_path "/usr/local/opt/bison/bin"
add_to_path "/usr/local/opt/flex/bin"

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

function command_exists() {
	command -v $1 > /dev/null 2>&1
}

if command_exists sudoedit ; then
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

if command_exists fzf ; then
	function f() {
		e $(fzf)
	}
fi

if command_exists youtube-dl ; then
	function youtube-mp3 () {
		youtube-dl -x --audio-format mp3 $@
	}
fi

if command_exists iconv ; then
	function latin1_to_utf8 () {
		filename=$(basename "$1")
		extension="${filename##*.}"
		filename="${filename%.*}"

		iconv -f latin1 -t utf8 "$1" > "$filename"_utf8."$extension"
	}

	function utf8_to_latin1 () {
		filename=$(basename "$1")
		extension="${filename##*.}"
		filename="${filename%.*}"

		iconv -f utf8 -t latin1 "$1" > "$filename"_latin1."$extension"
	}
fi

if [[ $(uname) = "Darwin" ]]; then
	function einschlafen() {
		sudo shutdown -s +"$1"
	}
fi

# Ein # ignoriert den Rest der Zeile:
setopt interactivecomments

# virtualenvwrapper:
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENV_PYTHON=$VIRTUALENVWRAPPER_PYTHON
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
if command_exists virtualenvwrapper.sh ; then
	source $(which virtualenvwrapper.sh)
fi

# Der C-Compiler soll in diesen Ordnern automatisch nach Headerdateien suchen:
export CPATH="/usr/local/include:/usr/local/opt/openssl/include:/usr/local/opt/gettext/include"
export INCLUDE=$CPATH
# Der C-Compiler soll in diesen Ordnern automatisch nach Bibliotheksdateien suchen:
export LIBRARY_PATH="/usr/local/lib:/usr/local/opt/openssl/lib:/usr/local/opt/gettext/lib"
export LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib"

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
	if command_exists landscape-sysinfo ; then
		echo
		landscape-sysinfo --exclude-sysinfo-plugins=LandscapeLink | sed 's/^\s*/\t/'
	fi
}

function my_screenfetch () {
	screenfetch_cmd="$DOTFILES/scripts/screenfetch/screenfetch-dev"
	if [[ -x $screenfetch_cmd ]]; then
		$screenfetch_cmd
	fi
}

function path_status () {
	print -P -- "\t%F{004}aktueller Pfad:%f"
	echo $PATH | tr -s ':' '\n' | awk '{print "\t"$0 }'
}

function create_directory_if_not_exists() {
	if [[ ! -d $1 ]]; then
		mkdir -p $1
	fi
}

function is_mounted() {
	mount | grep -q "^$1"
}

SSH_CONFIG="$HOME/.ssh/config"

function get_ssh_hostname() {
	local HOST=$1

	ssh -G $HOST | awk '/^hostname / {print $2}'
}

function get_ssh_port() {
	local HOST=$1

	ssh -G $HOST | awk '/^port / {print $2}'
}

function is_reachable() {
	if command_exists netcat ; then
		local HOST=$1
		local PORT=$2

		netcat -w 3 -z $HOST $PORT > /dev/null 2>&1
	fi
}

function mount_sshfs() {
	local SOURCE="$1"
	# ${stringvar%%:*} löscht aus $stringvar die Regex :* von hinten weg
	local HOST=${SOURCE%%:*}
	local HOSTNAME=$(get_ssh_hostname "$HOST")
	local PORT=$(get_ssh_port "$HOST")
	local TARGET="$2"

	if grep -q "$HOST" $SSH_CONFIG ; then

		create_directory_if_not_exists $TARGET

		if ! is_mounted $SOURCE ; then
			if is_reachable $HOSTNAME $PORT; then
				print -P -- "\t%F{002}✓%f $SOURCE → $TARGET"
				sshfs -p $PORT $SOURCE $TARGET
			else
				print -P -- "\t%F{001}✗%f $HOST ($HOSTNAME:$PORT) seems down"
			fi
		else
			print -P -- "\t%F{002}✓%f $SOURCE already mounted"
		fi
	else
		print -P -- "\t%F{001}✗%f $HOST ∉ $SSH_CONFIG"
	fi
}

function mount_stuff () {
	if [[ -e $SSH_CONFIG ]]; then
		echo
		print -P -- "\t%F{004}custom mounts:%f"

		mount_sshfs "joerdis:/home/md" "$HOME/mnt/joerdis"
		mount_sshfs "marquis:/home/md" "$HOME/mnt/marquis"
		mount_sshfs "muenster:" "$HOME/mnt/muenster"
	fi
}

function startup_status () {
	clear
	my_screenfetch
	path_status
	landscape_status
	virtualenvwrapper_status
	apache_status
}

function mcal () {
	gcal -i -K -s 1 $1
}

startup_status
