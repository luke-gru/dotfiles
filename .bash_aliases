# vim: ft=sh

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# all non-hidden dirs in current directory
alias lsd='ls -d */'
# all dirs in current directory
alias lsda='ls -d */ .*/'
# list all files in current directory
alias lsf='find . -maxdepth 1 -type f -print | cut -c 3- | xargs ls'
alias hid="lsf | grep -e '^\.'"

alias cls='clear; ls'
alias e='exit'
alias lsa='ls -a'

# bashrc
# reload bash config
alias reload='source ~/.bashrc'
alias bashrc='$EDITOR ~/.bashrc'

md () { mkdir -p "$1"; cd "$1"; }

# sysadmin type stuff
# list processes in terms of cpu %
alias pcpu='ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed "/^ 0.0 /d"'
alias ip="ifconfig | grep -Eo 'inet addr:192\.[^ ]+' | grep -Eo [0-9.]+"

if [ `uname -s | grep -ie 'linux'` ]; then
  # Add an "alert" alias for long running commands.  Use like so:
  # sleep 10; alert
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
  # copy/paste to/from clipboard
  if type -p 'xclip' > /dev/null 2>&1
  then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  fi
fi

# vim stuff
# for use after ack list search:
alias vimp='vim $(!!)'
alias vimpack='vim $(!! -l)'
# good ol gv, good in terminal and good in vim!
alias gv='gvim --remote-silent'
alias vimrc='$EDITOR ~/.vimrc'

# ack
if type -p "ack-grep" > /dev/null 2>&1
then
  alias ack='ack-grep'
fi

if type -p "gnome-terminal" > /dev/null 2>&1
then
  alias newg="gnome-terminal &"
fi

if type -p "gnome-terminal" > /dev/null 2>&1
then
  alias newx="xterm &"
fi

if type -p "tmux" > /dev/null 2>&1
then
  # start tmux with 256 colors
  alias tmux="tmux -2"
fi

if type -p "rvm" > /dev/null 2>&1
then
  alias gemset='rvm gemset name'
  alias gemsets='rvm gemset list'
  alias rubies='rvm list'
fi

if type -p "ruby" > /dev/null 2>&1
then
  alias gems='gem list'
  alias bexec="bundle exec"
fi

if type -p "git" > /dev/null 2>&1
then
  alias g='git'
  alias gdiff='git diff | gvim --remote-silent'
  # change the rebasing defaults
  alias alwaysrebase='git config branch.autosetuprebase always'
  alias localrebase='git config branch.autosetuprebase local'
  alias neverrebase='git config branch.autosetuprebase never'
fi

if type -p "sensible-browser" > /dev/null 2>&1
then
  alias browse='sensible-browser'
fi

# For use with the '$HOME/.dirs' directory. Source a file in that directory and quickly
# navigate between useful directories for a project.
alias dirs="\dirs -v"
alias 1="cd ~+1"
alias 2="cd ~+2"
alias 3="cd ~+3"
alias 4="cd ~+4"
alias 5="cd ~+5"
