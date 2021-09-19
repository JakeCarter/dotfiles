# Dotfiles

These are my personal dotfiles. I don't expect anyone will pull them down and use them as-is, but hopefully there are some pieces that others find useful. I've tried to clean them up a bit and I've moved all of my work specific stuff out. So you may see references to paths that don't exist within this repo.

# Requirements

- [homebrew](https://brew.sh)
- [macOS](http://apple.com/macos)
- [zsh](https://zsh.sourceforge.io)

Although these aren't all hard requirements, I make no effort to keep anything here compatible with other setups.

# Install

- Clone the repo, making sure to get the submodules
- `cd` into the working tree
- Run the setup script

```
git clone --recurse-submodules git@github.com:JakeCarter/dotfiles.git
cd dotfiles
zsh setup.zsh install
```

The setup script will symlink everything in the `home` folder into `~/` and also walk you through setting up your git name and email address if no `~/.gitconfig` is found.

# Uninstall

Newer versions of the setup script will write a `~/.dotfiles_manifest` file that contains the path to all symlinks it creates. If the file exists, you can remove the symlinks using:

```
cd dotfiles
zsh setup.zsh uninstall
```

If you don't already have a `~/.dotfiles_manifest` file, the setup script can create one for you based on the symlinks it would create for you. This may be different than the version of the setup script you've already run, but probably not. To have the setup script write the manifest without performing an install, run the following:

```
cd dotfiles
zsh setup.zsh manifest-write
```

# Notes

I've tried to add comments with info and attribution links, hopefully those are helpful. I love learning better ways to do stuff and sharing what I know, so feel free to file bugs and ask questions.
