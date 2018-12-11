#!/bin/bash
# .dotfiles installation script for Mac OS X

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Setup cloud folders
function cmd_cloud {
    cloudbase=~/Clouds
    cloudfolders=(
        "Adobe Systems Inc"
        "OneDrive"
        "OneDrive - Adobe Systems Inc"
        "OneDrive - Adobe Systems Incorporated"
        "Dropbox"
        "drivesync"
    )
    basefolders=(
        "Documents"
        "Movies"
        "Music"
        "Pictures"
    )

    for c in "${cloudfolders[@]}" ; do
        mkdir -vp $cloudbase/"$c"
    done

    for b in "${basefolders[@]}" ; do
        for l in ~/"$b"/* ; do
            t=$(readlink "$l")
            if [[ $t == /Users/*/Clouds/* ]] ; then
                echo "Removing $l"
                unlink "$l"
            fi
        done
    done

    for c in "${cloudfolders[@]}" ; do
        for b in "${basefolders[@]}" ; do
            for d in $cloudbase/"$c"/"$b"/* ; do
                n=$(basename "$d")
                t=~/"$b"/"$n"
                [ -d "$d" ] && [ ! -s "$t" ] && ln -sv "$d" "$t ($c)"
            done
        done
    done
}