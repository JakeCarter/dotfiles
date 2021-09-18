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

for file in home/*; do
    local src_file=$PWD/$file
    local link_name=~/.${file#home/}
    
    # only backup non-symbolic links
    if [[ -f $link_name && ! -h $link_name ]]; then
        mv $link_name ${link_name}_bak
     fi
     
     # create symbolic link
     ln -s $src_file $link_name
done

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
