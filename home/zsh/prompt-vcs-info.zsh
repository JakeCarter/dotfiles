# Enable version control system info and enable it for git; This needs to happen BEFORE any of the async stuff, otherwise none of the vcs settings will be available and you'll get nothing from `vcs_info_msg_0_`.
# Manual: http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
# Inspiration:
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/steeef.zsh-theme
# - https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info
# - https://github.com/vincentbernat/zshrc/blob/b329b4ade6c6f4b0fecbb758090d629ccef2fe3c/rc/vcs.zsh
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:*' formats "(%F{6}%b%f%c%u)"
zstyle ':vcs_info:*' stagedstr '😎'
zstyle ':vcs_info:*' unstagedstr '🚧'
zstyle ':vcs_info:*' actionformats "(%F{6}%b%f%c%u)(%F{1}%a%f)"

zstyle ':vcs_info:git*+set-message:*' hooks update-git-untracked update-git-skipped

function +vi-update-git-untracked() {
    # ZSH doesn't support showing untracked files. Adapted approach from here:
    # http://web.archive.org/web/20121018120253/https://briancarper.net/blog/570/git-info-in-your-zsh-prompt
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        hook_com[unstaged]+="👽"
    fi
}

function +vi-update-git-skipped() {
    # I wanted the following test to be `[[ -n $(git ls-files -v 2> /dev/null | grep ^S 2> /dev/null) ]]` but that always returns `false` when run from a vcs_info hook. I think it has something to do with the pipe (|). Relying on the git alias is working though.
    if [[ -n $(git li) ]]; then
        hook_com[unstaged]+="🙈"
    fi
}

function _update_vcs_info() {
    cd $1
    vcs_info
    print ${vcs_info_msg_0_}
}

function _update_vcs_info_done() {
    local stdout=$3
    vcs_info_msg_0_=$stdout
    zle reset-prompt
}

async_init
async_start_worker vcs_info_worker
async_register_callback vcs_info_worker _update_vcs_info_done

# `precmd` is executed before each prompt. We use this to ensure `vcs_info` is up to date.
add-zsh-hook precmd () {
    async_job vcs_info_worker _update_vcs_info $PWD
}

# Format prompt; %F changes the foreground color to the index provided. %f resets the foreground color
PROMPT=$'
%F{2}%n%f at %F{5}%m%f in %F{4}%~%f ${vcs_info_msg_0_}
%(!.#.$) '
