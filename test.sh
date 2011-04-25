#!/bin/bash

echo "What directory is 'dotfiles' in?"
read dotfiles_dir_trail
echo "$dotfiles_dir_trail" | sed 's/\/$//'
