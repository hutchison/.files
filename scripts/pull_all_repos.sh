#!/usr/bin/env sh

source "$DOTFILES/shell/functions.sh"

function git_origin_repo_has_pattern() {
	local pattern="$1"
	git -C "$dir" remote | grep -q origin && git -C "$dir" remote get-url origin | grep -q "$pattern"
	return $?
}

while getopts p: flag
do
	case "${flag}" in
		p)	pattern=${OPTARG} ;;
	esac
done

for dir in */; do
	if is_git_repo "$dir" ; then
		nr_rem=$( git -C "$dir" remote | wc -l | xargs )

		if [[ $nr_rem > 0 ]]; then
			printf "$dir"
			if [[ -n "$pattern" ]]; then
				if git_origin_repo_has_pattern "$pattern" ; then
					printf " $(git -C "$dir" remote get-url origin)\n"
					git -C "$dir" pull
				fi
			else
				git -C "$dir" pull
			fi
			printf "\n"
		fi
	fi
done
