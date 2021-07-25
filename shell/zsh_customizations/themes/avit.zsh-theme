# vim: ft=zsh
# AVIT ZSH Theme

PROMPT='
$(_user_host)${_current_dir} $(git_prompt_info)
%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '

PROMPT2='%{$fg[$CARETCOLOR]%}◀%{$reset_color%} '

RPROMPT='$(_vi_status)%{$(echotc UP 1)%}$(_git_time_since_commit) ${_return_status}%{$(echotc DO 1)%}'

local _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%} "
local _return_status="%{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
local _hist_no="%{$fg[grey]%}%h%{$reset_color%}"

function _current_dir() {
	local _max_pwd_length="65"
	if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
		echo "%{$fg_bold[blue]%}%-2~ ... %3~%{$reset_color%} "
	else
		echo "%{$fg_bold[blue]%}%~%{$reset_color%} "
	fi
}

function _user_host() {
	# Wenn ~/.local_hostname existiert, dann wird davon die erste Zeile
	# gelesen und als lokaler Hostname genutzt und angezeigt
	local local_hostname_file="$HOME/.local_hostname"
	if [[ -f "$local_hostname_file" ]]; then
		read local_hostname < $local_hostname_file
		me="%n@%U$local_hostname%u"
	elif [[ -n $SSH_CONNECTION ]]; then
		me="%n@%m"
	elif [[ $LOGNAME != $USER ]]; then
		me="%n"
	fi
	if [[ -n $me ]]; then
		echo "%{$fg[cyan]%}$me%{$reset_color%}:"
	fi
}

function _vi_status() {
	if {echo $fpath | grep -q "plugins/vi-mode"}; then
		echo "$(vi_mode_prompt_info)"
	fi
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
	# Only proceed if there is actually a commit.
	if last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null); then
		now=$(date +%s)
		seconds_since_last_commit=$((now-last_commit))

		# Totals
		minutes=$((seconds_since_last_commit / 60))
		hours=$((seconds_since_last_commit / 3600))
		days=$((seconds_since_last_commit / 86400))
		weeks=$((seconds_since_last_commit / 604800))
		years=$((seconds_since_last_commit / 31536000)) # 365 days

		# Sub-hours and sub-minutes
		sub_hours=$((hours % 24))
		sub_minutes=$((minutes % 60))
		sub_days=$((days % 7))
		sub_weeks=$((weeks % 52))

		if [ $weeks -ge 52 ]; then
			commit_age="${years}y${sub_weeks}w"
		elif [ $days -ge 7 ]; then
			commit_age="${weeks}w${sub_days}d"
		elif [ $hours -ge 24 ]; then
			commit_age="${days}d${sub_hours}h"
		elif [ $minutes -gt 60 ]; then
			commit_age="${sub_hours}h${sub_minutes}m"
		else
			commit_age="${minutes}m"
		fi

		color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
		echo "$color$commit_age%{$reset_color%}"
	fi
}

if [[ $USER == "root" ]]; then
	CARETCOLOR="red"
else
	CARETCOLOR="white"
fi

MODE_INDICATOR="%{$fg_bold[yellow]%}❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"

# LS colors, made with https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'
