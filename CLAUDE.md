# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal macOS dotfiles managed with **GNU Stow**. Each directory under `stow/` is a stow package that symlinks into `~` using the `dot-` prefix convention (e.g., `dot-config` becomes `.config`).

## Installation Commands

```bash
# Install a package (from repo root)
cd stow && stow <package-name>

# Uninstall a package
cd stow && stow -D <package-name>

# Apply macOS system defaults
cd defaults && ./osx.install
```

Stow is configured via `stow/.stowrc`: `--dotfiles` enables `dot-` renaming, `--target=~` sets the symlink destination.

## Stow Packages

| Package | What it configures |
|---------|-------------------|
| `aerospace` | AeroSpace tiling window manager |
| `claude` | Claude Code global settings, skills, and commands |
| `git` | Personal git config (user name/email); includes `git-common` |
| `git-common` | Shared git aliases, core settings, diff/merge tool config |
| `karabiner` | Keyboard remapping (Caps Lock → Hyper/Escape) |
| `lldb` | LLDB Python debugging scripts for iOS/Xcode |
| `nvim` | Neovim config (Lua, Kickstart-based, LSP + Treesitter) |
| `scripts` | Utility shell scripts (`~/.scripts/`) |
| `vim` | Legacy Vim configuration |
| `zsh` | Zsh shell config (modular: aliases, completions, prompt, etc.) |

## Architecture Notes

- **Git config is split**: `git/` has personal identity; `git-common/` has aliases and tool settings. The personal config includes the common one via `[include]`.
- **Zsh is modular**: `.zshrc` sources individual files from `~/.zsh/` (aliases, completions, prompt, personal functions, conditional includes).
- **Zsh plugins** (`zsh-autosuggestions`, `zsh-async`) are **git submodules** — clone with `--recurse-submodules`.
- **Scripts** in `stow/scripts/dot-scripts/` include AeroSpace workspace helpers and Beyond Compare git integration wrappers.
- **macOS defaults** in `defaults/` are organized as individual `.defaults` files sourced by `osx.install`.
