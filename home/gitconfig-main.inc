[alias]
  co = checkout
  ci = commit
  cp = cherry-pick
  st = status
  br = branch
  wt = worktree
  pu = push -u
  lg = log --graph --pretty=format:'%C(auto)%h%Creset -%C(auto)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
  lc = log --compact-summary
  list-stale = !"git br -vv | grep \": gone]\" | cut -d\" \" -f3"
  prune-stale = !"git list-stale | xargs git br -D"
  unstage = restore --staged
  li = !git ls-files -v | grep ^S
  i = update-index --skip-worktree
  u = update-index --no-skip-worktree
  stop-lying = !"git li | cut -d" " -f 2 | xargs git u"
  diffw = diff --color-words
  diffc = diff --cached
  diffcw = diff --cached --color-words
  porcelain-branch = !"git branch --format='%(refname:short)'"
  list-alias = config --get-regexp '^alias\\.'
  fixit = rebase -i --autosquash # [Git fixup explained](https://mikulskibartosz.name/git-fixup-explained)
[core]
	excludesfile = ~/.gitignore
	quotepath = false
[color]
	gui = true
[mergetool]
	keepBackup = true
[push]
    default = current
[pull]
	ff = only
[init]
	defaultBranch = main
[fetch]
	prune = true
