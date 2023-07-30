#!/bin/bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Install dotfiles
for dotfile in $base_dir/repo/* ; do
    name=$(basename $dotfile)
    target=~/.$name
    rm $target
    ln -sv $base_dir/repo/$name $target
    #[ ! -s "$target" ] && ln -sv "$base_dir/repo/$name" "$target"
done

# Create private exports file
[ -e ~/.exports_private ] || touch ~/.exports_private
