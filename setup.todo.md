# [ ] ZSH Prompt Idea

Separate quick prompt info from longer async info and leave placeholder that will get filled in for longer async info. For example:

`<normal zsh prompt stuff>(git-branch)(...)` <-- Kickoff async work to fill in "(...)" placeholder

Later, when async comes back:

`<normal zsh prompt stuff>(get-branch)(branch-status-inf0)`

# [ ] Setup Manifest

Setup script should write a manifest that can be used later to "uninstall"
