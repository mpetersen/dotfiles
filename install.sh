#!/bin/bash
# .dotfiles installation script for Mac OS X

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


# Syntax:
# 
#   install file cmd regex
# 
# Runs the install `cmd` for each line of the file, filtered with the regex
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

# Install brew and taps
if ! hash "brew"; then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/cask-fonts
brew tap homebrew/cask-drivers
fi

# Update brew
brew update

# Install software
install $base_dir/install/brew-cask-list "brew cask install --appdir=/Applications" "(.*)"
install $base_dir/install/brew-list "brew install" "(.*)"
install $base_dir/install/mas-list "mas install" "([^ ]*).*"

# Cleanup
brew cleanup

# Reload quicklook
qlmanage -r

# Install dotfiles
for dotfile in $base_dir/repo/* ; do
    name=$(basename "$dotfile")
    [ ! -s ~/.$name ] && ln -sv $base_dir/repo/$name ~/.$name
done

# Create private exports file
[ -e ~/.exports_private ] || touch ~/.exports_private

exit 0
