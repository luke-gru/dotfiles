#!/bin/bash

if [ -e $HOME/.vimrc ]
then
  rm $HOME/.vimrc
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

if [ -e $HOME/.rvmrc ]
then
  rm $HOME/.rvmrc
fi

if [ -e $HOME/.xmodmap ]
then
  rm $HOME/.xmodmap
fi

if [ -e $HOME/.inputrc ]
then
  rm $HOME/.inputrc
fi

if [ -e $HOME/.bash_aliases ]
then
  rm $HOME/.bash_aliases
fi

# directories

if [ -d $HOME/zim.notes ]
then
  rm -r $HOME/zim.notes
fi

if [ -d "$HOME/.dirs" ]
then
  rm -r "$HOME/.dirs"
fi

## = remove the .NEW suffix if there aren't any conflicts

# non-directory files
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.profile $HOME/.profile.NEW ##
ln -s $HOME/dotfiles/.bash_profile $HOME/.bash_profile.NEW ##
ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc.NEW ##
touch $HOME/.bashrc.local
ln -s $HOME/dotfiles/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/.git-completion.bash $HOME/.git-completion.bash
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/.gitignore_global $HOME/.gitignore
ln -s $HOME/dotfiles/.ircrc $HOME/.ircrc
ln -s $HOME/dotfiles/.irbrc $HOME/.irbrc
ln -s $HOME/dotfiles/.rvmrc $HOME/.rvmrc
ln -s $HOME/dotfiles/.gemrc $HOME/.gemrc
ln -s $HOME/dotfiles/.inputrc $HOME/.inputrc
ln -s $HOME/dotfiles/.xmodmap $HOME/.xmodmap

# directories
ln -s $HOME/dotfiles/zim.notes $HOME/zim.notes
ln -s "$HOME/dotfiles/.dirs" "$HOME/.dirs"
ln -s "$HOME/dotfiles/bin" "$HOME/binNEW" ##
