#!/usr/bin/env zsh

split_list=()
for ssh_entry in "${@:2}"; do
	split_list+=( split-pane ssh "$ssh_entry" ';' )
done

tmux new-session ssh "$1" ';' "${split_list[@]}" select-layout tiled ';' # set-option -w synchronize-panes
