#!/bin/bash
# Link cloud folders to home folder

home="$HOME"
clouds="$HOME/Clouds"

# clean up links that point to cloud folders
for dir in $home/* ; do
    if [[ -d "$dir" ]] ; then
        for item in $dir/* ; do
            target=$(readlink "$item")
            if [[ $target == /Users/*/Clouds/* ]] ; then
                unlink "$item"
            fi
        done
    fi
done

# for each cloud
for cloud in $clouds/* ; do
    cloud_name=$(basename "$cloud")
    # check if sub-folder contains a directory that is also available in home folder
    for folder in "$cloud"/* ; do
        folder_name=$(basename "$folder")
        target="$home/$folder_name"
        if [[ -d "$target" ]] ; then
            for item in "$folder"/* ; do
                if [[ -d "$item" ]] ; then
                    item_name=$(basename "$item")
                    # then create a link for each sub-folder/file of that directory
                    ln -s "$item" "$target/$item_name ($cloud_name)"
                fi
            done
        fi
    done
done
