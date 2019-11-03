#!/bin/bash
# .dotfiles installation script for Mac OS X

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Setup dock
function cmd_dock {
    dockutil --remove all --no-restart

    apps=(
        "/Applications/Utilities/Console.app"
        "/Applications/iTerm.app"
        "/Applications/Cyberduck.app"
        "/Applications/MacPass.app"
        "/Applications/Contacts.app"
        "/Applications/Mail.app"
        "/Applications/Messages.app"
        "/Applications/Safari.app"
        "/Applications/Calendar.app"
        "/Applications/Microsoft OneNote.app"
    )

    for app in "${apps[@]}"; do
        dockutil --add "$app" --no-restart
    done

    dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
    dockutil --add '~/Downloads' --view grid --display stack --sort dateadded --no-restart
    dockutil --add '~' --view grid --display folder --sort kind --no-restart

    killall Dock
}

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
fi

# Update brew
brew update

# Install software
install $base_dir/install/brew-cask-list "brew cask install --appdir=/Applications" "(.*)"
install $base_dir/install/brew-list "brew install" "(.*)"
install $base_dir/install/mas-list "mas install" "([^ ]*).*"

# Cleanup
brew cleanup
brew cask cleanup

# Reload quicklook
qlmanage -r

# Setup dock
cmd_dock

# Install dotfiles
for dotfile in $base_dir/repo/* ; do
    name=$(basename "$dotfile")
    [ ! -s ~/.$name ] && ln -sv $base_dir/repo/$name ~/.$name
done

# Create private exports file
[ -e ~/.exports_private ] || touch ~/.exports_private

exit 0
