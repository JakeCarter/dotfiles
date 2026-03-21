#!/usr/bin/env zsh

active=($(aerospace list-workspaces --all))

# Skips 0, which I treat as special and always bound to my laptop display, and my aerospace arrow keys - I, J, K and L
candidates=({1..9} {A..H} {M..Z})

for candidate in $candidates; do
  if (( ! ${active[(Ie)$candidate]} )); then
    echo $candidate
    exit 0
  fi
done

echo -1
exit 1

