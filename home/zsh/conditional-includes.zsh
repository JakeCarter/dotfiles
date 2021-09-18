# zsh-autosuggestions
if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    bindkey '^ ' autosuggest-accept
else
    echo 'zsh-autosuggestions not found. Please install:'
    echo '  (cd ~/.zsh/; git submodule init; git submodule update); source ~/.zshrc'
fi;

# zsh-async
if [[ -f ~/.zsh/zsh-async/async.zsh ]]; then
    source ~/.zsh/zsh-async/async.zsh
else
    echo 'zsh-async not found. Please install:'
    echo '  (cd ~/.zsh/; git submodule init; git submodule update); source ~/.zshrc'
fi;

# fzf
if [[ -f $(brew --prefix)/opt/fzf/shell/completion.zsh && -f $(brew --prefix)/opt/fzf/shell/key-bindings.zsh ]]; then
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
else
    echo 'fzf not found. Please install:'
    echo '  brew install fzf; source ~/.zshrc'
fi;

# z
if [[ -f $(brew --prefix)/etc/profile.d/z.sh ]]; then
    source "$(brew --prefix)/etc/profile.d/z.sh"
else
    echo 'z not found. Please install:'
    echo '  brew install z; source ~/.zshrc'
fi;

# work.zsh
[[ -f ~/.work/work.zsh ]] && source ~/.work/work.zsh