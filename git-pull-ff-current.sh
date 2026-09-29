#!/bin/sh
set -eu

if test "$#" -ne 0; then
    echo "Usage: ${0##*/}" >&2
    exit 64
fi

git=/usr/bin/git
repo=$PWD

if ! "$git" -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not a Git repository: $repo" >&2
    exit 64
fi

if test -n "$("$git" -C "$repo" status --porcelain)"; then
    echo "Working tree is not clean: $repo" >&2
    exit 65
fi

before=$("$git" -C "$repo" rev-parse HEAD)
lock=$("$git" -C "$repo" rev-parse --git-path git-pull-ff.lock)

/usr/bin/flock -n "$lock" "$git" -C "$repo" pull --ff-only

after=$("$git" -C "$repo" rev-parse HEAD)
printf '%s: %s -> %s\n' "$repo" "$before" "$after"
