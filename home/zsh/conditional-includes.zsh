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

# zoxide
if [[ -f $(brew --prefix)/bin/zoxide ]]; then
    eval "$(zoxide init --cmd cd zsh)"
else
    echo 'zoxide not found. please install:'
    echo ' brew install zoxide; source ~/.zshrc'
fi;

# chruby - Ruby environment tool
[[ -f /opt/homebrew/opt/chruby/share/chruby/chruby.sh ]] && source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
[[ -f /opt/homebrew/opt/chruby/share/chruby/auto.sh ]] && source /opt/homebrew/opt/chruby/share/chruby/auto.sh
[[ -f /opt/homebrew/opt/chruby/share/chruby/chruby.sh ]] && chruby ruby-3.1.2

# pyenv - Python version management
if command -v pyenv 1>/dev/null 2>&1; then
    export PATH=~/.pyenv/bin:$PATH
    eval "$(pyenv init -)"
fi

# work.zsh
[[ -f ~/.work/work.zsh ]] && source ~/.work/work.zsh