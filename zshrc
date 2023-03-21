# Ort meiner dotfiles
# "${(%):-%N}" ist das aktuelle Skript
# "readlink" löst eventuelle Softlinks auf (die .zshrc liegt normalerweise in
#   $HOME und ist ein Softlink auf die zshrc im Repo)
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
ZSH_CUSTOM=$DOTFILES/shell/zsh_customizations

# Einstellungen für den fuzzy file finder:
# -L              → Symlinks werden verfolgt und nicht nur gelistet.
# -type f         → es werden nur Dateien gelistet
# ! -iwholename … → diese Dateien werden ignoriert
export FZF_DEFAULT_COMMAND="find -L . -type f ! -iwholename '*.pyc' ! -iwholename '*.git*'"
export FZF_BASE="$DOTFILES/scripts/fzf"
source $FZF_BASE/shell/key-bindings.zsh

# Which plugins would you like to load?
# (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git timer)
if [[ $OSTYPE == darwin* ]]; then
	plugins=(macos $plugins)
fi
if [[ $VENDOR == debian || $VENDOR == ubuntu ]]; then
	plugins=(debian $plugins)
fi
if [[ ! -f "$HOME/.no_ssh-agent_plugin" ]]; then
	plugins=(ssh-agent $plugins)
fi

export TIMER_FORMAT='[%d]'
export TIMER_THRESHOLD=1

# zsh-completions:
if [[ -d "/usr/local/share/zsh-completions" ]]; then
	fpath=(/usr/local/share/zsh-completions $fpath)
fi

export LANG=de_DE.UTF-8

# User configuration

export EDITOR=vim
alias e=$EDITOR

# 'r' wiederholt den letzten Befehl, beißt sich aber mit der Statistiksoftware R
disable r

# Ein # ignoriert den Rest der Zeile
setopt interactivecomments

# Aktiviert extended globbing für filename generation
# For example, the ^ character negates the pattern following it.
# siehe auch http://zsh.sourceforge.net/Intro/intro_2.html
setopt extendedglob

# "The time the shell waits, in hundredths of seconds, for another key to be
# pressed when reading bound multi-character sequences."
# So klein wie möglich, damit man mittels ESC schnell in den vi-command-Modus
# wechseln kann
export KEYTIMEOUT=1

# die Einträge von $path müssen 'unique' sein:
typeset -U path

source $DOTFILES/shell/functions.sh

# Jeder Aufruf von add_to_path fügt den Pfad vorne an $PATH an.
# Heißt: was zuletzt hinzugefügt wurde, steht bei $PATH ganz vorne und wird
# zuerst nach verfügbaren Programmen durchsucht
add_to_path "/usr/sbin"
add_to_path "/usr/local/sbin"
add_to_path "/usr/local/bin"
add_to_path "$HOME/homebrew/bin"
add_to_path "$HOME/texlive/2023/bin/universal-darwin"
add_to_path "/opt/homebrew/bin"
add_to_path "/opt/homebrew/sbin"
add_to_path "$(python3 -m site --user-base)/bin"
add_to_path "$DOTFILES/scripts"
add_to_path "$FZF_BASE/bin"
add_to_path "$HOME/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.local/opt/bin"
add_to_path "$HOME/.cargo/bin"

# In ~/.environment packen wir Einstellungen wie HTTP_PROXY und so:
source_if_exists "$HOME/.environment"

if command_exists xdg-open ; then
	alias open=xdg-open
fi

# Der C-Compiler soll in diesen Ordnern automatisch nach Bibliotheksdateien suchen:
export LIBRARY_PATH="/usr/local/lib"
export LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib"
# Der C-Compiler soll in diesen Ordnern automatisch nach Headerdateien suchen:
export CPATH="/usr/local/include"
export INCLUDE=$CPATH

LDFLAGS="-L/usr/local/lib/"
CPPFLAGS="-I/usr/local/include"
if command_exists brew ; then
	BREW_PREFIX=$(brew --prefix)

	if [[ -d "${BREW_PREFIX}/opt/openssl@3/lib" ]]; then
		LDFLAGS+=" -L${BREW_PREFIX}/opt/openssl@3/lib"
	fi

	if [[ -d "${BREW_PREFIX}/opt/openssl@3/include" ]]; then
		CPPFLAGS+=" -I${BREW_PREFIX}/opt/openssl@3/include"
	fi

	if [[ -d "${BREW_PREFIX}/opt/gettext/lib" ]]; then
		LDFLAGS+=" -L${BREW_PREFIX}/opt/gettext/lib"
	fi

	if [[ -d "${BREW_PREFIX}/opt/gettext/include" ]]; then
		CPPFLAGS+=" -I${BREW_PREFIX}/opt/gettext/include"
	fi
fi
export CPPFLAGS
export LDFLAGS


export REGEX_MATRIKELNUMMER="\d\{7,9\}"

export TWINE_USERNAME=trivialanalog

# Einstellungen für Go (Programmiersprache):
export GOPATH="$HOME/.go"
create_directory_if_not_exists $GOPATH

# Einstellungen für cheat:
# https://github.com/cheat/cheat

export CHEAT_PATH="$DOTFILES/cheats:$DOTFILES/scripts/cheat/cheat/cheatsheets:$DOTFILES/community_cheatsheets"

source $ZSH/oh-my-zsh.sh

# Das vi-mode plugin funktioniert irgendwie nicht, daher nehmen wir den eingebauten:
bindkey -v
# Wichtig ist, dass der nach `source $ZSH/oh-my-zsh.sh` aktiviert, sonst funktioniert es nicht.
# Sehr merkwürdig.

# '?' im vi-command-Modus sucht rückwärts, wie man es von vim gewohnt ist
bindkey -M vicmd '?' history-incremental-search-backward
# CTRL-R sucht auch rückwärts, wie ich es in der Shell gewohnt bin:
bindkey -M viins '^R' fzf-history-widget

# 'K' im vi-command-Modus ruft die manpage auf
bindkey -M vicmd 'K' run-help

# Zur Vorbereitung "dircolors -p > ~/.dircolors" ausführen und dann diese Datenbank anpassen.
# dircolors liest dann die Datenbank und erzeugt daraus Bash-Code.
if [[ -f "$HOME/.dircolors" ]]; then
	if command_exists dircolors ; then
		eval $(dircolors -b "$HOME/.dircolors")
	fi
	if command_exists gdircolors ; then
		eval $(gdircolors -b "$HOME/.dircolors")
	fi
fi

startup_status
