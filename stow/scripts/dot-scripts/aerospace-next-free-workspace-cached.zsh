#!/usr/bin/env zsh

CACHE=/tmp/aerospace-next-free-workspace

if [[ -f $CACHE ]]; then
  echo $(<$CACHE)
else
  exec "${0:h}/aerospace-next-free-workspace.zsh"
fi
