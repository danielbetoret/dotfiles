#!/bin/sh

while read folder; do
    stow $folder
done < <(ls -A -d */ | sed -E 's/(.+)\//\1/g')
