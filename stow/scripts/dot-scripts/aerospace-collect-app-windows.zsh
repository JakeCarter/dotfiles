#!/usr/bin/env zsh
#
# Collect every window of the currently focused app into the current workspace,
# then re-focus the window that was originally focused.

set -euo pipefail

focused=$(aerospace list-windows --focused --format '%{window-id}|%{app-bundle-id}') || {
    print -u2 "aerospace-collect-windows: no focused window"
    exit 1
}

focused_window_id=${focused%%|*}
focused_bundle_id=${focused#*|}

if [[ -z $focused_window_id || -z $focused_bundle_id ]]; then
    print -u2 "aerospace-collect-windows: could not parse focused window"
    exit 1
fi

current_workspace=$(aerospace list-workspaces --focused)

# Move every other window of this app to the current workspace.
while IFS='|' read -r wid wname; do
    [[ -z $wid ]] && continue
    if [[ $wname != $current_workspace ]]; then
        aerospace move-node-to-workspace --window-id $wid "$current_workspace"
    fi
done < <(aerospace list-windows --monitor all --app-bundle-id "$focused_bundle_id" --format '%{window-id}|%{workspace}')

aerospace focus --window-id $focused_window_id
