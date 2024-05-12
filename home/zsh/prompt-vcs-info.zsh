# Enable version control system info and enable it for git; This needs to happen BEFORE any of the async stuff, otherwise none of the vcs settings will be available and you'll get nothing from `vcs_info_msg_0_`.
# Manual: http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
# Inspiration:
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/steeef.zsh-theme
# - https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info
# - https://github.com/vincentbernat/zshrc/blob/b329b4ade6c6f4b0fecbb758090d629ccef2fe3c/rc/vcs.zsh
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:*' stagedstr '😎'
zstyle ':vcs_info:*' unstagedstr '🚧'

# Break vcs_info into multiple formats/actionformats for easier parsing later
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' formats "(%F{6}%b%f)" "(%c%u)"
zstyle ':vcs_info:*' actionformats "(%F{6}%b%f)" "(%c%u)" "(%F{1}%a%f)"

zstyle ':vcs_info:git*+set-message:*' hooks update-git-untracked update-git-skipped

#
# `set-message` hooks will get called once per format set in formats/actionformats. That means `+vi-update-git-untracked` and `+vi-update-git-skipped` will each get called at least 2 times. 
# We only care about updating the "unstaged" message, which for both formats and actionformats is set in the 2nd format. 
# $1 will contain the 0-based index of the current format, so we can use that to ignore calls for formats we don't care about.
#

function +vi-update-git-untracked() {
    if [[ "$1" != "1" ]]; then
            return 0
    fi

    # ZSH doesn't support showing untracked files. Adapted approach from here:
    # http://web.archive.org/web/20121018120253/https://briancarper.net/blog/570/git-info-in-your-zsh-prompt
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        hook_com[unstaged]+="👽"
    fi
}

function +vi-update-git-skipped() {
    if [[ "$1" != "1" ]]; then
            return 0
    fi

    # I wanted the following test to be `[[ -n $(git ls-files -v 2> /dev/null | grep ^S 2> /dev/null) ]]` but that always returns `false` when run from a vcs_info hook. I think it has something to do with the pipe (|). Relying on the git alias is working though.
    if [[ -n $(git li) ]]; then
        hook_com[unstaged]+="🙈"
    fi
}

function _update_vcs_info() {
    cd $1
    vcs_info
    
    # vcs_info_msg_0_ will contain the branch info if we're in a git working tree and will be empty otherwise. No need to conditionally add this to the result
    local result="${vcs_info_msg_0_}"

    # Both vcs_info_msg_1_ and vcs_info_msg_2_ will contain staged, unstaged, untracked and skipped status. These will always be set to at least "()", even if there is no status. Because of this we are only adding them to the result if their string length is greater than 2. I have some ideas on how to make this better, but this is working for now.
    if [[ ${#vcs_info_msg_1_} -gt 2 ]]; then
        result="${result} ${vcs_info_msg_1_}"
    fi

    if [[ ${#vcs_info_msg_2_} -gt 2 ]]; then
        result="${result} ${vcs_info_msg_2_}"
    fi

    # This result will end up being the stdout used in `_update_vcs_info_done`
    print $result
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
