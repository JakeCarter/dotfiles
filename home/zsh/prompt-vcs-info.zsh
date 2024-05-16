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
zstyle ':vcs_info:*' formats "%F{6}%b%f" "%c%u"
zstyle ':vcs_info:*' actionformats "%F{6}%b%f" "%c%u" "%F{1}%a%f"

# Declare the async job and callback
function async_job_update_git_untracked_skipped() {
    cd $1

    local result=""

    # ZSH doesn't support showing untracked files. Adapted approach from here:
    # http://web.archive.org/web/20121018120253/https://briancarper.net/blog/570/git-info-in-your-zsh-prompt
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        result="${result}👽"
    fi

    # I wanted the following test to be `[[ -n $(git ls-files -v 2> /dev/null | grep ^S 2> /dev/null) ]]` but that always returns `false` when run from a vcs_info hook. I think it has something to do with the pipe (|). Relying on the git alias is working though.
    if [[ -n $(git li) ]]; then
        result="${result}🙈"
    fi

    print $result
}

function async_job_update_git_untracked_skipped_done() {
    # https://github.com/mafredri/zsh-async?tab=readme-ov-file#async_process_results-worker_name-callback_function
    local async_job_stdout=$3
    local has_next_result_in_buffer=$6

    update_git_prompt_string $async_job_stdout

    # Only reset the prompt if the async results buffer is empty
    if [[ -n $has_next_result_in_buffer ]]; then
        zle reset-prompt
    fi
}

async_init
async_start_worker git_info_worker
async_register_callback git_info_worker async_job_update_git_untracked_skipped_done

function update_git_prompt_string() {
    # When called from the async job callback, $1 will have the untracked and skipped status string. Otherwise it will be null or empty
    local git_untracked_or_skipped_msg=$1

    git_prompt_string=""
    
    # Branch
    if [[ -n ${vcs_info_msg_0_} ]]; then
        git_prompt_string="(${vcs_info_msg_0_})"
    fi

    # Staged, Unstaged, Untracked and Skipped
    if [[ -n ${vcs_info_msg_1_} || -n ${git_untracked_or_skipped_msg} ]]; then
        git_prompt_string="${git_prompt_string} (${vcs_info_msg_1_}${git_untracked_or_skipped_msg})"
    fi

    # Action message (ex. rebase, merge, etc...)
    if [[ -n ${vcs_info_msg_2_} ]]; then
        git_prompt_string="${git_prompt_string} (${vcs_info_msg_2_})"
    fi
}

# `precmd` is executed before each prompt. We use this to ensure `vcs_info` is up to date.
add-zsh-hook precmd () {
    # Updating the untracked and skipped files can be slow in large git repos. Kick this off to a background thread and update the prompt again when this comes back. (Technically just updating the untracked is slow, but I'm fine having these together to simplify things.)
    async_job git_info_worker async_job_update_git_untracked_skipped $PWD
    
    # Let vcs_info do its thing then update the prompt string
    vcs_info
    update_git_prompt_string

    update_jobs_string
}

function update_jobs_string() {
    if jobs | grep -q "caffeinate"; then;
        if ! jobs | grep -qv "caffeinate"; then
            jobs_string="☕️"
        else
            jobs_string="🔄☕️"
        fi
    else
        jobs_string="🔄"
    fi
}

# Format prompt; %F changes the foreground color to the index provided. %f resets the foreground color
PROMPT=$'
%F{2}%n%f on %F{5}%m%f %(1j.${jobs_string} .)in %F{4}%~%f ${git_prompt_string}
%(!.#.$) '
