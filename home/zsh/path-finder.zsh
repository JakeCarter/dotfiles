# In normal scripts, `$0` will return the script path as executed. Appending
# `:A` will resolve any relative paths and symbolic links. Appending `:h`
# will remove the script name.
#
# Unfortunately, `zshenv` is evaluated differently and `$0` will just return
# the 'zsh' process name. Putting this here and sourcing it from `zshenv` gets
# around that.

dotfiles_relative_path=${0:A:h}/../../
export DOTFILES_PATH=${dotfiles_relative_path:A}
unset dotfiles_relative_path
