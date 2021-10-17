ff () {
    find . \( \! -name .git -o -prune \) -a -type f -print0 | xargs -0 grep $*
}

list-colors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}m${i} "
    done
}


show-colors() {
    # https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
    
    # The text for the color test
    local T='•••'
    if [[ -n "$1" ]]; then
        T="$1"
    fi
    
    echo -e "\n         def     40m     41m     42m     43m     44m     45m     46m     47m";
    
    for FGs in '    m' '   1m' '  30m' '1;90m' '  31m' '1;91m' '  32m' \
               '1;92m' '  33m' '1;93m' '  34m' '1;94m' '  35m' '1;95m' \
               '  36m' '1;96m' '  37m' '1;97m';
    
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
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
