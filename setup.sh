#!/bin/bash

if [ -e $HOME/.autotest ]
then
  rm -rf $HOME/.autotest
fi

if [ -e $HOME/.vimrc ]
then
rm $HOME/.vimrc
fi

if [ -e $HOME/.bash_profile ]
then
  rm $HOME/.bash_profile
fi

if [ -e $HOME/.bashrc ]
then
  rm $HOME/.bashrc
fi

if [ -e $HOME/.gemrc ]
then
  rm $HOME/.gemrc
fi

if [ -e $HOME/.git-completion.bash ]
then
  rm $HOME/.git-completion.bash 
fi

if [ -e $HOME/.gitconfig ]
then
  rm $HOME/.gitconfig
fi

if [ -e $HOME/.gitignore ]
then
  rm $HOME/.gitignore
fi

if [ -e $HOME/.irbrc ]
then
  rm $HOME/.irbrc
fi

if [ -e $HOME/.ircrc ]
then
  rm $HOME/.ircrc
fi

if [ -e $HOME/.profile ]
then
  rm $HOME/.profile
fi

if [ -e $HOME/.rvmrc ]
then
  rm $HOME/.rvmrc
fi

if [ -e $HOME/.viminfo ]
then
  rm $HOME/.viminfo
fi

if [ -d $HOME/zim.notes ]
then
  rm $HOME/zim.notes
fi

if [ -d $HOME/.autotest_images ]
then
  rm -rf $HOME/.autotest_images
fi

if [ -d $HOME/.netscape ]
then
  rm  -rf $HOME/.netscape
fi

if [ -d $HOME/.backup ]
then
  rm -rf $HOME/.backup
fi

echo "What directory is 'dotfiles' in? *don't put a trailing '/'"
#should fix this, that's embarassing
read dotfiles_dir

ln -s $dotfiles_dir/dotfiles/zim.notes $HOME/zim.notes
ln -s $dotfiles_dir/dotfiles/.autotest_images $HOME/.autotest_images
ln -s $dotfiles_dir/dotfiles/.backup $HOME/.backup
ln -s $dotfiles_dir/dotfiles/.netscape $HOME/.netscape
ln -s $dotfiles_dir/dotfiles/.autotest $HOME/.autotest
ln -s $dotfiles_dir/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $dotfiles_dir/dotfiles/.bashrc $HOME/.bashrc
ln -s $dotfiles_dir/dotfiles/.gemrc $HOME/.gemrc
ln -s $dotfiles_dir/dotfiles/.git-completion.bash $HOME/.git-completion.bash
ln -s $dotfiles_dir/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $dotfiles_dir/dotfiles/.gitignore $HOME/.gitignore
ln -s $dotfiles_dir/dotfiles/.irbrc $HOME/.irbrc
ln -s $dotfiles_dir/dotfiles/.ircrc $HOME/.ircrc
ln -s $dotfiles_dir/dotfiles/.profile $HOME/.profile
ln -s $dotfiles_dir/dotfiles/.rvmrc $HOME/.rvmrc
ln -s $dotfiles_dir/dotfiles/.viminfo $HOME/.viminfo
ln -s $dotfiles_dir/dotfiles/.vimrc $HOME/.vimrc
#have to add Desktop/*
exit 0
