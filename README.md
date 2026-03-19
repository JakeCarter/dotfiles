# Dotfiles

These are my personal dotfiles. I don't expect anyone will pull them down and use them as-is, but hopefully there are some pieces that others find useful. I've tried to clean them up a bit and I've moved all of my work specific stuff out. So you may see references to paths that don't exist within this repo.

# Requirements

- [homebrew](https://brew.sh)
- [macOS](http://apple.com/macos)
- [zsh](https://zsh.sourceforge.io)

Although these aren't all hard requirements, I make no effort to keep anything here compatible with other setups.

# Install

- Ensure `stow` is installed via `brew install stow`
- Clone the repo, making sure to get the submodules
- `cd` into "dotfiles/stow"
- Run `stow <package-name(s)>` to install the packages you want

```
brew install stow
...
git clone --recurse-submodules git@github.com:JakeCarter/dotfiles.git
cd dotfiles/stow
stow zsh git-common git ...
```

# Uninstall

Use `stow -D <package-name(s)>` to uninstall them.

```
cd dotfiles/stow
stow -D zsh git-common git ...
```

# Notes

I've tried to add comments with info and attribution links, hopefully those are helpful. I love learning better ways to do stuff and sharing what I know, so feel free to file bugs and ask questions.
