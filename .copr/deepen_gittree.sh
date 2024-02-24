#! /bin/bash

if [[ -e .git/shallow ]]; then
	# for stable branches ensure the history is deep enough to include the branch point as
	# otherwise git will mess up when looking up changes for Patchlist.changelog generation
	current_branch=$(git rev-parse --abbrev-ref HEAD)
	if [[ "${current_branch}" != "${current_branch#ark-vanilla-stable-rc-}" ]]; then
		branchpoint="${current_branch#ark-vanilla-stable-rc-}"
	elif [[ "${current_branch}" != "${current_branch#ark-vanilla-stable-}" ]]; then
		branchpoint="${current_branch#ark-vanilla-stable-}"
	fi
	if [[ "${branchpoint}" ]]; then
		echo "deeping git tree to avoid oddities using"
		echo " git fetch --shallow-exclude=${branchpoint}"
		sleep 5
		git fetch --shallow-exclude="${branchpoint}"
	fi
fi
