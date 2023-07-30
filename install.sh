#!/bin/zsh
# .dotfiles installation script for Mac OS X

base_dir=${0:a:h}

# Syntax:
# 
#   install file cmd regex
# 
# Runs the install `cmd` for each line of the file, filtered with the `regex`
# 
function install() {
    echo "install($1, $2, $3)"
    install_file=$1
    install_cmd=$2
    install_regex=$3
    while read line; do
        echo "line: $line"
        id=`echo $line | sed -E "s/$install_regex|.*/\1/"`
        echo "id: $id"
        echo "command: $install_cmd $id"
        cmd="$install_cmd $id"
        eval ${cmd}
#        $install_cmd $id
    done <$install_file
}

function log() {
  echo "==============================================================================================================="
  echo "="
  echo "=    $1"
  echo "="
}

# Backup default configuration
[ ! -f ~/.dotfiles/defaults.orig ] && defaults read > ~/.dotfiles/defaults.orig

# Enable FileVault
log "Enable FileVault"
sudo fdesetup enable

# Install brew
log "Install Homebrew"
if ! hash "brew"; then
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install brew and taps
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#brew tap homebrew/cask-fonts
#brew tap homebrew/cask-drivers

# Update brew
log "Update Homebrew"
brew update --force --quiet
brew upgrade

# Install software (see: README.md)
log "Install formulae"
install $base_dir/install/brew-list "brew install --formulae" "(.*)"
log "Install casks"
install $base_dir/install/brew-cask-list "brew install --cask --appdir=/Applications" "(.*)"
log "Install from App Store"
install $base_dir/install/mas-list "mas install" "([^ ]*).*"

# Cleanup
log "Cleanup Homebrew"
brew cleanup

# Reload quicklook (currently disabled)
#qlmanage -r

# Install Prezto
# Source: https://github.com/sorin-ionescu/prezto
log "Install Prezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

exit 0
