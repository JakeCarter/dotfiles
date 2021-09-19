#!/bin/zsh

# This script will iterate through all files in the adjacent './home' folder
# and symlink them in '~'. When performing the symlink, it will prepend a '.'
# to each filename.
#
# E.g. 'zshrc' will be symlinked as '~/.zshrc'
#
# Any files that already exist in '~' will be backed up.
#
# E.g. If '~/.zshrc' already exists, it will be renamed to '~/.zshrc_bak'

function _setup_install() {
    if [[ -f ~/.dotfiles_manifest ]]; then
        echo "~/.dotfiles_manifest found from previous install; Performing uninstall first..."
        _setup_uninstall
    fi
    
    echo "Installing..."
    for file in home/*; do
        local src_file=$PWD/$file
        local link_name=~/.${file#home/}
        
        # only backup non-symbolic links
        if [[ -f $link_name && ! -h $link_name ]]; then
            echo "mv $link_name ${link_name}_bak"
            mv $link_name ${link_name}_bak
         fi
         
         # create symbolic link
         echo "ln -s $src_file $link_name"
         ln -s $src_file $link_name
         echo "$link_name" >> ~/.dotfiles_manifest
    done
}

function _setup_manifest_write() {
    for file in home/*; do
        local link_name=~/.${file#home/}
         echo "$link_name" >> ~/.dotfiles_manifest
    done
}

function _setup_gitconfig() {
    if [[ +commands[git] && ! -f ~/.gitconfig ]]; then
        echo "No `~/.gitconfig` file found..."
        vared -c -p '  enter name > ' gitusername
        git config --global user.name $gitusername
        unset gitusername
        
        vared -c -p '  enter email > ' gitemail
        git config --global user.email $gitemail
        unset gitemail
        
        git config --global include.path ~/.gitconfig-main
    else
        echo "Couldn't find `git` command or `~/.gitconfig` already exists."
    fi
}

function _setup_uninstall() {
    if [[ ! -f ~/.dotfiles_manifest ]]; then
        echo "Could not find manifest file."
        return
    fi
    
    echo "Found manifest ~/.dotfiles_manifest; Uninstalling..."
    while IFS= read -r line
    do
      echo "rm $line"
      rm $line
    done < ~/.dotfiles_manifest
    rm ~/.dotfiles_manifest
}

function _setup_print_usage() {
    echo "Usage:"
    echo "  install        - Installs symlinks from files in the 'home' folder; Performs an uninstall first if a ~/.dotfiles_manifest file is found."
    echo "  uninstall      - Uninstalls symlinks, if a ~/.dotfiles_manifest file is found"
    echo "  manifest-write - Writes a ~/.dotfiles_manifest file as if it were installing"
}

local subcommand=$1
case $subcommand in
    (install)
        _setup_install
    ;;
    (uninstall)
        _setup_uninstall
    ;;
    (manifest-write)
        _setup_manifest_write
    ;;
    (help)
        _setup_print_usage
    ;;
    (*)
        echo "Error: Unknown command."
        _setup_print_usage
    ;;
esac
