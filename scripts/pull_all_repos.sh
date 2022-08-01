#!/usr/bin/env sh

for dir in */; do
	if [[ -d "$dir/.git" ]]; then
		nr_remotes=$(git -C "$dir" remote | wc -l | xargs)
		if [[ $nr_remotes > 0 ]]; then
			echo "$dir"
			git -C "$dir" pull
		fi
	fi
done
