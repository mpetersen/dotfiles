#!/bin/bash
# .dotfiles installation script for Mac OS X

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


# Syntax:
# 
#   install file cmd regex
# 
# Runs the install `cmd` for each line of the file, filtered with the `regex`
# 
function install {
    install_file=$1
    install_cmd=$2
    install_regex=$3
    while read line; do
        id=`echo $line | sed -E "s/$install_regex|.*/\1/"`
        $install_cmd $id
    done <$install_file
}

# Backup default configuration
[ ! -f ~/.dotfiles/defaults.orig ] && defaults read > ~/.dotfiles/defaults.orig

# Install brew
if ! hash "brew"; then
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install brew and taps
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#brew tap homebrew/cask-fonts
#brew tap homebrew/cask-drivers

# Update brew
brew update --force --quiet
brew upgrade

# Install software (see: README.md)
install $base_dir/install/brew-list "brew install --formulae" "(.*)"
install $base_dir/install/brew-cask-list "brew install --cask --appdir=/Applications" "(.*)"
install $base_dir/install/mas-list "mas install" "([^ ]*).*"

# Cleanup
brew cleanup

# Reload quicklook (currently disabled)
#qlmanage -r

# Also install for zsh
# ln -sv ~/.bash_profile ~/.zprofile

# Create private exports file
[ -e ~/.exports_private ] || touch ~/.exports_private

# Install Oh My Zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Prezto
# Source: https://github.com/sorin-ionescu/prezto
#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
#setopt EXTENDED_GLOB
#for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#done

exit 0
