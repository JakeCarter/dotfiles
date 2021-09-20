_fzf_complete_git_branches () {
    _fzf_complete -- "$@" < <(
        git porcelain-branch
    )
}

_fzf_complete_git_worktrees() {
    _fzf_complete -- "$@" < <(
        git worktree list
    )
}

_fzf_complete_git_worktrees_post() {
    cut -f1 -d' '
}

_fzf_complete_git_changed_files() {
    _fzf_complete -- "$@" < <(
        git status --porcelain
    )
}

_fzf_complete_git_changed_files_post() {
    cut -d' ' -f3
}

_fzf_complete_git() {
    # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    local tokens=(${(z)LBUFFER})
    # git foo ,
    # 1   2   3  <- need at least 3 tokens
    if [[ ${#tokens} -le 2 ]]; then
        return
    fi
    
    local git_subcommand=${tokens[2]}
    case "$git_subcommand" in
        (co|checkout)
            _fzf_complete_git_branches "$@"
            return
        ;;
        (worktree)
            # git worktree foo ,
            # 1   2        3   4  <- need at least 4 tokens
            if [[ ${#tokens} -le 3 ]]; then
                return
            fi
            local git_worktree_subcommand=${tokens[3]}
            case "$git_worktree_subcommand" in
                (remove)
                    _fzf_complete_git_worktrees "$@"
                ;;
            esac
            return
        ;;
        (add|unstage)
            _fzf_complete_git_changed_files "$@"
        ;;
    esac
}
