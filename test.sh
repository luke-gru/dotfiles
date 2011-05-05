#!/usr/bin/env bash

echo "What directory is 'dotfiles' in?"
read dotfiles_dir_trail
echo $dotfiles_dir_trail | sed 's/\/$//'
dotfiles_dir_trail=$("$dotfiles_dir_trail" | sed -en s/\/$//)
echo $dotfiles_dir_trail
