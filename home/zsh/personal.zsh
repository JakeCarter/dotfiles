ff () {
    find . \( \! -name .git -o -prune \) -a -type f -print0 | xargs -0 grep $*
}

show-colors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}m${i} "
    done
}

add-auth-tid() {
    echo "About to ask for password to add Touch ID support for 'sudo'..."
    sudo sed -i.bak '2s;^;auth sufficient pam_tid.so\n;' /etc/pam.d/sudo
}

# Speed up git tab-completion. Taken from: https://superuser.com/questions/458906/zsh-tab-completion-of-git-commands-is-very-slow-how-can-i-turn-it-off and https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off/9810485#9810485 
__git_files () {
    _wanted files expl 'local files' _files
}

# Key Bindings
# `^[` - Meta usage requires enabling Terminal's "Use Option as Meta key" option. (Not sure if `^[` is really the meta sequence or if it's ESC and zsh is just treating it as meta.)
# https://unix.stackexchange.com/a/319854
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
