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
    _fzf_complete --height 50% --multi --preview 'git diff -- $(echo {} | cut -c 4-) | bat --style=numbers --color=always --line-range :500' --preview-window down,80% -- "$@" < <(
        git status --porcelain
    )
}
_fzf_complete_git_changed_files_post() {
    # keep everything starting at the 4th char
    cut -c 4-
}

_fzf_complete_git_stashes() {
    _fzf_complete -- "$@" < <(
        git stash list
    )
}
_fzf_complete_git_stashes_post() {
    cut -d':' -f1
}

_fzf_complete_git_commit_hash() {
    _fzf_complete -- "$@" < <(
        git lg -n 100
    )
}
_fzf_complete_git_commit_hash_post() {
    cut -d'-' -f1 | egrep -o \\w+
}

_fzf_complete_git() {
    # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    # `(z)` splits at zsh word boundaries
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
        (wt|worktree)
            # git worktree foo ,
            # 1   2        3   4  <- need at least 4 tokens
            if [[ ${#tokens} -le 3 ]]; then
                return
            fi
            local git_worktree_subcommand=${tokens[3]}
            case "$git_worktree_subcommand" in
                (remove)
                    _fzf_complete_git_worktrees "$@"
                    return
                ;;
            esac
            return
        ;;
        (add|unstage)
            _fzf_complete_git_changed_files "$@"
            return
        ;;
        (stash)
            # git stash push ,
            # 1   2     3    4  <- need at least 4 tokens
            if [[ ${#tokens} -le 3 ]]; then
                return
            fi
            
            local git_stash_subcommand=${tokens[3]}
            case "$git_stash_subcommand" in
                (push)
                    _fzf_complete_git_changed_files "$@"
                    return
                ;;
                (*)
                    _fzf_complete_git_stashes "$@"
                    return
                ;;
            esac
            return
        ;;
        (rebase)
            # git rebase --onto ,
            # 1   2      3      4  <- need at least 4 tokens
            if [[ ${#tokens} -le 3 ]]; then
                return
            fi
            
            local git_rebase_subcommand=${tokens[3]}
            case "$git_rebase_subcommand" in
                (--onto)
                    # git rebase --onto branch start-hash end-branch-name
                    # 1   2      3      4      5          6                <- comma could appear at 4, 5 or 6
                    if [[ ${#tokens} -eq 4 ]]; then
                        _fzf_complete_git_branches "$@"
                    elif [[ ${#tokens} -eq 5 ]]; then
                        _fzf_complete_git_commit_hash "$@"
                    elif [[ ${#tokens} -eq 6 ]]; then
                        # JCTODO: I only ever rebase the full contents of the branch. Output current branch name.
                    fi
                    return
                ;;
            esac
    esac
}
