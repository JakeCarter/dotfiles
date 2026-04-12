#!/usr/bin/env zsh

active=($(aerospace list-workspaces --all))

# Skips 0, which I treat as special and always bound to my laptop display, and my aerospace arrow keys - H, J, K and L
candidates=({1..9} {A..G} I {M..Z})

for candidate in $candidates; do
  # (Ie) returns the index of an exact match in $active, or 0 if not found
  if (( ! ${active[(Ie)$candidate]} )); then
    echo $candidate
    exit 0
  fi
done

echo -1
exit 1

