#!/bin/sh -

for i in /mnt/co/*
do
  [ ! -d "$i" ] && continue
  cd "$i" || continue
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || continue

  unstaged=false
  if git remote -v | grep -q 'origin[[:space:]]\+pi'
  then
    [ "$(git diff --staged | wc -c)" -ne 0 ] && continue
    [ "$(git diff | wc -c)" -ne 0 ] && unstaged=true
    echo "$i"
    if [ "$unstaged" = "true" ]; then
      git stash save "$0: auto-saving"
    fi
    git pull --ff-only || echo "$i: PULL FAILED"
    if [ "$unstaged" = "true" ]; then
      git stash pop || echo "$i: POP FAILED"
    fi
  fi
done
