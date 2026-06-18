#!/usr/bin/env zsh
#
# stack-left: arrange the focused workspace so all-but-the-last windows stack
# vertically on the left and the last window sits on the right at full height.
# A no-op for fewer than three windows.

set -euo pipefail

workspace=$(aerospace list-workspaces --focused) || {
    print -u2 "aerospace-stack-left: could not determine focused workspace"
    exit 1
}

orig_focus=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null || true)

aerospace flatten-workspace-tree --workspace "$workspace"

count=$(aerospace list-windows --workspace "$workspace" --format '%{window-id}' | wc -l | tr -d ' ')

if (( count >= 3 )); then
    aerospace layout v_tiles
    # After flatten + v_tiles, dfs-index addresses root's children in tree
    # order, which matches top-to-bottom visual order. dfs-index (count-1)
    # is the bottom window — pop it out to the right.
    aerospace focus --dfs-index $((count - 1))
    aerospace move right --boundaries-action create-implicit-container
fi

# `${var:-default}` is parameter-expansion-with-default: it expands to $var if
# var is set and non-empty, otherwise to `default`. With an empty default,
# `${orig_focus:-}` yields "" when orig_focus is unset, which keeps `set -u`
# from erroring. `-n` then skips the restore when the value is empty.
if [[ -n ${orig_focus:-} ]]; then
    aerospace focus --window-id "$orig_focus" 2>/dev/null || true
fi
