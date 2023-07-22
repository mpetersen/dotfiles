#!/bin/bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Enable FileVault
sudo fdesetup enable

# Install dotfiles
for dotfile in $base_dir/repo/* ; do
    name=$(basename "$dotfile")
    [ ! -s ~/.$name ] && ln -sv $base_dir/repo/$name ~/.$name
done
