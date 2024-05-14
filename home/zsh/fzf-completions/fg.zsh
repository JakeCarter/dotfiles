_fzf_complete_fg_jobs() {
    _fzf_complete -- "$@" < <(
        jobs
    )
}
_fzf_complete_fg_jobs_post() {
    # Example output this command will act on; We want to grab the number inside the square brackets ([1]) and prepend it with a percent sign (%)
    # [1]  + suspended  man echo
    # should become
    # %1
    cut -d']' -f1 | tr "[" "%"
}

_fzf_complete_fg() {
    _fzf_complete_fg_jobs "$@"
}
