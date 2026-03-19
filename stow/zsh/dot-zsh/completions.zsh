# Completions

# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

autoload -U compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # fuzzy completion; `1704<TAB>` would match `_DSC1704.JPG`
zstyle ':completion:*' list-colors '' # colors file/dir in completion menu
zstyle ':completion:*' menu select
