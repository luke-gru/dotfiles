# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
  
#added Nov. 27, 2010 
#added following on Dec. 15, 2010
PATH="$PATH:/usr/lib/ruby/1.9.1"
PATH="/usr/lib/ruby/gems:$PATH"
PATH="$PATH:/usr/lib/ruby/1.9.1/i686-linux"
PATH="$PATH:/usr/lib/ruby/1.9.1/tk"
PATH="$PATH:/usr/lib/ruby/1.9.1/tkextlib"
	
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

export PATH

# sample PATH below from linuxforums.org
#PATH=$PATH:$HOME/bin
#PATH=$PATH:/home/flebber/Python

